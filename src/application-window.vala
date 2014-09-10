namespace Example {

    [GtkTemplate (ui = "/org/gtk/exampleapp/window.ui")]
    public class ApplicationWindow : Gtk.ApplicationWindow {

        [GtkChild]
        private Gtk.Stack stack;
        [GtkChild]
        private Gtk.ToggleButton search;
        [GtkChild]
        private Gtk.SearchBar searchbar;
        [GtkChild]
        private Gtk.SearchEntry searchentry;

        private GLib.Settings settings;

        public ApplicationWindow (Gtk.Application application) {
            GLib.Object (application: application);

            settings = new GLib.Settings ("org.gtk.exampleapp");

            settings.bind ("transition", stack, "transition-type",
                           GLib.SettingsBindFlags.DEFAULT);

            search.bind_property ("active", searchbar, "search-mode-enabled",
                                  GLib.BindingFlags.BIDIRECTIONAL);
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

            search.sensitive = true;
        }

        [GtkCallback]
        public void visible_child_changed () {
        }

        [GtkCallback]
        public void search_text_changed () {
            var text = searchentry.get_text ();

            if (text == "")
                return;

            var tab = stack.get_visible_child () as Gtk.Bin;
            var view = tab.get_child () as Gtk.TextView;
            var buffer = view.get_buffer ();

            /* Very simple-minded search implementation */
            Gtk.TextIter start, match_start, match_end;
            buffer.get_start_iter (out start);
            if (start.forward_search (text, Gtk.TextSearchFlags.CASE_INSENSITIVE,
                                      out match_start, out match_end, null)) {
                buffer.select_range (match_start, match_end);
                view.scroll_to_iter (match_start, 0.0, false, 0.0, 0.0);
            }
        }
    }
}
