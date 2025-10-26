unit uProductTagsFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uTagListFrame,
  ADODB, DB, StdCtrls, uTag;

type
  TProductTagsFrame = class(TTagListFrame)
    adoqProductTags: TADODataSet;
    adocSaveProductTags: TADOCommand;
  private
    FProduct: Int64;
    procedure SetTagValuesForProduct(const ProductID: Int64);
  public
    procedure Initialise(Connection: TADOConnection);
    procedure EnsureInitialisedForProduct(productId: Int64);
    procedure InitialiseFromAnotherProduct(productId, sourceProductId: Int64);
    procedure SaveProductTagValues;
  end;

implementation

{$R *.dfm}

uses uBaseTagFrame;

procedure TProductTagsFrame.Initialise(Connection: TADOConnection);
begin
  Inherited Initialise(tcProduct, Connection);
  FProduct := -1;
  adoqProductTags.Connection := Connection;
  adocSaveProductTags.Connection := Connection;
end;

procedure TProductTagsFrame.EnsureInitialisedForProduct(productId: Int64);
begin
  if productId = FProduct then
    Exit;

  FProduct := productId;
  SetTagValuesForProduct(productId);
  FTagSelectionsChanged := False;
end;

procedure TProductTagsFrame.InitialiseFromAnotherProduct(productId: Int64; sourceProductId: Int64);
begin
  FProduct := productId;
  SetTagValuesForProduct(sourceProductId);
  FTagSelectionsChanged := True;
end;


procedure TProductTagsFrame.SetTagValuesForProduct(const ProductID: int64);
var
  FrameIndex: Integer;
  TempFrame: TfrmBaseTagFrame;
begin
  ClearTagSelections;
  with adoqProductTags do
  try
    Parameters[0].Value := IntToStr(ProductId);
    Open;
    while not(eof) do
    begin
      FrameIndex := TagSelectionFrameList.IndexOf(FieldByName('ParentName').AsString);
      if FrameIndex <> -1 then
      begin
        TempFrame := TfrmBaseTagFrame(TagSelectionFrameList.Objects[FrameIndex]);
        TempFrame.TagId := FieldByName('TagId').AsInteger;
      end;
      Next;
    end;
  finally
    Close;
  end;
end;

procedure TProductTagsFrame.SaveProductTagValues;
begin
  if FProduct = -1 then
    Exit;

  SaveTagSelections(true); // This populates #Tags with the selected tag ids

  adocSaveProductTags.Parameters[0].Value := IntToStr(FProduct);
  adocSaveProductTags.Execute;

  FTagSelectionsChanged := False;
end;

end.
