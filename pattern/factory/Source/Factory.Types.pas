unit Factory.Types;

interface

uses
  System.SysUtils,
  System.Classes,

  Generics.Defaults;

type
  TPizzaTypes = (ptSalami, ptCheese, ptHotAndSpicy);

  IPizza = interface(IInterface)
  ['{5D132FF1-42CA-4694-A135-C80C15D28102}']
    function GetType: TPizzaTypes;
    function GetName: string;

    procedure Prepare;
    procedure Bake;
    procedure Cut;
    procedure Box;
  end;

  TPizzaSalami = class(TInterfacedObject, IPizza)
  public
    constructor Create;
    destructor Destroy; override;
    // IPizza
    function GetType: TPizzaTypes;
    function GetName: string;
    procedure Prepare;
    procedure Bake;
    procedure Cut;
    procedure Box;
  end;

  TPizzaCheese = class(TInterfacedObject, IPizza)
  public
    constructor Create;
    destructor Destroy; override;
    // IPizza
    function GetType: TPizzaTypes;
    function GetName: string;
    procedure Prepare;
    procedure Bake;
    procedure Cut;
    procedure Box;
  end;

  TPizzaHotAndSpicy = class(TInterfacedObject, IPizza)
  public
    constructor Create;
    destructor Destroy; override;
    // IPizza
    function GetType: TPizzaTypes;
    function GetName: string;
    procedure Prepare;
    procedure Bake;
    procedure Cut;
    procedure Box;
  end;

  IPizzaStore = interface(IInterface)
  ['{9ACA1CF0-9180-4FDC-849E-7C66F42604AA}']
    function OrderPizza(const PizzaType: TPizzaTypes): IPizza;
  end;

  TPizzaHutStore = class(TInterfacedObject, IPizzaStore)
  public
    constructor Create;
    destructor Destroy; override;
    // IPizzaStore
    function OrderPizza(const PizzaType: TPizzaTypes): IPizza;
  end;

  TPizzaFactory = class(TSingletonImplementation)
  private class var
    FInstance: TPizzaFactory;
  protected
    function InternalCreatePizza(const PizzaType: TPizzaTypes): IPizza; virtual;
  public
    destructor Destroy; override;
    class function CreatePizzaByType(const PizzaType: TPizzaTypes): IPizza;
  end;

implementation

{ TPizzaSalami }

constructor TPizzaSalami.Create;
begin
  //
end;

destructor TPizzaSalami.Destroy;
begin
  inherited;
end;

procedure TPizzaSalami.Prepare;
begin
  //
end;

procedure TPizzaSalami.Bake;
begin
  //
end;

procedure TPizzaSalami.Cut;
begin
  //
end;

procedure TPizzaSalami.Box;
begin
  //
end;

function TPizzaSalami.GetName: string;
begin
  Result := 'SuperSalami 2,99€';
end;

function TPizzaSalami.GetType: TPizzaTypes;
begin
  Result := ptSalami;
end;

{ TPizzaCheese }

procedure TPizzaCheese.Bake;
begin
  //
end;

procedure TPizzaCheese.Box;
begin
  //
end;

constructor TPizzaCheese.Create;
begin
  //
end;

procedure TPizzaCheese.Cut;
begin
  //
end;

destructor TPizzaCheese.Destroy;
begin
  inherited;
end;

function TPizzaCheese.GetName: string;
begin
  Result := 'SuperCheese 3,99€';
end;

function TPizzaCheese.GetType: TPizzaTypes;
begin
  Result := ptCheese;
end;

procedure TPizzaCheese.Prepare;
begin
  //
end;

{ TPizzaHotAndSpicy }

procedure TPizzaHotAndSpicy.Bake;
begin
  //
end;

procedure TPizzaHotAndSpicy.Box;
begin
  //
end;

constructor TPizzaHotAndSpicy.Create;
begin
  //
end;

procedure TPizzaHotAndSpicy.Cut;
begin
  //
end;

destructor TPizzaHotAndSpicy.Destroy;
begin
  inherited;
end;

function TPizzaHotAndSpicy.GetName: string;
begin
  Result := 'SuperHotAndSpicy 4,99€';
end;

function TPizzaHotAndSpicy.GetType: TPizzaTypes;
begin
  Result := ptHotAndSpicy;
end;

procedure TPizzaHotAndSpicy.Prepare;
begin
  //
end;

{ TPizzaHutStore }

constructor TPizzaHutStore.Create;
begin
  //
end;

destructor TPizzaHutStore.Destroy;
begin
  inherited;
end;

function TPizzaHutStore.OrderPizza(const PizzaType: TPizzaTypes): IPizza;
begin
  Result := TPizzaFactory.CreatePizzaByType(PizzaType);
end;

{ TPizzaFactory }

class function TPizzaFactory.CreatePizzaByType(
  const PizzaType: TPizzaTypes): IPizza;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TPizzaFactory.Create;
  end;

  Result := FInstance.InternalCreatePizza(PizzaType);
end;

destructor TPizzaFactory.Destroy;
begin
  FreeAndNil(FInstance);
  inherited;
end;

function TPizzaFactory.InternalCreatePizza(const PizzaType: TPizzaTypes): IPizza;
begin
  case PizzaType of
    ptSalami: Result := TPizzaSalami.Create;
    ptCheese: Result := TPizzaCheese.Create;
    ptHotAndSpicy: Result := TPizzaHotAndSpicy.Create;
    else
      Assert(False, 'Unknown type.');
  end;

  Result.Prepare;
  Result.Bake;
  Result.Cut;
  Result.Box;
end;

end.
