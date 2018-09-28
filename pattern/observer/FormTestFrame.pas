unit FormTestFrame;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,

  Observer.Types;

type
  TFmTestFrame = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FmTestFrame: TFmTestFrame;

implementation

{$R *.dfm}

procedure TFmTestFrame.FormCreate(Sender: TObject);
var
  GreatContentProvider: TSubscribableChannel;
  AdvertisementSub: TAdvertisementSubscriber;
begin
  GreatContentProvider := TSubscribableChannel.Create;
  try
    // Initialization of the content provider
    // ...
    // ..
    // .

    // Add subs to content provider.
    GreatContentProvider.AddSubscriber(TVideoSubscriber.Create);
    GreatContentProvider.AddSubscriber(TNewspaperSubscriber.Create);

    AdvertisementSub := TAdvertisementSubscriber.Create;
    GreatContentProvider.AddSubscriber(AdvertisementSub);

    // Share info with subs.
    GreatContentProvider.CurrentInformation := 'FOO BAAAR!';

    // Remove the a sub.
    GreatContentProvider.RemoveSubscriber(AdvertisementSub);

    // Share info with subs again.
    GreatContentProvider.CurrentInformation := 'BAR FOOO!';
  finally
    GreatContentProvider.Free;
  end;
end;

end.
