
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}                           
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}           
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MAIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, SqlExpr, ComCtrls, jpeg, ExtCtrls, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxLookAndFeels, dxSkinsForm,
  dxGDIPlusClasses, dxSkinsdxBarPainter, cxGraphics, cxControls,
  cxLookAndFeelPainters, dxRibbonSkins, cxClasses, dxRibbon, dxBar,
    dxNavBarCollns,
  dxNavBarBase, dxNavBar, dxBarDBNav,
  dxSkinsdxRibbonPainter,strutils,
   cxPC, dxDockControl,
  dxDockPanel, dxSkinsdxNavBar2Painter ,ShellAPI, ImgList, dxSkinDarkRoom,
  dxSkinFoggy, dxSkinSeven, dxSkinSharp, DBAccess, MyAccess, DBXpress;

type
  TfrmMenu = class(TForm)
    dxSkinController1: TdxSkinController;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    User1: TMenuItem;
    Relogin1: TMenuItem;
    Daftar1: TMenuItem;
    dxDockSite1: TdxDockSite;
    dxNavBar2: TdxNavBar;
    dxNavBarGroup1: TdxNavBarGroup;
    dxNavBarGroup2: TdxNavBarGroup;
    dxNavBar2Group4: TdxNavBarGroup;
    dxUser: TdxNavBarItem;
    dxIdentitas: TdxNavBarItem;
    dxRelogin: TdxNavBarItem;
    dxDockPanel1: TdxDockPanel;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dxBarang: TdxNavBarItem;
    ImageList1: TImageList;
    Image1: TImage;
    dxgrouppf: TdxNavBarItem;
    dxtarget: TdxNavBarItem;
    dxMarketing: TdxNavBarItem;
    dxJual: TdxNavBarItem;
    dxCapai: TdxNavBarItem;
    dxKomisi: TdxNavBarItem;
    dxSettingCustomer: TdxNavBarItem;
    dxKunjungan: TdxNavBarItem;
    dxlapjualvstarget: TdxNavBarItem;
    dxlistjualitempf: TdxNavBarItem;
    ImportSql1: TMenuItem;
    OpenDialog2: TOpenDialog;
    dxEstimasiMarketing: TdxNavBarItem;
    dxlapestimasimarketing: TdxNavBarItem;
    procedure FileExit1Execute(Sender: TObject);
    function ShowForm(AFormClass: TFormClass): TForm;
    procedure Maximized1Click(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure bacafile;
    procedure Exit1Click(Sender: TObject);
    procedure frmuserClick(Sender: TObject);
    procedure frmRELoginClick(Sender: TObject);
    procedure dxReloginClick(Sender: TObject);
    procedure User1Click(Sender: TObject);
    procedure dxUserClick(Sender: TObject);
    procedure Relogin1Click(Sender: TObject);
    procedure dxDockPanel1AutoHideChanged(Sender: TdxCustomDockControl);
    procedure dxMarketingClick(Sender: TObject);
    procedure dxgrouppfClick(Sender: TObject);
    procedure dxtargetClick(Sender: TObject);
    procedure dxBarangClick(Sender: TObject);
    procedure dxCapaiClick(Sender: TObject);
    procedure dxJualClick(Sender: TObject);
    procedure dxKomisiClick(Sender: TObject);
    procedure dxSettingCustomerClick(Sender: TObject);
    procedure dxKunjunganClick(Sender: TObject);
    procedure dxlapjualvstargetClick(Sender: TObject);
    procedure dxlistjualitempfClick(Sender: TObject);
    procedure ImportSql1Click(Sender: TObject);
    procedure dxEstimasiMarketingClick(Sender: TObject);
    procedure dxlapestimasimarketingClick(Sender: TObject);


  private
    { Private declarations }

    FaDatabase: string;
    FaHost: string;
    Fapassword: string;
    Fauser: string;
    Fapathimage : string;
        FaDatabase2: string;
    FaHost2: string;
    Fapassword2: string;
    Fauser2: string;

  public
    { Public declarations }
    // conn: TSQLConnection;
    conn: TMyConnection;

    vg: string;
        KDUSER,NMUSER,KDCABANG,NMCABANG : String;
        otorisasi : Boolean;
      property aDatabase: string read FaDatabase write FaDatabase;
      property aHost: string read FaHost write FaHost;
      property apassword: string read Fapassword write Fapassword;
      property apathimage: string read Fapathimage write Fapathimage;
      property auser: string read Fauser write Fauser;
      property aDatabase2: string read FaDatabase2 write FaDatabase2;
      property aHost2: string read FaHost2 write FaHost2;
      property apassword2: string read Fapassword2 write Fapassword2;
      property auser2: string read Fauser2 write Fauser2;
  end;

var

  frmMenu: TfrmMenu;

//  for help / bantuan...
  varglobal : string;
  varglobal1 : string;
  varglobal2 : string;
  sqlbantuan : string;
  sqlfilter : string;
    zVersi:string;

implementation
 uses Ulib,uModuleConnection,ufrmUser, UfrmLogin,ufrmbrowsemarketing,
 ufrmbrowseGrouppf,ufrmtargetmarketing,ufrmbrowsesetingbarangpf,ufrmLapBulananMarketing,
 ufrmlistjualmarketing,ufrmlistjualmarketing2,ufrmkomisimarketing,ufrmsalesmarketing,ufrmlapkunjungan,
 ufrmListJualPFvsRiil,ufrmestimasimarketing,ufrmlapestimasimarketing;
{$R *.dfm}


procedure TfrmMenu.FileExit1Execute(Sender: TObject);
begin
  application.terminate;
end;

function TfrmMenu.ShowForm(AFormClass: TFormClass): TForm;
var
  aForm: TForm;
  i: Integer;
begin
//  inherited;


  if ( not ceKVIEW(frmMenu.KDUSER,AFormClass.ClassName)) then
        begin
           MessageDlg('Anda tidak berhak Membuka di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i].ClassName = AFormClass.ClassName then
    begin
      Result := MDIChildren[i];
      // mdiChildrenTabs.TabIndex := GetTabSetIndex(Result);
      Exit;
    end;
  end;

  aForm := AFormClass.Create(Application);
  aForm.FormStyle := fsMDIChild;
//  aForm.Position := poDefault;


//  aForm.WindowState := wsMaximized;
  Result := (aForm as AFormClass);

end;

procedure TfrmMenu.Maximized1Click(Sender: TObject);
begin
  if MDIChildCount <> 0 then
   ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
var
   sql:string;
   tsql:TmyQuery;
    AppVersi,DbVersi:Double;
begin

      bacafile;

      StatusBar1.Panels[1].Text := 'Connected  to ' + aHost;
      StatusBar1.Panels[2].Text := 'Database  ' + aDatabase;
//      conn.Username := auser;
//      conn.Server := ahost;
//      conn.Database := adatabase;
//      conn.Password := apassword;
//      conn.Port := 1100;
//      conn.Connected := true;

      // conn := xCreateConnection(ctMySQL,aHost,aDatabase,auser,apassword);
      conn := xCreateConnectionMy(ctMySQL,aHost,aDatabase,auser,apassword);

      ThousandSeparator:=',';
      ShortDateFormat := 'M/d/yyyy';
      DateSeparator   := '/';
      DecimalSeparator:= '.';
      zVersi:='4.0.17';
      StatusBar1.Panels[4].Text := 'Versi ' + zversi;
      Application.UpdateFormatSettings:=True;
// cek ver si
  frmLogin.Show;
end;

procedure TfrmMenu.bacafile;
 var                                           
 ltemp : TStringList;

 begin
 ltemp := TStringList.Create;
 ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default.cfg');
   aHost     := ltemp[0];
   aDatabase := ltemp[1];
   auser     := ltemp[2];
   apassword := ltemp [3];
   apathimage := ltemp [5];
   ltemp.free;
 end;

procedure TfrmMenu.Exit1Click(Sender: TObject);
begin
 Close;
end;
procedure TfrmMenu.frmuserClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Master User' then
 begin
    ShowForm(TfrmUser).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.frmRELoginClick(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
   begin
      MDIChildren[i].Release;
   end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;
end;


procedure TfrmMenu.dxReloginClick(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
  begin
      MDIChildren[i].Release;
  end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;

end;


procedure TfrmMenu.User1Click(Sender: TObject);
begin
frmUserClick(self);
end;

procedure TfrmMenu.dxUserClick(Sender: TObject);
begin
frmUserClick(self);
end;

procedure TfrmMenu.Relogin1Click(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
  begin
      MDIChildren[i].Release;
  end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;

end;


procedure TfrmMenu.dxDockPanel1AutoHideChanged(
  Sender: TdxCustomDockControl);
begin
  if dxDockPanel1.AutoHide then
     dxDockSite1.Width := 24
  else
     dxDockSite1.Width := 200;


end;

procedure TfrmMenu.dxMarketingClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Master Marketing' then
 begin
    ShowForm(TfrmBrowseMarketing).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.dxgrouppfClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Group Pf' then
 begin
    ShowForm(TfrmBrowseGrouppf).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;

end;

procedure TfrmMenu.dxtargetClick(Sender: TObject);
begin
       if ActiveMDIChild.Caption <> 'Target Marketing' then
 begin
    ShowForm(TfrmTargetMarketing).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;

end;

procedure TfrmMenu.dxBarangClick(Sender: TObject);
begin
        if ActiveMDIChild.Caption <> 'Setting Barang pf' then
 begin
    ShowForm(TfrmBrowsesetingbarangpf).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.dxCapaiClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Pencapaian Marketing' then
   begin
      ShowForm(Tfrmlapbulananmarketing).Show;
   end;

end;

procedure TfrmMenu.dxJualClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Penjualan Marketing' then
   begin
      ShowForm(Tfrmlistjualmarketing).Show;
   end;

end;

procedure TfrmMenu.dxKomisiClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Komisi Marketing' then
   begin
      ShowForm(Tfrmkomisimarketing).Show;
   end;

end;

procedure TfrmMenu.dxSettingCustomerClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Sales Marketing' then
 begin
    ShowForm(TfrmSalesMarketing).Show;
 end;

end;

procedure TfrmMenu.dxKunjunganClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Kunjungan Marketing' then
 begin
    ShowForm(TfrmLapKunjungan).Show;
 end;

end;

procedure TfrmMenu.dxlapjualvstargetClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Penjualan Marketing vs Target' then
 begin
    ShowForm(TfrmListJualMarketing2).Show;
 end;

end;

procedure TfrmMenu.dxlistjualitempfClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per item bs PF' then
 begin
    ShowForm(TfrmListJualPFvsRiil).Show;
 end;


end;

procedure TfrmMenu.ImportSql1Click(Sender: TObject);
var
  tt :TStrings;
  i:Integer;
  a:string;
begin
  if OpenDialog2.Execute then
  begin
  tt:=TStringList.Create;
  tt.LoadFromFile(OpenDialog2.FileName);
   try
    try
        a:= ' ';
        for i:=0 to tt.Count -1 do
        begin
           a:=a+tt[i];
           if RightStr(a,1) = ';' then
           begin
              // xExecQuery(a,frmMenu.conn);
              EnsureConnected(frmMenu.conn);
              ExecSQLDirect(frmMenu.conn, a);
              a:=' ';
           end;

        end;
      finally
        tt.Free;
      end;
   except
     ShowMessage('gagal import');
     // xRollback(frmMenu.conn);
     Exit;
   end;

    // xCommit(frmMenu.conn);
    ShowMessage('Import data berhasil');
end;
end;

procedure TfrmMenu.dxEstimasiMarketingClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Estimasi Marketing' then
 begin
    ShowForm(TfrmEstimasiMarketing).Show;
 end;


end;

procedure TfrmMenu.dxlapestimasimarketingClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Lap. Estimasi Marketing' then
 begin
    ShowForm(TfrmLapEstimasiMarketing).Show;
 end;

end;

end.
