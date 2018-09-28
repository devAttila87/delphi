unit SpecificationPattern.Sample.Types;

interface

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils,

  Generics.Collections,
  Generics.Defaults,

  Vcl.Graphics,

  SpecificationPattern.Interfaces;

type
  TRegion = (reEurope=0, reAmerica=1, reAsia=2, reAfrica=3, rePacific=4);
  TRegions = set of TRegion;

  TPerson = record
    Address: string;
    Region: TRegion;
  end;

  TCar = class(TObject)
  private
    FColor: TColor;
    FConvertible: Boolean;
    FPerson: TPerson;
    FManufacturingDate: TDate;
  public
    constructor CreateWithParams(
      const AColor: TColor;
      const AConvertible: Boolean;
      const APerson: TPerson;
      const ADate: TDate);
    destructor Destroy; override;
    property Color: TColor read FColor write FColor;
    property Convertible: Boolean read FConvertible write FConvertible;
    property Person: TPerson read FPerson write FPerson;
    property ManufacturingDate: TDate read FManufacturingDate
      write FManufacturingDate;
  end;
  TCars = class(TObjectList<TCar>);

  ICarRepository = interface
    ['{8136C192-6316-4909-B7FA-17EFF5754A61}']
    function FindAllCarsInStock: TCars;
  end;

  TCarRepo = class(TInterfacedObject, ICarRepository)
  private
    FCars: TCars;
  protected
    procedure Prepare(const AmountOfCars: Integer);
  public
    constructor Create(const AmountOfCars: Integer = 999);
    destructor Destroy; override;

    // ICarRepository
    function FindAllCarsInStock: TCars;
  end;

  ICarService = interface
    ['{37EA5C17-3D78-49EA-8917-C264E19D4B81}']
    function FindCandidateCars(Specification: ISpecification<TCar>): TCars;
    procedure SetRepository(const CarRepository: ICarRepository);
  end;

  TCarService = class(TInterfacedObject, ICarService)
  private
    FCarRepository: ICarRepository;
  protected
    function ObtainAllowedRegions: TRegions;
  public
    constructor Create(const Repository: ICarRepository);
    destructor Destroy; override;

    // ICarService
    function FindCandidateCars(Specification: ISpecification<TCar>): TCars;
    procedure SetRepository(const CarRepository: ICarRepository);

    property Repository: ICarRepository read FCarRepository write SetRepository;
  end;

var
  CarColorArray: array[0..5] of TColor = (
    clRed,
    clBlack,
    clPurple,
    clLime,
    clYellow,
    clAqua);

implementation

uses
  SpecificationPattern.Sample.Specs;

{ TCar }

constructor TCar.CreateWithParams(const AColor: TColor;
  const AConvertible: Boolean; const APerson: TPerson; const ADate: TDate);
begin
  inherited Create;
  FColor := AColor;
  FConvertible := AConvertible;
  FPerson := APerson;
  FManufacturingDate := ADate;
end;

destructor TCar.Destroy;
begin
  inherited;
end;

{ TCarService }

constructor TCarService.Create(const Repository: ICarRepository);
begin
  FCarRepository := Repository;
end;

destructor TCarService.Destroy;
begin
  inherited;
end;

function TCarService.FindCandidateCars(
  Specification: ISpecification<TCar>): TCars;
var
  Car: TCar;
  Cars: TCars;
  Keepers: TCars;
begin
  Cars := FCarRepository.FindAllCarsInStock;
  Keepers := TCars.Create(False);

  for Car in Cars do
  begin
    if Specification.IsSatisfiedBy(Car) then
    begin
      Keepers.Add(Car);
    end;
  end;

  Keepers.Sort;
  Result := Keepers;
end;

function TCarService.ObtainAllowedRegions: TRegions;
begin
  // All by default
  Result := [reEurope, reAmerica, reAsia, reAfrica, rePacific];
end;

procedure TCarService.SetRepository(const CarRepository: ICarRepository);
begin
  FCarRepository := CarRepository;
end;

{ TCarRepo }

constructor TCarRepo.Create(const AmountOfCars: Integer = 999);
begin
  FCars := TCars.Create(
    TComparer<TCar>.Construct(
    function (const L, R: TCar): integer
    begin
       if L.Color < R.Color then
          Result := -1
       else if L.Color > R.Color then
          Result := 1
       else
          Result := 0;
    end),
    False); // OwnsObjects

  Prepare(AmountOfCars);
end;

destructor TCarRepo.Destroy;
begin
  FCars.Free;
  inherited;
end;

function TCarRepo.FindAllCarsInStock: TCars;
begin
  Result := FCars;
end;

procedure TCarRepo.Prepare(const AmountOfCars: Integer);
var
  I: Integer;

  tmpRegion: TRegion;
  tmpRegions: TRegions;
  tmpRegionCount: Integer;

  Car: TCar;
  CarOwner: TPerson;
  CarColor: TColor;
  CarIsConvertible: Boolean;
  CarManufactureringDate: TDate;
begin
  // Obtain count of regions
  tmpRegionCount := 0;
  tmpRegions := [reEurope, reAmerica, reAsia, reAfrica, rePacific];
  for tmpRegion in tmpRegions do
  begin
    Inc(tmpRegionCount);
  end;

  for I := 0 to AmountOfCars do
  begin
    Randomize;

    CarOwner.Address := Format('Huston Street #%d', [I]);
    CarOwner.Region :=  TRegion(Ord(Random(tmpRegionCount)));
    CarColor := CarColorArray[Random(Length(CarColorArray))];
    CarIsConvertible := not (Random(2) = 0);
    CarManufactureringDate := (Now - Random(3600));

    Car := TCar.Create;
    try
      Car.Color := CarColor;
      Car.Person := CarOwner;
      Car.Convertible := CarIsConvertible;
      Car.ManufacturingDate := CarManufactureringDate;

      FCars.Add(Car);
    except
      raise Exception.Create('Could not create a TCar object.');
    end;
  end;

  FCars.Sort;
end;

end.
