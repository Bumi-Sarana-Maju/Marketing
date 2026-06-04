unit ufrmListJualPFvsRiil;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, Menus, cxLookAndFeelPainters,
  cxButtons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid ,
  Grids, BaseGrid, AdvGrid, AdvCGrid, ComCtrls, Mask, ImgList, FMTBcd,
  Provider, DB, DBClient, DBGrids, cxLookAndFeels, cxDBData,
  cxGridBandedTableView, cxGridDBTableView,
  cxGridChartView, cxCustomPivotGrid, cxDBPivotGrid, cxPC,
  cxPivotGridChartConnection, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns,  cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, dxPScxGrid6Lnk,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  te_controls, AdvEdBtn, AdvEdit, MemDS, DBAccess, MyAccess;


type
  TfrmListJualPFvsRiil = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel4: TTePanel;
    ilMenu: TImageList;
    TePanel1: TTePanel;
    ilToolbar: TImageList;
    TePanel2: TTePanel;
    TeLabel1: TTeLabel;
    SaveDialog1: TSaveDialog;
    TePanel3: TTePanel;
    dtstprvdr1: TDataSetProvider;
    sqlqry2: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxChart: TcxGrid;
    cxGrdChart: TcxGridChartView;
    lvlChart: TcxGridLevel;
    cxPivot: TcxDBPivotGrid;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid11Level1: TcxGridLevel;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxButton3: TcxButton;
    cxButton1: TcxButton;
    Label3: TLabel;
    edtNama: TAdvEdit;
    edtkode: TAdvEditBtn;
    Label4: TLabel;
    edtfilterNama: TAdvEdit;
    cxButton2: TcxButton;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxPageControl1Click(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure dttanggalChange(Sender: TObject);
    procedure TeSpeedButton2Click(Sender: TObject);
    procedure SetPivotColumns(ColumnSets: Array Of String);
    procedure SetPivotData(ColumnSets: Array Of String);
    procedure SetPivotRow(ColumnSets: Array Of String);
    procedure cxButton1Click(Sender: TObject);
    procedure edtkodeClickBtn(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);

  private
    flagedit : Boolean;
    fid : integer;
    fnomorjual : string ;
    FPivotChartLink: TcxPivotGridChartConnection;
    xtotal,xhpp : Double;
    iskupon : Integer;
    ntotalpremium , ntotalsolar , ntotalpertamax, ntotalpertamaxplus , ntotalpenjualan : double;
    ntotaljpremium , ntotaljsolar , ntotaljpertamax, ntotaljpertamaxplus  : double;
    ntotalbayar : double;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;


    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmListJualPFvsRiil: TfrmListJualPFvsRiil;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport,
  uFrmbantuan;
{$R *.dfm}



procedure TfrmListJualPFvsRiil.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJualPFvsRiil.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJualPFvsRiil.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListJualPFvsRiil.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJualPFvsRiil.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListJualPFvsRiil.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJualPFvsRiil.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJualPFvsRiil.loaddata;
var
  s:String ;
  skolom : string ;
  i,jmlkolom:integer;
begin
s:='';
  if edtkode.Text <> '' then

  s:=' SELECT Cabang,Nomor,Tanggal,Bulan,Tahun,Outlet,Kode,Nama,Qty,Nilai,Kontrak,Departemen,SubDepartemen,Kategori,Group_Produk,Pajak,IsPf,Salesman,Marketing,NilaiByHna,Nilaiblmppn,IsN3,kunjunganmarketing,kunjungansales,isecer,Biayapromosi '
+ ' ,if(bpf_brg_kode IS NULL ,0,nilaiblmppn) NilaiblmppnPF,'
+ ' if(bpf_brg_kode IS NULL ,0,qty) QtyPf FROM (select * from tampung_2022 union select * from tampung_2023 union select * from tampung_2024) A left JOIN tbarangpf'
+ ' ON bpf_brg_kode=kode and bulan=bpf_periode and tahun=bpf_tahun'
+ ' AND bpf_kode_grouppf = '+Quot(edtkode.Text)
+ ' where tanggal between '+ QuotD(startdate.DateTime) + ' and '+ QuotD(enddate.DateTime)
+ '  and cabang ='+ Quot(getnama('tcabang','cbg_kode',frmMenu.KDCABANG,'cbg_nama'));


if edtfilterNama.Text <> '' then
  s:=' SELECT Cabang,Nomor,Tanggal,Bulan,Tahun,Outlet,Kode,Nama,Qty,Nilai,Kontrak,Departemen,SubDepartemen,Kategori,Group_Produk,Pajak,IsPf,Salesman,Marketing,NilaiByHna,Nilaiblmppn,IsN3,kunjunganmarketing,kunjungansales,isecer,Biayapromosi '
+ ' ,if(bpf_brg_kode IS NULL ,0,nilaiblmppn) NilaiblmppnPF,'
+ ' if(bpf_brg_kode IS NULL ,0,qty) QtyPf FROM (select * from tampung_2022 union select * from tampung_2023 union select * from tampung_2024) A left JOIN tbarangpf'
+ ' ON bpf_brg_kode=kode and bulan=bpf_periode and tahun=bpf_tahun'
+ ' AND bpf_grup like  '+Quot('%'+edtfilterNama.Text+'%')
+ ' where tanggal between '+ QuotD(startdate.DateTime) + ' and '+ QuotD(enddate.DateTime)
+ '  and cabang ='+ Quot(getnama('tcabang','cbg_kode',frmMenu.KDCABANG,'cbg_nama'));

  IF S='' THEN
  begin
    ShowMessage('pilih kode atau isi filter name dulu');
    exit;
  end;

        ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

        Skolom :='Cabang,Nomor,Tanggal,Bulan,Tahun,Outlet,Kode,Nama,Qty,Nilai,Kontrak,Departemen,SubDepartemen,Kategori,Group_Produk,Pajak,IsPf,Salesman,Marketing,NilaiByHna,Nilaiblmppn,IsN3,kunjunganmarketing,kunjungansales,isecer,Biayapromosi,NilaiblmppnPF,QtyPf';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);

           jmlkolom :=cxGrid1DBTableView1.ColumnCount-2;

        for i:=0 To jmlkolom do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Tahun']);
           SetPivotRow (['Cabang','Outlet']);
           SetPivotData(['NilaiBlmPPn','NilaiblmppnPF']);

end;

procedure TfrmListJualPFvsRiil.btnTampilClick(Sender: TObject);
begin
  loaddata;
end;

procedure TfrmListJualPFvsRiil.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJualPFvsRiil.TeSpeedButton1Click(Sender: TObject);
begin

  IF PageControl1.Pages[1].Visible  then
     TcxDBPivotHelper(cxPivot).ExportToXLS
  else
  begin
     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;
 end;


end;


procedure TfrmListJualPFvsRiil.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJualPFvsRiil.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJualPFvsRiil.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJualPFvsRiil.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJualPFvsRiil.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJualPFvsRiil.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListJualPFvsRiil.cxButton1Click(Sender: TObject);
begin
  With cxPivot.GetFieldByName('Outlet') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('salesman') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('marketing') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;


    With cxPivot.GetFieldByName('Cabang') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Group_Produk') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Kategori') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('SubDepartemen') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;

       With cxPivot.GetFieldByName('Departemen') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiBlmPpn')
    else
      SortBySummaryInfo.Field := nil;
  end;
end;

procedure TfrmListJualPFvsRiil.edtkodeClickBtn(Sender: TObject);
var
  s:String;
  tsql:TmyQuery;
begin
   sqlbantuan:='select DISTINCT kode_grouppf Kode,Nama_Grouppf Nama from tgrouppf';
   Application.CreateForm(Tfrmbantuan,frmbantuan);
   frmBantuan.SQLMaster := SQLbantuan;
   frmBantuan.ShowModal;


   if varglobal <> '' then
   begin
     edtkode.Text := varglobal;
     edtNama.Text := varglobal1;
   end;


end;


procedure TfrmListJualPFvsRiil.cxButton2Click(Sender: TObject);
begin
  With cxPivot.GetFieldByName('Outlet') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('salesman') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('marketing') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;


    With cxPivot.GetFieldByName('Cabang') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Group_Produk') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Kategori') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('SubDepartemen') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;

       With cxPivot.GetFieldByName('Departemen') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('NilaiblmppnPF')
    else
      SortBySummaryInfo.Field := nil;
  end;
end;

end.
