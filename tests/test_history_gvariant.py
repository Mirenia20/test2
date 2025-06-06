import subprocess
from pathlib import Path
import textwrap
import pytest

def test_history_gvariant_roundtrip(tmp_path):
    script = tmp_path / "variant_script.py"
    script.write_text(textwrap.dedent(
        """
        import gi, sys
        from gi.repository import GLib

        path = sys.argv[1]
        builder = GLib.VariantBuilder.new(GLib.VariantType('a(sss)'))
        builder.add_value(GLib.Variant('(sss)', ('2024-01-01', '/tmp/a', '1')))
        builder.add_value(GLib.Variant('(sss)', ('2024-01-02', '/tmp/b', '2')))
        variant = builder.end()
        with open(path, 'wb') as f:
            f.write(variant.get_data_as_bytes().get_data())
        with open(path, 'rb') as f:
            data = f.read()
        variant2 = GLib.Variant.new_from_bytes(
            GLib.VariantType('a(sss)'), GLib.Bytes.new(data), False
        )
        assert variant2.n_children() == 2
        assert variant2.get_child_value(0).get_child_value(0).get_string() == '2024-01-01'
        assert variant2.get_child_value(1).get_child_value(1).get_string() == '/tmp/b'
        """
    ))
    gvb = tmp_path / "history.gvb"
    try:
        subprocess.run(['/usr/bin/python3', str(script), str(gvb)], check=True)
    except FileNotFoundError:
        pytest.skip('/usr/bin/python3 not available')



