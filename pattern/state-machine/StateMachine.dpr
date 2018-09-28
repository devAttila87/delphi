program StateMachine;

uses
  Vcl.Forms,
  FmMain in 'FmMain.pas' {FormMain},
  BaseTypes in 'BaseTypes.pas',
  CommonTypes in 'CommonTypes.pas',
  Miner in 'Miner.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
