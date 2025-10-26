unit uImportErrorLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfImportErrorLog = class(TForm)
    lbErrorList: TListBox;
    Label1: TLabel;
    OKButton: TButton;
    DetailsButton: TButton;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DetailsButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    slErrors : TStringList;
    DoDetailToggle: Boolean;

    function GetErrorList: TStringList;
    procedure SetErrorList(const Value: TStringList);
    procedure AdjustWindow;

  public
    { Public declarations }
    property ErrorList : TStringList read GetErrorList write SetErrorList;
  end;

implementation

{$R *.dfm}
{ TForm1 }

function TfImportErrorLog.GetErrorList: TStringList;
begin
  slErrors := TStringList (lbErrorList);
  Result := slErrors;
end;

procedure TfImportErrorLog.SetErrorList(const Value: TStringList);
begin
  slErrors := Value;
  lbErrorList.Items := slErrors;
end;

procedure TfImportErrorLog.FormCreate(Sender: TObject);
begin
  slErrors := TStringList.Create;
  DoDetailToggle := False;
end;

procedure TfImportErrorLog.FormShow(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to lbErrorList.Count-1 do begin
    lbErrorList.Items [i] := StringReplace(lbErrorList.Items [i], #9, ',', [rfReplaceAll]);
    lbErrorList.Items [i] := StringReplace(lbErrorList.Items [i], '<NULL>', ' ', [rfReplaceAll]);
  end;
end;

procedure TfImportErrorLog.DetailsButtonClick(Sender: TObject);
begin
  DoDetailToggle := not DoDetailToggle;
  AdjustWindow;
end;

procedure TfImportErrorLog.AdjustWindow;
begin
  case DoDetailToggle of
    True:
      begin
        Self.ClientHeight := Panel2.Height + 200;
        DetailsButton.Caption := '<< Details';
        lbErrorlist.Visible := true;
      end;
    False:
    begin
        Self.ClientHeight := Panel2.Height;
        DetailsButton.Caption := 'Details >>';
        lbErrorList.Visible := false;
    end;
  end;
end;

procedure TfImportErrorLog.OKButtonClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfImportErrorLog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  slErrors.Free;
end;

end.
