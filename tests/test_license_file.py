from pathlib import Path

def test_license_not_empty():
    path = Path('COPYING')
    assert path.exists()
    assert path.read_text().strip() != ''
