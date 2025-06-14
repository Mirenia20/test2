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
    [GtkTemplate (ui = "/Raccoon/jh/xz/data/ui/window.ui")]
    public class Window : Adw.ApplicationWindow {

        [GtkChild]
        private  unowned Adw.NavigationView nav_view;
        private  Raccoon.MainPage main_page;
      
        public Window (Gtk.Application app) {
            Object (application: app);


            var theme = Gtk.IconTheme.get_for_display(Gdk.Display.get_default());
            theme.add_resource_path("/Raccoon/jh/xz/resources/icons/symbolic");
            theme.add_resource_path("/Raccoon/jh/xz/icons");
        }

        construct{
            main_page =  new Raccoon.MainPage();
            nav_view.push(main_page);
        }


    }
}
