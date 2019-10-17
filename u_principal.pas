﻿unit u_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCEFWinControl, uCEFWindowParent,
  Vcl.ExtCtrls, uCEFChromium, system.JSON,

  //############ ATENÇÃO AQUI ####################
  //units adicionais obrigatórias
  uCEFInterfaces, uCEFConstants, uCEFTypes, UnitCEFLoadHandlerChromium,
  Vcl.StdCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, uTInject,
  Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXCtrls, System.NetEncoding;

  //############ ATENÇÃO AQUI ####################
  //Constantes obrigatórias para controle do destroy do TChromium
  const
  CEFBROWSER_CREATED          = WM_APP + $100;
  CEFBROWSER_CHILDDESTROYED   = WM_APP + $101;
  CEFBROWSER_DESTROY          = WM_APP + $102;

type
  Tfrm_principal = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ed_num: TEdit;
    Memo1: TMemo;
    Button5: TButton;
    lista: TListView;
    ImageList1: TImageList;
    Label3: TLabel;
    Image1: TImage;
    Button6: TButton;
    mem_message: TMemo;
    Button4: TButton;
    Image2: TImage;
    whatsOff: TImage;
    whatsOn: TImage;
    Timer1: TTimer;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    TrackBar1: TTrackBar;
    lbl_track: TLabel;
    ToggleSwitch2: TToggleSwitch;
    Label7: TLabel;
    InjectWhatsapp1: TInjectWhatsapp;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Label4: TLabel;
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
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
    procedure Chromium1OpenUrlFromTab(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition;
      userGesture: Boolean; out Result: Boolean);
    procedure Chromium1TitleChange(Sender: TObject; const browser: ICefBrowser;
      const title: ustring);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBar1Change(Sender: TObject);
    procedure ToggleSwitch2Click(Sender: TObject);
    procedure whatsOnClick(Sender: TObject);
    procedure whatsOffClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  protected

    //############ ATENÇÃO AQUI ####################
    //############ ATENÇÃO AQUI ####################
    //############ ATENÇÃO AQUI ####################
    // Inclua essas variáveis e procedures em seus projetos, ajudam à monitorar o destroy correto do TChromium.
    FCanClose : boolean;  // Defina como True em TChromium.OnBeforeClose
    FClosing  : boolean;  // Defina como True no evento CloseQuery.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;
    procedure BrowserCreated(var aMessage : TMessage); message CEF_AFTERCREATED;
    procedure BrowserDestroyMsg(var aMessage : TMessage); message CEF_DESTROY;

  private
    { Private declarations }
    ChromiumStarted: Boolean;
    vExtension, vBase64, vFileName: string;
    vBase64File: TBase64Encoding;
  public
    { Public declarations }
    vBase64Str, vFileNameURL: string;
    autenticado: boolean;
    i: integer;
  end;

var
  frm_principal: Tfrm_principal;

implementation

uses
  uCEFApplication, uCefMiscFunctions, u_autenticaWhats;

{$R *.dfm}

procedure Tfrm_principal.BrowserCreated(var aMessage : TMessage);
begin
  Caption            := '🎯 TInject  || Versão BETA || Envio de mensagem de texto e de imagens png base64 - Contribuições para o projeto entrar em contato: whatsapp (81) 9.96302385 Mike';
  frm_principal.WindowState := wsMaximized;
end;

procedure Tfrm_principal.BrowserDestroyMsg(var aMessage : TMessage);
begin
  //CEFWindowParent1.Free;
end;

procedure Tfrm_principal.WMMove(var aMessage : TWMMove);
begin
  inherited;
end;

procedure Tfrm_principal.WMMoving(var aMessage : TMessage);
begin
  inherited;
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


procedure Tfrm_principal.Button1Click(Sender: TObject);
begin
  if vBase64File <> nil then
  begin
    InjectWhatsapp1.sendBase64(vBase64Str, ed_num.Text, vFileName, mem_message.Text);
    vBase64File := nil;
    application.MessageBox('Arquivo enviado com sucesso!','TInject whatsapp', mb_iconAsterisk + mb_ok);
  end;
end;

procedure Tfrm_principal.Button4Click(Sender: TObject);
var
  vFilestream: TMemoryStream;
begin
  if OpenDialog1.Execute then
  begin
    vBase64File := TBase64Encoding.Create;
    vFilestream := TMemoryStream.Create;
    vFilestream.LoadFromFile(openDialog1.FileName);

    vExtension := Copy(ExtractFileExt(openDialog1.FileName),2,5);

    vFileName  := ExtractFileName(openDialog1.FileName);
    vFileNameURL := dateToStr(date)+timeToStr(time)+'.'+vExtension;
    if vExtension = 'pdf' then
    begin
      vBase64Str := 'data:application/'+vExtension+';base64,'+vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
    end else
      if vExtension = 'mp4' then
      begin
        vBase64Str := 'data:application/'+vExtension+';base64,'+vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
      end else
        if vExtension = 'mp3' then
        begin
          vBase64Str := 'data:audio/'+vExtension+';base64,'+vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
        end else
        if vExtension = 'rar' then
        begin
          vBase64Str := 'data:application/'+vExtension+';base64,'+vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
        end else
          begin
            vBase64Str := 'data:image/'+vExtension+';base64,'+vBase64File.EncodeBytesToString(vFilestream.Memory, vFilestream.Size);
          end;

    vFilestream.Free;
  end;
end;

procedure Tfrm_principal.Button5Click(Sender: TObject);
var JS: string;
var Item: TListItem;
begin
  Item := lista.Items.Add;
  item.Caption := '55'+ed_num.Text;
  item.SubItems.Add(item.Caption+'SubItem 1');
  item.SubItems.Add(item.Caption+'SubItem 2');
  item.ImageIndex := 0;
end;

procedure Tfrm_principal.Button6Click(Sender: TObject);
begin
  InjectWhatsapp1.send(ed_num.Text, mem_message.Text);
end;

procedure Tfrm_principal.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  { Agora que o navegador está totalmente inicializado, podemos enviar uma mensagem para
    o formulário principal para carregar a página inicial da web.}
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
  memo1.Lines.Add('ID: '+intToStr(i));
  if i > 3 then
  begin
    autenticado := true;
  end;
end;

procedure Tfrm_principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    application.Terminate;
end;

procedure Tfrm_principal.FormShow(Sender: TObject);
begin
  timer1.Enabled := true;
end;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);
begin
  if Assigned(frm_autenticaWhats) then
  begin
    if frm_autenticaWhats.autenticado = true then
    begin
      whatsOn.Visible := true;
      whatsOff.Visible := false;
    end else
    begin
      whatsOff.Visible := true;
      whatsOn.Visible := false;
    end;
  end;
end;

procedure Tfrm_principal.ToggleSwitch2Click(Sender: TObject);
begin
  if ToggleSwitch2.IsOn then
  begin
    InjectWhatsapp1.Config.ShowRandom := true;
  end else
  begin
    InjectWhatsapp1.Config.ShowRandom := false;
  end;
end;

procedure Tfrm_principal.TrackBar1Change(Sender: TObject);
begin
  lbl_track.Caption := intToStr(TrackBar1.Position);
  InjectWhatsapp1.Config.AutoDelay := TrackBar1.Position;
end;

procedure Tfrm_principal.whatsOffClick(Sender: TObject);
begin
  InjectWhatsapp1.startWhatsapp;
end;

procedure Tfrm_principal.whatsOnClick(Sender: TObject);
begin
  InjectWhatsapp1.startWhatsapp;
end;

end.
