unit Miner;

interface

uses
  System.SysUtils,
  System.Classes,

  Winapi.Windows,

  BaseTypes,
  CommonTypes;

type
  TEnterMineAndDigForNugget = class;
  TVisitBankAndDepositGold = class;
  TQuenchThirstInSaloon = class;
  TGoHomeAndSleepTilRested = class;
  TMinerGlobalState = class;

  TMiner = class(TBaseGameEntity)
  private
    // The place where the miner currently situated.
    FLocation: TLocation;
    // How many nuggets the miner has in his pockets.
    FGoldCarried: Byte;
    // How much money the miner has deposite in the bank.
    FMoneyInBank: Int64;
    // The higher the value, the thirtier the miner.
    FThirst: Byte;
    // The higher the value, the more tired the miner.
    FFatigue: Byte;
    // Instance of the agents FSM.
    FFSM: TStateMachine<TMiner>;
  protected const
    MaxNuggets: Byte = 8;
    ThirstStep: Byte = 1;
    FatigueStep: Byte = 1;
    ThirstThreshold: Byte = 4;
    FatigueThreshold: Byte = 24;
    WealhtyThreshold: Byte = 16;
  public
    constructor Create(const Identifier: Integer; const Callback: TEntityCallback); override;
    destructor Destroy; override;

    // Returns the instance of the entity.
    function GetFSM: TStateMachine<TMiner>;
    // Returns a qualified name for the enity.
    function GetQualifiedEntityName: string; override;
    // All entities must implement an update method.
    procedure Update; override;
    // This method changes the current location to the new location.
    procedure ChangeLocation(const NewLocation: TLocation);
    // Adds the amount to gold carried.
    procedure AddToGoldCarried(const AmountOfGold: Byte);
    // Transfers gold carried to money in bank.
    procedure DepositeGoldCarriedToBank;
    // Increases the level of thirst.
    procedure IncreaseThirst;
    // Increases the level of tiredness.
    procedure IncreaseFatigue;
    // Resets the thirst level to zero
    procedure DrinkToGetRidOfThirst;
    // Decreases the miner's fatigue level by.
    procedure Rest;
    // Returns true if the level of tiredness is equal or greater than the
    // threshold.
    function Tired: Boolean;
    // Returns true if the miner is rested and ready to work.
    function Rested: Boolean;
    // Returns true if the level of thirst is equal or greater than the
    // threshold.
    function Thirsty: Boolean;
    // Returns true if the amount of gol carried is equal or greater than
    // MaxNuggets.
    function PocketsFull: Boolean;

    property Location: TLocation read FLocation;
    property GoldCarried: Byte read FGoldCarried;
    property MoneyInBank: Int64 read FMoneyInBank;
    property Thirst: Byte read FThirst;
    property Fatigue: Byte read FFatigue;
    property ID;
    property OnCallback;
  end;

  // TEnterMineAndDigForNugget = class(TInterfacedObject, IState<TMiner>)
  TEnterMineAndDigForNugget = class(TState<TMiner>)
  private
    constructor Create;
  public class var
    FInstance: TEnterMineAndDigForNugget;
  public
    destructor Destroy; override;
    class function Instance: TEnterMineAndDigForNugget;
    class procedure Release;
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); override;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); override;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); override;
  end;

  // TVisitBankAndDepositGold = class(TInterfacedObject, IState<TMiner>)
  TVisitBankAndDepositGold = class(TState<TMiner>)
  private
    constructor Create;
  public class var
    FInstance: TVisitBankAndDepositGold;
  public
    destructor Destroy; override;
    class function Instance: TVisitBankAndDepositGold;
    class procedure Release;
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); override;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); override;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); override;
  end;

  // TQuenchThirstInSaloon = class(TInterfacedObject, IState<TMiner>)
  TQuenchThirstInSaloon = class(TState<TMiner>)
  private
    constructor Create;
  public class var
    FInstance: TQuenchThirstInSaloon;
  public
    destructor Destroy; override;
    class function Instance: TQuenchThirstInSaloon;
    class procedure Release;
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); override;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); override;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); override;
  end;

  // TGoHomeAndSleepTilRested = class(TInterfacedObject, IState<TMiner>)
  TGoHomeAndSleepTilRested = class(TState<TMiner>)
  private
    constructor Create;
  public class var
    FInstance: TGoHomeAndSleepTilRested;
  public
    destructor Destroy; override;
    class function Instance: TGoHomeAndSleepTilRested;
    class procedure Release;
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); override;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); override;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); override;
  end;

  // TMinerGlobalState = class(TInterfacedObject, IState<TMiner>)
  TMinerGlobalState = class(TState<TMiner>)
  private
    constructor Create;
  public class var
    FInstance: TMinerGlobalState;
  public
    destructor Destroy; override;
    class function Instance: TMinerGlobalState;
    class procedure Release;
    // This will execute when the state is entered.
    procedure Enter(const Entity: TBaseGameEntity); override;
    // This is called by the entity's update function each update step.
    procedure Execute(const Entity: TBaseGameEntity); override;
    // This will execute when the state is exited.
    procedure Exit(const Entity: TBaseGameEntity); override;
  end;

implementation

{ TMiner }

constructor TMiner.Create(const Identifier: Integer; const Callback: TEntityCallback);
begin
  inherited;
  FLocation := ltHome;
  FGoldCarried := 0;
  FMoneyInBank := 0;
  FThirst := 0;
  FFatigue := 0;

  FFSM := TStateMachine<TMiner>.Create(Self);
  FFSM.SetGlobalState(TMinerGlobalState.Instance());
  FFSM.SetPreviousState(TGoHomeAndSleepTilRested.Instance());
  FFSM.SetCurrentState(TEnterMineAndDigForNugget.Instance());
end;

procedure TMiner.DepositeGoldCarriedToBank;
begin
  FMoneyInBank := FMoneyInBank + FGoldCarried;
  FGoldCarried := 0;
end;

destructor TMiner.Destroy;
begin
  FFSM.Free;
  inherited;
end;

procedure TMiner.DrinkToGetRidOfThirst;
begin
  FThirst := 0;
  FMoneyInBank := FMoneyInBank - 1;
end;

function TMiner.GetFSM: TStateMachine<TMiner>;
begin
  Result := FFSM;
end;

function TMiner.GetQualifiedEntityName: string;
begin
  Result := TMinerNameString[TMinerName(FID)]
end;

procedure TMiner.Update;
begin
  IncreaseThirst;
  // Update the agents FSM.
  FFSM.Update;
end;

procedure TMiner.ChangeLocation(const NewLocation: TLocation);
begin
  if FLocation <> NewLocation then
  begin
    FLocation := Newlocation;
  end;
end;

procedure TMiner.IncreaseFatigue;
begin
  if FFatigue < FatigueThreshold then
    FFatigue := FFatigue + FatigueStep
  else
    FFatigue := 0;
end;

procedure TMiner.IncreaseThirst;
begin
  if FThirst < ThirstThreshold then
    FThirst := FThirst + ThirstStep
  else
    FThirst := 0;
end;

function TMiner.PocketsFull: Boolean;
begin
  Result := FGoldCarried >= MaxNuggets;
end;

procedure TMiner.Rest;
begin
  if Fatigue >= FatigueStep then
  begin
    FFatigue := FFatigue - FatigueStep;
  end;
end;

function TMiner.Rested: Boolean;
begin
  Result := FFatigue <= (FatigueThreshold div 4);
end;

function TMiner.Thirsty: Boolean;
begin
  Result := FThirst >= ThirstThreshold;
end;

function TMiner.Tired: Boolean;
begin
  Result := FFatigue >= FatigueThreshold;
end;

procedure TMiner.AddToGoldCarried(const AmountOfGold: Byte);
begin
  FGoldCarried := FGoldCarried + AmountOfGold;
end;

{ TEnterMineAndDigForNugget }

constructor TEnterMineAndDigForNugget.Create;
begin
  inherited Create;
  FInstance := nil;
end;

destructor TEnterMineAndDigForNugget.Destroy;
begin
  if FInstance = Self then
    FInstance := nil;
  inherited;
end;

class function TEnterMineAndDigForNugget.Instance: TEnterMineAndDigForNugget;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TEnterMineAndDigForNugget.Create;
  end;
  Result := FInstance;
end;

class procedure TEnterMineAndDigForNugget.Release;
begin
  FreeAndNil(FInstance);
end;

procedure TEnterMineAndDigForNugget.Enter(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // If the miner is not already located at the gold mine, he must change
    // location to the gold mine.
    if((Entity as TMiner).Location <> ltGoldmine) then
    begin
      // Write to debug output.
      OutputDebugString(PChar(
        Format('Miner %s: %s', [
          IntToStr((Entity as TMiner).ID),
          TMinerActionString[maWalkingToGoldmine]])));

      // Trigger callback
      if Assigned((Entity as TMiner).OnCallback) then
      begin
        (Entity as TMiner).OnCallback(
          (Entity as TMiner).GetQualifiedEntityName,
          (Entity as TMiner).ID,
          TMinerActionString[maWalkingToGoldmine])
      end;

      (Entity as TMiner).ChangeLocation(ltGoldmine);
    end;
  end;
end;

procedure TEnterMineAndDigForNugget.Execute(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // The miner digs for gold until he is carrying in excess of MaxNuggets.
    // If he gets thirsty during his digging he stops work and changes state
    // to go to saloon for a whiskey.
    (Entity as TMiner).AddToGoldCarried(1);
    // Digin' is hard work.
    (Entity as TMiner).IncreaseFatigue;

    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maPickingNugget]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maPickingNugget])
    end;

    // If enough gold mined, go and put it in the bank
    if (Entity as TMiner).PocketsFull then
    begin
      (Entity as TMiner).GetFSM.ChangeState(TVisitBankAndDepositGold.Instance());
    end;

    // If thirsty go and get a whiskey
    if (Entity as TMiner).Thirsty then
    begin
      (Entity as TMiner).GetFSM.ChangeState(TQuenchThirstInSaloon.Instance());
    end;

    // If tired go home and rest
    if (Entity as TMiner).Tired then
    begin
      (Entity as TMiner).GetFSM.ChangeState(TGoHomeAndSleepTilRested.Instance());
    end;
  end;
end;

procedure TEnterMineAndDigForNugget.Exit(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maLeavingGoldmine]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maLeavingGoldmine])
    end;
  end;
end;

{ TVisitBankAndDepositGold }

constructor TVisitBankAndDepositGold.Create;
begin
  inherited Create;
  FInstance := nil;
end;

destructor TVisitBankAndDepositGold.Destroy;
begin
  if FInstance = Self then
  begin
    FInstance := nil;
  end;
  inherited;
end;

class function TVisitBankAndDepositGold.Instance: TVisitBankAndDepositGold;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TVisitBankAndDepositGold.Create;
  end;
  Result := FInstance;
end;

class procedure TVisitBankAndDepositGold.Release;
begin
  FreeAndNil(FInstance);
end;

procedure TVisitBankAndDepositGold.Enter(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // If the miner is not already located at the bank, he must change
    // location to the bank.
    if((Entity as TMiner).Location <> ltBank) then
    begin
      // Write to debug output.
      OutputDebugString(PChar(
        Format('Miner %s: %s', [
          IntToStr((Entity as TMiner).ID),
          TMinerActionString[maGoingToBank]])));

      // Trigger callback
      if Assigned((Entity as TMiner).OnCallback) then
      begin
        (Entity as TMiner).OnCallback(
          (Entity as TMiner).GetQualifiedEntityName,
          (Entity as TMiner).ID,
          TMinerActionString[maGoingToBank])
      end;

      (Entity as TMiner).ChangeLocation(ltBank);
    end;
  end;
end;

procedure TVisitBankAndDepositGold.Execute(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    (Entity as TMiner).DepositeGoldCarriedToBank;
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        Format(TMinerActionString[maDepositingGold], [(Entity as TMiner).MoneyInBank])
      ])
    ));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        Format(TMinerActionString[maDepositingGold],
            [(Entity as TMiner).MoneyInBank]))
    end;

    // Does the miner have enough gold to be rich and go home?
    if (Entity as TMiner).FMoneyInBank >= (Entity as TMiner).WealhtyThreshold then
    begin
      // Write to debug output.
      OutputDebugString(PChar(
        Format('Miner %s: %s', [
          IntToStr((Entity as TMiner).ID),
          TMinerActionString[maRichEnough]])));

      // Trigger callback
      if Assigned((Entity as TMiner).OnCallback) then
      begin
        (Entity as TMiner).OnCallback(
          (Entity as TMiner).GetQualifiedEntityName,
          (Entity as TMiner).ID,
            TMinerActionString[maRichEnough])
      end;

      // The miner has achieved his goal for today. Let's take him home.
      (Entity as TMiner).GetFSM.ChangeState(TGoHomeAndSleepTilRested.Instance());
    end
    else
    begin
      // The miner has not enough gold found today so he has to work further.
      (Entity as TMiner).GetFSM.ChangeState(TEnterMineAndDigForNugget.Instance());
    end;
  end;
end;

procedure TVisitBankAndDepositGold.Exit(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maLeavingTheBank]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maLeavingTheBank])
    end;
  end;
end;

{ TQuenchThirstInSaloon }

constructor TQuenchThirstInSaloon.Create;
begin
  inherited Create;
  FInstance := nil;
end;

destructor TQuenchThirstInSaloon.Destroy;
begin
  if FInstance = Self then
  begin
    FInstance := nil;
  end;
  inherited;
end;

class function TQuenchThirstInSaloon.Instance: TQuenchThirstInSaloon;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TQuenchThirstInSaloon.Create;
  end;
  Result := FInstance;
end;

class procedure TQuenchThirstInSaloon.Release;
begin
  FreeAndNil(FInstance);
end;

procedure TQuenchThirstInSaloon.Enter(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // If the miner is not already located at the bank, he must change
    // location to the bank.
    if((Entity as TMiner).Location <> ltBank) then
    begin
      // Write to debug output.
      OutputDebugString(PChar(
        Format('Miner %s: %s', [
          IntToStr((Entity as TMiner).ID),
          TMinerActionString[maWalkingToSaloon]])));

      // Trigger callback
      if Assigned((Entity as TMiner).OnCallback) then
      begin
        (Entity as TMiner).OnCallback(
          (Entity as TMiner).GetQualifiedEntityName,
          (Entity as TMiner).ID,
          TMinerActionString[maWalkingToSaloon])
      end;

      (Entity as TMiner).ChangeLocation(ltSaloon);
    end;
  end;
end;

procedure TQuenchThirstInSaloon.Execute(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maDrinkLiquor]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(

        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maDrinkLiquor])
    end;

    // Take care of the miner's thirst level.
    (Entity as TMiner).DrinkToGetRidOfThirst;

    // The miner is no thirsty anymore. Let's go back to the mine.
    (Entity as TMiner).GetFSM.ChangeState(TEnterMineAndDigForNugget.Instance());
  end;
end;

procedure TQuenchThirstInSaloon.Exit(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maLeavingSaloon]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maLeavingSaloon])
    end;
  end;
end;

{ TGoHomeAndSleepeTilRested }

constructor TGoHomeAndSleepTilRested.Create;
begin
  inherited Create;
  FInstance := nil;
end;

destructor TGoHomeAndSleepTilRested.Destroy;
begin
  if FInstance = Self then
  begin
    FInstance := nil;
  end;
  inherited;
end;

class function TGoHomeAndSleepTilRested.Instance: TGoHomeAndSleepTilRested;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TGoHomeAndSleepTilRested.Create;
  end;
  Result := FInstance;
end;

class procedure TGoHomeAndSleepTilRested.Release;
begin
  FreeAndNil(FInstance);
end;

procedure TGoHomeAndSleepTilRested.Enter(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // If the miner is not already located at home, he must change
    // location to the bank.
    if((Entity as TMiner).Location <> ltHome) then
    begin
      // Write to debug output.
      OutputDebugString(PChar(
        Format('Miner %s: %s', [
          IntToStr((Entity as TMiner).ID),
          TMinerActionString[maGoingHome]])));

      // Trigger callback
      if Assigned((Entity as TMiner).OnCallback) then
      begin
        (Entity as TMiner).OnCallback(
          (Entity as TMiner).GetQualifiedEntityName,
          (Entity as TMiner).ID,
          TMinerActionString[maGoingHome])
      end;

      (Entity as TMiner).ChangeLocation(ltHome);
    end;
  end;
end;

procedure TGoHomeAndSleepTilRested.Execute(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maSleepingHome]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maSleepingHome])
    end;

    // Take care of the miner's fatgiue.
    (Entity as TMiner).Rest;

    if (Entity as TMiner).Rested then
    begin
      // After the miner has rested, he has to dig for gold.
      (Entity as TMiner).GetFSM.ChangeState(TEnterMineAndDigForNugget.Instance());
    end;
  end;
end;

procedure TGoHomeAndSleepTilRested.Exit(const Entity: TBaseGameEntity);
begin
  inherited;
  if Entity is TMiner then
  begin
    // Write to debug output.
    OutputDebugString(PChar(
      Format('Miner %s: %s', [
        IntToStr((Entity as TMiner).ID),
        TMinerActionString[maWakingUpHome]])));

    // Trigger callback
    if Assigned((Entity as TMiner).OnCallback) then
    begin
      (Entity as TMiner).OnCallback(
        (Entity as TMiner).GetQualifiedEntityName,
        (Entity as TMiner).ID,
        TMinerActionString[maWakingUpHome])
    end;
  end;
end;

{ TMinerGlobalState }

constructor TMinerGlobalState.Create;
begin
  inherited Create;
  FInstance := nil;
end;

destructor TMinerGlobalState.Destroy;
begin
  if FInstance = Self then
  begin
    FInstance := nil;
  end;
  inherited;
end;

procedure TMinerGlobalState.Enter(const Entity: TBaseGameEntity);
begin
  inherited;
  // todo.
end;

procedure TMinerGlobalState.Execute(const Entity: TBaseGameEntity);
begin
  inherited;
  // todo.
end;

procedure TMinerGlobalState.Exit(const Entity: TBaseGameEntity);
begin
  inherited;
  // todo.
end;

class function TMinerGlobalState.Instance: TMinerGlobalState;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TMinerGlobalState.Create;
  end;
  Result := FInstance;
end;

class procedure TMinerGlobalState.Release;
begin
  FreeAndNil(FInstance);
end;

initialization
  TMinerGlobalState.Instance();
  TGoHomeAndSleepTilRested.Instance();
  TEnterMineAndDigForNugget.Instance();
  TVisitBankAndDepositGold.Instance();
  TQuenchThirstInSaloon.Instance();

finalization
  TMinerGlobalState.Release();
  TGoHomeAndSleepTilRested.Release();
  TEnterMineAndDigForNugget.Release();
  TVisitBankAndDepositGold.Release();
  TQuenchThirstInSaloon.Release();

end.
