object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'StateMachine or somthing'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 554
    Height = 248
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 248
    Width = 554
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 254
    object LabelInterval: TLabel
      Left = 400
      Top = 13
      Width = 106
      Height = 13
      Caption = 'Update Interval in sec'
    end
    object ButtonStartFSM: TButton
      Left = 197
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Let'#39's go Miners'
      TabOrder = 0
      OnClick = ButtonStartFSMClick
    end
    object ButtonStopFSM: TButton
      Left = 297
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Ciao Miners'
      TabOrder = 1
      OnClick = ButtonStopFSMClick
    end
    object EditInterval: TEdit
      Left = 512
      Top = 10
      Width = 32
      Height = 21
      Alignment = taCenter
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 2
      Text = '1'
    end
    object ButtonAddMiner: TButton
      Left = 13
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Add Miner'
      TabOrder = 3
      OnClick = ButtonAddMinerClick
    end
    object PanelSpacer: TPanel
      Left = 190
      Top = 3
      Width = 1
      Height = 34
      TabOrder = 4
    end
    object ButtonClear: TButton
      Left = 94
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 5
      OnClick = ButtonClearClick
    end
  end
  object TimerFSMUpdate: TTimer
    OnTimer = TimerFSMUpdateTimer
    Left = 488
    Top = 184
  end
end
