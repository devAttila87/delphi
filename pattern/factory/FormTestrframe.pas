unit FormTestrframe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  Factory.Types;

type
  TFmTestFrame = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FmTestFrame: TFmTestFrame;

implementation

{$R *.dfm}

procedure TFmTestFrame.FormCreate(Sender: TObject);
var
  PizzaStore: IPizzaStore;
  Pizza: IPizza;
  I: TPizzaTypes;
begin
  PizzaStore := TPizzaHutStore.Create;
  try
    for I := Low(TPizzaTypes) to High(TPizzaTypes) do
    begin
      Pizza := PizzaStore.OrderPizza(I);
      Assert(Assigned(Pizza), 'Something went wrong');
      ShowMessage(Format('Ordered a Pizza %s', [Pizza.GetName]));
    end;
  finally
    // The interface will be released when te scope of this method will be lost.
    // FreeAndNil(PizzaStore);
  end;
end;

end.
