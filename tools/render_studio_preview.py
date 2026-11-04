"""Approximate layout QA from the generated patch; NOT a native Max capture.

Synthetic signals and generic routing labels only. Pillow/font substitution is
development-only; the shipped AMXD uses native Max UI objects and system fonts.
"""
import json
import math
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
sys.path[:0] = [str(ROOT), str(ROOT / 'tests')]
from max_event_model import Graph
from studio_ui import PALETTES, COMPACT_HEIGHT, SETTINGS_HEIGHT

SCALE = 2
FONT_ROOT = Path('/usr/share/fonts/truetype/dejavu')
PREFIX = 'root/popup/'


def render(theme, page, folder, diagnostics=None):
    g = Graph()
    g.initialize({'VTM Theme': theme, 'VTM Detection dB': -26, 'VTM Beat zoom':2,
                  'VTM Compensation ms': 92.2})
    if page != 'compact': g.click('settings')
    if page == 'advanced': g.click('advanced')
    for msg in [('hasdelta', 1), ('delta', -17.5), ('state', 4), ('sync', 1),
                ('level', .08), ('beatlevel', .5), ('count', 123), ('maxdev', 300.)]:
        g.send(PREFIX[:-1], msg)
    if diagnostics is not None:
        g.click('calibrate')
        g.send(PREFIX[:-1], ('latencydiagnostics',)+tuple(diagnostics))
        g.send(PREFIX[:-1], ('latencystatus',4))
    height = 169 if page == 'device' else COMPACT_HEIGHT if page == 'compact' else SETTINGS_HEIGHT
    width = 360 if page == 'device' else 640
    scope = 'root' if page == 'device' else PREFIX[:-1]
    palette = PALETTES[theme]
    im = Image.new('RGB', (width*SCALE, height*SCALE))
    draw = ImageDraw.Draw(im)
    overflow = []
    def color(c): return tuple(round(v*255) for v in c[:3])
    def rect(r): return tuple(round(v*SCALE) for v in (r[0], r[1], r[0]+r[2], r[1]+r[3]))
    def font(size, bold=False):
        return ImageFont.truetype(str(FONT_ROOT / ('DejaVuSans-Bold.ttf' if bold else 'DejaVuSans.ttf')), round(size*SCALE))
    def text(id, value, r, size, fill, bold=False, align=0, button=False):
        f = font(size, bold)
        pad = 8 if button else 2
        maxw = (r[2]-2*pad)*SCALE
        lines = []
        for line in str(value).split('\n'):
            if button:
                lines.append(line)
                if f.getlength(line)>maxw: overflow.append([id, 'width', line])
                continue
            words = line.split(); current = ''
            for word in words:
                candidate = (current+' '+word).strip()
                if current and f.getlength(candidate)>maxw:
                    lines.append(current);current=word
                else: current=candidate
            lines.append(current)
        lineh = round(size*1.2*SCALE)
        if lineh*len(lines) > r[3]*SCALE+SCALE:
            overflow.append([id, 'height', value])
        y = r[1]*SCALE + ((r[3]*SCALE-lineh*len(lines))/2 if button else 0)
        for line in lines:
            width = f.getlength(line)
            x = r[0]*SCALE+pad*SCALE
            if align==1: x=r[0]*SCALE+(r[2]*SCALE-width)/2
            if align==2: x=(r[0]+r[2]-pad)*SCALE-width
            draw.text((x,y), line, font=f, fill=color(fill), anchor='lt')
            y += lineh
    nodes = []
    for key, b in g.boxes.items():
        if key.rsplit('/',1)[0] != scope or not b.get('presentation'):continue
        s = g.state[key]
        if s.get('hidden', b.get('hidden',False)):continue
        if b['presentation_rect'][1] >= height:continue
        nodes.append((key,b,s))
    # Native background panels are behind foreground UI objects.
    nodes.sort(key=lambda n: 0 if n[1]['maxclass']=='panel' else 1)
    for key,b,s in nodes:
        id=b['id']; cls=b['maxclass']; r=b['presentation_rect']
        attrs={**b, **s.get('attrs',{})}
        if cls=='panel':
            fill=attrs.get('bgfillcolor',attrs.get('bgcolor'))
            if isinstance(fill,dict):fill=fill['color']
            draw.rounded_rectangle(rect(r), radius=round(b.get('rounded',0)*SCALE), fill=color(fill))
        elif cls=='comment':
            value=' '.join(map(str,s.get('label',()))) if 'label' in s else b.get('text','')
            if id=='count-text':value='123'
            text(id,value,r,b.get('fontsize',11),attrs['textcolor'],b.get('fontface',0)==1,b.get('textjustification',0))
        elif cls in ('textbutton','number','flonum','umenu','live.numbox'):
            selected=bool(s.get('value',0)) if cls=='textbutton' else False
            fill=attrs['lcdbgcolor'] if cls=='live.numbox' else attrs.get('bgoncolor') if selected else attrs['bgcolor']
            draw.rounded_rectangle(rect(r),radius=(8 if cls=='textbutton' else 2)*SCALE,fill=color(fill))
            if cls=='textbutton':value=b.get('texton',b.get('text')) if selected else b.get('text','')
            elif cls=='umenu':
                value={'grid-ui':'1/4','beat-type':'Pista instrumentală','beat-channel':'Post Mixer'}[id]
                x,y,w,h=r;draw.polygon([(int((x+w-15)*SCALE),int((y+h/2-2)*SCALE)),(int((x+w-7)*SCALE),int((y+h/2-2)*SCALE)),(int((x+w-11)*SCALE),int((y+h/2+2)*SCALE))],fill=color(palette['muted']))
            else:
                v=s.get('value',0)
                value=(b['saved_attribute_attributes']['valueof']['parameter_units'] % v) if cls=='live.numbox' else str(int(v)) if v==int(v) else str(v)
            fill=attrs['lcdcolor'] if cls=='live.numbox' else attrs.get('textoncolor') if selected else attrs['textcolor']
            text(id,value,r,b.get('fontsize',11),fill,b.get('fontface',0)==1,1 if cls in ('textbutton','live.numbox') else 0,True)
        elif cls=='live.scope~':
            x,y,w,h=r;line=color(attrs['linecolor'])
            if id=='grid-scope':
                for k in range(10):
                    sx=round((x+(k+.25)*w/10)*SCALE)
                    draw.line((sx,(y+1)*SCALE,sx,(y+h-1)*SCALE), fill=line,width=SCALE)
            else:
                mid=y+h/2;pts=[]
                for j in range(round(w*SCALE)):
                    t=j/(w*SCALE);wave=math.sin(t*2350)+.5*math.sin(t*4101)
                    envelope=.03+sum(a*math.exp(-((t-p)/q)**2) for p,q,a in ((.1,.017,.45),(.23,.03,.65),(.36,.05,.5),(.6,.04,.9),(.82,.04,.6)))
                    if id=='beat-scope':envelope=.18+.20*max(0,math.cos(t*80))**5
                    pts.append((round(x*SCALE+j),round((mid+wave*envelope*h*.36)*SCALE)))
                draw.line(pts, fill=line,width=SCALE)
        elif cls=='multislider':
            draw.rounded_rectangle(rect(r),radius=2*SCALE,fill=color(attrs['bgcolor']))
            v=s.get('value',(-60.,))[0];x,y,w,h=r;position=x+w*max(0,min(1,(v+60)/60))
            if b['setstyle']==1:draw.rounded_rectangle(rect((x,y,position-x,h)),radius=2*SCALE,fill=color(attrs['slidercolor']))
            else:draw.line((position*SCALE,y*SCALE,position*SCALE,(y+h)*SCALE),fill=color(attrs['slidercolor']),width=2*SCALE)
    name=('light' if theme else 'dark')+'-'+page
    im.save(folder/(name+'.png'))
    return overflow


if __name__=='__main__':
    out=ROOT/'previews';out.mkdir(exist_ok=True)
    result={}
    for theme in (0,1):
        for page in ('compact','basic','advanced','device'):
            result[f'{theme}-{page}']=render(theme,page,out)
    (out/'layout-check.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(result,ensure_ascii=False))
