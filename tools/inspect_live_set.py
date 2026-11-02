#!/usr/bin/env python3
"""Read-only inspection of VTM state from an actual Ableton Live Set.

No audio, external files, devices or plug-ins are loaded/executed. Output only
the VTM parameter payload and its saved input routing, without personal paths.
This diagnoses a saved file; it does not run Max or prove successful replay.
"""
import gzip
import json
from pathlib import Path
import sys
import xml.etree.ElementTree as ET

ROUTING_KEYS=('VTM Instrumental type','VTM Instrumental channel')


def stored_label(value):
    # coll emits a one-symbol result as the typed message "symbol <name>".
    # pattr preserves that selector in its Blob array. Both that native form
    # and a direct one-atom symbol carry the same exact label for lookup.
    if isinstance(value,list):
        if len(value)==2 and value[0]=='symbol':value=value[1:]
        if len(value)==1 and isinstance(value[0],str) and value[0].startswith('vtm '):
            return value[0]
    return None


def inspect_bytes(data):
    root=ET.fromstring(gzip.decompress(data) if data[:2]==b'\x1f\x8b' else data)
    found=[]
    for device in root.findall('.//MxDeviceAudioEffect'):
        refs=device.findall('./PatchSlot/Value/MxPatchRef/FileRef/Path')
        names=[n.get('Value','').replace('\\','/').split('/')[-1] for n in refs]
        if not any(n.startswith('Vocal_Timing_Monitor') for n in names):continue
        stored={}; blob=device.find('./BlobSlot/Value/MxDBlob/Blob')
        if blob is not None and blob.text and blob.text.strip():
            decoded=bytes.fromhex(blob.text).rstrip(b'\0')
            # Unknown host blob formats must be reported, not silently treated
            # as success or imported as executable state.
            stored=json.loads(decoded.decode('utf-8'))
        parameters=[]
        for p in device.findall('./ParameterList/ParameterList/*'):
            name=p.find('Name'); value=p.find('Timeable/Manual')
            parameters.append({'class':p.tag,'name':name.get('Value') if name is not None else None,
                               'value':value.get('Value') if value is not None else None})
        labels=[stored_label(stored.get(k)) for k in ROUTING_KEYS]
        labels_ok=all(label is not None for label in labels)
        numeric_fallback=any(p['class']=='MxDFloatParameter'
                             and p['name'] in ['vtm_saved_beat_type','vtm_saved_beat_channel']
                             for p in parameters)
        inputs=[]
        for route in device.findall('./Routables/InRoutings/*/Routable'):
            upper=route.find('UpperDisplayString');lower=route.find('LowerDisplayString')
            inputs.append({'source':upper.get('Value','') if upper is not None else '',
                           'channel':lower.get('Value','') if lower is not None else ''})
        # RC3.1 stored "vtm 2" twice. It had the expected string shape but
        # encoded indices, not the route's labels. Compare to saved bus 1.
        route=inputs[1] if len(inputs)>1 else inputs[0] if inputs else None
        labels_match=(labels_ok and route is not None and
                      labels[0]=='vtm '+route['source'] and
                      labels[1]=='vtm '+route['channel'])
        found.append({'device':names[0],'stored_values':stored,'parameters':parameters,
                      'routing_labels_stored':labels_ok,
                      'routing_labels_match_saved_input':labels_match,
                      'routing_schema':'stored_labels' if labels_match else
                           'stored_labels_mismatch' if labels_ok else
                           'incorrect_numeric_fallback' if numeric_fallback else 'missing_labels',
                      'saved_inputs':inputs})
    return found


if __name__=='__main__':
    print(json.dumps(inspect_bytes(Path(sys.argv[1]).read_bytes()),ensure_ascii=False,indent=2))
