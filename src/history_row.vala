
namespace Raccoon{
[GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/history_row.ui")]
public class HistoryRow : Adw.ActionRow {
    [GtkChild] private unowned Gtk.Label date_label;
    [GtkChild] private unowned Gtk.Label path_label;
    [GtkChild] private unowned Gtk.Label size_label;

    public HistoryRow(string date, string path, string size) {
        Object(); // Required to finish template setup
        date_label.label = date;
        path_label.label = path;
        size_label.label = size;
    }

}
}
