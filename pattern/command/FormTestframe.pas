unit FormTestframe;

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

  Command.Interfaces,
  Command.Types;

type
  TFmTestframe = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FmTestframe: TFmTestframe;

implementation

{$R *.dfm}

procedure TFmTestframe.FormCreate(Sender: TObject);
var
  Secretary: TSecretary;
  PrintCommand: IPrintCommand;
  PrinterToUse: IPrinter;
begin
  Secretary := TSecretary.Create(nil); // initial no command for printing.
  try
    // We need a printer.
    PrinterToUse := TBlackAndWhitePrinter.Create;
    // And a print command.
    PrintCommand := TBlackAndWhitePrintCommand.Create(PrinterToUse);
    // Assigned the print command to our secretary.
    Secretary.PrintCommand := PrintCommand;
    // Now we can print our stuff.
    Secretary.DoPrint('Hello World #1');

    // Change the configuration.
    Secretary.PrintCommand := TColorPrintCommand.Create(TColorPrinter.Create);

    // Now we can print our stuff.
    Secretary.DoPrint('Hello World #2');
  finally
    Secretary.Free;
  end;
end;

end.
