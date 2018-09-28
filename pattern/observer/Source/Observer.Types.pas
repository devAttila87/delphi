unit Observer.Types;

interface

uses
  System.SysUtils,
  System.Classes,

  Winapi.Windows,

  Observer.Interfaces;
type
  TSubscribableChannel = class(TInterfacedObject, ISubscribable)
  private
    function GetSubscriberCount: Integer;
    procedure SetCurrentInformation(const Value: string);
  protected
    FSubscribers: TInterfaceList;
    FCurrentInformation: string;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    // ISubscribable
    procedure AddSubscriber(const Subscriber: ISubscriber);
    procedure RemoveSubscriber(const Subscriber: ISubscriber);
    procedure ShareInformationWithSubscribers;

    property SubscriberCount: Integer read GetSubscriberCount;
    property CurrentInformation: string read FCurrentInformation
      write SetCurrentInformation;
  end;

  TNewspaperSubscriber = class(TInterfacedObject, ISubscriber)
  protected
    FTitle: string;
  public
    constructor Create;
    // ISubscriber
    procedure ObtainSubscribedInformation(const AInformation: string);
  end;

  TAdvertisementSubscriber = class(TInterfacedObject, ISubscriber)
  protected
    FTitle: string;
  public
    constructor Create;
    // ISubscriber
    procedure ObtainSubscribedInformation(const AInformation: string);
  end;

  TVideoSubscriber = class(TInterfacedObject, ISubscriber)
  protected
    FTitle: string;
  public
    constructor Create;
    // ISubscriber
    procedure ObtainSubscribedInformation(const AInformation: string);
  end;

implementation

{ TSubscribableChannel }

constructor TSubscribableChannel.Create;
begin
  inherited;
  FSubscribers := TInterfaceList.Create;
  FCurrentInformation := 'N/A';
end;

destructor TSubscribableChannel.Destroy;
begin
  FSubscribers.Free;
  inherited;
end;

function TSubscribableChannel.GetSubscriberCount: Integer;
begin
  Result := FSubscribers.Count;
end;

procedure TSubscribableChannel.AddSubscriber(const Subscriber: ISubscriber);
begin
  FSubscribers.Add(Subscriber);

  OutputDebugString(PChar('Added subscriber.'));
end;

procedure TSubscribableChannel.RemoveSubscriber(const Subscriber: ISubscriber);
begin
  FSubscribers.Remove(Subscriber);
  OutputDebugString(PChar('Removed subscriber.'));
end;

procedure TSubscribableChannel.SetCurrentInformation(const Value: string);
begin
  if not SameStr(Value, FCurrentInformation) then
  begin
    FCurrentInformation := Value;
    ShareInformationWithSubscribers;
  end;
end;

procedure TSubscribableChannel.ShareInformationWithSubscribers;
var
  Sub: IInterface;
  SubCount: Integer;
begin
  SubCount := GetSubscriberCount;
  OutputDebugString(PChar(
    Format('Started sharing with %d subscribers.', [SubCount])));
  for Sub in FSubscribers do
  begin
    if Supports(Sub, ISubscriber) then
    begin
      (Sub as ISubscriber).ObtainSubscribedInformation(FCurrentInformation);
    end;
  end;
  OutputDebugString(PChar(
    Format('Finished sharing with %d subscribers.', [SubCount])));
end;

{ TNewspaperSubscriber }

constructor TNewspaperSubscriber.Create;
begin
  inherited;
  FTitle := 'Great Newspaper!';
end;

procedure TNewspaperSubscriber.ObtainSubscribedInformation(
  const AInformation: string);
begin
  OutputDebugString(
    PChar(Format('%s has received the subscribed information %s',
      [FTitle, AInformation])));
end;

{ TAdvertisementSubscriber }

constructor TAdvertisementSubscriber.Create;
begin
  inherited;
  FTitle := 'AdMob Advertisement!'
end;

procedure TAdvertisementSubscriber.ObtainSubscribedInformation(
  const AInformation: string);
begin
  OutputDebugString(
    PChar(Format('%s has received the subscribed information %s',
      [FTitle, AInformation])));
end;

{ TVideoSubscriber }

constructor TVideoSubscriber.Create;
begin
  inherited;
  FTitle := 'YouTube!'
end;

procedure TVideoSubscriber.ObtainSubscribedInformation(
  const AInformation: string);
begin
  OutputDebugString(
    PChar(Format('%s has received the subscribed information %s',
      [FTitle, AInformation])));
end;

end.
