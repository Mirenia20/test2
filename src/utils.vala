namespace Raccoon {
public class Utils : Object {
    public static inline uint number_of_folder_children (File f) {
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

