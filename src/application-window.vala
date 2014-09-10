namespace Example {

    [GtkTemplate (ui = "/org/gtk/exampleapp/window.ui")]
    public class ApplicationWindow : Gtk.ApplicationWindow {

        [GtkChild]
        private Gtk.Stack stack;

        private GLib.Settings settings;

        public ApplicationWindow (Gtk.Application application) {
            GLib.Object (application: application);

            settings = new GLib.Settings ("org.gtk.exampleapp");

            settings.bind ("transition", stack, "transition-type",
                           GLib.SettingsBindFlags.DEFAULT);
        }

        public void open (GLib.File file) {
            var basename = file.get_basename ();
            var font_name = settings.get_string ("font");
            var font = Pango.FontDescription.from_string (font_name);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.show ();
            scrolled.hexpand = true;
            scrolled.vexpand = true;

            var view = new Gtk.TextView ();
            view.editable = false;
            view.cursor_visible = false;
            view.override_font (font);
            view.show ();

            scrolled.add (view);
            stack.add_titled (scrolled, basename, basename);

            try {
                uint8[] contents;
                if (file.load_contents (null, out contents, null)) {
                    var buffer = view.get_buffer ();
                    buffer.set_text ((string)contents);
                }
            } catch (GLib.Error e) {
                GLib.warning ("There was an error loading '%s': %s",
                              basename, e.message);
            }
        }
    }
}
