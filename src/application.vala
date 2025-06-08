/* application.vala
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
public class Application : Adw.Application {
    public Application () {
        Object (
            application_id: "Raccoon.jh.xz",
            flags: ApplicationFlags.DEFAULT_FLAGS,
            resource_base_path: "/Raccoon/jh/xz/data"
        );
    }

    construct {


       ActionEntry[] action_entries = {
            { "about", this.on_about_action },
            { "preferences", this.on_preferences_action },
            { "quit", this.quit }
        };
        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", {"<primary>q"});
    }

    public override void activate () {
        base.activate ();
        print("asdf");
        var win = this.active_window ?? new Raccoon.Window (this);
        print("asdf");
        win.present ();
    }

    private void on_about_action () {
        string[] developers = { "Unknown" };
        var about = new Adw.AboutDialog () {
            application_name = "raccoon",
            application_icon = "Raccoon.jh.xz",
            developer_name = "Unknown",
            translator_credits = _("translator-credits"),
            version = "0.1.0",
            developers = developers,
            copyright = " 2025 Unknown",
        };

        about.present (this.active_window);
    }

    private void on_preferences_action () {
        message ("app.preferences action activated");
         var win = this.active_window ?? new Raccoon.Window (this);
        var preferences =  new Raccoon.PreferencesDialog((Raccoon.Window)win);


    }
}
}
