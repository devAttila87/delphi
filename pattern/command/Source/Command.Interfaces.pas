unit Command.Interfaces;

interface

type
  IPrinter = interface(IInterface)
    ['{591CEE66-A6EC-4D11-9993-2E74B0D966FC}']
    procedure Configure;
    procedure Print(const Content: string);
  end;

  IPrintCommand = interface(IInterface)
    ['{0FDE0BC7-541E-404C-8E50-ABA1B5532C61}']
    procedure Execute(const Content: string);
  end;

implementation

end.
