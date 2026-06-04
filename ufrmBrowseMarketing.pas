unit ufrmBrowseMarketing;

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
  TfrmBrowseMarketing = class(TfrmCxBrowse)
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
  frmBrowseMarketing: TfrmBrowseMarketing;

implementation
   uses ufrmMarketing,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMarketing.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mkt_kode Kode ,mkt_nama Nama,cbg_nama Cabang from tmarketing'
  + ' inner join tcabang on cbg_kode=mkt_cabang ';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseMarketing.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMarketing.cxButton2Click(Sender: TObject);
var
  frmmarketing: Tfrmmarketing;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmmarketing  := frmmenu.ShowForm(Tfrmmarketing) as Tfrmmarketing;
      frmmarketing.edtKode.SetFocus;
   end;
   frmmarketing.Show;
end;

procedure TfrmBrowseMarketing.cxButton1Click(Sender: TObject);
var
  frmmarketing: Tfrmmarketing;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master marketing' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmmarketing  := frmmenu.ShowForm(Tfrmmarketing) as Tfrmmarketing;
      frmmarketing.ID := CDSMaster.FieldByname('KODE').AsString;
      frmmarketing.FLAGEDIT := True;
      frmmarketing.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmmarketing.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmmarketing.edtKode.Enabled := False;
   end;
   frmmarketing.Show;
end;

procedure TfrmBrowseMarketing.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMarketing.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmmarketing') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tmarketing '
        + ' where mkt_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);

end;

end.
