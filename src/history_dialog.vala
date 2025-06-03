using GLib.Path;


namespace Raccoon{
    [GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/history_dialog.ui")]
    public class HistoryDialog : Adw.Dialog {
        [GtkChild]
        private  unowned  Gtk.Button  clear_all;
        [GtkChild]
        private unowned Gtk.ListBox listbox_history;

        private string path_file_history; 
        public HistoryDialog (Gtk.Widget parent) {

            this.present(parent);

        }


        construct{ 
        
            path_file_history = GLib.Environment.get_user_data_dir() + "/Raccoon/history.gvb";

            load_history();
            clear_all.clicked.connect(clear_history);

        }

        private void clear_history() {
               
            var file = GLib.File.new_for_path(path_file_history);

            try {
                if (file.query_exists()) {
                    file.delete();
                }


                var row = listbox_history.get_first_child();
                while (row != null) {
                    // save next before remova
                    var next = row.get_next_sibling(); 
                    listbox_history.remove(row);
                    row = next;
                }

            } catch (Error e) {
                warning("Error clearing history: %s", e.message);
            }
        }

        public void load_history() {
            try {
                // Build file path (you must define path_file_history elsewhere)
                var file = GLib.File.new_for_path(path_file_history);
                if (!file.query_exists()) return;

                // Load contents with 3 args
                uint8[] data;
                file.load_contents(null, out data, null);

                // Convert uint8[] to GLib.Bytes
                var bytes = new GLib.Bytes(data);

                // Deserialize from GLib.Variant
                var variant = new GLib.Variant.from_bytes(
                    new GLib.VariantType("a(sss)"), bytes, false
                    );

                // Iterate through array of (string, string, string)
                for (int i = 0; i < variant.n_children(); i++) {
                    var child = variant.get_child_value(i);
                    string date = child.get_child_value(0).get_string();
                    string path = child.get_child_value(1).get_string();
                    string size = child.get_child_value(2).get_string();

                    // Create a HistoryRow with this data
                    var row = new Raccoon.HistoryRow(date, path, size);
                    listbox_history.append(row);
                }

            } catch (Error e) {
                warning("Failed to load history.gvb: %s", e.message);
            }
        }



    


    }
}
