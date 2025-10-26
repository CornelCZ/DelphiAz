unit uBaseTagFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TfrmBaseTagFrame = class (TFrame)
  private
    { Private declarations }
    FParentTagName: String;
    FParentTagID: Integer;
    function GetDisplayParentTagName: string;
  protected
    FOnChangeHandler: TNotifyEvent;
    procedure SetTagID(Value: Integer); virtual; abstract;
    function GetTagName: string; virtual; abstract;
    function GetTagID: Integer; virtual; abstract;
    function GetTagSelected: Boolean; virtual; abstract;
    procedure InitialiseFrame; virtual; abstract;
    function EscapeSpecialChars(_string: string): String;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; _ParentTagID: Integer; _ParentTagName: String; OnChangeHandler: TNotifyEvent = nil); reintroduce;
    procedure ClearSelected; virtual; abstract;
    property DisplayParentTagName: string read GetDisplayParentTagName;
    property ParentTagName: string read FParentTagName write FParentTagName;
    property ParentTagID: integer read FParentTagID write FParentTagID;
    property TagID: Integer read GetTagId write SetTagId;
    property TagName: string read GetTagName;
    property TagSelected: Boolean read GetTagSelected;
  end;

implementation

{$R *.dfm}

{ TfrmBaseTagFrame }

constructor TfrmBaseTagFrame.Create(AOwner: TComponent;
  _ParentTagID: Integer; _ParentTagName: String; OnChangeHandler: TNotifyEvent = nil);
begin
  inherited Create(Aowner);
  ParentTagName := _ParentTagName;
  ParentTagID := _ParentTagID;
  FOnChangeHandler := OnChangeHandler;
  Name := Format(Name + '%d',[ParentTagID]);
  DoubleBuffered := True;
  //InitialiseFrame;
end;


function TfrmBaseTagFrame.EscapeSpecialChars(_string: string): String;

begin
  Result := stringreplace(_string,'&','&&',[rfReplaceAll,rfIgnoreCase]);
end;

function TfrmBaseTagFrame.GetDisplayParentTagName: string;
begin
  Result := EscapeSpecialChars(FParentTagName);
end;

end.
