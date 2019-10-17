//TInject Criado por Mike W. Lustosa
//TInject Criado por Mike W. Lustosa
//Códido aberto à comunidade Delphi
//mikelustosa@gmail.com

unit u_autenticaWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uCEFChromium,
  uCEFWinControl, uCEFWindowParent,

  //units adicionais obrigatórias
  uCEFInterfaces, uCEFConstants, uCEFTypes, UnitCEFLoadHandlerChromium, uCEFApplication,
  Vcl.StdCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, System.JSON,
  Vcl.Buttons, Vcl.Imaging.pngimage;

  const
    CEFBROWSER_CREATED          = WM_APP + $100;
    CEFBROWSER_CHILDDESTROYED   = WM_APP + $101;
    CEFBROWSER_DESTROY          = WM_APP + $102;

type
  Tfrm_autenticaWhats = class(TForm)
    CEFWindowParent1: TCEFWindowParent;
    Chromium1: TChromium;
    Timer1: TTimer;
    Timer2: TTimer;
    memo_js: TMemo;
    Panel1: TPanel;
    Memo1: TMemo;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; const targetUrl, targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess,
      Result: Boolean);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser;
      var aAction: TCefCloseBrowserAction);
    procedure Chromium1ConsoleMessage(Sender: TObject;
      const browser: ICefBrowser; level: Cardinal; const message,
      source: ustring; line: Integer; out Result: Boolean);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure Chromium1OpenUrlFromTab(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition;
      userGesture: Boolean; out Result: Boolean);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser;
      const title: ustring);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
  protected
   // Variáveis para controlar quando podemos destruir o formulário com segurança
    FCanClose : boolean;  // Defina como True em TChromium.OnBeforeClose
    FClosing  : boolean;  // Defina como True no evento CloseQuery.

    // You have to handle this two messages to call NotifyMoveOrResizeStarted or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    // You also have to handle these two messages to set GlobalCEFApp.OsmodalLoop
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;

    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;
  private
    { Private declarations }

  public
    { Public declarations }
    JS1: string;
    autenticado: boolean;
    i: integer;
    procedure Send(vNum, vText:string);
    procedure SendBase64(vBase64, vNum, vFileName, vText:string);
    function caractersWhats(vText: string): string;
  end;

var
  frm_autenticaWhats: Tfrm_autenticaWhats;

implementation

{$R *.dfm}

Function removeCaracter(texto : String) : String;
Begin

  While pos('-', Texto) <> 0 Do
    delete(Texto,pos('-', Texto),1);

  While pos('/', Texto) <> 0 Do
    delete(Texto,pos('/', Texto),1);

  While pos(',', Texto) <> 0 Do
    delete(Texto,pos(',', Texto),1);

  Result := Texto;
End;

function Tfrm_autenticaWhats.caractersWhats(vText: string): string;
begin
 vText := StringReplace(vText, sLineBreak,'\n',[rfReplaceAll]);
 vText := StringReplace((vText), #13,'',[rfReplaceAll]);
 Result := vText;
end;

procedure Tfrm_autenticaWhats.BrowserDestroyMsg(var aMessage : TMessage);
begin
  CEFWindowParent1.Free;
end;

procedure Tfrm_autenticaWhats.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure Tfrm_autenticaWhats.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure Tfrm_autenticaWhats.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := True;
end;

procedure Tfrm_autenticaWhats.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := False;
end;

procedure Tfrm_autenticaWhats.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  { Agora que o navegador está totalmente inicializado, podemos enviar uma mensagem para
    o formulário principal para carregar a página inicial da web.}
  //PostMessage(Handle, CEFBROWSER_CREATED, 0, 0);
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure Tfrm_autenticaWhats.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure Tfrm_autenticaWhats.Chromium1BeforePopup(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl,
  targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition;
  userGesture: Boolean; const popupFeatures: TCefPopupFeatures;
  var windowInfo: TCefWindowInfo; var client: ICefClient;
  var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue;
  var noJavascriptAccess, Result: Boolean);
begin
// bloqueia todas as janelas pop-up e novas guias
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure Tfrm_autenticaWhats.Chromium1Close(Sender: TObject;
  const browser: ICefBrowser; var aAction: TCefCloseBrowserAction);
begin
  PostMessage(Handle, CEF_DESTROY, 0, 0);
  aAction := cbaDelay;
end;

procedure Tfrm_autenticaWhats.Chromium1ConsoleMessage(Sender: TObject;
  const browser: ICefBrowser; level: Cardinal; const message, source: ustring;
  line: Integer; out Result: Boolean);
var
  Json: TJSONObject;
begin
 {Aqui devemos pegar o log do console e criar um JSon para percorrer as mensagens recebidas
 pelo whatsApp}
    try
      Json := TJSONObject.Create;
      Json.Parse(TEncoding.UTF8.GetBytes(string(message)), 0);
      Memo1.Lines.Add('Nova mensagem: '+Json.ToString);

    if Json <> nil then
    begin
      Json.Free;
    end;
    finally
      //Json.Free;
    end;

end;

procedure Tfrm_autenticaWhats.Chromium1LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  //Aqui possível rotina para verificar se usuário está logado e código foi injetado
end;

procedure Tfrm_autenticaWhats.Chromium1OpenUrlFromTab(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl: ustring;
  targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
  out Result: Boolean);
begin
 //Bloqueia popup do windows e novas abas
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure Tfrm_autenticaWhats.Chromium1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  i := i + 1;
  memo1.Lines.Add('ID: '+intToStr(i));
  if i > 3 then
  begin
    autenticado := true;
  end;
end;

procedure Tfrm_autenticaWhats.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  frm_autenticaWhats := nil;
end;

procedure Tfrm_autenticaWhats.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;
      Chromium1.CloseBrowser(True);
    end;
end;

procedure Tfrm_autenticaWhats.FormCreate(Sender: TObject);
begin
  FCanClose := False;
  FClosing  := False;
  Chromium1.DefaultURL := 'https://web.whatsapp.com/';
  autenticado := false;
end;

procedure Tfrm_autenticaWhats.FormDestroy(Sender: TObject);
begin
  PostMessage(Handle, CEFBROWSER_CHILDDESTROYED, 0, 0);
end;

procedure Tfrm_autenticaWhats.FormShow(Sender: TObject);
begin
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) then Timer1.Enabled := True;
end;

procedure Tfrm_autenticaWhats.Image1Click(Sender: TObject);
begin
  frm_autenticaWhats.Hide;
end;

procedure Tfrm_autenticaWhats.SendBase64(vBase64, vNum, vFileName, vText: string);
var
 JS: string;
 Base64File: TStringList;
 i: integer;
 vLine: string;
begin
  vText := caractersWhats(vText);
  removeCaracter(vFileName);
  Base64File:= TStringList.Create;
  Base64File.Text := vBase64;
  for i := 0 to Base64File.Count -1  do
  begin
    vLine := vLine + Base64File[i];
  end;
  vBase64 := vLine;
  JS := 'window.WAPI.sendImage("'+Trim(vBase64)+'","'+Trim(vNum)+'", "'+Trim(vFileName)+'", "'+Trim(vText)+'")';

  if Chromium1.Browser <> nil then
  begin
    Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);
  end;

  freeAndNil(vBase64);
end;

procedure Tfrm_autenticaWhats.Send(vNum, vText: string);
var
 JS: string;
begin
 vText := caractersWhats(vText);

 JS := 'window.WAPI.sendMessageToID("'+Trim(vNum)+'","'+Trim(vText)+'")';

 if Chromium1.Browser <> nil then
      Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);

end;

procedure Tfrm_autenticaWhats.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) and not(Chromium1.Initialized) then
    Timer1.Enabled := True;
end;

procedure Tfrm_autenticaWhats.Timer2Timer(Sender: TObject);
var
  arq: TextFile;
  linha, JS: string;
begin
  //Rotina para leitura e inject do arquivo js.abr ---- 12/10/2019 Mike
  if autenticado = true then
  begin
    AssignFile(arq, ExtractFilePath(Application.ExeName)+ 'js.abr');
    {$I-}         // desativa a diretiva de Input
      Reset(arq);   // Abre o arquivo texto para leitura
    {$I+}         // ativa a diretiva de Input

    if (IOResult <> 0) then
    begin
      showmessage('Erro na abertura do arquivo JS.');
    end else
      begin
        // verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
        while (not eof(arq)) do
        begin
          readln(arq, linha); //Lê linha do arquivo
          memo_js.Lines.Add(linha);
        end;
        CloseFile(arq); //Fecha o arquivo texto aberto
      end;

       //injeta o JS principal
       JS :=  memo_js.Text;
       Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);

       timer2.Enabled := false;
  end;

end;

end.
