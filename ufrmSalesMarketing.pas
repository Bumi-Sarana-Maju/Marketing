unit ufrmSalesMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  AdvCombo, MyAccess;

type
  TfrmSalesMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
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
    clSalesman: TcxGridDBColumn;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    edtCabang: TAdvEditBtn;
    clAlamat: TcxGridDBColumn;
    cxGrdMainColumn1: TcxGridDBColumn;
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
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    function getcabang(akode:String):string;  
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton7Click(Sender: TObject);
    procedure edtCabangClickBtn(Sender: TObject);
    procedure clSalesmanPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

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
  frmSalesMarketing: TfrmSalesMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink;

{$R *.dfm}

procedure TfrmSalesMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmSalesMarketing.refreshdata;
begin
  FID:='';
  edtcabang.Clear;
  edtNama.Clear;
    initgrid;
end;
procedure TfrmSalesMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmSalesMarketing.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSalesMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSalesMarketing.loaddata(akode:string) ;
var
  s: string;
  tsql : TmyQuery;
  i:Integer;
begin
  s:= 'select cus_kode,cus_nama,cus_alamat alamat,'
    + '(select mkt_nama from tmarketing inner join tsalescustomer on sc_sls_kode=mkt_kode '
    +' where sc_cus_kode=cus_kode and sc_periode='+inttostr(cbbbulan.itemindex+1)+' and sc_tahun='+edttahun.text
    + ' and mkt_cabang='+ Quot(edtcabang.Text)
    + ' limit 1) mkt_nama ,'
    + '(select mkt_kode from tmarketing inner join tsalescustomer on sc_sls_kode=mkt_kode '
    +' where sc_cus_kode=cus_kode and sc_periode='+inttostr(cbbbulan.itemindex+1)+' and sc_tahun='+edttahun.text
    +' and mkt_cabang='+ Quot(edtcabang.Text)
    + ' limit 1) mkt_kode '
    + ' from '
    + ' customer '
    + ' where cus_cabang='+Quot(akode);
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;

    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('kode').AsString := fieldbyname('cus_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('cus_nama').AsString;
      CDS.FieldByName('alamat').AsString  := fieldbyname('alamat').AsString;
      CDS.FieldByName('salesman').AsString  := fieldbyname('mkt_nama').AsString;
      CDS.FieldByName('idsales').AsString  := fieldbyname('mkt_kode').AsString;


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


procedure TfrmSalesMarketing.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
begin
     tt := TStringList.Create;
   s:= ' delete a.* from tsalescustomer a inner join tmarketing b on mkt_kode=sc_sls_kode'
      + ' where  mkt_cabang=' + quot(edtcabang.text)
      + ' and sc_periode='+ inttostr(cbbbulan.ItemIndex+1)
      + ' and sc_tahun = '+ edttahun.Text;

   tt.Append(s);
      CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('idsales').asstring <> '' then
   begin
    S:='insert into tsalescustomer (sc_sls_kode,sc_cus_kode,sc_periode,sc_tahun) values ('
      + Quot(CDS.FieldByName('idsales').Asstring) +','
      + quot(CDS.FieldByName('kode').Asstring) + ','
      + inttostr(cbbBulan.ItemIndex+1)+','
      + edttahun.Text
      + ');';
    tt.Append(s);
   end;
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


procedure TfrmSalesMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmSalesMarketing.cxButton1Click(Sender: TObject);
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

procedure TfrmSalesMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSalesMarketing.cxButton2Click(Sender: TObject);
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
procedure TfrmSalesMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmSalesMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'Alamat', ftstring, False,100);
    zAddField(FCDS, 'Salesman', ftstring, False,20);
    zAddField(FCDS, 'idsales', ftstring, False,10);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmSalesMarketing.getcabang(akode:String):string;
var
  s:String;
  tsql:TmyQuery;
begin
  s:='select mkt_cabang from tmarketing where mkt_kode='+Quot(akode);
  tsql:= xOpenQuery(s,frmmenu.conn) ;
  with tsql do
  begin
    try
      Result := fields[0].AsString;
    finally
      free;
    end;
  end;
end;

procedure TfrmSalesMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSalesMarketing.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmSalesMarketing.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdMain.DataController.CollapseDetails;

end;

procedure TfrmSalesMarketing.edtCabangClickBtn(Sender: TObject);
var
  s:String;
  tsql:TmyQuery;
begin
  sqlbantuan:='select cbg_kode Kode,cbg_nama  Nama from tcabang where cbg_kode like  '+ Quot(frmmenu.KDCABANG+'%');
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtcabang.Text := varglobal;
  edtNama.Text := varglobal1;
  loaddata(edtcabang.text);
  end;

end;

procedure TfrmSalesMarketing.clSalesmanPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
    sqlbantuan:='select mkt_kode Kode,mkt_nama  Nama from tmarketing where mkt_cabang like  '+ Quot(edtcabang.text+'%');
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
       If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('salesman').AsString  := varglobal1;
      CDS.FieldByName('idsales').AsString  := varglobal;
      CDS.Post;

  end;

end;

end.
