namespace Example {

    public class Application : Gtk.Application {

        private ApplicationWindow window;

        public Application () {
            application_id = "org.gtk.exampleapp";
            flags |= GLib.ApplicationFlags.HANDLES_OPEN;
        }

        public override void activate () {
            window = new ApplicationWindow (this);
            window.present ();
        }

        public override void open (GLib.File[] files,
                                   string      hint) {
            if (window == null)
                window = new ApplicationWindow (this);

            foreach (var file in files)
                window.open (file);

            window.present ();
        }
    }
}
