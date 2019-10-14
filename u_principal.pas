unit u_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCEFWinControl, uCEFWindowParent,
  Vcl.ExtCtrls, Vcl.StdCtrls, uCEFChromium,  controller.injetaJS, system.JSON,

  //units adicionais obrigatórias
  uCEFInterfaces, uCEFConstants, uCEFTypes, UnitCEFLoadHandlerChromium;


  const
  CEFBROWSER_CREATED          = WM_APP + $100;
  CEFBROWSER_CHILDDESTROYED   = WM_APP + $101;
  CEFBROWSER_DESTROY          = WM_APP + $102;

type
  Tfrm_principal = class(TForm)
    AddressPnl: TPanel;
    AddressEdt: TEdit;
    GoBtn: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Button2: TButton;
    memo_js: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    Button1: TButton;
    Edit3: TEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    CEFWindowParent1: TCEFWindowParent;
    Memo1: TMemo;
    Chromium1: TChromium;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; const targetUrl, targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess,
      Result: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure Chromium1Close(Sender: TObject; const browser: ICefBrowser;
      var aAction: TCefCloseBrowserAction);
    procedure Chromium1ConsoleMessage(Sender: TObject;
      const browser: ICefBrowser; level: Cardinal; const message,
      source: ustring; line: Integer; out Result: Boolean);
    procedure Chromium1OpenUrlFromTab(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition;
      userGesture: Boolean; out Result: Boolean);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser;
      const title: ustring);
    procedure Button3Click(Sender: TObject);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

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

    procedure BrowserCreated(var aMessage : TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;

  private
    { Private declarations }
    ChromiumStarted: Boolean;

  public
    { Public declarations }
    JS1: string;
    autenticado: boolean;
    i: integer;
  end;

var
  frm_principal: Tfrm_principal;

implementation

uses
  uCEFApplication, uCefMiscFunctions;

{$R *.dfm}

procedure Tfrm_principal.BrowserCreated(var aMessage : TMessage);
begin
  Caption            := '🎯 TInject  || Versão BETA || Envio de mensagem de texto e de imagens png base64 - Contribuições para o projeto entrar em contato: whatsapp (81) 9.96302385 Mike';
  AddressPnl.Enabled := True;
  frm_principal.WindowState := wsMaximized;
end;

procedure Tfrm_principal.BrowserDestroyMsg(var aMessage : TMessage);
begin
  CEFWindowParent1.Free;
end;

procedure Tfrm_principal.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure Tfrm_principal.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (Chromium1 <> nil) then Chromium1.NotifyMoveOrResizeStarted;
end;

procedure Tfrm_principal.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := True;
end;

procedure Tfrm_principal.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := False;
end;


procedure Tfrm_principal.Button2Click(Sender: TObject);
var
  send: string;
begin
  if (edit1.Text <> '') and (edit2.Text <> '') then
  begin
    send := 'window.WAPI.sendMessageToID("'+'55'+edit1.text+'@c.us'+'", "'+edit2.text+'")';
    Chromium1.Browser.MainFrame.ExecuteJavaScript(send, 'about:blank', 0);
    sleep(random(2000));

    send := 'window.WAPI.sendMessageToID("'+'55'+edit4.text+'@c.us'+'", "'+edit2.text+'")';
    Chromium1.Browser.MainFrame.ExecuteJavaScript(send, 'about:blank', 0);
    sleep(random(2000));

    send := 'window.WAPI.sendMessageToID("'+'55'+edit5.text+'@c.us'+'", "'+edit2.text+'")';
    Chromium1.Browser.MainFrame.ExecuteJavaScript(send, 'about:blank', 0);
    sleep(random(2000));
    application.MessageBox('Mensagem enviada com sucesso.','dInject - By Mike Lustosa 81996302385', MB_ICONASTERISK + MB_OK);
  end;
end;

procedure Tfrm_principal.Button3Click(Sender: TObject);
var
  send: string;
begin
  if (edit1.Text <> '') and (edit2.Text <> '') then
  begin
    send := 'window.WAPI.sendImage('+'"'+edit3.text+'"'+', "'+'55'+edit1.text+'@c.us'+'", "Test.png", "Imagem fundo red")';
    Chromium1.Browser.MainFrame.ExecuteJavaScript(send, 'about:blank', 0);
    sleep(1000);
    application.MessageBox('Imagem enviada com sucesso.','TInject - By Mike Lustosa 81996302385', MB_ICONASTERISK + MB_OK);
   end;

end;

procedure Tfrm_principal.Button4Click(Sender: TObject);
var JS: string;
begin
  //injeta o JS principal
  JS :=  memo_js.Text;
  frm_principal.Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);

end;

procedure Tfrm_principal.Button5Click(Sender: TObject);
var JS: string;
begin
  JS :=  'WAPI.getUnreadMessages(includeMe="True", includeNotifications="True", use_unread_count="True")';
  frm_principal.Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);
end;

procedure Tfrm_principal.Button6Click(Sender: TObject);
var JS: string;
begin
  JS :=  'console.dir(document.body)';
  frm_principal.Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);
end;

procedure Tfrm_principal.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  { Agora que o navegador está totalmente inicializado, podemos enviar uma mensagem para
    o formulário principal para carregar a página inicial da web.}
  //PostMessage(Handle, CEFBROWSER_CREATED, 0, 0);
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure Tfrm_principal.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure Tfrm_principal.Chromium1BeforePopup(Sender: TObject;
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

procedure Tfrm_principal.Chromium1Close(Sender: TObject;
  const browser: ICefBrowser; var aAction: TCefCloseBrowserAction);
begin
  PostMessage(Handle, CEF_DESTROY, 0, 0);
  aAction := cbaDelay;
end;

procedure Tfrm_principal.Chromium1ConsoleMessage(Sender: TObject;
  const browser: ICefBrowser; level: Cardinal; const message, source: ustring;
  line: Integer; out Result: Boolean);
var
  Json: TJSONObject;
begin
 {Aqui devemos pegar o log do console e criar um JSon para percorrer as mensagens recebidas
 pelo whatsApp}
  if Chromium1.Initialized then
  begin
    Json := TJSONObject.Create;
    if Json.Parse(TEncoding.ANSI.GetBytes((message)), 0) >= 0 then
    begin
      if i > 3 then
      begin
        Memo1.Lines.Add('Nova mensagem! '+string(source));
      end;

      if Json <> nil then
      begin
        Json.Free;
      end;
    end;
  end;

end;

procedure Tfrm_principal.Chromium1LoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  //Aqui possível rotina para verificar se usuário está logado e código foi injetado
end;

procedure Tfrm_principal.Chromium1OpenUrlFromTab(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const targetUrl: ustring;
  targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
  out Result: Boolean);
begin
  //Bloqueia popup do windows e novas abas
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure Tfrm_principal.Chromium1TitleChange(Sender: TObject;
  const browser: ICefBrowser; const title: ustring);
begin
  i := i + 1;
  memo1.Lines.Add(intToStr(i));
  if i > 3 then
  begin
    autenticado := true;
  end;
end;

procedure Tfrm_principal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;
      Chromium1.CloseBrowser(True);
    end;
end;

procedure Tfrm_principal.FormCreate(Sender: TObject);
begin
  FCanClose := False;
  FClosing  := False;
  Chromium1.DefaultURL := AddressEdt.Text;
  autenticado := false;
end;

procedure Tfrm_principal.FormDestroy(Sender: TObject);
begin
  PostMessage(Handle, CEFBROWSER_CHILDDESTROYED, 0, 0);
end;

procedure Tfrm_principal.FormShow(Sender: TObject);
begin
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) then Timer1.Enabled := True;
end;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) and not(Chromium1.Initialized) then
    Timer1.Enabled := True;
end;

procedure Tfrm_principal.Timer2Timer(Sender: TObject);
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
       frm_principal.Chromium1.Browser.MainFrame.ExecuteJavaScript(JS, 'about:blank', 0);

       frm_principal.timer2.Enabled := false;
  end;
end;

end.
