unit uScaleContainerDeletionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB;

type
  TScaleContainerDeletionDialog = class(TForm)
    wwDBGrid1: TwwDBGrid;
    btnNo: TButton;
    lblContainer: TLabel;
    btnCopy: TButton;
    dsProductsUsingContainer: TDataSource;
    adoqProductsUsingContainer: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    { Private declarations }
    FScaleContainerID: Integer;
    FScaleContainerName: String;
    procedure UpdateLabelCaption;
    procedure BuildTempTable;

  public
    { Public declarations }
    property ScaleContainerID: Integer read FScaleContainerID write FScaleContainerID;
    property ScaleContainerName: String read FScaleContainerName write FScaleContainerName;
  end;

var
  ScaleContainerDeletionDialog: TScaleContainerDeletionDialog;

implementation

uses
  uDMThemeData, uADO, uExcelExportImport, uAztecLog;

{$R *.dfm}

{ TScaleContainerDeletionDialog }

procedure TScaleContainerDeletionDialog.BuildTempTable;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('IF OBJECT_ID(''tempdb..#ProductsUsingContainer'') IS NOT NULL DROP TABLE #ProductsUsingContainer');
    ExecSQL;

    SQL.Clear;
    SQL.Add('CREATE TABLE #ProductsUsingContainer (');
    SQL.Add(' [Entity Code] float,');
    SQL.Add(' [Portion ID] integer,');
    SQL.Add(' [Retail Name] varchar(16),');
    SQL.Add(' [Description] varchar(40),');
    SQL.Add(' [Portion] varchar(16),');
    SQL.Add(' [Container] varchar(20)');
    SQL.Add(')');
    ExecSQL;

    SQL.Clear;
    SQL.Add('INSERT #ProductsUsingContainer ([Entity Code], [Portion ID], [Retail Name], [Description], [Portion], [Container])');
    SQL.Add('SELECT distinct p.EntityCode, po.PortionID, [Extended RTL Name], [Retail Description], pt.Name,'''+FScaleContainerName+'''');
    SQL.Add('FROM Products p');
    SQL.Add('JOIN Portions po');
    SQL.Add('ON p.EntityCode = po.EntityCode');
    SQL.Add('JOIN ac_PortionType pt on pt.ID = po.PortionTypeID');
    SQL.Add('WHERE po.ContainerID = ' + IntToStr(FScaleContainerID));
    SQl.Add('AND ((p.Deleted = ''N'') or (p.Deleted is null))');
    ExecSQL;
  end;
end;

procedure TScaleContainerDeletionDialog.FormShow(Sender: TObject);
begin
  BuildTempTable;
  UpdateLabelCaption;
  adoqProductsUsingContainer.Open;
end;

procedure TScaleContainerDeletionDialog.UpdateLabelCaption;
begin
  lblContainer.Caption := StringReplace(lblContainer.Caption,'<blah>',QuotedStr(FScaleContainerName),[rfReplaceAll]);
end;

procedure TScaleContainerDeletionDialog.btnCopyClick(Sender: TObject);
begin
  with TExcelExportImport.Create do
  begin
    HandleLogging := uAztecLog.Log;
    CopyToClipBoard(dmThemeData.AztecConn,
                    '#ProductsUsingContainer',
                    '[Entity Code],[Portion ID]',
                    '[Retail Name],Description,Portion,Container',
                    '[Entity Code],[Portion ID]');
    Free;
  end;
end;

end.
