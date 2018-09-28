unit SpecificationPattern.Interfaces;

interface

uses
  Generics.Collections,
  Generics.Defaults;

type
  ISpecification<T: class> = interface
    ['{A4AC3668-1A07-4D92-B585-F77D8240CCA9}']
    // Returns true if satisfied with the given specification.
    function IsSatisfiedBy(const T: T): Boolean;
    // Returns a newly created specification that is the AND operation of both.
    function _And(const Specification: ISpecification<T>): ISpecification<T>;
    // Returns a newly created specification that is the OR operation of both.
    function _Or(const Specification: ISpecification<T>): ISpecification<T>;
    // Returns a newly created specification that is the NOT operation of both.
    function _Not(const Specification: ISpecification<T>): ISpecification<T>;
  end;

implementation

end.
