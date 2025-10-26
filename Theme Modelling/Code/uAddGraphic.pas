unit uAddGraphic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ADODB;

type
  TAddGraphic = class(TForm)
    edtGraphicName: TEdit;
    Bevel1: TBevel;
    LblGraphicName: TLabel;
    lblFileName: TLabel;
    btnOpenFile: TButton;
    imPreview: TImage;
    btnOK: TButton;
    bntCancel: TButton;
    Bevel2: TBevel;
    odGetFileName: TOpenDialog;
    PanelDisableFilenameEdit: TPanel;
    edtFileName: TEdit;
    procedure edtGraphicNameKeyPress(Sender: TObject; var Key: Char);
    procedure btnOpenFileClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function AddGraphic (out GraphicName: String; out PathName:string):boolean;
  end;

var
  AddGraphic: TAddGraphic;

implementation

Uses uValidateGraphic, uADO, uGlobals;

const
  INVALIDCHARACTERS=['/','\',':','*','"','<','>','|'];
{$R *.dfm}

function TAddGraphic.AddGraphic (out GraphicName: String; out PathName:string):boolean;
var
  AddGraphic:TAddGraphic;
begin
  AddGraphic:=TAddGraphic.Create(Nil);
  AddGraphic.edtGraphicName.Text:='New Graphic Name';
  Result:=AddGraphic.ShowModal=mrOK;
  GraphicName:=AddGraphic.edtGraphicName.Text;
  PathName:=AddGraphic.edtFileName.Text;
  FreeAndNil(AddGraphic);
end;

procedure TAddGraphic.edtGraphicNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in INVALIDCHARACTERS then
    Key:=#0;
end;

procedure TAddGraphic.btnOpenFileClick(Sender: TObject);
var
  Filename:string;
  AcceptPath:boolean;
begin
  AcceptPath:=FALSE;
  while NOT AcceptPath do
  begin
    if odGetFileName.Execute then
    begin
      Filename:=odGetFileName.FileName;
      AcceptPath:=ValidateGraphic(FileName);
      if AcceptPath then
      begin
        edtFileName.Text:=Filename;
        imPreview.Picture.LoadFromFile(Filename);
      end;
    end
    else
      break; // PEM : 11/06/2007 - cancelled the open file dialog.
  end;
  // PEM : 11/06/2007
  // Enables the OK button if the file name is not blank, the file exists, and it passes the image validation
  // routine.
  btnOK.Enabled := (not SameText('', Trim(edtFileName.Text) ) ) and ( ValidateGraphic(edtFileName.Text) );
end;

procedure TAddGraphic.btnOKClick(Sender: TObject);
var
  ADOqCheckName:TADOQuery;
begin
  try
    try
      ADOqCheckName:=TADOQuery.Create(nil);
      ADOqCheckName.Connection:=dmADO.AztecConn;
      ADOqCheckName.SQL.Clear;
      ADOqCheckName.SQL.Add('SELECT * FROM [dbo].[TerminalGraphics] WHERE [FileName]='''
          +edtGraphicName.Text+''' and isnull(deleted, 0) = 0');
      ADOqCheckName.Open;
      If ADOqCheckName.RecordCount>0 Then
      begin
        ShowMessage('Sorry the selected graphic name is already in use');
        ModalResult:=mrNone;
        edtGraphicName.SetFocus;
      end;
    except
      ShowMessage('Sorry the selected graphic name is invalid');
        ModalResult:=mrNone;
        edtGraphicName.SetFocus;
    end;
  finally
    FreeAndNil(adoqCheckName);
  end;
end;

procedure TAddGraphic.FormCreate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_ADD_EDIT_TERMINAL_GRAPHICS);
end;

end.
