unit SpecificationPattern.Types;

interface

uses
  System.SysUtils,
  System.Classes,

  Generics.Collections,
  Generics.Defaults,

  SpecificationPattern.Interfaces;

type
  // Abstract base with default implementation of Add, Or and Not.
  TAbstractSpecification<T: class> = class(TInterfacedObject,
    ISpecification<T>)
  public
    // ISpecification<T>
    function IsSatisfiedBy(const T: T): Boolean; virtual; abstract;
    function _And(const Specification: ISpecification<T>): ISpecification<T>;
    function _Or(const Specification: ISpecification<T>): ISpecification<T>;
    function _Not(const Specification: ISpecification<T>): ISpecification<T>;
  end;

  // AND specification, used to create a new specifcation that is the AND of
  // two other specifications.
  TAndSpecification<T: class> = class(TAbstractSpecification<T>,
    ISpecification<T>)
  protected
    FSpecificationA: ISpecification<T>;
    FSpecificationB: ISpecification<T>;
  public
    constructor Create(const SpecA, SpecB: ISpecification<T>);
    // ISpecification<T>
    function IsSatisfiedBy(const T: T): Boolean; override;
  end;

  // OR specification, used to create a new specifcation that is the OR of
  // two other specifications.
  TOrSpecification<T: class> = class(TAbstractSpecification<T>, ISpecification<T>)
  protected
    FSpecificationA: ISpecification<T>;
    FSpecificationB: ISpecification<T>;
  public
    constructor Create(const SpecA, SpecB: ISpecification<T>);
    // ISpecification<T>
    function IsSatisfiedBy(const T: T): Boolean; override;
  end;

  // NOT decorator, used to create a new specifcation that is the inverse (NOT)
  // of the given specification.
  TNotSpecification<T: class> = class(TAbstractSpecification<T>, ISpecification<T>)
  protected
    FSpecificationA: ISpecification<T>;
    // FSpecificationB: ISpecification<T>;
  public
    constructor Create(const SpecA(*, SpecB*): ISpecification<T>);
    // ISpecification<T>
    function IsSatisfiedBy(const T: T): Boolean; override;
  end;

implementation

{ TAbstractSpecification<T> }

function TAbstractSpecification<T>._And(
  const Specification: ISpecification<T>): ISpecification<T>;
begin
  Result := TAndSpecification<T>.Create(Self, Specification);
end;

function TAbstractSpecification<T>._Not(
  const Specification: ISpecification<T>): ISpecification<T>;
begin
  Result := TNotSpecification<T>.Create((*Self, *)Specification);
end;

function TAbstractSpecification<T>._Or(
  const Specification: ISpecification<T>): ISpecification<T>;
begin
  Result := TOrSpecification<T>.Create(Self, Specification);
end;

{ TAndSpecification<T> }

constructor TAndSpecification<T>.Create(const SpecA, SpecB: ISpecification<T>);
begin
  Assert(Assigned(SpecA) and Assigned(SpecB), 'not allowed');
  FSpecificationA := SpecA;
  FSpecificationB := SpecB;
end;

function TAndSpecification<T>.IsSatisfiedBy(const T: T): Boolean;
begin
  Result := FSpecificationA.IsSatisfiedBy(T) and
    FSpecificationB.IsSatisfiedBy(T);
end;

{ TOrSpecification<T> }

constructor TOrSpecification<T>.Create(const SpecA, SpecB: ISpecification<T>);
begin
  Assert(Assigned(SpecA) and Assigned(SpecB), 'not allowed');
  FSpecificationA := SpecA;
  FSpecificationB := SpecB;
end;

function TOrSpecification<T>.IsSatisfiedBy(const T: T): Boolean;
begin
  Result := FSpecificationA.IsSatisfiedBy(T) or
    FSpecificationB.IsSatisfiedBy(T);
end;

{ TNotSpecification<T> }

constructor TNotSpecification<T>.Create(const SpecA(*, SpecB*): ISpecification<T>);
begin
  Assert(Assigned(SpecA), 'not allowed');
  FSpecificationA := SpecA;
  //FSpecificationB := SpecB;
end;

function TNotSpecification<T>.IsSatisfiedBy(const T: T): Boolean;
begin
  (*
  Result := FSpecificationA.IsSatisfiedBy(T) and
    not FSpecificationB.IsSatisfiedBy(T);
  *)
  Result := not FSpecificationA.IsSatisfiedBy(T);

end;

end.
