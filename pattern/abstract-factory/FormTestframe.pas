unit FormTestframe;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Generics.Collections,
  Generics.Defaults,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,

  AbstractFactory.Interfaces,
  AbstractFactory.Types;

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
  Plant: IPlant;
  Animal: IAnimal;
  Ground: IGround;
  WorldGenerator: IGenerator;
begin
  // Get godlike world generator.
  WorldGenerator := TPolarRegionGenerator.Create;

  // Fill the world with entities.
  Plant := WorldGenerator.GeneratePlant;
  Animal := WorldGenerator.GenerateAnimal;
  Ground := WorldGenerator.GenerateGround;

  // Build the world.
  // ...
  // ..
  // .
end;

end.
