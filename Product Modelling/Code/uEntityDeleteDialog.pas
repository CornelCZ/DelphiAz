unit uEntityDeleteDialog;

(*
 * Unit provides the dialog used to offer up
 * various reasons (query results) as to why
 * an entity delete cannot proceed;
 *
 * Author: Stuart Boutell, Ice Cube/Edesix
 *)

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DB, Grids, DBGrids, FlexiDBGrid, DBTables, ClipBrd,
  Wwdbigrd, Wwdbgrid, ImgList, ADODB;

type
  THackedADOQuery = class(TADOQuery)
  end;

  TEntityDeleteDialog = class(TForm)
    yesButon: TButton;
    noBtn: TButton;
    questionImage: TImage;
    entityDeleteConfirmLabel: TLabel;
    entityDeleteConfirmGroupBox: TGroupBox;
    entityDeleteConfirmDataSource: TDataSource;
    entityDeleteConfirmDBGrid: TwwDBGrid;
    ImageListGlyphs: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure entityDeleteConfirmDBGridDrawTitleCell(Sender: TObject;
      Canvas: TCanvas; Field: TField; Rect: TRect;
      var DefaultDrawing: Boolean);
    procedure entityDeleteConfirmDBGridTitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    { Private declarations }
  public
    function entityDeleteConfirm(question:string; var query:TDataSet):boolean;
    function entityLinkedProducts(question:string; var query:TDataSet):boolean;
    { Public declarations }
  end;

var
  EntityDeleteDialog: TEntityDeleteDialog;

implementation

uses
  uGuiUtils, uEntityDelete, dialogs;

{$R *.dfm}

{ TentityDeleteDialog }

function TEntityDeleteDialog.entityDeleteConfirm(question: string;
  var query: TDataSet): boolean;
begin
  Caption := 'Confirm';
  EntityDeleteConfirmDataSource.DataSet := query;
  EntityDeleteConfirmLabel.Caption := question;
  
// Added by AK for PM334
  yesButon.Caption := 'Yes';
  noBtn.Caption := 'No';

  if ShowModal = mrYes then begin
    entityDeleteConfirm := true;
  end else begin
    entityDeleteConfirm := false;
  end;
end;

// Added by AK for PM334
function TEntityDeleteDialog.entityLinkedProducts(question:string; var query:TDataSet):boolean;
var
   temp:string;
   loop:integer;
begin
  Caption :=  'Linked Products';
  EntityDeleteConfirmDataSource.DataSet := query;
  EntityDeleteConfirmLabel.Caption := question;

  yesButon.Caption := 'Copy';
  noBtn.Caption := 'Cancel';

  Result := ShowModal = mryes;
  Clipboard.Open;
  Clipboard.Clear;

  temp := '';
  with entityDeleteConfirmDBGrid.DataSource.DataSet do
  begin
    First;
    while not Eof do
    begin
      for loop := 0 to pred(FieldCount) do
      begin
         temp := temp + Fields[loop].AsString + #9 ;
      end;
      temp := temp + #13#10;
      Next;
    end;
  end;
  Clipboard.SetTextBuf(PChar(temp));
  Clipboard.Close;
end;

procedure TEntityDeleteDialog.FormCreate(Sender: TObject);
begin
  setImageToStandardIcon( questionImage, IDI_QUESTION );
end;

procedure TEntityDeleteDialog.entityDeleteConfirmDBGridDrawTitleCell(
  Sender: TObject; Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
var
  txtRect: TRect;
  bmpRect: TRect;
  str: string;
  SortDown: Boolean;
  DrawGlyph: Boolean;
  IndexFieldName: String;
  GlyphIndex: Integer;
begin
  DefaultDrawing := False;
  txtRect := Rect;
  GlyphIndex := -1;

  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(rect);

    DrawGlyph := False;
    IndexFieldName := THackedADOQuery(EntityDelete.EntityIngredientOrMenuItemQuery).IndexFieldNames;
    if (Pos(Field.FullName,IndexFieldName) > 0) then
    begin
      DrawGlyph := True;
      SortDown := Pos(' DESC',THackedADOQuery(EntityDelete.EntityIngredientOrMenuItemQuery).IndexFieldNames) > 0;
      if SortDown then
        GlyphIndex := 0
      else
        GlyphIndex := 1;
    end;

    if DrawGlyph then
    begin
      bmpRect := Rect;
      bmpRect.Left := bmpRect.Right - ImageListGlyphs.Width;
      bmpRect.Top := bmpRect.Top + ((bmpRect.Bottom - bmpRect.Top - ImageListGlyphs.Height) div 2);

      txtRect.Right := bmpRect.Left;
    end;

    str := Field.DisplayName;
    txtRect.Left := txtRect.Left + 2;
    txtRect.Top := (txtRect.Bottom - txtRect.Top - TextHeight(str)) div 2;
    DrawText(canvas.Handle, PChar(str),
             length(str), txtRect,
             DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS);

    if DrawGlyph and (GlyphIndex >= 0) then
    begin
      ImageListGlyphs.Draw(Canvas,bmpRect.left,bmpRect.top,GlyphIndex);
    end;
  end;
end;

procedure TEntityDeleteDialog.entityDeleteConfirmDBGridTitleButtonClick(
  Sender: TObject; AFieldName: String);
var
  bkmark: TBookmark;
begin
  with THackedADOQuery(EntityDelete.EntityIngredientOrMenuItemQuery) do
  begin
    DisableControls;
    bkmark := GetBookmark;
    try
      if (AFieldName = IndexFieldNames) then
        IndexFieldNames := AFieldName + ' DESC'
      else if (AFieldName + ' DESC') = IndexFieldNames then
        IndexFieldNames := AFieldName
      else
        IndexFieldNames := AFieldName;
    finally
      GotoBookmark(bkmark);
      EnableControls;
    end;
  end;
end;

end.
