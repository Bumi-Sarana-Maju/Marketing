unit ufrmGroupPF;

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
  dxSkinscxPCPainter, cxDBExtLookupComboBox, MyAccess;

type
  TfrmGroupPF = class(TForm)
    AdvPanel1: TAdvPanel;
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
    clKode: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    clHna: TcxGridDBColumn;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    clnamadept: TcxGridDBColumn;
    clkodegroup: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGrdMainColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure clnamagroupPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    function gethna(akode:string):double;  
   procedure loaddata (abulan:String;atahun:string);
   procedure initViewdept;

  private
    FFLAGEDIT: Boolean;
    FID: string;
    FCDSSKU : TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    { Public declarations }
  end;

var
  frmGroupPF: TfrmGroupPF;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmGroupPF.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
          initViewdept;
end;

procedure TfrmGroupPF.refreshdata;
begin
  FID:='';
  edtTahun.Text := FormatDateTime('yyyy',Date);
  initgrid;
end;
procedure TfrmGroupPF.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmGroupPF.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGroupPF.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmGroupPF.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  fid : integer;
begin


   s:= ' delete from tgrouppf'
      + ' where  periode =' + inttostr(cbbBulan.ItemIndex+1)
      + ' and tahun = ' + edtTahun.Text;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
       // xCommit(frmMenu.conn);

   tt := TStringList.Create;
    CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if not CDS.FieldByName('kode').IsNull then
   begin
    s:='insert into tgrouppf (kode_grouppf,nama_grouppf,hna_grouppf,periode,tahun,kode_deptpf)'
    + ' values ('
      + quot(CDS.FieldByName('kode').Asstring) + ','
      + quot(CDS.FieldByName('nama').Asstring) + ','
      + FloatToStr(CDS.FieldByName('HNA').AsFloat) + ','
      + inttostr(cbbBulan.ItemIndex+1) + ','
      + edttahun.text+','
      + quot(CDS.FieldByName('departemen').Asstring) 
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


procedure TfrmGroupPF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmGroupPF.cxButton1Click(Sender: TObject);
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

procedure TfrmGroupPF.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmGroupPF.cxButton2Click(Sender: TObject);
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
procedure TfrmGroupPF.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmGroupPF.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'nama', ftstring, False,100);
    zAddField(FCDS, 'kode', ftInteger, False);
    zAddField(FCDS, 'HNA', ftFloat, False);
    zAddField(FCDS, 'Departemen', ftstring, False,100);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmGroupPF.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmGroupPF.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmGroupPF.clnamagroupPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
  sqlbantuan := ' SELECT  kode_grouppf Kode,nama_Grouppf Nama,hna_grouppf from tgrouppf order by nama_grouppf';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin

   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('kodeGroup').AsString := varglobal;
      CDS.FieldByName('namaGroup').AsString := varglobal1;
      CDS.FieldByName('HNA').asfloat := gethna(varglobal);


  end;

end;

function TfrmGroupPF.gethna(akode:string):double;
var
  s:String;
  tsql:TmyQuery;
begin
  result:=0;
  s:='select hna_grouppf from tgrouppf where kode_grouppf='+ Quot(akode);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
         result :=  fields[0].asfloat;
    finally
      free;
    end;
  end;
end;

procedure TfrmGroupPF.loaddata (abulan:String;atahun:string);
var
  s:string;
  tsql:TmyQuery;
begin
 s:='SELECT kode_Grouppf,nama_grouppf,hna_grouppf,kode_deptpf,periode,tahun'
+ ' FROM tgrouppf '
+ ' WHERE periode = '+abulan+' AND tahun = '+ atahun ;
  tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
   tsql.First;
   cds.EmptyDataSet;
   while not Eof do
   begin
     cds.Append;
     cds.FieldByName('kode').AsString := Fields[0].AsString;
     cds.FieldByName('nama').AsString := Fields[1].AsString;
     cds.FieldByName('hna').Asfloat := Fields[2].AsFloat;
     cds.FieldByName('departemen').AsString := Fields[3].AsString;
     cds.post;
     Next;
   end;
   finally
     free;
   end;
 end;


end;

procedure TfrmGroupPF.initViewdept;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select kode_deptpf departemen,nama_deptpf from tdeptpf ';


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clnamadept.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'departemen','departemen',['departemen'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clnamadept.Properties) do
    LoadFromCDS(CDSSKU, 'departemen','nama_deptpf',['departemen'],Self);


end;


end.
