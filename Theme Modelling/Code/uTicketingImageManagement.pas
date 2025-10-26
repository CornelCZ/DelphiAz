unit uTicketingImageManagement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ExtCtrls, ADODB, Grids, Wwdbigrd, Wwdbgrid,
  DBCtrls, uGridSortHelper;

type
  TTicketingImageManagement = class(TForm)
    Label1: TLabel;
    btAdd: TButton;
    btEdit: TButton;
    btDelete: TButton;
    btClose: TButton;
    Label2: TLabel;
    DBText1: TDBText;
    dbgImages: TwwDBGrid;
    Timer1: TTimer;
    lbSizeWarning: TLabel;
    procedure btAddClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    ImageSortHelper: TGridSortHelper;
    procedure CheckCanEdit(dataset: TDataset);
  public
    ThemeId: integer;
    { Public declarations }
  end;

implementation

uses uTicketingImageAddEdit, uFormNavigate, uGenerateThemeIDs, uDMThemeData, uAztecLog,
  dADOAbstract;

{$R *.dfm}

procedure TTicketingImageManagement.CheckCanEdit(dataset: TDataset);
begin
  if dataset.recordcount = 0 then
    Raise exception.create('Please add some items first!');
end;

procedure TTicketingImageManagement.btAddClick(Sender: TObject);
var
  AddEditForm: TTicketingImageAddEdit;
  BitmapBlobStream: TStream;
  ThemeImageIndex: integer;
begin
  Log('Add image clicked');
  ThemeImageIndex := dmThemeData.GetNextTicketThemeImageIndex(ThemeId);
  AddEditForm := TTicketingImageAddEdit.Create(nil);
  if AddEditForm.Add(ThemeID) then
  with AddEditForm, dmThemeData.qThemeCloakroomImage do
  begin
    Insert;
    FieldByName('CloakroomImageID').AsInteger := GetNewId(scThemeCloakroomImage);
    FieldByName('ThemeID').AsInteger := ThemeId;
    FieldByName('Name').AsString := AddEditForm.edName.Text;
    BitmapBlobStream := CreateBlobStream(FieldByName('Bitmap'), bmWrite);
    CloakroomImage.Picture.Bitmap.SaveToStream(BitmapBlobStream);
    BitmapBlobStream.free;
    FieldByName('ThemeImageIndex').AsInteger := ThemeImageIndex;
    FieldByName('ImageControlCode').AsString := Format('1C70%2.2d00', [ThemeImageIndex]);
    Post;
    Log('Image '+AddEditForm.edName.Text+' added');
    dmThemeData.qTotalImageSize.Requery();
  end;
  AddEditForm.Release;
end;

procedure TTicketingImageManagement.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TTicketingImageManagement.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmThemeData.DeAccessDataset(dmThemeData.qThemeCloakroomImage);
  dmThemeData.DeAccessDataset(dmThemeData.qTotalImageSize);
  dmThemeData.DeAccessDataset(dmThemeData.qThemes);
  Nav.MoveBack;
end;

procedure TTicketingImageManagement.FormShow(Sender: TObject);
begin
  dmThemeData.AccessDataset(dmThemeData.qThemes);
  dmThemeData.qThemes.Locate('ThemeId', ThemeId, []);
  dmThemeData.AccessDataset(dmThemeData.qThemeCloakroomImage);
  dmThemeData.AccessDataset(dmThemeData.qTotalImageSize);
  ImageSortHelper.Reset;
end;

procedure TTicketingImageManagement.FormCreate(Sender: TObject);
begin
  ImageSortHelper:= TGridSortHelper.Create;
  ImageSortHelper.Initialise(dbgImages);
end;

procedure TTicketingImageManagement.FormDestroy(Sender: TObject);
begin
  ImageSortHelper.Free;
end;

procedure TTicketingImageManagement.btDeleteClick(Sender: TObject);
var
  DeletedThemeImageId: integer;
begin
  Log('Delete image clicked');
  with dmThemeData do
  begin
    CheckCanEdit(qThemeCloakroomImage);
    if messagedlg(
      format('Are you sure you want to delete Image "%s"?', [qThemeCloakroomImage.fieldbyname('Name').asstring]),
        mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
    begin
      DeletedThemeImageId := qThemeCloakroomImage.FieldByName('ThemeImageIndex').AsInteger;
      log('Deleting image ' + qThemeCloakroomImage.fieldbyname('Name').asstring);
      adoqRun.SQL.Text :=
        Format('update ThemeCloakroomSequence set CloakroomImageId = null where CloakroomImageID = %d',
          [qThemeCloakroomImage.fieldbyname('CloakroomImageId').AsInteger]);
      adoqRun.ExecSQL;

      adoqRun.SQL.Text := Format(
        'update b '+
        '  set b.ThemeImageIndex = a.ThemeImageIndex, b.ImageControlCode = a.ImageControlCode '+
        'from ThemeCloakroomImage a '+
        'join ThemeCloakroomImage b on a.ThemeImageIndex+1 = b.ThemeImageIndex '+
        'where a.ThemeImageIndex >= %d', [DeletedThemeImageId]);
      adoqRun.ExecSQL;
      ImageSortHelper.Refresh('CloakroomImageId');
      qThemeCloakroomImage.delete;

      qTotalImageSize.Requery();
    end;
  end;
end;

procedure TTicketingImageManagement.btEditClick(Sender: TObject);
var
  AddEditForm: TTicketingImageAddEdit;
  BitmapBlobStream: TStream;
begin
  Log('Edit image clicked');
  AddEditForm := TTicketingImageAddEdit.Create(nil);
  with AddEditForm, dmThemeData.qThemeCloakroomImage do
  begin
    CheckCanEdit(dmThemeData.qThemeCloakroomImage);
    edName.Text := FieldByName('Name').AsString;
    BitmapBlobStream := CreateBlobStream(FieldByName('Bitmap'), bmRead);
    CloakroomImage.Picture.Bitmap.LoadFromStream(BitmapBlobStream);
    BitmapBlobStream.free;
    if AddEditForm.Edit(ThemeID, FieldByName('CloakroomImageID').AsInteger) then
    begin
      Edit;
      FieldByName('ThemeID').AsInteger := ThemeId;
      FieldByName('Name').AsString := edName.Text;
      BitmapBlobStream := CreateBlobStream(FieldByName('Bitmap'), bmWrite);
      CloakroomImage.Picture.Bitmap.SaveToStream(BitmapBlobStream);
      BitmapBlobStream.free;
      Post;
      Log('Image '+AddEditForm.edName.Text+' edited');
      dmThemeData.qTotalImageSize.Requery();
    end;
  end;
  AddEditForm.Release;
end;

procedure TTicketingImageManagement.Timer1Timer(Sender: TObject);
begin
  try
    lbSizeWarning.Left := DBText1.Left + DBText1.Width + 8;
    lbSizeWarning.Visible := dmThemeData.qTotalImageSize['TotalImageSize'] > 128;
  except
  end;
end;

end.
