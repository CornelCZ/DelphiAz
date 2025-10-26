unit uProductInPanelReportParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDataTree, StdCtrls, ComCtrls, DB, ADODB, ExtCtrls;

type
  TProductInPanelReportParams = class(TForm)
    Label1: TLabel;
    btPreview: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    Panel1: TPanel;
    tvProductSelection: TTreeView;
    GroupBox1: TGroupBox;
    edName: TEdit;
    Button1: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btPreviewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    ProductNamesArray: TNamesArray;
    ProductDataTree: TDataTree;
    SearchStringChanged: boolean;
  public
    { Public declarations }
  end;

var
  ProductInPanelReportParams: TProductInPanelReportParams;

implementation

uses uAdo, uProductInPanelReport;

{$R *.dfm}

procedure TProductInPanelReportParams.FormCreate(Sender: TObject);
begin
  dmado.AztecConn.Execute('if object_id(''tempdb..#producttree_names'') is not null drop table #producttree_names');
  adoquery1.execsql;
  with dmado.adoqrun do
  begin
    SQL.Text := 'select * from #producttree_names';
    Open;
    SetLength(ProductNamesArray, RecordCount+1);
    First;
    while not EOF do
    begin
      ProductNamesArray[FieldByName('ID').AsInteger] := FieldByName('Name').AsString;
      Next;
    end;
    Close;
  end;

  ProductDataTree := TDataTree.Create(tvProductSelection, dmAdo.AztecConn, '#ProductTree_Data', ProductNamesArray);
  ProductDataTree.AddLevel('Division', '');
  ProductDataTree.AddLevel('Category', '');
  ProductDataTree.AddLevel('Subcategory', '');
  ProductDataTree.AddLevel('Product', 'SELECT [Retail Description] as Hint FROM Products where cast((EntityCode-10000000000.0) as int) = %d and EntityCode < 20000000000.0');
  ProductDataTree.Initialise;
end;

procedure TProductInPanelReportParams.btPreviewClick(Sender: TObject);
begin
  if not Assigned(tvProductSelection.Selected)
    or (tvProductSelection.Selected.Level <> 3) then
      raise Exception.Create('Please pick a valid product first.');

  Screen.Cursor := crHourGlass;
  with TProductInPanelReport.Create(nil) do try
    ProductID := 10000000000 + Integer(tvProductSelection.Selected.Data);
    PreviewReport;
  finally
    Screen.Cursor := crDefault;
    Free;
  end;
end;

procedure TProductInPanelReportParams.FormDestroy(Sender: TObject);
begin
  ProductDataTree.Free;
end;

procedure TProductInPanelReportParams.edNameChange(Sender: TObject);
begin
  SearchStringChanged := True;
end;

procedure TProductInPanelReportParams.Button1Click(Sender: TObject);
begin
  if SearchStringChanged then
    ProductDataTree.FindNodes(edName.Text, '#ProductTree_Names', ProductDataTree.GetMaxLevel, ProductDataTree.GetMaxLevel);
  SearchStringChanged := False;
  ProductDataTree.FindNext;
end;

procedure TProductInPanelReportParams.Button3Click(Sender: TObject);
begin
  if SearchStringChanged then
    ProductDataTree.FindNodes(edName.Text, '#ProductTree_Names', ProductDataTree.GetMaxLevel, ProductDataTree.GetMaxLevel);
  SearchStringChanged := False;
  ProductDataTree.FindPrev;
end;

end.
