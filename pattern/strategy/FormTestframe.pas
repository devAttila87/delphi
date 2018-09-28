unit FormTestframe;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,

  Strategy.Types;

type
  TFmTestframe = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FmTestframe: TFmTestframe;

implementation

{$R *.dfm}

procedure TFmTestframe.FormCreate(Sender: TObject);
var
  ShepherdDog: TGermanShepherdDog;
begin
  ShepherdDog := TGermanShepherdDog.Create;
  try
    // test default strategy
    ShepherdDog.DoBark;
    ShepherdDog.DoRun;

    // change strategy
    ShepherdDog.StrategyBark := TStrategyBarkLoud.Create;
    ShepherdDog.StrategyRun := TStrategyRunFast.Create;

    // test strategy again
    ShepherdDog.DoBark;
    ShepherdDog.DoRun;
  finally
    ShepherdDog.Free;
  end;
end;

end.
