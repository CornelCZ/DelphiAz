unit uTerminalGraphics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Wwtable, Wwdatsrc, Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, DBCtrls, ADODB, DBGrids, ExtCtrls, ActnList;

type
  TTerminalGraphics = class(TForm)
    wwdsGraphicNames: TwwDataSource;
    ADOqryGetGraphicNames: TADOQuery;
    PreviewImage: TImage;
    btnUpdate: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    wwDBGTerminalGraphics: TwwDBGrid;
    ADOTTerminalGraphics: TADOTable;
    odUpdateFile: TOpenDialog;
    imDefaultImage: TImage;
    DBImage1: TDBImage;
    btnClose: TButton;
    ActionList1: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    procedure actAddExecute(Sender: TObject);
    procedure wwDBGTerminalGraphicsCellChanged(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGTerminalGraphicsDblClick(Sender: TObject);
    procedure actEditDeleteUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
    procedure EditTerminalGraphics;
  end;

var
  TerminalGraphics: TTerminalGraphics;

implementation

uses uGlobals, uAddGraphic, uADO, uValidateGraphic;

{$R *.dfm}


procedure TTerminalGraphics.EditTerminalGraphics;
var
  TerminalGraphics:TTerminalGraphics;
begin
  TerminalGraphics:=TTerminalGraphics.Create(Nil);
  TerminalGraphics.ADOqryGetGraphicNames.Open;
  TerminalGraphics.ShowModal;
  TerminalGraphics.ADOqryGetGraphicNames.close;
  FreeAndNil(TerminalGraphics);
end;

procedure TTerminalGraphics.actAddExecute(Sender: TObject);
var
  GraphicName:string;
  PathName:String;
  ADOQGraphic:TADOQuery;
  NewGraphicID:Integer;
  ImageStream : TStream ;
  fsImage :TFileStream;
begin
  if AddGraphic.AddGraphic(GraphicName,Pathname) then
  begin

    ADOQGraphic:=TADOQuery.Create(Nil);
    ADOQGraphic.Connection:=dmADO.AztecConn;

    ADOQGraphic.SQL.Clear;
    ADOQGraphic.SQL.add('SELECT (MAX([ID])) AS [ID] FROM [dbo].[TerminalGraphics]');
    ADOQGraphic.Open;
    NewGraphicID := ADOQGraphic.FieldByName('ID').AsInteger+1;
    ADOQGraphic.Close;
    ADOQGraphic.SQL.Clear;
    ADOQGraphic.SQL.add('INSERT INTO [dbo].[TerminalGraphics] SELECT '+inttostr(NewGraphicID)+' AS [ID] , ');
    ADOQGraphic.SQL.add(''''+GraphicName+''' AS [FileName], ');
    ADOQGraphic.SQL.add('Null AS [BitMap],Null AS [Deleted], Getdate() AS [LMDT] ');
    ADOQGraphic.ExecSQL;

    ADOTTerminalGraphics.Open;
    ADOTTerminalGraphics.Locate('ID',NewGraphicID,[]);
    ADOTTerminalGraphics.Edit;
    ImageStream := ADOTTerminalGraphics.CreateBlobStream(ADOTTerminalGraphics.FieldByName('BitMap'), bmWrite);
    try
      ImageStream.Seek(0, soFromBeginning);
      fsImage := TFileStream.Create(Pathname, fmOpenRead or
        fmShareDenyWrite);
      try
        ImageStream.CopyFrom(fsImage, fsImage.Size)
      finally
        fsImage.Free
      end;
    finally
      ImageStream.Free
    end;
    ADOTTerminalGraphics.post;
    ADOTTerminalGraphics.Close;
    FreeandNil(ADOQGraphic);
    ADOqryGetGraphicNames.Close;
    ADOqryGetGraphicNames.Open;
    PreviewImage.Picture.LoadFromFile(Pathname);
  end;
  wwDBGTerminalGraphics.SetFocus;
end;

procedure TTerminalGraphics.wwDBGTerminalGraphicsCellChanged(Sender: TObject);
Var
  ImageStream : TStream;
begin
  PreviewImage.Picture.Bitmap.Empty;
  ImageStream:=ADOqryGetGraphicNames.CreateBlobStream(ADOqryGetGraphicNames.FieldByName('BitMap'),bmRead);
  PreviewImage.Picture.Bitmap.LoadFromStream(ImageStream);
  PreviewImage.Refresh;
  PreviewImage.repaint;
  FreeAndNil(ImageStream);
end;

procedure TTerminalGraphics.actEditExecute(Sender: TObject);
var
  ImageStream : TStream ;
  fsImage :TFileStream;
begin
  if odUpdateFile.Execute then
  begin
    if ValidateGraphic(odUpdateFile.FileName) then
    try
      dmADO.qRun.Clone(ADOqryGetGraphicNames);
      dmADO.qRun.Locate('ID', ADOqryGetGraphicNames.FieldByName('ID').AsInteger, []);

      ADOqryGetGraphicNames.Edit;

      ImageStream := ADOqryGetGraphicNames.CreateBlobStream(ADOqryGetGraphicNames.FieldByName('BitMap'), bmWrite);
      try
        ImageStream.Seek(0, soFromBeginning);
        fsImage := TFileStream.Create(odUpdateFile.FileName, fmOpenRead or
          fmShareDenyWrite);
        try
          ImageStream.CopyFrom(fsImage, fsImage.Size);
        finally
          FreeAndNil(fsImage);
        end;
      finally
        FreeAndNil(ImageStream);
      end;

      if (dmADO.qRun.FieldByName('BitMap').Value <> ADOqryGetGraphicNames.FieldByName('BitMap').Value) then
        if MessageDlg('Save Changes', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          ADOQryGetGraphicNames.FieldByName('LMDT').AsDateTime := Now;
          ADOqryGetGraphicNames.Post;
        end
        else
          ADOqryGetGraphicNames.Cancel;
    finally
      dmADO.qRun.SQL.Clear;
    end;
  end;
  wwDBGTerminalGraphics.SetFocus;
end;

procedure TTerminalGraphics.actDeleteExecute(Sender: TObject);
var
  adoqCheckAndUpDate:TADOQuery;
  RecordNumber : Integer;
begin
  // PEM : 11/06/2007 - Used to move the cursor back to the position of the record last deleted or as close as
  // can be reached.
  RecordNumber := ADOqryGetGraphicNames.RecNo;
  adoqCheckAndUpDate:=TADOQuery.create(nil);
  try
    adoqCheckAndUpDate.Connection:=dmADO.AztecConn;
    adoqCheckAndUpDate.SQL.Clear;
    adoqCheckAndUpDate.SQL.Add('SELECT [GraphicID] FROM [dbo].[ThemePanelHeader] WHERE ');
    adoqCheckAndUpDate.SQL.Add('[GraphicID] = '+ADOqryGetGraphicNames.FieldByName('ID').asstring);
    adoqCheckAndUpDate.SQL.Add(' UNION ');
    adoqCheckAndUpDate.SQL.Add('SELECT [GraphicID] FROM [dbo].[ThemeConfigSet] WHERE ');
    adoqCheckAndUpDate.SQL.Add('[GraphicID] = '+ADOqryGetGraphicNames.FieldByName('ID').asstring);
    adoqCheckAndUpDate.Open;
    if adoqCheckAndUpDate.RecordCount>0 then
    begin
      if Messagedlg('This graphic is in use, delete any way?',mtWarning,[mbYes,mbNO],0)=mrNo then
        exit
      else
      begin
        adoqCheckAndUpDate.SQL.Clear;
        adoqCheckAndUpDate.SQL.Add('UPDATE [dbo].[ThemePanelHeader] SET [GraphicID] = NULL WHERE');
        adoqCheckAndUpDate.SQL.Add('[GraphicID] = '+ADOqryGetGraphicNames.FieldByName('ID').asstring);
        adoqCheckAndUpDate.ExecSQL;
        adoqCheckAndUpDate.SQL.Clear;
        adoqCheckAndUpDate.SQL.Add('UPDATE [dbo].[ThemeConfigSet] SET [GraphicID] = NULL WHERE');
        adoqCheckAndUpDate.SQL.Add('[GraphicID] = '+ADOqryGetGraphicNames.FieldByName('ID').asstring);
        adoqCheckAndUpDate.ExecSQL;
      end;
    end;
    adoqCheckAndUpDate.SQL.Clear;
    adoqCheckAndUpDate.SQL.Add('UPDATE [dbo].[TerminalGraphics] SET [deleted]=1, LMDT = GETDATE() WHERE [ID] = '+ADOqryGetGraphicNames.FieldByName('ID').asstring);
    adoqCheckAndUpDate.ExecSQL;
  finally
    adoqCheckAndUpDate.Close;
    FreeAndNil(adoqCheckAndUpDate);
    ADOqryGetGraphicNames.Close;
    ADOqryGetGraphicNames.Open;
    // PEM : 11/06/2007 - Move the cursor
    ADOqryGetGraphicNames.MoveBy(RecordNumber - 1);
    wwDBGTerminalGraphics.SetFocus;
  end;
end;

procedure TTerminalGraphics.FormShow(Sender: TObject);
begin
  ADOqryGetGraphicNames.Open;
  wwDBGTerminalGraphics.SetFocus;
end;

procedure TTerminalGraphics.wwDBGTerminalGraphicsDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TTerminalGraphics.actEditDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := wwdsGraphicNames.DataSet.RecordCount > 0;
end;

procedure TTerminalGraphics.FormCreate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_TERMINAL_GRAPHICS);
end;

end.
