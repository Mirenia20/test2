namespace Raccoon {

/**
 * Utility functions related to application settings.
 */
public static bool has_paths(GLib.Settings settings) {
    return settings.get_strv("uris").length != 0;
}

}

