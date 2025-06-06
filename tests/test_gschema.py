import subprocess
from pathlib import Path

def test_gschema_compiles():
    schema = Path('data/Raccoon.jh.xz.gschema.xml')
    subprocess.run(['glib-compile-schemas', str(schema.parent)], check=True)
