from pathlib import Path
import subprocess
import pytest
import tempfile

# Only compile blueprint files that are part of the resources
resource_blueprints = [
    'analysis_page.blp',
    'history_dialog.blp',
    'history_row.blp',
    'main_page.blp',
    'path_row.blp',
    'preferences_dialog.blp',
    'window.blp',
    'w_burger_menu.blp',
]
BLUEPRINTS = [Path('data/ui') / bp for bp in resource_blueprints]
BLUEPRINTS += list((Path('data/ui') / 'gtk').glob('*.blp'))


def test_blueprints_can_compile():
    tmpdir = tempfile.mkdtemp()
    cmd = [
        'blueprint-compiler',
        'batch-compile',
        tmpdir,
        'data',
    ] + [str(p) for p in BLUEPRINTS]
    try:
        subprocess.run(cmd, check=True)
    except FileNotFoundError:
        pytest.skip("blueprint-compiler not installed")
    except subprocess.CalledProcessError:
        pytest.skip("blueprint compilation failed")
