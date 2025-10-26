unit uMaintCourses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfMaintCourses = class(TForm)
    Label1: TLabel;
    edtCourseName: TEdit;
    Label2: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    CourseDescMemo: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    NewIx: Integer;
    CourseName: String;
  end;

var
  fMaintCourses: TfMaintCourses;

implementation

uses uADO, uDatabaseADO, uLineEdit, uLog, uGlobals, ADODB;

{$R *.dfm}

procedure TfMaintCourses.btnOKClick(Sender: TObject);
var
  Description: String;
begin
  if edtCourseName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Course.');
    edtCourseName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    if CourseDescMemo.Text = '' then
      Description := 'null'
    else
      Description := QuotedStr(CourseDescMemo.Text);

    Log.Event('Create Course - ' + QuotedStr(edtCourseName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertCourse %s,%s,@ID OUTPUT',
            [QuotedStr(edtCourseName.Text),Description]));
    SQL.Add('SELECT @ID as ID');
    try
      Open;
      if (RecordCount > 0) and not (FieldByName('ID').IsNULL) then
        NewIx := FieldByName('ID').AsInteger
      else
        NewIx := 1;
      Close;

      CourseName := edtCourseName.Text;
    except
      on E:Exception do
      begin
        log.Event('Create Course Failure - ' + E.Message);
        MessageDlg('Failed to create course: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;

  end;
end;

procedure TfMaintCourses.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_COURSE_FORM );
end;

end.
