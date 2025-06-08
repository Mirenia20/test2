namespace Raccoon {

    public enum form { FORM_XIB, FORM_XB }
   
    public class Utils : GLib.Object {


        public static int64 recursive_size_file(GLib.File file) {
            int64 size = 0;

            try {
                var info = file.query_info("standard::type,standard::size", FileQueryInfoFlags.NONE);
                switch (info.get_file_type()) {
                    case FileType.REGULAR:
                        return info.get_size();

                    case FileType.DIRECTORY:
                        var enumerator = file.enumerate_children("standard::name", FileQueryInfoFlags.NONE);
                        FileInfo? file_info;

                        while ((file_info = enumerator.next_file()) != null) {
                            var child = file.get_child(file_info.get_name());
                            size += recursive_size_file(child);
                        }
                        break;

                    default:
                        break;
                }
            } catch (Error e) {
                warning("Size error for file %s: %s", file.get_uri(), e.message);
            }

            return size;
        }







        public static void delete_files_recursive(string uri) {
            var dir = File.new_for_uri(uri);

            try {
                var enumerator = dir.enumerate_children(
                    FileAttribute.STANDARD_NAME,
                    FileQueryInfoFlags.NONE
                    );

                FileInfo? info;
                while ((info = enumerator.next_file()) != null) {
                    var child = dir.get_child(info.get_name());

                    if (child.query_file_type(FileQueryInfoFlags.NONE, null) == FileType.DIRECTORY) {
                        // Recursively delete contents of the subdirectory
                        delete_files_recursive(child.get_uri());
                    } else {
                        child.delete();
                    }
                }

                // After deleting all contents, delete the now-empty directory
                dir.delete();
            } catch (Error e) {
                stderr.printf("Error deleting %s: %s\n", uri, e.message);
            }
        }


        //add unit test for this func

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

    public static int64 get_recursive_size(GLib.File file) {
        int64 size = 0;
        try {
            var info = file.query_info("standard::type,standard::size", FileQueryInfoFlags.NONE);
            switch (info.get_file_type()) {
                case FileType.REGULAR:
                    return info.get_size();
                case FileType.DIRECTORY:
                    var enumerator = file.enumerate_children("standard::name", FileQueryInfoFlags.NONE);
                    FileInfo? file_info;
                    while ((file_info = enumerator.next_file()) != null) {
                        var child = file.get_child(file_info.get_name());
                        size += get_recursive_size(child);
                    }
                    break;
                default:
                    break;
            }
        } catch (Error e) {
            warning("Size error for file %s: %s", file.get_uri(), e.message);
        }
        return size;
    }

    public static uint number_of_folder_children (File f) {
        var folder = f.enumerate_children ("standard::name",
                                           FileQueryInfoFlags.NONE, null);
        uint counter = 0;
        FileInfo file_info;
        while ((file_info = folder.next_file ()) != null) {
            counter++;
        }
        return counter;
    }

    public static string get_icon_from_mime_type (string mime_type) {
        if (mime_type.has_prefix ("text/")) {
            return "text-x-generic";
        } else if (mime_type.has_prefix ("image/")) {
            return "image-x-generic";
        } else if (mime_type == "inode/directory") {
            return "folder";
        }
        return "application-x-unknown";
    }
}

}

