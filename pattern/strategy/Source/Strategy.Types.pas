unit Strategy.Types;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.TypInfo,
  Strategy.Interfaces;

type
  TStrategyBarkQuiet = class(TInterfacedObject, IStrategyBehaviorBark)
  public
    procedure Bark;
  end;

  TStrategyBarkLoud = class(TInterfacedObject, IStrategyBehaviorBark)
  public
    procedure Bark;
  end;

  TStrategyRunSlow = class(TInterfacedObject, IStrategyBehaviorRun)
  public
    procedure Run;
  end;

  TStrategyRunFast = class(TInterfacedObject, IStrategyBehaviorRun)
  public
    procedure Run;
  end;

  TAbstractDog = class abstract(TObject)
  private
    FStrategyBehaviorBark: IStrategyBehaviorBark;
    FStrategyBehaviorRun: IStrategyBehaviorRun;
    function GetStrategyBark: IStrategyBehaviorBark;
    function GetStrategyRun: IStrategyBehaviorRun;
    procedure SetStrategyBark(const Value: IStrategyBehaviorBark);
    procedure SetStrategyRun(const Value: IStrategyBehaviorRun);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure DoBark;
    procedure DoRun;

    property StrategyBark: IStrategyBehaviorBark
      read GetStrategyBark write SetStrategyBark;
    property StrategyRun: IStrategyBehaviorRun
      read GetStrategyRun write SetStrategyRun;
  end;

  TGermanShepherdDog = class(TAbstractDog)
  end;

  TFrenchBulldog = class(TAbstractDog)
  end;

implementation

{ TStrategyBarkQuiet }

procedure TStrategyBarkQuiet.Bark;
begin
  OutputDebugString(PChar(
    Format('[%s] Barking really quiet', [ClassName])));
end;

{ TStrategyBarkLoud }

procedure TStrategyBarkLoud.Bark;
begin
  OutputDebugString(PChar(
    Format('[%s] Barking out loud', [ClassName])));
end;

{ TStrategyRunSlow }

procedure TStrategyRunSlow.Run;
begin
  OutputDebugString(PChar(
    Format('[%s] Running slowly', [ClassName])));
end;

{ TStrategyRunFast }

procedure TStrategyRunFast.Run;
begin
  OutputDebugString(PChar(
    Format('[%s] Running really fast', [ClassName])));
end;

{ TAbstractDog }

constructor TAbstractDog.Create;
begin
  inherited;
  // Default strategies for running and barking.
  FStrategyBehaviorBark := TStrategyBarkQuiet.Create;
  FStrategyBehaviorRun := TStrategyRunSlow.Create;
end;

destructor TAbstractDog.Destroy;
begin
  inherited;
end;

function TAbstractDog.GetStrategyBark: IStrategyBehaviorBark;
begin
  Result := FStrategyBehaviorBark;
end;

function TAbstractDog.GetStrategyRun: IStrategyBehaviorRun;
begin
  Result := FStrategyBehaviorRun;
end;

procedure TAbstractDog.SetStrategyBark(
  const Value: IStrategyBehaviorBark);
begin
  FStrategyBehaviorBark := Value;

  OutputDebugString(PChar(
    Format('Changed strategy to %s',
      [(FStrategyBehaviorBark as TInterfacedObject).ClassName])));
end;

procedure TAbstractDog.SetStrategyRun(
  const Value: IStrategyBehaviorRun);
begin
  FStrategyBehaviorRun := Value;

  OutputDebugString(PChar(
    Format('Changed strategy to %s',
      [(FStrategyBehaviorRun as TInterfacedObject).ClassName])));
end;

procedure TAbstractDog.DoRun;
begin
  if Assigned(FStrategyBehaviorRun) then
  begin
    FStrategyBehaviorRun.Run;
  end;
end;

procedure TAbstractDog.DoBark;
begin
  if Assigned(FStrategyBehaviorBark) then
  begin
    FStrategyBehaviorBark.Bark;
  end;
end;

end.
