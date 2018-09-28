unit Decorator.Types;

interface

uses
  System.SysUtils,

  Decorator.Interfaces;

type
  TSteak = class(TInterfacedObject, IMeal)
  public
    // IMeal
    function Price: Double;
    function Description: string;
  end;

  TFish = class(TInterfacedObject, IMeal)
  public
    // IMeal
    function Price: Double;
    function Description: string;
  end;



  TGarnish = class abstract(TInterfacedObject)
  protected
    FMeal: IMeal;
  public
    constructor Create(const Meal: IMeal); virtual; abstract;
  end;

  TPommes = class(TGarnish, IMeal)
  public
    constructor Create(const Meal: IMeal); override;
    // IMeal
    function Price: Double;
    function Description: string;
  end;

  TSalad = class(TGarnish, IMeal)
  public
    constructor Create(const Meal: IMeal); override;
    // IMeal
    function Price: Double;
    function Description: string;
  end;

implementation

{ TSteak }

function TSteak.Description: string;
begin
  Result := 'Steak';
end;

function TSteak.Price: Double;
begin
  Result := 19.99;
end;

{ TFish }

function TFish.Description: string;
begin
  Result := 'Fish'
end;

function TFish.Price: Double;
begin
  Result := 16.99;
end;


{ TPommes }

constructor TPommes.Create(const Meal: IMeal);
begin
  FMeal := Meal;
end;

function TPommes.Description: string;
begin
  Result := Format('%s, Pommes', [FMeal.Description]);
end;

function TPommes.Price: Double;
begin
  Result := FMeal.Price + 1.99;
end;

{ TSalad }

constructor TSalad.Create(const Meal: IMeal);
begin
  FMeal := Meal;
end;

function TSalad.Description: string;
begin
  Result := Format('%s, Salad', [FMeal.Description]);
end;

function TSalad.Price: Double;
begin
  Result := FMeal.Price + 1.49;
end;

end.
