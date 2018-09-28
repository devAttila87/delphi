unit Decorator.Interfaces;

interface

type
  IMeal = interface(IUnknown)
    ['{88462CF5-CD27-4055-8DD2-8593D401DBDF}']
    function Price: Double;
    function Description: string;
  end;


implementation

end.
