unit ufrmListJualMarketing2;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, te_controls, Menus, cxLookAndFeelPainters,
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
  AdvCombo, MemDS, DBAccess, MyAccess;


type
  TfrmListJualMarketing2 = class(TForm)
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
    cbbBulan: TAdvComboBox;
    Label3: TLabel;
    edtTahun: TComboBox;
    Label4: TLabel;
    edtFilter: TEdit;
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
    xhppPremium,xhppsolar,xhpppertamaxplus,xhpppertamax : double ;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmListJualMarketing2: TfrmListJualMarketing2;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport;
{$R *.dfm}



procedure TfrmListJualMarketing2.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJualMarketing2.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJualMarketing2.refreshdata;
begin
startdate.DateTime := date;
enddate.DateTime := date;
startdate.SetFocus;
//  edttahun.text :=  FormatDateTime('yyyy',Date);
//  edtTahun.setfocus;

end;

procedure TfrmListJualMarketing2.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJualMarketing2.FormShow(Sender: TObject);
begin
  flagedit := False;
  edtfilter.Text := FormatDateTime('yyyy',date);
//  refreshdata;
end;





procedure TfrmListJualMarketing2.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJualMarketing2.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJualMarketing2.loaddata;
var
  skolom,s,smargin: string ;
  afilter2,afilter : string ;
  i,jmlkolom:integer;
begin


s:= 'SELECT c.mkt_nama Marketing,kode_grouppf,nama_grouppf Nama,tm_periode Periode,tm_tahun Tahun,tm_target Target,'
+ ' (tm_target*hna_grouppf) Target_value,d.cbg_nama Cabang ,'
+ ' (SELECT ifnull(SUM(QTY),0) FROM salespfbygroup WHERE'
+ ' nama_grouppf=a.nama_grouppf AND tahun=b.tm_tahun AND periode=b.tm_periode AND sc_sls_kode =c.mkt_kode ) qty_realisasi,'
+ ' (SELECT ifnull(SUM(Nilai),0) FROM salespfbygroup WHERE'
+ ' nama_grouppf=a.nama_grouppf AND tahun=b.tm_tahun AND periode=b.tm_periode AND sc_sls_kode =c.mkt_kode ) Total_realisasi'
+ ' FROM tgrouppf a'
+ ' INNER JOIN ttargetmarketing b ON a.kode_grouppf=b.tm_grouppf AND a.periode=tm_periode'
+ ' AND a.tahun=tm_tahun'
+ ' INNER JOIN tmarketing c ON c.mkt_kode=b.tm_salesman'
+ ' INNER JOIN tcabang d ON cbg_kode=mkt_cabang AND tm_tahun='+edtFilter.Text;



        ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Marketing,Kode_Grouppf,Nama,Periode,Tahun,Target,Target_Value,Cabang,Qty_Realisasi,Total_realisasi';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';
//
//        cxGrid1DBTableView1.Columns[13].Summary.FooterKind:=skSum;
//        cxGrid1DBTableView1.Columns[13].Summary.FooterFormat:='###,###,###,###';
//



           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           jmlkolom :=cxGrid1DBTableView1.ColumnCount-1;

        for i:=0 To jmlkolom do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;



        //  hitung;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Cabang','Bulan']);
           SetPivotRow (['Nama']);
           SetPivotData(['Target_Value','Total_realisasi']);


end;

procedure TfrmListJualMarketing2.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListJualMarketing2.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJualMarketing2.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListJualMarketing2.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJualMarketing2.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJualMarketing2.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJualMarketing2.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJualMarketing2.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJualMarketing2.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListJualMarketing2.cxButton1Click(Sender: TObject);
begin
    With cxPivot.GetFieldByName('Marketing') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Total_realisasi')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Total_realisasi')
    else
      SortBySummaryInfo.Field := nil;
  end;
end;

end.
