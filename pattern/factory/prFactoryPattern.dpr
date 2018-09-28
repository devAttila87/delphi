program prFactoryPattern;

uses
  Vcl.Forms,
  FormTestrframe in 'FormTestrframe.pas' {FmTestFrame},
  Factory.Types in 'Source\Factory.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmTestFrame, FmTestFrame);
  Application.Run;
end.
