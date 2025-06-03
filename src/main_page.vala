/* window.vala
 *
 * Copyright 2025 Unknown
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
namespace Raccoon{
[GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/main_page.ui")]
public class MainPage : Adw.NavigationPage {
    [GtkChild]
    private  unowned  Gtk.Button history_button;
    [GtkChild]
    private  unowned  Gtk.Button analysis_button;
    [GtkChild]
    private unowned Gtk.Image icon_fill;
    [GtkChild]
    private  unowned  Gtk.Box hint_box;

    [GtkChild]
    private  unowned  Gtk.Label last_cleanup;

    private GLib.Settings settings_pref;

    private string[] uris;




    public MainPage (){
    }    
    private void history_display(){
        var history_dialog = new Raccoon.HistoryDialog(this);

    }

    construct{
        history_button.clicked.connect (history_display);
        analysis_button.clicked.connect (analysis);
   
        icon_fill.add_css_class ("full");
        icon_fill.add_css_class ("destructive-action");

        settings_pref = new GLib.Settings("Raccoon.jh.xz");

        uris = settings_pref.get_strv("uris");
      
        if(uris.length == 0 ){
            analysis_button.set_sensitive(false);
            hint_box.set_visible(true);
        } else {
            hint_box.set_visible(false);
        }
        

        settings_pref.changed["uris"].connect (() => {
            string[] uriss = settings_pref.get_strv("uris");
            bool has_uris = uriss.length != 0;

            hint_box.set_visible(!has_uris);
            analysis_button.set_sensitive(has_uris);
        });


        var date = settings_pref.get_string("last-cleanup");
        last_cleanup.set_label("Last cleanup:\n"+date); 



    }



    private void analysis(){

    icon_fill.set_from_icon_name ("user-trash-symbolic");
    icon_fill.remove_css_class ("full");

    bool all_valid = true;
    foreach (var uri in uris) {
        var file = GLib.File.new_for_uri(uri);
        if (!file.query_exists()) {
            all_valid = false;
            break;
        }
    }

    if (!all_valid) {
        var dialog = new Adw.MessageDialog(
            this.get_root() as Gtk.Window,
            "Invalid Path",
            "One or more excluded directories do not exist. Please check your settings."
        );
        dialog.set_response_enabled("ok", true);
        dialog.add_response("ok", "OK");
        dialog.set_default_response("ok");
        dialog.set_close_response("ok");
        dialog.present();
        return;
    }

    var parent = this.get_parent();
    while (parent != null && !(parent is Adw.NavigationView)) {
        parent = parent.get_parent();
    }

    if (parent is Adw.NavigationView) {
        var nav_view = parent as Adw.NavigationView;

        var page = nav_view.find_page("analysis");

        if (page == null) {
            print("Page not found. Creating one.\n");

            var analysis_page = new Raccoon.AnalysisPage((Adw.NavigationView)parent);
            analysis_page.set_name("analysis");

            nav_view.push(analysis_page);

        } else {
            nav_view.push(page);
        }
    }
    }

}
}

