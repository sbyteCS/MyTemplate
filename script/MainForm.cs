using Eto.Forms;
using Eto.Drawing;

namespace script;

public class MainForm : Form
{
    public MainForm()
    {
        Title = "MyTemplate UI";
        ClientSize = new Size(400, 200);

        var label = new Label { Text = "Bem-vindo ao MyTemplate UI!", TextAlignment = TextAlignment.Center };
        var btn = new Button { Text = "Clique aqui" };

        btn.Click += (s, e) =>
        {
            MessageBox.Show(this, "Você clicou no botão!");
        };

        Content = new StackLayout
        {
            Padding = 20,
            Items =
            {
                label,
                btn
            }
        };
    }
}
