program prStrategyPattern;

uses
  Vcl.Forms,
  FormTestframe in 'FormTestframe.pas' {FmTestframe},
  Strategy.Interfaces in 'Source\Strategy.Interfaces.pas',
  Strategy.Types in 'Source\Strategy.Types.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmTestframe, FmTestframe);
  Application.Run;
end.
