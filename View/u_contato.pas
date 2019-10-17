unit u_contato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels;

type
  Tfr_contato = class(TFrame)
    CardPanel1: TCardPanel;
    lbl_contato: TLabel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
