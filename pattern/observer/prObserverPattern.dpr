program prObserverPattern;

uses
  Vcl.Forms,
  FormTestFrame in 'FormTestFrame.pas' {FmTestFrame},
  Observer.Interfaces in 'Source\Observer.Interfaces.pas',
  Observer.Types in 'Source\Observer.Types.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmTestFrame, FmTestFrame);
  Application.Run;
end.
