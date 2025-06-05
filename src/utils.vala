namespace Raccoon {

public class Utils : Object {
    public Utils() {
    }

    public static string format_file_size (double bsize, form f) {
        string[] units = { "B", "KB", "MB", "GB", "PB" };
        int i = 0;
        int formats = 1000;

        if (f == FORM_XIB) {
            formats = 1024;
            units[1] = "KiB";
            units[2] = "MiB";
            units[3] = "GiB";
            units[4] = "PiB";
        }

        while (bsize >= formats && i < units.length - 1) {
            bsize /= formats;
            i += 1;
        }
        return ("%.2f".printf (bsize) + " " + units[i]);
    }

    public static GLib.Variant to_variant_uint64 (uint64 value) {
        return new GLib.Variant.uint64 (value);
    }

    public static uint64 from_variant_uint64 (GLib.Variant variant) {
        return variant.get_uint64();
    }
}

}
