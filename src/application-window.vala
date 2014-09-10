namespace Example {

    public class ApplicationWindow : Gtk.ApplicationWindow {

        public ApplicationWindow (Gtk.Application application) {
            GLib.Object (application: application);
        }

        public void open (GLib.File file) {
        }
    }
}
