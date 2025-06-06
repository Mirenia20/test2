namespace Raccoon {
    public class DirectoryHistory : Object {
        private Gee.ArrayList<GLib.File> entries;
        private int index = -1;

        public DirectoryHistory() {
            entries = new Gee.ArrayList<GLib.File>();
        }

        public void add_file(GLib.File file) {
            while (entries.size - 1 > index) {
                entries.remove_at(entries.size - 1);
            }
            entries.add(file);
            index = entries.size - 1;
        }

        public bool has_prev() {
            return index > 0;
        }

        public bool has_next() {
            return index >= 0 && index < entries.size - 1;
        }

        public GLib.File? go_prev() {
            if (has_prev()) {
                index--;
                return entries.get(index);
            }
            return null;
        }

        public GLib.File? go_next() {
            if (has_next()) {
                index++;
                return entries.get(index);
            }
            return null;
        }

        public GLib.File? get_current() {
            if (index >= 0 && index < entries.size) {
                return entries.get(index);
            }
            return null;
        }
    }
}
