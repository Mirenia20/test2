namespace Raccoon {
    public class DirectoryHistory : Object {
        private GLib.List<GLib.File> entries;
        private unowned GLib.List<GLib.File>? current = null;

        public DirectoryHistory() {
            entries = new GLib.List<GLib.File>();
        }



        public void add_file(GLib.File file) {
            if (current != null) {
                unowned GLib.List<GLib.File>? node = current.next;
                while (node != null) {
                    unowned GLib.List<GLib.File>? next = node.next;
                    entries.delete_link(node);
                    node = next;
                }
            }

            entries.append(file);            
            current = entries.last();        

        }





        public bool has_prev() {
            return current != null && current.prev != null;
        }

        public bool has_next() {
            return current != null && current.next != null;
        }

        public GLib.File? go_prev() {
            if (has_prev()) {
                current = current.prev;
                return current.data;
            }
            return null;
        }

        public GLib.File? go_next() {
            if (has_next()) {
                current = current.next;
                return current.data;
            }
            return null;
        }

        public GLib.File? get_current() {
            return current != null ? current.data : null;
        }
    }
}

