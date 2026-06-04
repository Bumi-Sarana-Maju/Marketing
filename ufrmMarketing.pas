unit ufrmMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,DBClient, MyAccess;

type
  TfrmMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtKode: TAdvEdit;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label1: TLabel;
    cxExtLookupCabang: TcxExtLookupComboBox;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeExit(Sender: TObject);
    function GetCDSCabang: TClientDataset;
    procedure FormCreate(Sender: TObject);
  private
    FCDScabang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  public
     property CDSCabang: TClientDataset read GetCDSCabang write FCDSCabang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmMarketing: TfrmMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmMarketing.refreshdata;
begin
  FID:='';
  edtKode.Enabled := True;
  edtNama.Clear;
  edtNama.SetFocus;
end;
procedure TfrmMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


  if Key= VK_F10 then
  begin
    try
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;
      
      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
  end;
end;

procedure TfrmMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmMarketing.loaddata(akode:string) ;
var
  s: string;
  tsql : TmyQuery;
begin
  s:= 'select mkt_kode,mkt_nama,mkt_cabang from tmarketing where mkt_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtKode.Enabled := False;
      edtNama.Text := fieldbyname('mkt_nama').AsString;
      cxExtLookupCabang.EditValue :=fieldbyname('mkt_cabang').AsString;
      FID :=fieldbyname('mkt_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmMarketing.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tmarketing set '
    + ' mkt_nama = ' + Quot(edtNama.Text)+','
    + ' mkt_cabang = '+ Quot(cxExtLookupCabang.EditValue)
    + ' where mkt_kode = ' + quot(FID) + ';'
else
begin

  s :=  ' insert into tmarketing '
             + ' (mkt_kode,mkt_nama,mkt_cabang) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text)+','
             + Quot(cxExtLookupCabang.EditValue)
             + ');';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmMarketing.getmaxkode:string;
var
  s:string;
begin
  s:='select max(SUBSTR(mkt_kode,4,2)) from tmarketing';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 'WH-'+RightStr(IntToStr(100+1),2)
      else
         result:= 'WH-'+RightStr(IntToStr(100+fields[0].AsInteger+1),2);

    finally
      free;
    end;
  end;
end;

procedure TfrmMarketing.cxButton1Click(Sender: TObject);
begin
    try
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

procedure TfrmMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmMarketing.cxButton2Click(Sender: TObject);
begin
   try
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
    Release;
end;

procedure TfrmMarketing.edtKodeExit(Sender: TObject);
begin
loaddata(edtKode.Text);
end;

function TfrmMarketing.GetCDScabang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScabang) then
  begin
    S := 'select cbg_nama as Nama, cbg_kode Kode'
        +' from tcabang where cbg_aktif=0';

    FCDScabang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScabang;
end;


procedure TfrmMarketing.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxExtLookupCabang.Properties) do
    LoadFromCDS(CDSCabang, 'Kode','Nama',['Kode'],Self);

end;

end.
