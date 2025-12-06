using Eto.Forms;
using Eto.GtkSharp;

namespace script;

public static class Program
{
    [STAThread]
    public static void Main(string[] args)
    {
        Native.main();
        new Application(Eto.Platforms.Gtk).Run(new MainForm());
    }
}
