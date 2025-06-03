//enum{succes,warning};
namespace Raccoon{
[GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/path_row.ui")]
public class PathRow : Gtk.Box {
   [GtkChild]
   private  unowned  Gtk.Button  clear_button;
   [GtkChild]
   private unowned Gtk.Entry path_entry;
   [GtkChild]
   private unowned Gtk.Image icon_status;
//where is initilization of this func
   public signal void removed (Raccoon.PathRow row);

    private unowned string path;
    //change to get GLib.File than just string
    public PathRow (string path) {
        //Object (path: path);
        //
        this.path = path;
         icon_status.add_css_class ("status");
     //   print(path);
        path_entry.set_text(path);
    }

        //check duplicate
    construct{


        clear_button.clicked.connect (() => {removed (this); });

        path_entry.changed.connect(is_exist);


    }

        //GtkEntry:placeholder-text


    //unload
    //         //strange
    private void  is_exist(){

                 print("is exist?");
         if (path_entry.get_text_length() == 0 ){
            icon_status.remove_css_class ("path-not-valid");
            icon_status.remove_css_class ("path-valid");
                         print("text null");
            return;
        }

/*        Posix.Stat sb;


        Posix.stat(path, out sb);
        //0 - not exist i node
        if((uint)sb.st_ino > 0){*/
        var uri = path_entry.get_text();
        var file = File.new_for_uri (uri);
        if(file.query_exists (null)){
                             debug(" exist");
            icon_status.add_css_class ("path-valid");
            icon_status.remove_css_class ("path-not-valid");
            return;
        }

        icon_status.remove_css_class ("path-valid");
        icon_status.add_css_class ("path-not-valid");
        //print(((uint)sb.st_ino).to_string());
        //print("\n");

    }

    public string get_path(){return path;}
    
    public void set_path(string path){
        path_entry.set_text(path);
    }

}
}
