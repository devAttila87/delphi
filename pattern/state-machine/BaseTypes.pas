unit BaseTypes;

interface

uses
  System.SysUtils,
  System.Classes,

  CommonTypes;

type
  TStateMachine<T> = class;

  // TEntityCallback = procedure(const Identifier: Integer; const CallbackMsg: string) of object;
  TEntityCallback = reference to procedure(const Name: string; const Identifier: Integer; const CallbackMsg: string);

  TBaseGameEntity = class(TObject)
  protected
    // Every entity has a unique identifying number.
    FID: Integer;
    // Triggered when a output is available.
    FOnEntityCallback: TEntityCallback;
  protected class var
    // This is next valid ID. Each time a TBaseGameEntity is instantiated this
    // value is updated.
    FNextValidID: Integer;
    // This is called within the constructor to make sure the ID is set
    // correctly. It verifies that the value passed to the method is greater or
    // equal to the next valid ID, before setting the ID and incrementing the
    // next valid ID.
    procedure SetID(const Identifier: Integer);
  public
    class constructor Create;
    class destructor Destroy;
    constructor Create(const Identifier: Integer; const Callback: TEntityCallback); virtual;
    destructor Destroy; override;
    // Returns a qualified name for the enity.
    function GetQualifiedEntityName: string; virtual; abstract;
    // All entities must implement an update method.
    procedure Update; virtual; abstract;
    property ID: Integer read FID;
    property OnCallback: TEntityCallback read FOnEntityCallback write FOnEntityCallback;
  end;

  IState<T> = interface
    ['{AB0FBB88-2778-4B09-95C1-257A616A5199}']
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity);
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity);
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity);
  end;

  (* For memory leak testing.
  *)
  TState<T> = class(TInterfacedObject, IState<T>)
  public
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); virtual; abstract;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); virtual; abstract;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); virtual; abstract;
  end;

  TStateMachine<T> = class(TObject)
  private
    // Reference to an agent that owns this instance.
    FOwner: TBaseGameEntity;
    // Actual state the agent is in.
    // FCurrentState: IState<T>;
    FCurrentState: TState<T>;
    // Last state the agent was in.
    // FPreviousState: IState<T>;
    FPreviousState: TState<T>;
    // this state logic is called every time the FSM is updated.
    // FGlobalState: IState<T>;
    FGlobalState: TState<T>;
  public
    constructor Create(const Owner: TBaseGameEntity);
    destructor Destroy; override;

    // Use these methods to initialize the FSM.
    (*
    procedure SetCurrentState(const S: IState<T>);
    procedure SetPreviousState(const S: IState<T>);
    procedure SetGlobalState(const S: IState<T>);
    *)
    procedure SetCurrentState(const S: TState<T>);
    procedure SetPreviousState(const S: TState<T>);
    procedure SetGlobalState(const S: TState<T>);

    // Call this to update the FSM.
    procedure Update();
    // Change to a new state.
    // procedure ChangeState(const NewState: IState<T>);
    procedure ChangeState(const NewState: TState<T>);
    // Change the state back to the previous state.
    procedure RevertToPreviousState();

    // Returns true if the current state's type is equal to the type of the
    // class passed as a parameter.
    // function IsInState(const S: IState<T>): Boolean;
    function IsInState(const S: TState<T>): Boolean;

    (*
    property CurrentState: IState<T> read FCurrentState;
    property PreviousState: IState<T> read FPreviousState;
    property GlobalState: IState<T> read FGlobalState;
    *)
    property CurrentState: TState<T> read FCurrentState;
    property PreviousState: TState<T> read FPreviousState;
    property GlobalState: TState<T> read FGlobalState;
  end;

implementation

{ TBaseGameEntity }

class constructor TBaseGameEntity.Create;
begin
  FNextValidID := 0;
end;

class destructor TBaseGameEntity.Destroy;
begin
  // ...
end;

constructor TBaseGameEntity.Create(const Identifier: Integer; const Callback: TEntityCallback);
begin
  SetID(Identifier);
  FOnEntityCallback := Callback;
end;

destructor TBaseGameEntity.Destroy;
begin
  inherited;
end;

procedure TBaseGameEntity.SetID(const Identifier: Integer);
begin
  if (FNextValidID = 0) or (FNextValidID >= Identifier) then
  begin
    FID := Identifier;
    FNextValidID := FID;
    Inc(FNextValidID);
  end
  else
  begin
    Assert(False);
  end;
end;

{ TStateMachine<T> }

constructor TStateMachine<T>.Create(const Owner: TBaseGameEntity);
begin
  inherited Create;
  FOwner := Owner;
  FGlobalState := nil;
  FCurrentState := nil;
  FPreviousState := nil;
end;

destructor TStateMachine<T>.Destroy;
begin
  inherited;
end;

// procedure TStateMachine<T>.ChangeState(const NewState: IState<T>);
procedure TStateMachine<T>.ChangeState(const NewState: TState<T>);
begin
  Assert(Assigned(FCurrentState) and Assigned(NewState));
  // Why does that not work properly?
  // Keep a record of the previous state.
  FPreviousState := FCurrentState;
  // Call the exit method of the existing state.
  FCurrentState.Exit(FOwner);
  // Change the state to the new state.
  FCurrentState := NewState;
  // Call the enter mehod of the new state.
  FCurrentState.Enter(FOwner);
end;

procedure TStateMachine<T>.RevertToPreviousState;
begin
  ChangeState(FPreviousState);
end;

// function TStateMachine<T>.IsInState(const S: IState<T>): Boolean;
function TStateMachine<T>.IsInState(const S: TState<T>): Boolean;
begin
  Result := S = FCurrentState;
end;

// procedure TStateMachine<T>.SetCurrentState(const S: IState<T>);
procedure TStateMachine<T>.SetCurrentState(const S: TState<T>);
begin
  FCurrentState := S;
end;

// procedure TStateMachine<T>.SetGlobalState(const S: IState<T>);
procedure TStateMachine<T>.SetGlobalState(const S: TState<T>);
begin
  FGlobalState := S;
end;

// procedure TStateMachine<T>.SetPreviousState(const S: IState<T>);
procedure TStateMachine<T>.SetPreviousState(const S: TState<T>);
begin
  FPreviousState := S;
end;

procedure TStateMachine<T>.Update;
begin
  // If a global state exist, call its execute method.
  if Assigned(FGlobalState) then
  begin
    FGlobalState.Execute(FOwner);
  end;

  // Same for the current state.
  if Assigned(FCurrentState) then
  begin
    FCurrentState.Execute(FOwner);
  end;
end;

end.
