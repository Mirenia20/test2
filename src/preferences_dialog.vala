namespace Raccoon{

[GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/preferences_dialog.ui")]
public class PreferencesDialog : Adw.PreferencesDialog {
    [GtkChild]
    private unowned Gtk.Box enty_dirs_box;
    //[GtkChild]
    private unowned Gtk.Image sheldule_clean;

    [GtkChild]
    private unowned Gtk.Button add_path_button;
    private GLib.Settings settings_pref;

    public PreferencesDialog (Raccoon.Window parent) {

        this.present(parent);

    }

    construct{


    var display = Gdk.Display.get_default ();
    var theme =  Gtk.IconTheme.get_for_display(Gdk.Display.get_default());
    string[] icons = theme.get_icon_names ();


        settings_pref = new GLib.Settings("Raccoon.jh.xz");

        foreach (var uri in settings_pref.get_strv ("uris")) {
                var file = File.new_for_uri (uri);
                var row = new Raccoon.PathRow (file.get_uri());
                row.removed.connect((r) => {
                    enty_dirs_box.remove(r);
                    Utils.remove_uri(uri);
                });


                enty_dirs_box.append (row);
         
        }


        add_path_button.clicked.connect (  ()=>{
            add_new_path();

       /*        try {
                  var fileDialog = new Gtk.FileDialog();
                   var file =   yield fileDialog.select_folder(parent,null);

              } catch (Error e) {
                 stdout.printf ("Error: %s\n", e.message);
              }
*/
        });



    }

    public async GLib.File open_dir(Gtk.Window parent_window) {
        GLib.File folder = null;
        var dialog = new Gtk.FileDialog();
        dialog.set_accept_label(_("_OK"));
        var start_folder = GLib.File.new_for_path("/");
        dialog.set_initial_folder(start_folder);
        dialog.set_modal(true);
        dialog.set_title("Select folder for cleaning");

        try {
            folder = yield dialog.select_folder(parent_window, null);
        } catch (Error error) {
            print("Failed to choose folder: %s", error.message);
        }

        return folder;
    }



   private async void add_new_path() {
    var parent = this.get_root() as Gtk.Window;
    var folder_path = yield open_dir(parent);


         if (folder_path == null) {
                debug("No folder selected.");
                return;
            }

            string uri = folder_path.get_uri();

            if (is_uri_added(uri)) {
                debug("Folder already added: %s", uri);
                return;
            }



        var path_row = new Raccoon.PathRow(uri);
        enty_dirs_box.append(path_row);
        Utils.add_uri(uri);
        path_row.removed.connect((r) => {
            enty_dirs_box.remove(r);
            Utils.remove_uri(uri);
        });
    
}

private bool is_uri_added(string uri) {
    var uris = settings_pref.get_strv("uris");
    return uri in uris;
}

  
    //string get_actual_paths():
        //
        //  if (file.has_uri_scheme ("file")) {
        /*        title = file.get_path ();
            } else {
                title = file.get_uri ();
            }*/
           // Utils.remove_uri (uri);

    private void set_path_to_gsettings(){}
    private Gee.ArrayList<string> get_actual_paths(){
            var list = new Gee.ArrayList<string> ();
            return list;


 /* try {
              var fileDialog = new Gtk.FileDialog();
              return yield fileDialog.select_folder(window,null);

          } catch (Error e) {
             stdout.printf ("Error: %s\n", e.message);
          }
          return null;*/


/*
         *
         *
         * Gtk.Widget? chilsd = box.get_first_child();
while (child != null) {
    // do something with child, e.g. remove it
    box.remove(child);
    child = child.get_next_sibling();
}
*/     //observ

        //create list
         //   enty_dirs_box.childs

        //enum
         //if( Raccoon.sucees == child.get_status_path()){}
             //add ot list


    }
}

}
