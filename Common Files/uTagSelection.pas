unit uTagSelection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, uTag, uTagListFrame, ADODB;

Type
  TPositionOverride = procedure (ChildWindow: TForm) of object;

  TfTagSelection = class(TForm)
    lblTags: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    TagListFrame: TTagListFrame;
    procedure btnOKClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    function GetSelectedTags: TTagList;
  public
    constructor Create(AOwner: TComponent; SelectedTags: TTagList; Context: TTagContext; Connection: TADOConnection; PositionOverride: TPositionOverride = nil); reintroduce;
    property SelectedTags: TTagList read GetSelectedTags;
  end;

implementation

uses
  CommCtrl;

{$R *.dfm}

constructor TfTagSelection.Create(Aowner: TComponent;
  SelectedTags: TTagList;
  Context: TTagContext;
  Connection: TADOConnection;
  PositionOverride: TPositionOverride);
begin
  inherited Create(AOwner);

  case Context of
    tcSite: Caption := 'Site Tags';
    tcProduct: Caption := 'Product Tags';
  end;

  TagListFrame.Initialise(Context, Connection, SelectedTags);

  if Assigned(PositionOverride) then
    PositionOverride(Self)
  else
    Position := poOwnerFormCenter;
end;


procedure TfTagSelection.btnOKClick(Sender: TObject);
begin
  TagListFrame.SaveTagSelections(False);
end;

procedure TfTagSelection.btnClearClick(Sender: TObject);
begin
  TagListFrame.ClearTagSelections;
end;

function TfTagSelection.GetSelectedTags: TTagList;
begin
  Result := TagListFrame.SelectedTags;
end;

end.
