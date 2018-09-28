program prAbstractFactory;

uses
  Vcl.Forms,
  FormTestframe in 'FormTestframe.pas' {FmTestframe},
  AbstractFactory.Types in 'Source\AbstractFactory.Types.pas',
  AbstractFactory.Interfaces in 'Source\AbstractFactory.Interfaces.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmTestframe, FmTestframe);
  Application.Run;
end.
