/* main.vala
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

int main (string[] args) {
    //Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
    //Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
    //Intl.textdomain (Config.GETTEXT_PACKAGE);

    var app = new Raccoon.Application ();
    return app.run (args);
}
