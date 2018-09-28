program prCommandPattern;

uses
  Vcl.Forms,
  FormTestframe in 'FormTestframe.pas' {FmTestframe},
  Command.Interfaces in 'Source\Command.Interfaces.pas',
  Command.Types in 'Source\Command.Types.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmTestframe, FmTestframe);
  Application.Run;
end.
