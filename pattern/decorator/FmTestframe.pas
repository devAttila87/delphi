unit FmTestframe;

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

  Decorator.Interfaces,
  Decorator.Types;

type
  TFormTestFrame = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormTestFrame: TFormTestFrame;

implementation

{$R *.dfm}

procedure TFormTestFrame.FormCreate(Sender: TObject);
var
  MyMeal: IMeal;
begin
  // Order a steak with pommes and salad.
  MyMeal :=
    TSalad.Create( TPommes.Create( TSteak.Create ) );

  OutputDebugString(PChar(Format('%s for %.2f', [MyMeal.Description,
    MyMeal.Price])));

  MyMeal := nil;

  // Order fish with salad.
  MyMeal := TSalad.Create( TFish.Create );

  OutputDebugString(PChar(Format('%s for %.2f', [MyMeal.Description,
    MyMeal.Price])));


  // Step by step
  MyMeal := TSteak.Create;
  try
    OutputDebugString(PChar(
      Format('%s for %.2f', [MyMeal.Description, MyMeal.Price])));

    MyMeal := TPommes.Create(MyMeal);
    try
      OutputDebugString(PChar(
        Format('%s for %.2f', [MyMeal.Description, MyMeal.Price])));

      MyMeal := TSalad.Create(MyMeal);
      try
        OutputDebugString(PChar(
          Format('%s for %.2f', [MyMeal.Description, MyMeal.Price])));
      finally
        // Ignore
      end;

    finally
      // Ignore
    end;

  finally
    MyMeal := nil;
  end;

end;

end.
