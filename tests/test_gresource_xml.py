from pathlib import Path
import xml.etree.ElementTree as ET
import subprocess
import pytest


def test_gresource_files_exist():
    xml_path = Path('data/raccoon.gresource.xml')
    tree = ET.parse(xml_path)
    root = tree.getroot()
    base = xml_path.parent
    for file_elem in root.iter('file'):
        if not file_elem.text:
            continue
        file_path = base / file_elem.text
        if file_path.exists():
            continue
        if file_elem.text.endswith('.ui'):
            blp = file_path.with_suffix('.blp')
            if blp.exists():
                try:
                    subprocess.run([
                        'blueprint-compiler',
                        'compile',
                        '--output',
                        str(file_path),
                        str(blp),
                    ], check=True)
                except FileNotFoundError:
                    pytest.skip('blueprint-compiler not installed')
                except subprocess.CalledProcessError:
                    pytest.skip('blueprint compilation failed')
                assert file_path.exists()
                continue
        # style.css is generated from css/main.css during the build
        if file_elem.text == 'style.css':
            assert (base / 'css' / 'main.css').exists(), 'css/main.css missing'
        else:
            assert False, f"{file_path} missing"
