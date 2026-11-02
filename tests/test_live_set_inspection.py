"""Minimal XML fixtures; no user project or recording is distributed."""
import gzip
import importlib.util
import json
from pathlib import Path
import unittest

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('inspect_live_set',ROOT/'tools/inspect_live_set.py')
inspector=importlib.util.module_from_spec(spec);spec.loader.exec_module(inspector)


def fixture(values, parameters='', source='4-Test beat', channel='Post Mixer'):
    blob=(json.dumps(values)+'\0').encode().hex()
    return f'''<Ableton><LiveSet><MxDeviceAudioEffect>
    <PatchSlot><Value><MxPatchRef><FileRef><Path Value="C:/private/Vocal_Timing_Monitor_TEST.amxd"/>
    </FileRef></MxPatchRef></Value></PatchSlot>
    <BlobSlot><Value><MxDBlob><Blob>{blob}</Blob></MxDBlob></Value></BlobSlot>
    <ParameterList><ParameterList>{parameters}</ParameterList></ParameterList>
    <Routables><InRoutings><MxDInRoutable><Routable>
    <UpperDisplayString Value="{source}"/><LowerDisplayString Value="{channel}"/>
    </Routable></MxDInRoutable></InRoutings></Routables>
    </MxDeviceAudioEffect></LiveSet></Ableton>'''.encode()


class LiveSetInspectionTests(unittest.TestCase):
    def test_recognizes_actual_rc3_failure_shape_without_conflating_native_routing(self):
        # Minimal equivalent of owner .als: numeric UI values were saved, source
        # labels absent from BlobSlot; two fallback Float parameters at zero.
        floats=''.join(f'''<MxDFloatParameter><Name Value="vtm_saved_beat_{kind}"/>
                     <Timeable><Manual Value="0"/></Timeable></MxDFloatParameter>'''
                     for kind in ['type','channel'])
        report=inspector.inspect_bytes(fixture({'VTM Compensation ms':[92.2]},floats))[0]
        self.assertEqual(report['stored_values']['VTM Compensation ms'],[92.2])
        self.assertEqual(report['routing_schema'],'incorrect_numeric_fallback')
        self.assertFalse(report['routing_labels_stored'])
        self.assertEqual(report['saved_inputs'][0],{'source':'4-Test beat','channel':'Post Mixer'})

    def test_labels_in_stored_payload_are_the_expected_success_shape(self):
        data=fixture({'VTM Instrumental type':['vtm 4-Test beat'],
                      'VTM Instrumental channel':['vtm Post Mixer']})
        for encoded in [data,gzip.compress(data)]:
            report=inspector.inspect_bytes(encoded)[0]
            self.assertTrue(report['routing_labels_stored'])
            self.assertEqual(report['routing_schema'],'stored_labels')
            self.assertNotIn('private',json.dumps(report))

    def test_numeric_or_sentinel_payload_cannot_be_reported_as_saved_labels(self):
        for value in [0,'__vtm_unset__']:
            report=inspector.inspect_bytes(fixture({'VTM Instrumental type':[value],
                                                   'VTM Instrumental channel':['vtm Post Mixer']}))[0]
            self.assertFalse(report['routing_labels_stored'])

    def test_actual_rc3_1_vtm_two_payload_does_not_match_saved_track_labels(self):
        data=fixture({'VTM Instrumental type':['vtm 2'],
                      'VTM Instrumental channel':['vtm 2']})
        report=inspector.inspect_bytes(data)[0]
        self.assertTrue(report['routing_labels_stored'])  # right type, wrong content
        self.assertFalse(report['routing_labels_match_saved_input'])
        self.assertEqual(report['routing_schema'],'stored_labels_mismatch')

    def test_legitimate_numeric_channel_label_is_compared_to_its_name(self):
        data=fixture({'VTM Instrumental type':['vtm Ext. In'],
                      'VTM Instrumental channel':['vtm 2']},source='Ext. In',channel='2')
        report=inspector.inspect_bytes(data)[0]
        self.assertTrue(report['routing_labels_match_saved_input'])

    def test_actual_rc3_2_symbol_selector_wrapper_preserves_the_correct_labels(self):
        data=fixture({'VTM Instrumental type':['symbol','vtm 4-Test beat'],
                      'VTM Instrumental channel':['symbol','vtm Post Mixer']})
        report=inspector.inspect_bytes(data)[0]
        self.assertEqual(report['routing_schema'],'stored_labels')
        self.assertTrue(report['routing_labels_match_saved_input'])

    def test_other_devices_are_ignored(self):
        data=fixture({}).replace(b'Vocal_Timing_Monitor_TEST',b'UnrelatedDevice')
        self.assertEqual(inspector.inspect_bytes(data),[])


if __name__=='__main__':unittest.main()
