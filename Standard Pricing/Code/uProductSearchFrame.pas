unit uProductSearchFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, DB;

type
  TSearchDirection = (sdNext, sdPrevious);

  TProductSearchFrame = class(TFrame)
    lblIncSearch: TLabel;
    edtMidSearch: TEdit;
    btnPrevSearch: TSpeedButton;
    btnNextSearch: TSpeedButton;
    procedure edtMidSearchChange(Sender: TObject);
    procedure btnPrevSearchClick(Sender: TObject);
    procedure btnNextSearchClick(Sender: TObject);
    procedure edtMidSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FProductDataset: TDataset;
    FPreviousSearchFailed: boolean;
    FFailedSearchText: string;
    FSearchInProgress: boolean;
    FSearchRequestIgnored: boolean;
    FFontColor: TColor;
    function CheckSearchCriteria: boolean;
    procedure DoSearch(const direction: TSearchDirection);
  protected
    procedure SetEnabled(value: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    property ProductDataset: TDataset read FProductDataset write FProductDataset;
    procedure Clear;
    property Enabled: boolean write SetEnabled;
  end;

implementation

{$R *.dfm}

uses strUtils;

constructor TProductSearchFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPreviousSearchFailed := False;
  FFailedSearchText := '';
  FSearchInProgress := False;
  FSearchRequestIgnored := False;
  FFontColor := edtMidSearch.Font.Color;
end;

procedure TProductSearchFrame.DoSearch(const direction: TSearchDirection);
var
  searchText: string;
  match:boolean;
  wrapround,
  startpos:integer;
  loopCounter: integer;
begin
  if FSearchInProgress then
    Exit;

  FSearchInProgress := True;

  try
    searchText := edtMidSearch.Text;

    if searchText = '' then
      Exit;

    if FPreviousSearchFailed and AnsiContainsText(searchText, FFailedSearchText) then
      Exit;

    with FProductDataset do
    try
      DisableControls;

      loopCounter := 0;
      wrapround := 0;
      startpos := RecNo;

      repeat
        match := AnsiContainsText(FieldByName('DisplayProductName').asString, searchText) or
                 AnsiContainsText(FieldByName('ProductDescription').asString, searchText) or
                 AnsiContainsText(FieldByName('Import/Export Reference').asString, searchText);

        if not match then
        begin
          if direction = sdPrevious then
          begin
            Prior;
            if Bof then
            begin
              inc(wrapround);
              Last;
            end;
          end
          else
          begin
            Next;
            if Eof then
            begin
              inc(wrapround);
              First;
            end;
          end;

          //Keep the UI looking responsive
          inc(loopCounter);
          if loopCounter > 1000 then
          begin
            loopCounter := 0;
            Application.ProcessMessages;
          end;
        end;

      until (match) or (wrapround > 1) or (Recno = startpos);

      if not(match) then
      begin
        FPreviousSearchFailed := True;
        FFailedSearchText := searchText;
        edtMidSearch.Font.Color := clRed;
      end
      else
      begin
        FPreviousSearchFailed := False;
        FFailedSearchText := '';
        edtMidSearch.Font.Color := FFontColor;
      end;

    finally
      EnableControls;
    end;
  finally
    FSearchInProgress := False;
  end;

  //Catch up with any search requests that were ignored because a search was in progress.
  if FSearchRequestIgnored then
  begin
    FSearchRequestIgnored := False;
    if edtMidSearch.Text <> searchText then
      DoSearch(sdNext);
  end;
end;

procedure TProductSearchFrame.edtMidSearchChange(Sender: TObject);
begin
  if FSearchInProgress then
  begin
    FSearchRequestIgnored := True;
    Exit;
  end;

  DoSearch(sdNext);
end;

procedure TProductSearchFrame.btnPrevSearchClick(Sender: TObject);
begin
  if FSearchInProgress then
    Exit;

  if CheckSearchCriteria then
  begin
    with FProductDataset do
    try
      DisableControls;

      if not Bof then
        Prior
      else
        Last;

      DoSearch(sdPrevious);
    finally
      EnableControls;
    end;
  end;
end;

procedure TProductSearchFrame.btnNextSearchClick(Sender: TObject);
begin
  if FSearchInProgress then
    Exit;

  if CheckSearchCriteria then
  begin
    with FProductDataset do
    try
      DisableControls;

      if not Eof then
        Next
      else
        First;

      DoSearch(sdNext);
    finally
      EnableControls;
    end;
  end;
end;

procedure TProductSearchFrame.edtMidSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Up then
    btnPrevSearchClick(Sender)
  else
    if Key = vk_Down then
      btnNextSearchClick(Sender);
end;

function TProductSearchFrame.CheckSearchCriteria: boolean;
begin
  result := edtMidSearch.Text <> '';
  if not result then
  begin
    ShowMessage('Please enter the text you wish to search for.');
    edtMidSearch.SetFocus;
  end;
end;

procedure TProductSearchFrame.SetEnabled(value: boolean);
begin
  edtMidSearch.Enabled := value;
  btnPrevSearch.Enabled := value;
  btnNextSearch.Enabled := value;
  inherited;
end;

procedure TProductSearchFrame.Clear;
begin
  edtMidSearch.Clear;
end;

end.
