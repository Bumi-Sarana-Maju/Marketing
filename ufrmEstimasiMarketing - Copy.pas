unit ufrmEstimasiMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, AdvCombo, cxCurrencyEdit,DateUtils,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TfrmEstimasiMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    edtKode: TAdvEditBtn;
    clTarget: TcxGridDBColumn;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    clEstimasi: TcxGridDBColumn;
    clRealisasi: TcxGridDBColumn;
    clRatio: TcxGridDBColumn;
    Label5: TLabel;
    edtTarget: TAdvEdit;
    btnRefresh: TcxButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function gettarget(akode:string): double;
    function cekdata(atahun:string;abulan:string;akode:string):Boolean;
    function cekada(atahun:string;abulan:string;akode:string):Boolean;
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure btnRefreshClick(Sender: TObject);

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
  frmEstimasiMarketing: TfrmEstimasiMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmEstimasiMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmEstimasiMarketing.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;
  edtTahun.Text := FormatDateTime('yyyy',Date);
  initgrid;
end;
procedure TfrmEstimasiMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmEstimasiMarketing.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmEstimasiMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmEstimasiMarketing.loaddata(akode:string) ;
var
  ssql,s: string;
  tsql2,tsql : TmyQuery;
  i:Integer;
  akhir,awal : TDateTime;
  abulan,atahun : Integer;
  adatabase :string;
  CurrentMonth, Month1, Month2, Month3: Integer;
begin

    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
    awal  := StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text);



    if cbbBulan.ItemIndex+1 < 4 then
      begin
         if cbbBulan.ItemIndex+1 = 3 then
            abulan := 12
         else
         if cbbBulan.ItemIndex+1 = 2 then
            abulan := 11
         else if cbbBulan.ItemIndex+1 = 1 then
            abulan := 10;
         atahun := StrToInt(edtTahun.Text) -1 ;
      end
    else
      begin
        abulan := (cbbBulan.ItemIndex+1) - 3;
        atahun := StrToInt(edttahun.text);
      end;
          ssql := 'SELECT dbase FROM tmarketing INNER JOIN tcabang ON mkt_cabang = cbg_kode '
      + ' WHERE mkt_kode = ' + Quot(edtkode.text)
      + ' AND mkt_cabang LIKE ' + Quot(frmmenu.KDCABANG+'%');

    tsql := xOpenQuery(ssql,frmmenu.conn);
    with tsql do
    begin
      try
        adatabase := fields[0].AsString;
      finally
       free;
      end;
    end;



    if cekada(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),akode) then
      s:= ' SELECT cus_kode, cus_nama, esd_targetsales target, esd_estimasisales estimasi, esd_realisasisales riil, CAST(0 AS DECIMAL) ratio, '
        + '(SELECT SUM(fpd_qty * hna_grouppf)/3 FROM ' + adatabase + '.tfp_dtl INNER JOIN ' + adatabase + '.tfp_hdr ON fp_nomor = fpd_fp_nomor '
        + ' INNER JOIN tbarangpf ON bpf_brg_kode = fpd_brg_kode AND bpf_tahun = '  + edtTahun.Text + ' AND bpf_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
        + ' INNER JOIN tgrouppf ON kode_grouppf = bpf_kode_grouppf AND periode = ' + IntToStr(cbbBulan.ItemIndex+1) + ' AND tahun = ' + edtTahun.Text
        + ' WHERE (fp_tanggal) < ' + Quot(edttahun.text + '/' + IntToStr(cbbBulan.ItemIndex+1) +  '/01')
        + ' and fp_tanggal >= ' + Quot(IntToStr(atahun) + '/' + IntToStr(abulan) + '/01') + ' AND fp_cus_kode = cus_kode '
        + ' ) avgsales  '
        + ' FROM testimasimarketing_hdr2 '
        + ' INNER JOIN testimasimarketing_dtl2 ON esd_esh_id = esh_id '
        + ' INNER JOIN '+ adatabase + '.tcustomer ON cus_kode = esd_cus_kode '
        + ' WHERE esh_sls_kode= '+ Quot(edtKode.Text)
        + ' AND esh_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
        + ' AND esh_tahun = ' + edtTahun.Text
    else
    S := ' SELECT cus_kode, cus_nama ,0 target, '
      + '(SELECT SUM(fpd_qty * hna_grouppf)/3 FROM ' + adatabase + '.tfp_dtl INNER JOIN ' + adatabase + '.tfp_hdr ON fp_nomor = fpd_fp_nomor '
      + ' INNER JOIN tbarangpf ON bpf_brg_kode = fpd_brg_kode AND bpf_tahun = '  + edtTahun.Text + ' AND bpf_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
      + ' INNER JOIN tgrouppf ON kode_grouppf = bpf_kode_grouppf AND periode = ' + IntToStr(cbbBulan.ItemIndex+1) + ' AND tahun = ' + edtTahun.Text
      + ' WHERE (fp_tanggal) < ' + Quot(edttahun.text + '/' + IntToStr(cbbBulan.ItemIndex+1) +  '/01')
      + ' and fp_tanggal >= ' + Quot(IntToStr(atahun) + '/' + IntToStr(abulan) + '/01') + ' AND fp_cus_kode = x.cus_kode '
      + ' ) avgsales, 0 estimasi, '
      + ' ( '
      + ' SELECT SUM(fpd_qty*hna_grouppf) FROM ' + adatabase + '.tfp_dtl INNER JOIN ' + adatabase + '.tfp_hdr ON fp_nomor=  fpd_fp_nomor '
      + ' INNER JOIN tbarangpf ON bpf_brg_kode = fpd_brg_kode AND bpf_tahun = ' +  edtTahun.Text + ' AND bpf_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
      + ' INNER JOIN tgrouppf ON kode_grouppf = bpf_kode_grouppf AND periode = ' + IntToStr(cbbBulan.ItemIndex+1) + ' AND tahun = ' +  edtTahun.Text
      + ' WHERE MONTH(fp_tanggal) IN (' + IntToStr(cbbBulan.ItemIndex+1) + ') AND YEAR(fp_tanggal) = ' + edtTahun.Text + ' AND fp_cus_kode = x.cus_kode ) riil,'
      + ' 0 ratio'
      + ' FROM tmarketing z'
      + ' INNER JOIN tsalescustomer y ON sc_sls_kode = mkt_kode AND sc_periode = ' + IntToStr(cbbBulan.ItemIndex+1) + ' AND sc_tahun = ' + edtTahun.Text
      + ' INNER JOIN customer x ON sc_cus_kode = cus_kode AND mkt_cabang = cus_cabang'
      + ' WHERE mkt_kode = ' + Quot(edtkode.text) + ';';

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
      begin
      CDS.EmptyDataSet;
        while  not Eof do
        begin
          CDS.Append;
          CDS.FieldByName('Kode').AsString := FieldByName('cus_kode').AsString;
          CDS.FieldByName('Nama').AsString  := FieldByName('cus_nama').AsString;
          CDS.FieldByName('TargetSales').AsFloat  := FieldByName('target').AsFloat;
          CDS.FieldByName('AverageSale').AsFloat  := FieldByName('avgsales').AsFloat;
          CDS.FieldByName('EstimasiSales').AsFloat  := FieldByName('estimasi').AsFloat;
          CDS.FieldByName('RealisasiSales').AsFloat  := FieldByName('riil').AsFloat;
          CDS.FieldByName('RatioSales').AsFloat  := FieldByName('ratio').AsFloat;

          CDS.Post;
          i:=i+1;
          next;
        end;
       end;
    finally
      Free;
    end;
  end;

end;

procedure TfrmEstimasiMarketing.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  fid : integer;
begin

  fid := getmaxid('testimasimarketing_hdr2','esh_id');

  s:=' delete from testimasimarketing_dtl2 where esd_esh_id in ('
    + ' select esh_id from testimasimarketing_hdr2 where esh_periode =' + inttostr(cbbBulan.ItemIndex+1)
    + ' AND esh_tahun = ' + edtTahun.Text
    + ' AND esh_sls_kode = ' + Quot(edtKode.Text)
    + ' AND esh_lock = 0 )';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);

  s := ' DELETE FROM testimasimarketing_hdr2'
    + ' WHERE  esh_periode =' + inttostr(cbbBulan.ItemIndex+1)
    + ' AND esh_tahun = ' + edtTahun.Text
    + ' AND esh_sls_kode = ' + Quot(edtKode.Text)
    + ' AND esh_lock = 0 ';


  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);

  tt := TStringList.Create;
  s :='INSERT INTO testimasimarketing_hdr2 (esh_id,esh_sls_kode,esh_periode,esh_tahun)'
    + ' VALUES ('
    + IntToStr(fid)  + ','
    + Quot(edtKode.Text) + ','
    + IntToStr(cbbBulan.ItemIndex+1) + ','
    + edtTahun.Text + ');';

  tt.Append(s);
  CDS.First;
  i:=1;

  while not CDS.Eof do
  begin
     if not CDS.FieldByName('kode').IsNull then
     begin
      S :='INSERT INTO testimasimarketing_dtl2 '
        + '(esd_esh_id,esd_cus_kode,esd_targetsales,esd_estimasisales,esd_avgsales,esd_realisasisales '
        + ') VALUES ('
        + IntToStr(fid) +','
        + quot(CDS.FieldByName('kode').Asstring) + ','
        + FloatToStr(CDS.FieldByName('TargetSales').AsFloat) + ','
        + FloatToStr(CDS.FieldByName('EstimasiSales').AsFloat) + ','
        + FloatToStr(CDS.FieldByName('averagesale').AsFloat) + ','
        + FloatToStr(CDS.FieldByName('RealisasiSales').AsFloat)
        + ');';
      tt.Append(s);
     end;
    CDS.Next;
    Inc(i);
  end;
// tt.SaveToFile('d:\aa.txt');
 try
    for i:=0 to tt.Count -1 do
    begin
        xExecQuery(tt[i],frmMenu.conn);
    end;
 finally
    tt.Free;
 end;
end;


procedure TfrmEstimasiMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmEstimasiMarketing.cxButton1Click(Sender: TObject);
begin
    try
      If not cekdata(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),edtKode.Text) then exit;
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

procedure TfrmEstimasiMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmEstimasiMarketing.cxButton2Click(Sender: TObject);
begin
   try
      If not cekdata(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),edtKode.Text) then exit;
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
procedure TfrmEstimasiMarketing.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT mkt_kode Kode, mkt_nama Nama, mkt_cabang Cabang FROM tmarketing ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtNama.Text := varglobal1;
  edtTarget.Text := formatfloat('###,###,###,###',gettarget(edtkode.Text));
  end;

end;

procedure TfrmEstimasiMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmEstimasiMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'TargetSales', ftFloat, False);
    zAddField(FCDS, 'AverageSale', ftFloat, False);
    zAddField(FCDS, 'EstimasiSales', ftFloat, False);
    zAddField(FCDS, 'RealisasiSales', ftFloat, False);
    zAddField(FCDS, 'RatioSales', ftFloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmEstimasiMarketing.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
  sqlbantuan := ' SELECT cus_kode Kode, cus_nama Nama, gc_nama Golongan, cus_piutang Piutang FROM tcustomer '
              + ' INNER JOIN tgolongancustomer ON cus_gc_kode = gc_kode';

  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;

  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Customer ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
      end;
    end;
   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('kode').AsString := varglobal;
      CDS.FieldByName('nama').AsString := varglobal1;

  end;

end;

procedure TfrmEstimasiMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmEstimasiMarketing.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

function TfrmEstimasiMarketing.gettarget(akode:string): double;
var
  s: string ;
  tsql : TmyQuery;
begin
  Result := 0;
  s := 'SELECT sum(tm_target*hna_grouppf) FROM ttargetmarketing inner join tgrouppf on kode_grouppf=tm_grouppf'
    + ' and periode=tm_periode and tahun=tm_tahun'
    + ' WHERE tm_salesman = ' + Quot(akode)
    + ' and tm_periode = '+ IntToStr(cbbBulan.ItemIndex+1)
    + ' and tm_tahun = ' + edtTahun.Text;

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
     Result := Fields[0].AsFloat;
  end;
end;


function TfrmEstimasiMarketing.cekdata(atahun:string;abulan:string;akode:string):Boolean;
var
  i:integer;
  s:string;
  tsql:TmyQuery;
begin
  result:=true;

  s := ' SELECT * FROM testimasimarketing_hdr2 WHERE esh_sls_kode = ' + Quot(akode)
    + ' AND esh_tahun = ' + atahun
    + ' AND esh_periode = ' + abulan
    + ' AND esh_lock = 1 ';

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
      begin
        ShowMessage('sudah di Lock, tidak bisa edit');
        result:=false;
        Exit;
      end;
    finally
      free;
    end;
  end;

   If edtKode.Text = '' then
  begin
    ShowMessage('Salesman belum di pilih');
    result:=false;
    Exit;
  end;
end;


function TfrmEstimasiMarketing.cekada(atahun:string;abulan:string;akode:string):Boolean;
var
  i:integer;
  s:string;
  tsql:TmyQuery;
begin
  result:=false;
  s := ' SELECT * FROM testimasimarketing_hdr2 WHERE esh_sls_kode = ' + Quot(akode)
      + ' AND esh_tahun = ' + atahun
      + ' AND esh_periode = ' + abulan;

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
      begin
        result:=true;
        Exit;
      end;
    finally
      free;
    end;
  end;
end;

procedure TfrmEstimasiMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('targetsales')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Realisasisales'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Targetsales'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmEstimasiMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('targetinkaso')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Realisasiinkaso'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Targetinkaso'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmEstimasiMarketing.btnRefreshClick(Sender: TObject);
begin
  if edtkode.text <> '' then
    loaddata(edtKode.Text);
end;

end.
