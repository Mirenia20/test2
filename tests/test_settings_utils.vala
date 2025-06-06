using GLib;
using Raccoon;

int main (string[] args) {
    Test.init (ref args);

    string data_dir = args.length > 1 ? args[1] : "../data";
    string schema_dir = Path.build_filename (Environment.get_tmp_dir (), "raccoon_test_schema");
    DirUtils.create (schema_dir, 0755);

    string[] cmd = {"glib-compile-schemas", "--targetdir", schema_dir, data_dir};
    int status = 0;
    string? out_str;
    string? err_str;
    try {
        Process.spawn_sync (null, cmd, null, SpawnFlags.SEARCH_PATH, null,
            out out_str, out err_str, out status);
    } catch (Error e) {
        stderr.printf ("Schema compile error: %s\n", e.message);
        return 1;
    }
    if (status != 0) {
        stderr.printf ("Schema compile failed\n");
        return 1;
    }

    Environment.set_variable ("GSETTINGS_SCHEMA_DIR", schema_dir, true);

    Test.add_func ("/settings_utils/has_paths/empty", () => {
        var settings = new Settings ("Raccoon.jh.xz");
        settings.set_strv ("uris", {});
        assert (!Raccoon.has_paths (settings));
    });

    Test.add_func ("/settings_utils/has_paths/nonempty", () => {
        var settings = new Settings ("Raccoon.jh.xz");
        settings.set_strv ("uris", {"file:///tmp"});
        assert (Raccoon.has_paths (settings));
    });

    var result = Test.run ();
    DirUtils.remove (schema_dir);
    return result;
}

