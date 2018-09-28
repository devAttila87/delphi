unit Observer.Interfaces;

interface

uses
  System.SysUtils;

type
  ISubscriber = interface(IUnknown)
    ['{94E5FE4E-66F4-40D2-8E8E-79A5BECBDCA9}']
    procedure ObtainSubscribedInformation(const AInformation: string);
  end;

  ISubscribable = interface(IUnknown)
    ['{BB081BAE-D810-472D-9D26-251EDC643681}']
    procedure AddSubscriber(const Subscriber: ISubscriber);
    procedure RemoveSubscriber(const Subscriber: ISubscriber);
    procedure ShareInformationWithSubscribers;
  end;

implementation

end.
