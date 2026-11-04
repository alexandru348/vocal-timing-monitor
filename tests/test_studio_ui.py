"""Native graph contracts and UI logic; NOT a Max renderer or Live serializer."""
import hashlib
import json
from collections import defaultdict,deque
from pathlib import Path
import unittest
from max_event_model import Graph,parameter_enabled
from test_static import PATCH,boxmap,edges
from studio_ui import PALETTES,STATES

P='root/popup/'

def label(g,id):return ' '.join(map(str,g.state[P+id].get('label',())))

def contrast(a,b):
    def luminance(c):
        v=[x/12.92 if x<=.04045 else ((x+.055)/1.055)**2.4 for x in c[:3]]
        return sum(w*x for w,x in zip((.2126,.7152,.0722),v))
    l1,l2=sorted([luminance(a),luminance(b)])
    return (l2+.05)/(l1+.05)

class StudioTests(unittest.TestCase):
    def assert_device_palette(self, g, theme):
        palette=PALETTES[theme]
        self.assertEqual(g.state['root/ui-device-canvas']['attrs']['bgfillcolor'],tuple(palette['bg']))
        for id in ('title','version','note1','note2'):
            self.assertEqual(g.state['root/'+id]['attrs']['textcolor'],
                             tuple(palette['voice' if id=='title' else 'muted']))
        for attr,role in (('bgcolor','field'),('textcolor','text'),
                          ('bgoncolor','selected'),('textoncolor','selected_text'),
                          ('textovercolor','text')):
            self.assertEqual(g.state['root/open']['attrs'][attr],tuple(palette[role]))

    def test_device_body_theme_follows_live_toggle_in_both_directions(self):
        g=Graph();g.initialize();g.click('autostop')
        before=dict(g.params);commands=list(g.state['root/beat-router']['commands'])
        for theme in (1,0,1,0):
            g.click('theme');self.assert_device_palette(g,theme)
            self.assertEqual(g.state[P+'studio-canvas']['attrs']['bgcolor'],tuple(PALETTES[theme]['bg']))
            self.assertEqual(g.params,before)
            self.assertEqual(g.state['root/beat-router']['commands'],commands)
            self.assertFalse(g.calls)
        canvas=g.boxes['root/ui-device-canvas']
        self.assertEqual(canvas['bgfillcolor']['type'],'color')
        self.assertEqual(canvas['presentation_rect'],[0.,0.,360.,169.])
        self.assertEqual(canvas['background'],1);self.assertEqual(canvas['ignoreclick'],1)
        g.send('root/open',(1,));self.assertEqual(g.openings,1)

    def test_device_body_restores_saved_theme_before_monitor_is_opened(self):
        g=Graph();g.initialize({'VTM Theme':1,'VTM Voice zoom':2.5,
                              'VTM Beat zoom':2,'VTM Compensation ms':92.2})
        self.assertEqual(g.openings,0);self.assert_device_palette(g,1)
        g.click('autostop');saved=g.saved_parameters()
        for theme in (1,0):
            saved['VTM Theme']=theme
            reopened=Graph();reopened.initialize(saved)
            self.assertEqual(reopened.openings,0);self.assert_device_palette(reopened,theme)
            self.assertEqual(reopened.state[P+'voice-gain']['value'],2.5)
            self.assertEqual(reopened.params['offsetms'],92.2)
            self.assertEqual(reopened.params['autostop'],0)
            reopened.emit('root/thisdevice');reopened.drain()
            self.assert_device_palette(reopened,theme)

    def test_device_palette_outlet_is_local_and_cannot_reach_audio_or_actions(self):
        parent=PATCH['patcher'];b=boxmap(parent);ui=boxmap(b['popup']['patcher'])
        self.assertGreater(ui['ui-device-theme-out']['patching_rect'][0],ui['out']['patching_rect'][0])
        self.assertEqual(b['popup']['numoutlets'],3)
        self.assertEqual([d for s,d in edges(parent) if s==('popup',1)],
                         [('ui-device-theme-select',0)])
        for theme in (0,1):
            for command in b['ui-device-palette-'+str(theme)]['text'].split(','):
                self.assertEqual(command.split()[:2],['script','send'])
                self.assertIn(command.split()[2],{'vtm_device_'+id for id in
                              ('canvas','title','version','open','note1','note2')})
                self.assertIn(command.split()[3],{'bgfillcolor','textcolor','bgcolor',
                              'bgoncolor','textoncolor','textovercolor'})
        light=Graph();dark=Graph();light.initialize({'VTM Theme':1});dark.initialize()
        self.assert_device_palette(light,1);self.assert_device_palette(dark,0)
        light.click('theme');self.assert_device_palette(dark,0)

    def test_dsp_source_matches_published_rc33(self):
        src=Path(__file__).resolve().parents[1]/'src/vtm_engine.genexpr'
        self.assertEqual(hashlib.sha256(src.read_bytes()).hexdigest(),
                         '5da751738b15e42bb4ad708eda7c8007a89c3a7b587823080fbe4941600f0945')

    def test_theme_is_stored_only_and_silent_restore_preserves_all_values(self):
        g=Graph();g.initialize({'VTM Theme':1,'VTM Analysis':0,'VTM Grid':1,
                              'VTM Threshold ms':80,'VTM Detection dB':-26,
                              'VTM Compensation ms':92.2,'VTM Voice zoom':2,'VTM Beat zoom':3})
        b=g.boxes[P+'theme'];self.assertEqual(b['varname'],'vtm_theme')
        self.assertEqual(b['saved_attribute_attributes']['valueof']['parameter_type'],1)
        self.assertEqual(g.state[P+'theme']['value'],1)
        self.assertEqual(g.state[P+'studio-canvas']['attrs']['bgcolor'],tuple(PALETTES[1]['bg']))
        self.assertEqual(g.params['enabled'],0);self.assertEqual(g.params['grid'],8)
        self.assertEqual(g.params['autostop'],0);self.assertFalse(g.calls)
        saved=g.saved_parameters();restored=Graph();restored.initialize(saved)
        self.assertEqual(restored.saved_parameters(),saved)
        self.assertEqual(restored.state[P+'voice-gain']['value'],2)

    def test_theme_advanced_and_settings_never_change_audio_params_or_armed_stop(self):
        g=Graph();g.initialize();g.click('autostop')
        before=dict(g.params);commands=list(g.state['root/beat-router']['commands'])
        for _ in range(6):
            g.click('theme');g.click('settings');g.click('advanced')
        self.assertEqual(g.params,before);self.assertEqual(g.params['autostop'],1)
        self.assertEqual(g.state['root/beat-router']['commands'],commands)
        self.assertFalse(g.calls)
        g.emit('root/snapshot-2',(1,));g.drain();g.advance(151);g.drain()
        self.assertEqual(g.calls,[('call','stop_playing')]);self.assertEqual(g.params['autostop'],0)

    def test_theme_switch_recolors_current_status_without_new_engine_packet(self):
        g=Graph();g.initialize()
        for code in (0,4,5,6,9,10):
            g.send(P[:-1],('state',code))
            for theme in (1,0):
                g.send(P+'theme',(theme,))
                self.assertEqual(label(g,'state-text'),STATES[code][0])
                role=STATES[code][2]
                for id in ('state-text','delta-text','status-mark'):
                    self.assertEqual(g.state[P+id]['attrs']['textcolor'],tuple(PALETTES[theme][role]))

    def test_level_raw_peak_threshold_and_overload_are_visual_only(self):
        g=Graph();g.initialize();g.send(P+'gatedb',(-26.,));before=dict(g.params)
        for value,kind,expected in ((.001,0,'Nivel sub prag'),(.1,1,'Nivel peste prag'),(1.2,2,'Nivel prea mare')):
            g.send(P[:-1],('level',value))
            self.assertIn(expected,label(g,'level-feedback'))
            self.assertEqual(g.params,before)
            self.assertFalse(g.calls)
            for theme in (1,0):
                g.send(P+'theme',(theme,))
                self.assertIn(expected,label(g,'level-feedback'))
                role=('muted','voice','red')[kind]
                self.assertEqual(g.state[P+'level-feedback']['attrs']['textcolor'],tuple(PALETTES[theme][role]))
        self.assertEqual(g.state[P+'input-meter']['value'],(0.,))
        self.assertEqual(g.state[P+'threshold-meter']['value'],(-26.,))

    def test_display_modules_have_no_path_to_core(self):
        ui=boxmap(PATCH['patcher'])['popup']['patcher'];adj=defaultdict(list)
        for a,b in edges(ui):adj[a[0]].append(b[0])
        for start in ('theme','advanced','input-meter','threshold-meter','settings'):
            seen=set();todo=deque([start])
            while todo:
                id=todo.popleft()
                if id in seen:continue
                seen.add(id);todo.extend(adj[id])
            self.assertFalse(seen & {'out','enabled','autostop','reset','grid-ui','redms','offsetms','gatedb','beat-type','beat-channel'},start)

    def test_basic_and_advanced_pages_visible_bounds_and_no_hit_target_overlap(self):
        g=Graph();g.initialize()
        for page in (0,1):
            g.send(P+'advanced',(page,))
            visible=[]
            for key,b in g.boxes.items():
                if key.rsplit('/',1)[0]!=P[:-1] or not b.get('presentation'):continue
                if g.state[key].get('hidden',bool(b.get('hidden'))):continue
                x,y,w,h=b['presentation_rect'];self.assertTrue(x>=0 and y>=0 and x+w<=640 and y+h<=760,key)
                if b['maxclass'] in ('textbutton','number','flonum','umenu','live.numbox'):
                    visible.append((key,(x,y,w,h)))
            for i,(a,(ax,ay,aw,ah)) in enumerate(visible):
                for b,(bx,by,bw,bh) in visible[i+1:]:
                    self.assertFalse(ax<bx+bw and bx<ax+aw and ay<by+bh and by<ay+ah,(a,b,page))
            self.assertEqual(g.state[P+'gatedb']['hidden'],bool(page))
            self.assertEqual(g.state[P+'offsetms']['hidden'],not bool(page))

    def test_repeated_ready_returns_basic_compact_without_rearming(self):
        g=Graph();g.initialize({'VTM Theme':1});g.click('settings');g.click('advanced');g.click('autostop')
        g.emit('root/thisdevice');g.drain()
        self.assertEqual(g.params['autostop'],0)
        self.assertEqual(g.state[P+'theme']['value'],1)
        self.assertFalse(g.state[P+'gatedb']['hidden']);self.assertTrue(g.state[P+'offsetms']['hidden'])
        left,top,right,bottom=g.state[P+'window']['rect'];self.assertEqual((right-left,bottom-top),(640,370))

    def test_sign_labels_clear_with_measurement_validity(self):
        g=Graph();g.initialize();g.send(P[:-1],('hasdelta',1))
        for delta,word in ((-17.5,'Mai devreme'),(0.,'Pe reperul'),(109.,'Mai târziu')):
            g.send(P[:-1],('delta',delta));self.assertIn(word,label(g,'sign-caption'))
        g.send(P[:-1],('hasdelta',0));self.assertEqual(label(g,'delta-text'),'--')
        self.assertEqual(label(g,'sign-caption'),'Față de grila din Ableton')

    def test_zoom_unit_fields_keep_numeric_gain_range_restore_and_theme(self):
        g=Graph();g.initialize();g.click('autostop');before=dict(g.params)
        for id in ('voice-gain','beat-gain'):
            b=g.boxes[P+id];attrs=b['saved_attribute_attributes']['valueof']
            self.assertEqual(b['maxclass'],'live.numbox')
            self.assertEqual(attrs['parameter_type'],0)
            self.assertEqual(attrs['parameter_invisible'],1)
            self.assertEqual(attrs['parameter_unitstyle'],9)
            self.assertEqual(attrs['parameter_units'],'%g×')
            for value in (1.,2.,2.5,8.,0.,9.):
                expected=max(1.,min(8.,value));g.send(P+id,(value,))
                self.assertEqual(g.state[P+id]['value'],expected)
                self.assertIn((1,(expected,)),g.state[P+id.replace('-gain','-magnify')]['controls'])
                self.assertEqual(g.params,before)
            g.send(P+id,(2.5,))
            for theme in (1,0):
                g.send(P+'theme',(theme,))
                self.assertEqual(g.state[P+id]['attrs']['lcdbgcolor'],tuple(PALETTES[theme]['field']))
                self.assertEqual(g.state[P+id]['attrs']['lcdcolor'],tuple(PALETTES[theme]['text']))
        saved=g.saved_parameters();reopened=Graph();reopened.initialize(saved)
        for id in ('voice-gain','beat-gain'):
            self.assertEqual(reopened.state[P+id]['value'],2.5)
        self.assertEqual(reopened.params['autostop'],0);self.assertFalse(g.calls)

    def test_impossible_tolerance_warning_updates_in_both_directions(self):
        g=Graph();g.initialize()
        g.send(P[:-1],('maxdev',75.));self.assertIn('Scade toleranța',label(g,'rhythm-hint'))
        g.send(P+'redms',(50,));self.assertIn('Abaterea permisă',label(g,'rhythm-hint'))
        self.assertFalse(g.calls)

    def test_text_and_semantic_colors_have_readable_contrast_in_both_themes(self):
        for palette in PALETTES:
            for role in ('text','muted','voice','beat','amber','red'):
                self.assertGreaterEqual(contrast(palette[role],palette['card']),4.5,role)
            self.assertGreaterEqual(contrast(palette['text'],palette['field']),4.5)
            self.assertGreaterEqual(contrast(palette['selected_text'],palette['selected']),4.5)
            self.assertGreaterEqual(contrast(palette['stop_text'],palette['stop_bg']),4.5)

if __name__=='__main__':unittest.main()
