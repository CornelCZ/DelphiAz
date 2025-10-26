unit uLineCheckComment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TGetLineCheckCommentForm = class(TForm)
    mmUserComment: TMemo;
    btnDone: TButton;
  private
    { Private declarations }
    function GetUserComment: string;
  public
    property UserComment: string read GetUserComment;
  end;

function GetLineCheckComment: string;

implementation

{$R *.dfm}

function GetLineCheckComment: string;
var
  GetLineCheckCommentForm: TGetLineCheckCommentForm;
begin
  GetLineCheckCommentForm := TGetLineCheckCommentForm.Create(nil);

  try
    GetLineCheckCommentForm.ShowModal;
    Result := GetLineCheckCommentForm.UserComment; 
  finally
    FreeAndNil(GetLineCheckCommentForm);
  end;
end;

{ TGetLineCheckCommentForm }

function TGetLineCheckCommentForm.GetUserComment: string;
begin
  Result := mmUserComment.Text;
end;

end.
