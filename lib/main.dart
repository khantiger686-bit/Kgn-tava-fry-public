cd /home/claude && which flutter; python3 - <<'EOF'
import re,zipfile,json
src=zipfile.ZipFile('/mnt/user-data/uploads/DOC-20261008-WA0004.zip').read('kgn_tava_fry/lib/main.dart').decode()
items=[]
for m in re.finditer(r"MenuItem\(name: '([^']+)', category: '([^']+)'([^)]*)\)",src):
    d={'n':m.group(1),'c':m.group(2)}
    for k,key in (('half','h'),('full','f'),('perPc','p')):
        x=re.search(k+r': (\d+)',m.group(3))
        if x:d[key]=int(x.group(1))
    items.append(d)
print(len(items))
html=open('tpl.html').read().replace('__MENU__',json.dumps(items,ensure_ascii=False,separators=(',',':')))
import os;os.makedirs('/mnt/user-data/outputs',exist_ok=True)
open('/mnt/user-data/outputs/kgn_tawa_fry.html','w').write(html)
print(len(html))
EOF
