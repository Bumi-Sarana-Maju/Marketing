unit ufrmTargetMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit,
  cxRadioGroup, AdvCombo, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  MyAccess;

type
  TfrmTargetMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxsimpan: TcxButton;
    AdvPanel4: TAdvPanel;
    edtKode: TAdvEditBtn;
    Label1: TLabel;
    Label4: TLabel;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    LihatDetail1: TMenuItem;
    Pencapaian1: TMenuItem;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    clTarget: TcxGridDBColumn;
    clHna: TcxGridDBColumn;
    clPenjualan: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxButton2: TcxButton;
    cxstylrpstry1: TcxStyleRepository;
    cxstyl1: TcxStyle;
    clkode: TcxGridDBColumn;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    function GetCDS: TClientDataSet;

    
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxButton1Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure
        cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure clTargetPropertiesEditValueChanged(Sender: TObject);
    procedure simpandata;
    procedure cxsimpanClick(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS: TClientDataSet;

  public
    property CDS: TClientDataSet read GetCDS write FCDS;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmTargetMarketing: TfrmTargetMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxgridExportlink,uReport;

{$R *.dfm}

procedure TfrmTargetMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

procedure TfrmTargetMarketing.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;

  initgrid;
end;
procedure TfrmTargetMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmTargetMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmTargetMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmTargetMarketing.loaddata;
var
  sfilter,s,ss: string;
  tsql,tsql2 : TmyQuery;
  i:Integer;

begin
s:='select kode_grouppf,nama_grouppf nama,ifnull(tm_target,0) target,ifnull(hna_grouppf,0) hna,'
+ ' ifnull(hna_grouppf,0)*ifnull(tm_target,0) target_penjualan from tgrouppf '
+ ' left join ttargetmarketing on tm_grouppf=kode_grouppf'
+ ' and tm_periode = '+IntToStr(cbbBulan.ItemIndex+1)
+ ' and tm_tahun = '+ edtTahun.Text
+ ' and tm_salesman = '+ Quot(edtKode.Text)
+ ' where isaktif=1'
+ ' and periode = '+IntToStr(cbbBulan.ItemIndex+1)
+ ' and tahun ='+ edtTahun.Text;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try

    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS.FieldByName('kode').AsString  := fieldbyname('kode_grouppf').AsString;      
      CDS.FieldByName('target').Asfloat  := fieldbyname('target').AsFloat;
      CDS.FieldByName('hna').AsFloat  := fieldbyname('hna').AsFloat;
      CDS.FieldByName('target_value').AsFloat  := fieldbyname('target_penjualan').AsFloat;
      CDS.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;

  end;
 
end;


procedure TfrmTargetMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmTargetMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

function TfrmTargetMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'kode', ftString, False,20);    
    zAddField(FCDS, 'Nama', ftString, False,200);
    zAddField(FCDS, 'Target', ftFloat, False);
    zAddField(FCDS, 'hna', ftFloat, False);

    zAddField(FCDS, 'Target_Value', ftFloat, False);
    
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;



procedure TfrmTargetMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmTargetMarketing.cxButton1Click(Sender: TObject);
var
  apersen : double;
  akomisivalue : Double;
  apengurang : Double;
begin
loaddata;


end;

procedure TfrmTargetMarketing.edtKodeClickBtn(Sender: TObject);
begin
    sqlbantuan := ' SELECT mkt_kode Kode,mkt_nama Nama from tmarketing ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtNama.Text := varglobal1;
  end;

end;

procedure TfrmTargetMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmTargetMarketing.cxButton7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid);
     end;

end;

procedure
    TfrmTargetMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmTargetMarketing.clTargetPropertiesEditValueChanged(
  Sender: TObject);
  var
    i:integer;
    lval:double;
begin
 cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, cltarget.Index] * cxGrdMain.DataController.Values[i, clHna.Index] ;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('target_value').AsFloat := lVal;
  CDS.Post;
end;

procedure TfrmTargetMarketing.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin
   tt := TStringList.Create;
   s:= ' delete from ttargetmarketing '
      + ' where  tm_periode='+ inttostr(cbbBulan.ItemIndex+1)
      + ' and tm_tahun='+ edtTahun.Text
      + ' and tm_salesman = '+ Quot(edtkode.Text)+';';

   tt.Append(s);
   CDS.First;
     i:=1;
  while not CDS.Eof do
  begin

    S:='insert into ttargetmarketing '
    + ' (tm_grouppf,tm_salesman,tm_target,tm_periode,tm_tahun) values ('
      + Quot(CDS.FieldByName('kode').AsString) +','
      + Quot(edtkode.Text) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('target').AsFloat))+','
      + inttostr(cbbBulan.ItemIndex+1) +','
      + edtTahun.Text
      + ');';
    tt.Append(s);
    CDS.Next;
    Inc(i);
  end;

     try
        for i:=0 to tt.Count -1 do
        begin
            // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;


end;

procedure TfrmTargetMarketing.cxsimpanClick(Sender: TObject);
begin
  try
     simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

end.
