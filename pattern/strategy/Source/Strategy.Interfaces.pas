unit Strategy.Interfaces;

interface

type
  IStrategyBehaviorBark = interface(IUnknown)
    ['{4B9FFD6E-6E72-478C-ACC9-9E4A0F8CE8F2}']
    procedure Bark;
  end;

  IStrategyBehaviorRun = interface(IUnknown)
    ['{7043CC6A-1401-4704-9793-F5B659A945D4}']
    procedure Run;
  end;

implementation

end.
