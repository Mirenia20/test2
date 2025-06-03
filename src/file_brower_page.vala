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
[GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/analysis_page.ui")]
public class  FileBrowserPage: Adw.NavigationPage {


   /* public MainPage (Adw.NavigationView viewer){
       viewer.pop();


    }*/
    //[GtkChild]
  // private  unowned  Gtk.Button ;

    //sin
   //public signal void analysis_completed ();
      public FileBrowserPage (Adw.NavigationView viewer){


       }



    construct{
             //   analysis_completed (//pop up self page);
             var settings_pref = new Settings ("Raccoon.jh.xz");
                var uris = settings_pref.get_strv ("uris");
                    foreach (var uri in uris){
                        list_directory(uri);
                    }
    }
            void list_directory(string uri) {
                try {
                    // Create a GLib.File from URI
                    File file = File.new_for_uri(uri);

                    // Check if it exists and is a directory
                    FileInfo info = file.query_info("standard::type", FileQueryInfoFlags.NONE, null);
                    if (info.get_file_type() == FileType.DIRECTORY) {
                        print("Directory: %s\n", uri);

                        // Enumerate the children
                        FileEnumerator enumerator = file.enumerate_children("standard::name,standard::type", FileQueryInfoFlags.NONE, null);
                        FileInfo child_info;

                        while ((child_info = enumerator.next_file(null)) != null) {
                            string name = child_info.get_name();
                            FileType type = child_info.get_file_type();

                            if (type == FileType.DIRECTORY) {
                                print("[DIR ] %s\n", name);
                            } else if (type == FileType.REGULAR) {
                                print("[FILE] %s\n", name);
                            } else {
                                print("[OTHER] %s\n", name);
                            }
                        }
                    } else {
                        print("The URI is not a directory.\n");
                    }
                } catch (Error e) {
                    print("Error: %s\n", e.message);
                }
            }


    }




}

