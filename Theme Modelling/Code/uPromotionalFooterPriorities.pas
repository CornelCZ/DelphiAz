unit uPromotionalFooterPriorities;

interface

{$R '..\..\Common Files\Icons\ArrowGlyphs.res' '..\..\Common Files\Icons\ArrowGlyphs.rc'}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, uSimpleLocalise;

type
  TFooterOrderData = class(TObject)
    Id: integer;
    Priority: integer;
    Modified: boolean;
    Enabled: boolean;
  end;

  TPromotionalFooterPriorities = class(TForm)
    Panel5: TPanel;
    lblSetPriority: TLabel;
    Bevel3: TBevel;
    imLogo: TImage;
    lblSetPriorityDescription: TLabel;
    lbFooterPriority: TListBox;
    sbMoveUp: TSpeedButton;
    sbMoveDown: TSpeedButton;
    btnOK: TButton;
    btnCancel: TButton;
    pnlBottom: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbFooterPriorityDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbFooterPriorityDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure sbMoveUpClick(Sender: TObject);
    procedure sbMoveDownClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbFooterPriorityDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    procedure SwapPriority(InputA, InputB: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PromotionalFooterPriorities: TPromotionalFooterPriorities;

implementation

uses uDMThemeData, uDMPromotionalFooter, Math, uAztecLog;

{$R *.dfm}

procedure TPromotionalFooterPriorities.FormCreate(Sender: TObject);
begin
  sbMoveUp.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphUp');
  sbMoveDown.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphDown');
  imLogo.Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
end;

procedure TPromotionalFooterPriorities.FormShow(Sender: TObject);
var
  TmpFooterOrderData: TFooterOrderData;
  StatusFilter: string;
begin
  //uPromotionsLog.Log.Event('SetPromotion Order', 'Show');
  with dmThemeData.adoqRun do
  begin
    lbFooterPriority.Clear;
    if dmPromotionalFooter.HideDisabledPromotionalFooters then
      StatusFilter := 'where Status = 0'
    else
      StatusFilter := '';
    SQL.Text := Format('select Name, Id, Priority, Status from PromotionalFooter %s order by Priority ASC',
      [StatusFilter]);
    Open;
    while not EOF do
    begin
      TmpFooterOrderData := TFooterOrderData.Create;
      TmpFooterOrderData.Id := FieldByName('Id').AsInteger;
      TmpFooterOrderData.Priority := FieldByName('Priority').AsInteger;
      TmpFooterOrderData.Modified := False;
      TmpFooterOrderData.Enabled := FieldByName('Status').AsInteger = 0;
      if TmpFooterOrderData.Enabled then
        lbFooterPriority.Items.AddObject(FieldByName('Name').AsString, TmpFooterOrderData)
      else
        lbFooterPriority.Items.AddObject(FieldByName('Name').AsString+' (Disabled)', TmpFooterOrderData);
      Next;
    end;
  end;
  uSimpleLocalise.LocaliseForm(self);
end;

procedure TPromotionalFooterPriorities.lbFooterPriorityDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  DragPos: TPoint;
  DragItem: integer;
begin
  DragPos.X := X;
  DragPos.Y := Y;
  DragItem := TListBox(Sender).ItemAtPos(DragPos, False);
  Accept := (DragItem >= 0) and (DragItem < TListBox(Sender).Count);
end;


procedure TPromotionalFooterPriorities.lbFooterPriorityDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  DragPos: TPoint;
  i,j: integer;
begin
  //romotionsLog.Log.Event('  Set Promotion Priority', 'Item Dropped');
  DragPos.X := X;
  DragPos.Y := Y;
  i := TListBox(Sender).ItemIndex;
  j := TListBox(Sender).ItemAtPos(DragPos, False);
  while i <> j do
  begin
    SwapPriority(i, i + sign(j-i));
    i := i + sign(j-i);
  end;
end;

procedure TPromotionalFooterPriorities.SwapPriority(InputA, InputB: integer);
var
  DataA, DataB: TFooterOrderData;
begin
  DataA := TFooterOrderData(lbFooterPriority.Items.Objects[InputA]);
  DataB := TFooterOrderData(lbFooterPriority.Items.Objects[InputB]);
  DataA.Priority := DataA.Priority XOR DataB.Priority;
  DataB.Priority := DataA.Priority XOR DataB.Priority;
  DataA.Priority := DataA.Priority XOR DataB.Priority;
  DataA.Modified := True;
  DataB.Modified := True;
  // Swap items in the list view
  lbFooterPriority.Items.Exchange(InputA, InputB);
end;

procedure TPromotionalFooterPriorities.sbMoveUpClick(Sender: TObject);
begin
  if lbFooterPriority.ItemIndex >= 1 then
  begin
    //uPromotionsLog.Log.Event('  Promotion Priority Move Up Button Clicked', lbPromotionOrder.Items[lbPromotionOrder.ItemIndex]);
    SwapPriority(lbFooterPriority.ItemIndex, lbFooterPriority.ItemIndex-1);
  end;
end;

procedure TPromotionalFooterPriorities.sbMoveDownClick(Sender: TObject);
begin
  if (lbFooterPriority.ItemIndex <> -1) and (lbFooterPriority.ItemIndex < lbFooterPriority.Count-1) then
  begin
    //uPromotionsLog.Log.Event('  Promotion Priority Move Down Button Clicked', lbPromotionOrder.Items[lbPromotionOrder.ItemIndex]);
    SwapPriority(lbFooterPriority.ItemIndex, lbFooterPriority.ItemIndex+1);
  end;
end;

procedure TPromotionalFooterPriorities.btnOKClick(Sender: TObject);
var
  i: integer;
begin
  //uPromotionsLog.Log.Event('SetPromotion Order', 'Ok Button Clicked');
  for i := 0 to pred(lbFooterPriority.Items.Count) do
  begin
    with dmThemeData, TFooterOrderData(lbFooterPriority.Items.Objects[i]) do
      if Modified then
      begin
        adoqRun.SQL.Text := Format('update PromotionalFooter set Priority = %d where Id = %d',
          [Priority, Id]);
        adoqRun.ExecSQL;
      end;
  end;
end;

procedure TPromotionalFooterPriorities.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to pred(lbFooterPriority.Items.Count) do
  begin
    lbFooterPriority.Items.Objects[i].Free;
  end;
end;

procedure TPromotionalFooterPriorities.lbFooterPriorityDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin
    if not TFooterOrderData(
      TListBox(Control).Items.Objects[Index]
      ).Enabled then
    begin
      Font.Color := clGrayText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left + 2, Rect.Top, (Control as TListBox).Items[Index])
  end;
end;

end.


