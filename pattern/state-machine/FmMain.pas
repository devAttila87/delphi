unit FmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  Miner, Vcl.StdCtrls, Vcl.ExtCtrls,

  Generics.Collections;

type
  TFormMain = class(TForm)
    ButtonStartFSM: TButton;
    Memo: TMemo;
    PanelBottom: TPanel;
    ButtonStopFSM: TButton;
    TimerFSMUpdate: TTimer;
    EditInterval: TEdit;
    LabelInterval: TLabel;
    ButtonAddMiner: TButton;
    PanelSpacer: TPanel;
    ButtonClear: TButton;
    procedure TimerFSMUpdateTimer(Sender: TObject);
    procedure ButtonStartFSMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonStopFSMClick(Sender: TObject);
    procedure ButtonAddMinerClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FMiners: TObjectList<TMiner>;
    procedure MinerCallback(const Name: string; const Identifier: Integer; const CallbackMsg: string);
  public
    { Public-Deklarationen }
    procedure UpdateTitle;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonAddMinerClick(Sender: TObject);
begin
  FMiners.Add(Tminer.Create(FMiners.Count, MinerCallback));
  UpdateTitle;
end;

procedure TFormMain.ButtonClearClick(Sender: TObject);
begin
  Memo.Clear;
  FMiners.Clear;
  UpdateTitle;
end;

procedure TFormMain.ButtonStartFSMClick(Sender: TObject);
begin
  TimerFSMUpdate.Interval := StrToInt(EditInterval.Text) * 1000;
  TimerFSMUpdate.Enabled := True;
  EditInterval.Enabled := not TimerFSMUpdate.Enabled;
  UpdateTitle;
end;

procedure TFormMain.ButtonStopFSMClick(Sender: TObject);
begin
  TimerFSMUpdate.Enabled := False;
  EditInterval.Enabled := not TimerFSMUpdate.Enabled;
  UpdateTitle;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FMiners := TObjectList<TMiner>.Create(True);
  FMiners.Add(TMiner.Create(FMiners.Count, MinerCallback));
  UpdateTitle;

  TimerFSMUpdate.Enabled := False;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FMiners.Free;
end;

procedure TFormMain.TimerFSMUpdateTimer(Sender: TObject);
var
  Miner: TMiner;
begin
  TimerFSMUpdate.Enabled := False;
  try
    for Miner in FMiners do
    begin
      Miner.Update;
      UpdateTitle;
    end;
  finally
    TimerFSMUpdate.Enabled := true;
  end;
end;

procedure TFormMain.UpdateTitle;
const
  Status: array [Boolean] of String = ('Working', 'Idle');
begin
  Caption := 'Statemachine or something';
  Caption := Format('%s [Miners: %d; Status: %s]', [
    Caption,
    FMiners.Count,
    Status[EditInterval.Enabled]]);
end;

procedure TFormMain.MinerCallback(const Name: string; const Identifier: Integer; const CallbackMsg: string);
begin
  Memo.Lines.Add(Format('Miner %s (%d): %s', [Name, Identifier, CallbackMsg]));
  UpdateTitle;
end;

end.
