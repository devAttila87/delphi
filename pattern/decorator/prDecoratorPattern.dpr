program prDecoratorPattern;

uses
  Vcl.Forms,
  FmTestframe in 'FmTestframe.pas' {FormTestFrame},
  Decorator.Interfaces in 'Source\Decorator.Interfaces.pas',
  Decorator.Types in 'Source\Decorator.Types.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormTestFrame, FormTestFrame);
  Application.Run;
end.
