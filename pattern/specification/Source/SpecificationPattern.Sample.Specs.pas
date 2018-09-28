unit SpecificationPattern.Sample.Specs;

interface

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.Types,

  VCL.Graphics,

  Generics.Collections,

  SpecificationPattern.Types,
  SpecificationPattern.Sample.Types;

type
  TCarAgeSpecification = class(TAbstractSpecification<TCar>)
  protected
    FTodayDate: TDate;
    FMaxAgeInYears: Integer;
  public
    constructor Create(const TodayDate: TDate; const MaxAgeInYears: Integer);
    // ISpecification<T>
    function IsSatisfiedBy(const T: TCar): Boolean; override;
  end;

  TCarColorSpecification = class(TAbstractSpecification<TCar>)
  protected
    FColor: TColor;
  public
    constructor Create(const AColor: TColor);
    // ISpecification<T>
    function IsSatisfiedBy(const T: TCar): Boolean; override;
  end;

  TCarPersonRegionSpecification = class(TAbstractSpecification<TCar>)
  protected
    FAllowedRegions: TRegions;
  public
    constructor Create(const AAllowedRegions: TRegions);
    // ISpecification<T>
    function IsSatisfiedBy(const T: TCar): Boolean; override;
  end;

  TCarConvertibleSpecification = class(TAbstractSpecification<TCar>)
  public
    // ISpecification<T>
    function IsSatisfiedBy(const T: TCar): Boolean; override;
  end;

implementation

{ TCarAgeSpecification }

constructor TCarAgeSpecification.Create(const TodayDate: TDate;
  const MaxAgeInYears: Integer);
begin
  inherited Create;
  FTodayDate := TodayDate;
  FMaxAgeInYears := MaxAgeInYears;
end;

function TCarAgeSpecification.IsSatisfiedBy(const T: TCar): Boolean;
var
  tmpDate: TDateTime;
begin
  tmpDate := IncYear(FTodayDate, -Abs(FMaxAgeInYears));
  Result := CompareDateTime(tmpDate, T.ManufacturingDate) = LessThanValue;
end;

{ TCarColorSpecification }

constructor TCarColorSpecification.Create(const AColor: TColor);
begin
  inherited Create;
  FColor := AColor;
end;

function TCarColorSpecification.IsSatisfiedBy(const T: TCar): Boolean;
begin
  Result := T.Color = FColor;
end;

{ TCarPersonRegionSpecification }

constructor TCarPersonRegionSpecification.Create(
  const AAllowedRegions: TRegions);
begin
  FAllowedRegions := AAllowedRegions;
end;

function TCarPersonRegionSpecification.IsSatisfiedBy(const T: TCar): Boolean;
begin
  Result := T.Person.Region in FAllowedRegions;
end;

{ TCarConvertibleSpecification }

function TCarConvertibleSpecification.IsSatisfiedBy(const T: TCar): Boolean;
begin
  Result := T.Convertible;
end;

end.
