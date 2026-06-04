unit ufrmBrowseGroupPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, dxSkinDarkRoom,
  dxSkinFoggy, dxSkinSeven, dxSkinSharp, dxSkinsDefaultPainters;

type
  TfrmBrowseGrouppf = class(TfrmCxBrowse)
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseGrouppf: TfrmBrowseGrouppf;

implementation
   uses ufrmGroupPF,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseGrouppf.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select '
  + ' Periode,Tahun,Kode_grouppf,Nama_Grouppf,HNA_Grouppf'
  + '  from tgrouppf order by kode_grouppf ';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
end;

procedure TfrmBrowseGrouppf.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseGrouppf.cxButton2Click(Sender: TObject);
var
  frmGroupPF: TfrmGroupPF;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Seting Group PF' then
   begin
      frmGroupPF  := frmmenu.ShowForm(TfrmGroupPF) as TfrmGroupPF;
   end;
   frmGroupPF.Show;
end;

procedure TfrmBrowseGrouppf.cxButton1Click(Sender: TObject);
var
  frmGroupPF: TfrmGroupPF;
begin
  inherited;
  If CDSMaster.FieldByname('periode').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Seting Group PF' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmGroupPF  := frmmenu.ShowForm(TfrmGroupPF) as TfrmGroupPF;
//      frmGroupPF.ID := CDSMaster.FieldByname('KODE').AsString;
      frmGroupPF.FLAGEDIT := True;
      frmGroupPF.cbbBulan.ItemIndex := StrToInt(CDSMaster.FieldByname('Periode').AsString)-1;
      frmGroupPF.edtTahun.Text := CDSMaster.FieldByname('Tahun').AsString;
      frmGroupPF.loaddata(CDSMaster.FieldByname('periode').AsString,CDSMaster.FieldByname('tahun').AsString);

   end;
   frmGroupPF.Show;
end;

procedure TfrmBrowseGrouppf.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseGrouppf.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmGrouppf') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tGrouppf '
        + ' where periode = ' + quot(CDSMaster.FieldByname('periode').AsString)
        + ' and tahun = ' + quot(CDSMaster.FieldByname('tahun').AsString)+';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


//      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
  btnRefreshClick(self);
end;

end.
