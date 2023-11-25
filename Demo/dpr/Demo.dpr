program Demo;

uses
  Vcl.Forms,
  uMain in '..\src\uMain.pas' {frmMain},
  VM.CodiceFiscale.Classes in '..\..\Core\VM.CodiceFiscale.Classes.pas',
  VM.PartitaIVA.Classes in '..\..\Core\VM.PartitaIVA.Classes.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
