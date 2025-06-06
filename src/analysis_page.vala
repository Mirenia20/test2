/* analysis_page.vala
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

    public enum form { FORM_XIB, FORM_XB }


    [GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/analysis_page.ui")]
    public class  AnalysisPage: Adw.NavigationPage {
        private bool selection_mode = false;


        [GtkChild]
        private unowned Gtk.SearchBar searchbar;
        [GtkChild]
        private unowned Gtk.SearchEntry searchentry;

        private Gtk.FilterListModel? filtered_model = null;
        private Gtk.StringFilter? name_filter = null;

        [GtkChild]
        private unowned Gtk.ListView list_view;

        [GtkChild]
        private unowned  Gtk.Button clean_button;

        [GtkChild]
        private unowned  Adw.WindowTitle total_size;



        [GtkChild]
        private unowned  Gtk.Button prev_button;
        [GtkChild]
        private unowned  Gtk.Button next_button;



        [GtkChild]
        private unowned  Gtk.Button cancel_button;
        [GtkChild]
        private unowned  Gtk.Button select_all_button;



        [GtkChild]
        private unowned Adw.HeaderBar top_headbar;

        [GtkChild]
        private unowned Adw.HeaderBar bottom_headbar;


        [GtkChild]
        private unowned  Gtk.Button search_button;

        [GtkChild]
        private unowned  Gtk.Button selection_button;

        [GtkChild]
        private unowned Gtk.SignalListItemFactory item_factory;


        private Adw.NavigationView viewer;

        public AnalysisPage(Adw.NavigationView viewer) {
            this.viewer = viewer;
        }


        construct {
            var model = new GLib.ListStore(typeof(GLib.File));
            var multi = new Gtk.MultiSelection(model);
            list_view.model = multi;
            list_view.factory = item_factory;

            var settings_pref = new Settings("Raccoon.jh.xz");

            var virtual_root = GLib.File.new_for_uri("virtual://root");
            List<GLib.File> history = new List<GLib.File>();
            history.append(virtual_root);
            unowned List<GLib.File>? current = history.last();

            refresh_virtual_root(model, settings_pref);



            searchentry.search_changed.connect(() => {
                if (!searchbar.search_mode_enabled)
                    return;

                string query = searchentry.text.strip().down();
                model.remove_all();

                if (query.length > 0) {
                    foreach (var uri in settings_pref.get_strv("uris")) {
                        var file = GLib.File.new_for_uri(uri);
                        if (file.query_exists()) {
                            search_and_append_recursive(model, file, query);
                        }
                    }
                }
            });






            var key_controller = new Gtk.EventControllerKey();
            searchentry.add_controller(key_controller);

            key_controller.key_pressed.connect((keyval, keycode, state) => {
                if (keyval == Gdk.Key.Escape && searchbar.search_mode_enabled) {
                    searchbar.search_mode_enabled = false;
                    bottom_headbar.set_visible(true);
                    searchentry.set_text("");
                    refresh_virtual_root(model, settings_pref);
                    list_view.set_factory(null);
                    list_view.set_factory(item_factory);
                    return true;
                }
                return false;
            });




            search_button.clicked.connect(() => {
                searchbar.search_mode_enabled = !searchbar.search_mode_enabled;

                if (searchbar.search_mode_enabled) {
                    bottom_headbar.set_visible(false);
                    model.remove_all();
                } else {
                    bottom_headbar.set_visible(true);
                    searchentry.set_text("");
                    refresh_virtual_root(model, settings_pref);
                    list_view.set_factory(null);
                    list_view.set_factory(item_factory);

                }
            });



            top_headbar.pack_end(cancel_button);
            top_headbar.pack_start(select_all_button);

            cancel_button.clicked.connect(() => {
                selection_mode = false;
                cancel_button.set_visible(false);
                select_all_button.set_visible(false);
                top_headbar.set_show_back_button(true);
                selection_button.set_visible(true);
                list_view.set_factory(null);
                list_view.set_factory(item_factory);
            });

            selection_button.clicked.connect(() => {
                selection_mode = true;
                cancel_button.set_visible(true);
                select_all_button.set_visible(true);
                top_headbar.set_show_back_button(false);
                selection_button.set_visible(false);
                list_view.set_factory(null);
                list_view.set_factory(item_factory);
            });

            clean_button.clicked.connect(() => {
                int64 total_cleaned = 0;
                foreach (var uri in settings_pref.get_strv("uris")) {
                    var file = GLib.File.new_for_uri(uri);
                    if (file.query_exists()) {
                        total_cleaned += Utils.get_recursive_size(file);
                        delete_files_recursive(uri);
                    }
                }

                selection_mode = false;
                cancel_button.set_visible(false);
                select_all_button.set_visible(false);
                top_headbar.set_show_back_button(true);
                selection_button.set_visible(true);

                refresh_virtual_root(model, settings_pref);

                prev_button.sensitive = false;
                next_button.sensitive = false;

                list_view.set_factory(null);
                list_view.set_factory(item_factory);

                var parent_window = (Gtk.Window) this.get_root();
                show_summary_dialog(parent_window, total_cleaned);

                var now = new GLib.DateTime.now_local();
                settings_pref.set_string("last-cleanup", now.format("%Y-%m-%d %H:%M:%S"));

                string timestamp = now.format("%Y.%m.%d %H:%M");
                string size_label = Utils.format_file_size((double) total_cleaned, FORM_XIB);
                foreach (var uri in settings_pref.get_strv("uris")) {
                    var file = GLib.File.new_for_uri(uri);
                    if (file.query_exists()) {
                        string path = file.get_path() ?? uri;
                        save_history_entry(timestamp, path, size_label);
                    }
                }

                viewer.pop();
            });

            prev_button.clicked.connect(() => {
                if (current != null && current.prev != null) {
                    current = current.prev;

                    if (current.data.get_uri() == "virtual://root/") {
                        refresh_virtual_root(model, settings_pref);
                        ((Adw.WindowTitle) top_headbar.title_widget).title = "~";
                    } else {
                        handle_navigation(model, current.data, settings_pref.get_strv("uris"));
                        create_files_lists(model, current.data);
                        ((Adw.WindowTitle) top_headbar.title_widget).title = current.data.get_path();
                    }
                    update_navigation_buttons(prev_button, next_button, current);
                }
            });

            next_button.clicked.connect(() => {
                if (current != null && current.next != null) {
                    current = current.next;
                    create_files_lists(model, current.data);
                    handle_navigation(model, current.data, settings_pref.get_strv("uris"));
                    update_navigation_buttons(prev_button, next_button, current);
                    ((Adw.WindowTitle) top_headbar.title_widget).title = current.data.get_uri();
                }
            });

            multi.selection_changed.connect(() => {
                var selection = multi.get_selection();
                for (uint i = 0; i < model.get_n_items(); i++) {
                    if (selection.contains(i)) {
                        var file = model.get_item(i) as GLib.File;
                        if (file == null) continue;

                        var info = file.query_info("standard::type", FileQueryInfoFlags.NONE);
                        if (info.get_file_type() == FileType.DIRECTORY) {
                            history.append(file);
                            current = history.last();
                            create_files_lists(model, file);
                            update_navigation_buttons(prev_button, next_button, current);
                            ((Adw.WindowTitle) top_headbar.title_widget).title = file.get_path();
                        }
                    }
                }

                update_total_size_from_settings(settings_pref.get_strv("uris"));
            });

            update_total_size_from_settings(settings_pref.get_strv("uris"));

            item_factory.setup.connect(on_list_view_setup);
            item_factory.bind.connect(on_list_view_bind);
        }




        private void refresh_virtual_root(GLib.ListStore model, Settings settings) {
            model.remove_all();
            foreach (var uri in settings.get_strv("uris")) {
                var file = GLib.File.new_for_uri(uri);
                if (file.query_exists()) {
                    print("Adding to model: %s\n", file.get_path());
                    model.append(file);
                } else {
                    print("NOT FOUND: %s\n", uri);
                }
            }
            list_view.set_factory(null);
            list_view.set_factory(item_factory);
        }

        private void search_and_append_recursive(GLib.ListStore model, GLib.File dir, string query) {
            try {
                var enumerator = dir.enumerate_children("standard::name,standard::type", FileQueryInfoFlags.NONE);

                FileInfo? info;
                while ((info = enumerator.next_file()) != null) {
                    var name = info.get_name();
                    var child = dir.get_child(name);

                    if (name.down().contains(query)) {
                        model.append(child);
                    }

                    if (info.get_file_type() == FileType.DIRECTORY) {
                        search_and_append_recursive(model, child, query);
                    }
                }
            } catch (Error e) {
                warning("Search error in %s: %s", dir.get_uri(), e.message);
            }
        }

        public void 
            handle_navigation(GLib.ListStore model, GLib.File file, string[] uris) {
                if (file.get_uri() == "virtual://root") {
                    show_virtual_root(model, uris);
                } else {
                    create_files_lists(model, file);
                }
            }


        public void 
            show_virtual_root(GLib.ListStore model, string[] uris) {
                model.remove_all();
                foreach (var uri in uris) {
                    var file = GLib.File.new_for_uri(uri);
                    if (file.query_exists()) {
                        model.append(file);
                    }
                }
            }


        public void 
            update_total_size_from_settings(string[] uris) {
                int64 total_bytes = 0;
                foreach (var uri in uris) {
                    var file = GLib.File.new_for_uri(uri);
                    if (file.query_exists()) {
                        total_bytes += Utils.get_recursive_size(file);
                    }
                }
                total_size.set_title(Utils.format_file_size(total_bytes, form.FORM_XB));
                total_size.set_subtitle("🗑 Will be deleted");
            }



        public void 
            update_effective_deletion_size_display(
                Gtk.MultiSelection multi,
                GLib.ListStore model) {
                int64 total_bytes = 0;
                int64 excluded_bytes = 0;

                for (uint i = 0; i < model.get_n_items(); i++) {
                    var file = model.get_item(i) as GLib.File;
                    if (file == null) continue;

                    int64 file_size = Utils.get_recursive_size(file);
                    total_bytes += file_size;

                    if (multi.get_selection().contains(i)) {
                        excluded_bytes += file_size;
                    }
                }

                int64 will_delete = total_bytes - excluded_bytes;

                total_size.set_title(Utils.format_file_size(will_delete, form.FORM_XB));
                total_size.set_subtitle("🗑 Will be deleted");
            }






        void show_summary_dialog(Gtk.Window parent, int64 bytes_cleaned) {
            var dialog = new Adw.MessageDialog(parent, "🧹 Cleaning Complete", null);
            dialog.set_body("You have cleaned " + Utils.format_file_size(bytes_cleaned, form.FORM_XB) + ".");
            dialog.add_response("ok", "_OK");
            dialog.set_default_response("ok");
            dialog.set_close_response("ok");

            dialog.response.connect((response_id) => {
                dialog.destroy();
            });

            dialog.present();
        }


        // later rewrite without recursion
        // dont return how much byte is deleted
        // and clean listview and cange to clened page
        // also add list which elm not need to delete
        // if dir is empty emmit toasts "dir is empty"and not go to this dir
        // rewritten iteratively to avoid deep recursion
        public void delete_files_recursive(string uri) {
            var root = File.new_for_uri(uri);
            var dirs = new Gee.ArrayList<File>();
            var delete_order = new Gee.ArrayList<File>();

            dirs.add(root);

            // depth-first traversal collecting directories
            while (dirs.size > 0) {
                var dir = dirs.remove_at(dirs.size - 1);
                delete_order.add(dir);

                try {
                    var enumerator = dir.enumerate_children(
                        FileAttribute.STANDARD_NAME 
                            + "," + FileAttribute.STANDARD_TYPE,
                        FileQueryInfoFlags.NONE);

                    FileInfo? info;
                    while ((info = enumerator.next_file()) != null) {
                        var child = dir.get_child(info.get_name());
                        if (info.get_file_type() == FileType.DIRECTORY) {
                            dirs.add(child);
                        } else {
                            child.delete();
                        }
                    }
                } catch (Error e) {
                    stderr.printf("Error enumerating %s: %s\n", dir.get_uri(), e.message);
                }
            }

            // delete directories in reverse order so children are removed first
            for (int i = delete_order.size - 1; i >= 0; i--) {
                try {
                    delete_order.get(i).delete();
                } catch (Error e) {
                    stderr.printf("Error deleting %s: %s\n", delete_order.get(i).get_uri(), e.message);
                }
            }
        }

        public void update_navigation_buttons (
            unowned Gtk.Button prev_button, unowned Gtk.Button next_button, 
            unowned List<GLib.File>? current
            ) {

            prev_button.sensitive = current != null && current.prev != null;
            next_button.sensitive = current != null && current.next != null;
        }

        public void create_files_lists (GLib.ListStore model, GLib.File file) {
            if (!file.query_exists ()) {
                // add print uri path

                print ("Directory does not exist: \n");
            }
            try {
                var enumerator = file.enumerate_children ("standard::name",
                                                          FileQueryInfoFlags.NONE,
                                                          null);
                model.remove_all ();
                FileInfo? file_info;
                // here check for emtpy folder
                while ((file_info = enumerator.next_file ()) != null) {

                    string name = file_info.get_name ();
                    GLib.File child = file.get_child (name);
                    model.append (child);
                    file_info = enumerator.next_file ();
                }
            } catch (Error e) {
                stderr.printf ("Error: %s\n", e.message);
            }    list_view.set_factory(null);
            list_view.set_factory(item_factory);
        }




        // in class add member File f in xxx_row



        private void 
            on_list_view_setup (Gtk.SignalListItemFactory factory, GLib.Object list_item) {

                var item = list_item as Gtk.ListItem;
                var row = new Adw.ActionRow ();
                var icon = new Gtk.Image ();
                var label = new Gtk.Label ("");
                var check = new Gtk.CheckButton();
                check.get_style_context().add_class("selection-check");

                icon.set_icon_size (Gtk.IconSize.LARGE);
                row.add_prefix (icon);
                row.add_suffix (label);
                row.add_suffix(check);


                //later exaplain
                row.set_data ("icon", icon);
                row.set_data ("label", label);
                row.set_data("check", check);
                item.set_child (row);
            }



        public void save_history_entry(string timestamp, string path, string size) {
            string dir = GLib.Environment.get_user_data_dir() + "/Raccoon";
            string file_path = dir + "/history.gvb";

            var file = GLib.File.new_for_path(file_path);
            var builder = new GLib.VariantBuilder(new GLib.VariantType("a(sss)"));

            // Load previous entries
            if (file.query_exists()) {
                try {
                    uint8[] data;
                    file.load_contents(null, out data, null); 
                    var bytes = new GLib.Bytes(data);         
                    var variant = new GLib.Variant.from_bytes(
                        new GLib.VariantType("a(sss)"),
                        bytes,
                        false
                        );

                    for (int i = 0; i < variant.n_children(); i++) {
                        var child = variant.get_child_value(i);
                        string d = child.get_child_value(0).get_string();
                        string p = child.get_child_value(1).get_string();
                        string s = child.get_child_value(2).get_string();
                        builder.add("(sss)", d, p, s);
                    }
                } catch (Error e) {
                    warning("Failed to read old history.gvb: %s", e.message);
                }
            }

            // Append new entry
            builder.add("(sss)", timestamp, path, size);
            var new_variant = builder.end();

            // Save

            // Save new_variant to file
            try {
                string? etag = null;
                var bytes = new_variant.get_data_as_bytes(); 
                file.get_parent().make_directory_with_parents(null);
                file.replace_contents(
                    bytes.get_data(),
                    null,
                    false,
                    GLib.FileCreateFlags.REPLACE_DESTINATION,
                    out etag,
                    null
                    );
            } catch (Error e) {
                warning("Failed to write history.gvb: %s", e.message);
            }
        }




        private void on_list_view_bind (Gtk.SignalListItemFactory factory, GLib.Object list_item) {

            var item = list_item as Gtk.ListItem;
            var row = item.get_child() as Adw.ActionRow;
            var file = item.get_item() as File;

            var icon = row.get_data<Gtk.Image>("icon");
            var label = row.get_data<Gtk.Label>("label");
            var check = row.get_data<Gtk.CheckButton>("check");

            try {
                var info = file.query_info(
                    "standard::name,standard::type,standard::size,standard::content-type",
                    FileQueryInfoFlags.NONE);

                var name = info.get_name();
                var size = info.get_size();
                var mime = info.get_content_type();
                var icon_name = Utils.get_icon_from_mime_type(mime);

                row.title = name;
                icon.set_from_icon_name(icon_name);

                if (info.get_file_type() == FileType.DIRECTORY) {
                    var n_items = Utils.number_of_folder_children(file);
                    label.label = (n_items != 0 ? n_items.to_string() + " items" : "Empty");
                } else {
                    label.label = Utils.format_file_size(size, FORM_XB);
                }

                // Store file in row to access later


                check.set_visible(selection_mode);
                if (selection_mode) {
                    check.get_style_context().add_class("visible");
                } else {
                    check.get_style_context().remove_class("visible");
                }
                row.set_data("file", file);
            } catch (Error e) {
                stderr.printf("Info error: %s\n", e.message);
            }
        }



    }
}

