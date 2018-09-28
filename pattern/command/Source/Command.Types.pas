unit Command.Types;

interface

uses
  Winapi.Windows,
  System.SysUtils,

  Command.Interfaces;

type
  //////////////////////////////////////////////////////////////////////////////
  ///  Caller
  TBasePrintCaller = class abstract(TInterfacedObject)
  private
    function GetPrintCommand: IPrintCommand;
    procedure SetPrintCommand(const Value: IPrintCommand);
  protected
    FPrintCommand: IPrintCommand;
  public
    constructor Create(const PrintCommand: IPrintCommand); virtual;
    procedure DoPrint(const Content: string); virtual;

    property PrintCommand: IPrintCommand read GetPrintCommand
      write SetPrintCommand;
  end;

  TSecretary = class(TBasePrintCaller)
  public
    procedure DoPrint(const Content: string); override;
    property PrintCommand;
  end;

  //////////////////////////////////////////////////////////////////////////////
  ///  Receiver
  TBlackAndWhitePrinter = class(TInterfacedObject, IPrinter)
  protected
    FContent: string;
    procedure PrintAsBlackAndWhite;
  public
    // IPrinter
    procedure Configure;
    procedure Print(const Content: string);
  end;

  TColorPrinter = class(TInterfacedObject, IPrinter)
  protected
    FContent: string;
    function EnoughPrinterCartridgeLevel: Boolean;
    procedure PrintColoured;
  public
    procedure InconvenientConfigure;
    // IPrinter
    procedure Configure;
    procedure Print(const Content: string);
  end;

  TPDFPrinter = class(TInterfacedObject, IPrinter)
  protected
    FContent: string;
    procedure Save;
  public
    // IPrinter
    procedure Configure;
    procedure Print(const Content: string);
  end;

  //////////////////////////////////////////////////////////////////////////////
  ///  Commands
  TBlackAndWhitePrintCommand = class(TInterfacedObject, IPrintCommand)
  protected
    FPrinter: IPrinter;
  public
    constructor Create(const Printer: IPrinter);
    // IPrintCommand
    procedure Execute(const Content: string);
  end;

  TColorPrintCommand = class(TInterfacedObject, IPrintCommand)
  protected
    FPrinter: IPrinter;
  public
    constructor Create(const Printer: IPrinter);
    // IPrintCommand
    procedure Execute(const Content: string);
  end;

  TPDFPrintCommand = class(TInterfacedObject, IPrintCommand)
  protected
    FPrinter: IPrinter;
  public
    constructor Create(const Printer: IPrinter);
    // IPrintCommand
    procedure Execute(const Content: string);
  end;

implementation

{ TBasePrintCaller }

constructor TBasePrintCaller.Create(const PrintCommand: IPrintCommand);
begin
  OutputDebugString(PChar('Created Caller.'));
  FPrintCommand := PrintCommand;
end;

procedure TBasePrintCaller.DoPrint(const Content: string);
begin
  OutputDebugString(PChar('Caller requested print.'));
  if Assigned(FPrintCommand) then
  begin
    FPrintCommand.Execute(Content);
  end;
end;

function TBasePrintCaller.GetPrintCommand: IPrintCommand;
begin
  Result := FPrintCommand;
end;

procedure TBasePrintCaller.SetPrintCommand(const Value: IPrintCommand);
begin
  OutputDebugString(PChar('Caller setting print command.'));
  if Value <> FPrintCommand then
  begin
    FPrintCommand := Value;
  end;
end;

{ TSecretary }

procedure TSecretary.DoPrint(const Content: string);
begin
  inherited;
end;

{ TBlackAndWhitePrinter }

procedure TBlackAndWhitePrinter.Configure;
begin
  // Nothing required.
  OutputDebugString(PChar('Receiver called configure.'));
end;

procedure TBlackAndWhitePrinter.Print(const Content: string);
begin
  OutputDebugString(PChar('Receiver called print.'));
  FContent := Content;
  Assert(not SameStr(FContent, EmptyStr));
  PrintAsBlackAndWhite;
end;

procedure TBlackAndWhitePrinter.PrintAsBlackAndWhite;
begin
  // Please write awesome code to print B/W into this proc.
  Beep;
  OutputDebugString(PChar(UpperCase(FContent)));
end;

{ TColorPrinter }

procedure TColorPrinter.Configure;
begin
  // Nothing required.
  OutputDebugString(PChar('Receiver called configure.'));
end;

function TColorPrinter.EnoughPrinterCartridgeLevel: Boolean;
begin
  Result := True;
end;

procedure TColorPrinter.InconvenientConfigure;
begin
  // Please write awesome code to make more config stuff here.
  Beep;
end;

procedure TColorPrinter.Print(const Content: string);
begin
  OutputDebugString(PChar('Receiver called print.'));
  FContent := Content;
  Assert(not SameStr(FContent, EmptyStr));
  PrintColoured;
end;

procedure TColorPrinter.PrintColoured;
begin
  if EnoughPrinterCartridgeLevel then
  begin
    // Print in color af!
    Beep;
    OutputDebugString(PChar(LowerCase(FContent)));
  end
  else
  begin
    Beep;
    OutputDebugString(PChar('Not enough stuff to print'));
  end;
end;

{ TPDFPrinter }

procedure TPDFPrinter.Configure;
begin
  // Nothing required.
  OutputDebugString(PChar('Receiver called configure.'));
end;

procedure TPDFPrinter.Print(const Content: string);
begin
  OutputDebugString(PChar('Receiver called print.'));
  FContent := Content;
  Assert(not SameStr(FContent, EmptyStr));
  Save;
end;

procedure TPDFPrinter.Save;
begin
  // Save to the hard disk
  Beep;
  OutputDebugString(PChar(FContent + ' will be printed as pdf.'));
end;

{ TBlackAndWhitePrintCommand }

constructor TBlackAndWhitePrintCommand.Create(
  const Printer: IPrinter);
begin
  OutputDebugString(PChar('Created print command.'));
  Assert(Assigned(Printer));
  FPrinter := Printer;
  FPrinter.Configure;
end;

procedure TBlackAndWhitePrintCommand.Execute(const Content: string);
begin
  OutputDebugString(PChar('Executed print command.'));
  FPrinter.Print(Content);
end;

{ TColorPrintCommand }

constructor TColorPrintCommand.Create(const Printer: IPrinter);
begin
  OutputDebugString(PChar('Created print command.'));
  Assert(Assigned(Printer));
  FPrinter := Printer;
  FPrinter.Configure;
end;

procedure TColorPrintCommand.Execute(const Content: string);
begin
  OutputDebugString(PChar('Executed print command.'));
  FPrinter.Print(Content);
end;

{ TPDFPrintCommand }

constructor TPDFPrintCommand.Create(const Printer: IPrinter);
begin
  OutputDebugString(PChar('Created print command.'));
  Assert(Assigned(Printer));
  FPrinter := Printer;
  FPrinter.Configure;
end;

procedure TPDFPrintCommand.Execute(const Content: string);
begin
  OutputDebugString(PChar('Executed print command.'));
  FPrinter.Print(Content);
end;

end.
