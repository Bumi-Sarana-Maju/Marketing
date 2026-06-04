program Marketing;

uses
  Forms,
  MAIN in 'MAIN.pas' {frmMenu},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  ufrmUser in 'ufrmUser.pas' {frmUser},
  uFrmbantuan in 'bantu\uFrmbantuan.pas' {frmBantuan},
  uReport in 'bantu\uReport.pas',
  uModuleConnection in 'bantu\uModuleConnection.pas',
  ufrmCxBrowse in 'ufrmCxBrowse.pas' {frmCxBrowse},
  ufrmBrowseMarketing in 'ufrmBrowseMarketing.pas' {frmBrowseMarketing},
  ufrmMarketing in 'ufrmMarketing.pas' {frmMarketing},
  ufrmBrowseSubBarangPF in 'ufrmBrowseSubBarangPF.pas' {frmBrowseSubBarangPF},
  ufrmSubBarangPF in 'ufrmSubBarangPF.pas' {frmSubBarangPF},
  ufrmTargetMarketing in 'ufrmTargetMarketing.pas' {frmTargetMarketing},
  ufrmBrowseSetingBarangPF in 'ufrmBrowseSetingbarangpf.pas' {frmBrowseSetingBarangPF},
  ufrmSetingBarangPF in 'ufrmSetingBarangPF.pas' {frmSetingBarangPF},
  ufrmBrowseGrouppf in 'ufrmBrowseGrouppf.pas' {frmBrowseGrouppf},
  ufrmGrouppf in 'ufrmGrouppf.pas' {frmGroupPF},
  ufrmLapBulananMarketing in 'ufrmLapBulananMarketing.pas' {frmLapBulananMarketing},
  ufrmListJualMarketing in 'ufrmListJualMarketing.pas' {frmListJualMarketing},
  Ulib in 'bantu\Ulib.pas',
  ufrmKomisiMarketing in 'ufrmKomisiMarketing.pas' {frmKomisiMarketing},
  ufrmSalesMarketing in 'ufrmSalesMarketing.pas' {frmSalesMarketing},
  ufrmLapKunjungan in 'ufrmLapKunjungan.pas' {frmLapKunjungan},
  ufrmListJualMarketing2 in 'ufrmListJualMarketing2.pas' {frmListJualMarketing2},
  ufrmListJualPFvsRiil in 'ufrmListJualPFvsRiil.pas' {frmListJualPFvsRiil},
  ufrmEstimasiMarketing in 'ufrmEstimasiMarketing.pas' {frmEstimasiMarketing},
  ufrmLapEstimasiMarketing in 'ufrmLapEstimasiMarketing.pas' {frmLapEstimasiMarketing};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
