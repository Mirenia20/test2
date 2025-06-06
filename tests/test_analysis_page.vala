using Gtk;
using Adw;
using Gee;

static File create_tmp_dir(out string path) {
    path = DirUtils.make_tmp("testXXXXXX");
    return File.new_for_path(path);
}

int main(string[] args) {
    Test.init(ref args);

    Test.add_func("number_of_folder_children", () => {
        string path;
        var dir = create_tmp_dir(out path);
        var view = new Adw.NavigationView();
        var page = new Raccoon.AnalysisPage(view);
        try {
            assert(page.number_of_folder_children(dir) == 0);
            var f1 = dir.get_child("a.txt");
            f1.create(FileCreateFlags.NONE);
            assert(page.number_of_folder_children(dir) == 1);
            var f2 = dir.get_child("b.txt");
            f2.create(FileCreateFlags.NONE);
            assert(page.number_of_folder_children(dir) == 2);
        } finally {
            try {
                dir.delete();
            } catch (Error e) {}
        }
    });

    Test.add_func("get_icon_from_mime_type", () => {
        var view = new Adw.NavigationView();
        var page = new Raccoon.AnalysisPage(view);
        assert(page.get_icon_from_mime_type("text/plain") == "text-x-generic");
        assert(page.get_icon_from_mime_type("image/png") == "image-x-generic");
        assert(page.get_icon_from_mime_type("inode/directory") == "folder");
        assert(page.get_icon_from_mime_type("application/unknown") == "application-x-unknown");
    });

    Test.add_func("get_recursive_size", () => {
        string path;
        var dir = create_tmp_dir(out path);
        var view = new Adw.NavigationView();
        var page = new Raccoon.AnalysisPage(view);
        try {
            var f1 = dir.get_child("a.txt");
            var out1 = f1.create(FileCreateFlags.NONE);
            out1.write(new uint8[]{0,1,2,3}, null);
            out1.close();
            var subdir = dir.get_child("sub");
            subdir.make_directory();
            var f2 = subdir.get_child("b.txt");
            var out2 = f2.create(FileCreateFlags.NONE);
            out2.write(new uint8[]{0,1}, null);
            out2.close();
            assert(page.get_recursive_size(dir) == 6);
        } finally {
            try { dir.delete(); } catch (Error e) {}
        }
    });

    Test.add_func("delete_files_recursive", () => {
        string path;
        var dir = create_tmp_dir(out path);
        var view = new Adw.NavigationView();
        var page = new Raccoon.AnalysisPage(view);
        try {
            var subdir = dir.get_child("sub");
            subdir.make_directory();
            var f1 = subdir.get_child("a.txt");
            f1.create(FileCreateFlags.NONE);
            page.delete_files_recursive(dir.get_uri());
            assert(!dir.query_exists());
        } finally {
            // nothing
        }
    });

    return Test.run();
}
