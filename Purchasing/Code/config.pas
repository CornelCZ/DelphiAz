unit config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, wwdblook, DBTables, Wwdatsrc, Grids,
  Wwdbigrd, Wwdbgrid, Buttons, ExtCtrls, ComCtrls, ADODB;

type
  TfrmMainConfig = class(TForm)
    wwFixedCatsDS: TwwDataSource;
    wwCodeCatsDS: TwwDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    wwFixedCatGrid: TwwDBGrid;
    FInsertBtn: TBitBtn;
    RemoveBtn: TBitBtn;
    EditRepNameBtn: TBitBtn;
    Panel2: TPanel;
    CInsertBtn: TBitBtn;
    CRemoveBtn: TBitBtn;
    EditRepCodeBtn: TBitBtn;
    wwCodedCatGrid: TwwDBGrid;
    Label2: TLabel;
    HintPanel1: TPanel;
    AcceptCodeBtn: TBitBtn;
    CancelCodeBtn: TBitBtn;
    CloseBtn: TBitBtn;
    HintsLbl: TLabel;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    Panel3: TPanel;
    AcceptBtn: TBitBtn;
    CancelBtn: TBitBtn;
    FixCatCopyBM: TBatchMove;
    CodeCatsCopyBM: TBatchMove;
    wwFixedCatsTbl: TADOTable;
    wwFixedCatsTbltmp: TADOTable;
    wwCodeCatsTbl: TADOTable;
    wwCodeCatsTbltmp: TADOTable;
    procedure FormShow(Sender: TObject);
    procedure wwFixedCatGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wwFixedCatGridDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure wwFixedCatGridDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FInsertBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure CInsertBtnClick(Sender: TObject);
    procedure CRemoveBtnClick(Sender: TObject);
    procedure EditRepNameBtnClick(Sender: TObject);
    procedure EditRepCodeBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure AcceptBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure wwFixedCatGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwCodedCatGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cFromXY,cToXY: TGridCoord;
    cFromStr: TStringList;
    cFromRec,cToRec: integer;
    DataChange: Boolean;
    procedure CfgDisplayHint(Sender: TObject);
    procedure SetupHint;
    procedure CheckCursPos;
  end;

var
  frmMainConfig: TfrmMainConfig;

implementation

uses uinscat, uDMWklyPrchRep, uinscode, uADO, uGlobals;

{$R *.DFM}

procedure TfrmMainConfig.CfgDisplayHint(Sender: TObject);
begin

end;

procedure TfrmMainConfig.SetupHint;
begin

end;

procedure TfrmMainConfig.FormShow(Sender: TObject);
var
mappings: TStringlist;
begin
  wwFixedCatsTbl.Open;
  //wwFixedCatsTbltmp.open;
  dmADO.EmptySQLTable('FixCatstmp');
  //wwFixedCatsTbltmp.close;
  //wwFixedCatsTbltmp.EmptyTable;
  mappings:=Tstringlist.Create;
      // add mappings

  dmADO.BatchMove(wwFixedCatsTbl,wwFixedCatsTblTmp,mappings);
  mappings.Destroy;
  //FixCatCopyBM.Execute;

  wwCodeCatsTbl.Open;
  //wwCodeCatsTbltmp.open;
  //if not (wwCodeCatsTbltmp.Eof) then
  //  wwCodeCatsTbltmp.DeleteRecords(arAll);
  //wwCodeCatsTbltmp.close;

  dmADO.EmptySQLTable('codeCatstmp');

  //wwCodeCatsTbltmp.EmptyTable;
  mappings:=Tstringlist.Create;
      // add mappings

  dmADO.BatchMove(wwCodeCatsTbl,wwCodeCatsTbltmp,mappings);
  mappings.Destroy;

  //CodeCatsCopyBM.Execute;

  AcceptBtn.Enabled := False;
  CancelBtn.Enabled := False;
  //frmDMWklyPrchRep.CatListChange := False;
	{if wwFixedCatsTbl.RecordCount = 0 then
  begin
  	UpBtn.Enabled := False;
     DownBtn.Enabled := False;
  end;}
  CheckCursPos
end;

procedure TfrmMainConfig.wwFixedCatGridMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if Button = mbLeft then
  begin
  	With (sender as TwwDBGrid) do
     begin
        wwFixedCatGrid.BeginDrag(False);
        cFromXY := wwFixedCatGrid.MouseCoord(X,Y);
     end;
  	CheckCursPos;
  end;
end;

procedure TfrmMainConfig.wwFixedCatGridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
	if (Source as TwwDBGrid).Name = 'wwFixedCatGrid' Then
  	Accept := True
  else
  	Accept := False;
end;

procedure TfrmMainConfig.wwFixedCatGridDragDrop(Sender, Source: TObject; X,
  Y: Integer);
Var
 NoOfFields, i: integer;
begin
  cFromStr := TStringlist.Create;
  
  with wwFixedCatsTbl do
  begin
  	NoOfFields := FieldCount - 1;
     for i := 0 to NoOfFields do  // put record to be moved into a stringlist
     	cFromStr.Add(Fields[i].asString);
  end; //with

  with wwFixedCatsTbl do
  Begin
     cFromRec := RecNo;
  	cToXY := wwFixedCatGrid.MouseCoord(X,Y);
     If (cFromXY.Y <> cToXY.Y) then
     begin
       Delete;
       cToRec := (cFromRec - (cFromXY.Y - cToXY.Y));
       RecNo := cToRec;
       insertrecord([cFromStr.Strings[0],cFromStr.Strings[1],cFromStr.Strings[2],
       					cFromStr.Strings[3]]);
     end; //if

     DisableControls;
     // renumber the order in which the report items will be displayed
     First;
    	for i := 0 to RecordCount - 1 do
  	begin
  		Edit;
  		FieldValues['Report Order'] := i + 1;
     	post;
        next;
  	end; //for

     RecNo := cToRec;
     EnableControls;
     CancelBtn.Enabled := True;
     AcceptBtn.Enabled := True;
  end; //with

  cFromStr.Free;
  CheckCursPos;
end;

procedure TfrmMainConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if AcceptBtn.Enabled then
  begin  // changes to both

  	if MessageDlg('You have changed the Report Configuration without'+
     				' accepting/canceling your changes.'+#13+
                 'Click OK to: Accept the current configuration and Exit'+#13+
                 'Click Cancel to: Return to the Report Configuration',
                 mtWarning,[mbOK, mbCancel],0) = mrOK then
     begin
        wwFixedCatsTbl.Close;
  		wwCodeCatsTbl.Close;
     	Action := caFree;
     end
     else
        Action := caNone;
  end
  else
  begin
  	wwFixedCatsTbl.Close;
  	wwCodeCatsTbl.Close;
     Action := caFree;
  end;
end;

procedure TfrmMainConfig.FInsertBtnClick(Sender: TObject);
begin
 InsertFixCatDlg := TInsertFixCatDlg.Create(nil);
 if purchHelpExists then
  setHelpContextID(InsertFixCatDlg, HLP_WKLY_REPORT_CONFIG_ADD_PRIMARY_CATEGORY);

 With InsertFixCatDlg do
  begin
  	QGetFixedCatNames.Close;
		QGetFixedCatNames.Open;
  	if QGetFixedCatNames.RecordCount = 0 then
  	begin
  		ShowMessage('There are no Categories to add');
        QGetFixedCatNames.Close;
     	Free;
     	Exit;
  	end;
  end;

 if wwFixedCatsTbl.RecordCount < 8 then  // outer ifelse
 begin
  HintsLbl.Caption := '';
  InsertFixCatDlg.ShowModal;
	if (InsertFixCatDlg.ModalResult = mrOK)
  	AND (InsertFixCatDlg.CatnameEdit.Text <> '')
     AND (InsertFixCatDlg.RepNameEdit.Text <> '') then
  begin
  	wwFixedCatsTbl.AppendRecord(	[wwFixedCatsTbl.RecordCount + 1,
                                    InsertFixCatDlg.RepNameEdit.Text,
                                    InsertFixCatDlg.CatnameEdit.Text,
     			frmDMWklyPrchRep.RemoveBSlash(InsertFixCatDlg.CatnameEdit.Text)]);
     CancelBtn.Enabled := True;
     AcceptBtn.Enabled := True;
     //frmDMWklyPrchRep.CatListChange := True;
  end // inner if
  else
  	//frmDMWklyPrchRep.CatListChange := False;
 end
 else
 	ShowMessage('You cannot have more than 8 report categories.');
  //end of outer ifelse
 InsertFixCatDlg.Free;
 CheckCursPos;
end;

procedure TfrmMainConfig.RemoveBtnClick(Sender: TObject);
Var
	i,CurRec: integer;
begin
 if wwFixedCatsTbl.RecordCount > 0 then
 begin
	if MessageDlg('Are you sure you want to delete '+#39+' '+
  					wwFixedCatsTbl.FieldByName('Category Name').AsString +#39,
           		mtConfirmation,
           		[mbOK,mbCancel],0) = mrOK then
  begin
     with wwFixedCatsTbl do
     begin
  		Delete;
     	CurRec := RecNo;
     	DisableControls;
     	First;
     	for i := 0 to RecordCount - 1 do
  		begin
  			Edit;
  			FieldValues['Report Order'] := i + 1;
     		post;
        	next;
  		end; //for
        RecNo := CurRec;
        EnableControls;
        CancelBtn.Enabled := True;
        AcceptBtn.Enabled := True;
        //frmDMWklyPrchRep.CatListChange := True;
     end; //with
  end
  else
  	//frmDMWklyPrchRep.CatListChange := False; //ifelse
 end;//if
 CheckCursPos;
end;

procedure TfrmMainConfig.CInsertBtnClick(Sender: TObject);
begin
  frmInsCodeCateg := TfrmInsCodeCateg.Create(nil);
   if purchHelpExists then
    setHelpContextID(frmInsCodeCateg, HLP_WKLY_REPORT_CONFIG_ADD_CODED_CATEGORY);

  With frmInsCodeCateg do
  begin
  	QGetCodeCatNames.Close;
        QGetCodeCatNames.Open;
  	if QGetCodeCatNames.RecordCount = 0 then
  	begin
  		ShowMessage('There are no Categories to add');
        QGetCodeCatNames.Close;
     	Free;
     	Exit;
  	end;
  end;

  frmInsCodeCateg.ShowModal;
	if     (frmInsCodeCateg.ModalResult = mrOK)
  	AND (frmInsCodeCateg.CategoryEdit.Text <> '')
     AND (Length(frmInsCodeCateg.ReportCodeEdit.Text) = 2) then
  begin
     wwCodeCatsTbl.open;
     wwCodeCatsTbl.edit;
  	wwCodeCatsTbl.AppendRecord([frmInsCodeCateg.ReportCodeEdit.Text,
      									 frmInsCodeCateg.CategoryEdit.Text,
     		  frmDMWklyPrchRep.RemoveBSlash(frmInsCodeCateg.CategoryEdit.Text)]);
     CancelBtn.Enabled := True;
     AcceptBtn.Enabled := True;
//     wwCodeCatsTbl.close;
     //frmDMWklyPrchRep.CatListChange := True;
  end
  else if frmInsCodeCateg.ModalResult = mrCancel then
  	//frmDMWklyPrchRep.CatListChange := False
  else
   	ShowMessage(frmInsCodeCateg.ReportCodeEdit.Text+
     												' is not a valid 2 character code.');
  frmInsCodeCateg.Free;
end;

procedure TfrmMainConfig.CRemoveBtnClick(Sender: TObject);
begin
 if wwCodeCatsTbl.RecordCount > 0 then
 begin
	if MessageDlg('Are you sure you want to delete '+#39+' '+
  					wwCodeCatsTbl.FieldByName('Code').AsString+': '+
  					wwCodeCatsTbl.FieldByName('Category Name').AsString +#39,
           		mtConfirmation,
           		[mbOK,mbCancel],0) = mrOK then
  begin
     wwCodeCatsTbl.Delete;
     CancelBtn.Enabled := True;
     AcceptBtn.Enabled := True;
     //frmDMWklyPrchRep.CatListChange := True;
  end //if
  else
  	//frmDMWklyPrchRep.CatListChange := False;
 end;

end;

procedure TfrmMainConfig.EditRepNameBtnClick(Sender: TObject);
Var
	NewFixStr,OldFixStr: string;
begin
  wwFixedCatsTbl.DisableControls;
	wwFixedCatsTbl.Edit;

  OldFixStr := wwFixedCatsTbl.FieldByName('Report Name').AsString;
  NewFixStr := InputBox('Edit Report Name',
  						    'Enter new name then click OK. Cancel to abort:',
         					 OldFixStr);

  if  NewFixStr = OldFixStr then  //if no change
  begin
  	wwFixedCatsTbl.Cancel;
     wwFixedCatsTbl.EnableControls;
     exit;
  end;

  if (Length(NewFixStr) > 10) OR (Length(NewFixStr) = 0) then // invalid length
  begin
		ShowMessage(#39+NewFixStr+#39+' is not a valid Report Name.'+#13
  		+' Report Names must not have more than 10 characters.');
     wwFixedCatsTbl.FieldByName('Report Name').AsString := OldFixStr;
     wwFixedCatsTbl.Post;
  end
  else if wwFixedCatsTbl.Locate('Report Name',NewFixStr,[loCaseInsensitive])
  then //already exists
  begin
  	ShowMessage('Report Name: '+NewFixStr+' already exists.'+#13+
        												'Report names must be unique.');
     wwFixedCatsTbl.Locate('Report Name',oldFixStr,[]);
  end
  else    //ok
  begin
		wwFixedCatsTbl.Edit;
    	wwFixedCatsTbl.FieldByName('Report Name').AsString := NewFixStr;
    	CancelBtn.Enabled := True;
    	AcceptBtn.Enabled := True;
     wwFixedCatsTbl.Post;
  end; //if/else ladder
  wwFixedCatsTbl.EnableControls;
end;

procedure TfrmMainConfig.EditRepCodeBtnClick(Sender: TObject);
Var
	NewCodeStr, OldCodeStr: String;
begin
  wwCodeCatsTbl.DisableControls;
	wwCodeCatsTbl.Edit;

  OldCodeStr := wwCodeCatsTbl.FieldByName('Code').AsString;
  NewCodeStr := InputBox('Edit Report Code Name',
        		  'Enter a new 2 character code then click OK or Cancel to abort:',
         		  wwCodeCatsTbl.FieldByName('Code').AsString);
  
  if  NewCodeStr = OldCodeStr then  //if no change
  begin
  	wwCodeCatsTbl.Cancel;
     wwCodeCatsTbl.EnableControls;
     exit;
  end;

  if Length(NewCodeStr) <> 2 then
	begin
  	ShowMessage(NewCodeStr+ 'is not a valid 2 character code');
     wwCodeCatsTbl.FieldByName('Code').AsString := OldCodeStr;
     wwCodeCatsTbl.Post;
  end
  else if wwCodeCatsTbl.Locate('Code',NewCodeStr,[loCaseInsensitive]) then
    //already exists
  begin
  	ShowMessage('Code: '+NewCodeStr+' already exists.'+#13+
        												'Code names must be unique.');
     wwCodeCatsTbl.Locate('Code',oldCodeStr,[]);
  end
  else    //ok
  begin
     wwCodeCatsTbl.Edit;
  	wwCodeCatsTbl.FieldByName('Code').AsString := UpperCase(NewCodeStr);
     CancelBtn.Enabled := True;
     AcceptBtn.Enabled := True;
     wwCodeCatsTbl.Post;
     //frmDMWklyPrchRep.CatListChange := True;
  end;
  wwCodeCatsTbl.EnableControls;
end;

procedure TfrmMainConfig.CancelBtnClick(Sender: TObject);
Var
	CurrRec: Integer;
        mappings:TstringList;
begin
  if MessageDlg('Click Yes to cancel ALL changes made to the Report'
  					+' Configuration since the last Accept.'+#13+
                 'Click No to continue with Report Configuration.',
                 mtConfirmation,
                 [mbYes,mbNo]
                 ,0) = mrYes then
  begin
  	with wwFixedCatsTbl do
  	begin
        CurrRec := RecNo;
  		DisableControls;
  		Close;
                //wwFixedCatsTbl.open;
                //if not (wwFixedCatsTbl.Eof) then
                //  wwFixedCatsTbl.DeleteRecords(arAll);
                //wwFixedCatsTbl.close;
                dmADO.EmptySQLTable('FixCats');
  		//EmptyTable;

        mappings:=Tstringlist.Create;
      // add mappings

        dmADO.BatchMove(wwFixedCatsTbltmp,wwFixedCatsTbl,mappings);
        mappings.Destroy;
        //FixCatCopyBM.Source := wwFixedCatsTbltmp;
        //FixCatCopyBM.Destination := wwFixedCatsTbl;
        //FixCatCopyBM.Execute;
        Open;
        wwFixedCatGrid.ApplySelected;
        EnableControls;
        RecNo := CurrRec;
     end;
     with wwCodeCatsTbl do
  	begin
        CurrRec := RecNo;
  		DisableControls;
  		Close;

                dmADO.EmptySQLTable('codeCats');

  	       //	EmptyTable;
        mappings:=Tstringlist.Create;
      // add mappings

        dmADO.BatchMove(wwCodeCatsTbltmp,wwCodeCatsTbl,mappings);
        mappings.Destroy;
        //CodeCatsCopyBM.Source := wwCodeCatsTbltmp;
        //CodeCatsCopyBM.Destination := wwCodeCatsTbl;
        //CodeCatsCopyBM.Execute;
        Open;
        wwCodedCatGrid.ApplySelected;
        EnableControls;
        RecNo := CurrRec;
     end;
     CancelBtn.Enabled := False;
     AcceptBtn.Enabled := False;
  end;
end;

procedure TfrmMainConfig.AcceptBtnClick(Sender: TObject);
var
  mappings:Tstringlist;
begin
  if MessageDlg('Click Yes to accept ALL changes made to the Report'
  					+' Configuration.'+#13+
                 'Click No to continue with Report Configuration.',
                 mtConfirmation,
                 [mbYes,mbNo]
                 ,0) = mrYes then
  begin
  	with wwFixedCatsTbltmp do
  	begin
        Close;
        dmADO.EmptySQLTable('FixCatstmp');


  	       //	EmptyTable;

        mappings:=Tstringlist.Create;
      // add mappings

        dmADO.BatchMove(wwFixedCatsTbl,wwFixedCatsTbltmp,mappings);
        mappings.Destroy;
       // FixCatCopyBM.Source := wwFixedCatsTbl;
       // FixCatCopyBM.Destination := wwFixedCatsTbltmp;
       // FixCatCopyBM.Execute;
     end;
     with wwCodeCatsTbltmp do
  	begin
  		Close;
  	       //	EmptyTable;
        dmADO.EmptySQLTable('codeCatstmp');
        //wwCodeCatsTbltmp.close;
        //CodeCatsCopyBM.Source := wwCodeCatsTbl;
        //CodeCatsCopyBM.Destination := wwCodeCatsTbltmp;
        //CodeCatsCopyBM.Execute;
        mappings:=Tstringlist.Create;
      // add mappings

        dmADO.BatchMove(wwCodeCatsTbl,wwCodeCatsTbltmp,mappings);
        mappings.Destroy;
     end;
  	CancelBtn.Enabled := False;
     AcceptBtn.Enabled := False;
  end;
end;

procedure TfrmMainConfig.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainConfig.UpBtnClick(Sender: TObject);
Var
	i, TheRec: integer;
begin
  cFromStr := TStringlist.Create;
  cFromStr.Clear;

	with wwFixedCatsTbl do
  begin
     DisableControls;
     for i := 0 to FieldCount - 1 do  //put record to be moved into a stringlist
     	cFromStr.Add(Fields[i].asString);
     if RecNo = RecordCount  then
     begin
     	Delete;
        InsertRecord([cFromStr.Strings[0],cFromStr.Strings[1],
        											 cFromStr.Strings[2],
        											 cFromStr.Strings[3]]);
     end
     else
     begin
        Delete;
        Prior;
        InsertRecord([cFromStr.Strings[0],cFromStr.Strings[1],
        											 cFromStr.Strings[2],
        											 cFromStr.Strings[3]]);
     end;

     // renumber the order in which the report items will be displayed
     TheRec := RecNo;
     First;
    	for i := 0 to RecordCount - 1 do
  	begin
  		Edit;
  		FieldValues['Report Order'] := i + 1;
     	post;
        next;
  	end; //for
     RecNo := TheRec;
     EnableControls;
  end;  //with
  CancelBtn.Enabled := True;
  AcceptBtn.Enabled := True;
 
  cFromStr.Free;
  CheckCursPos;
end;

procedure TfrmMainConfig.DownBtnClick(Sender: TObject);
Var
	i, TheRec: integer;
begin
  cFromStr := TStringlist.Create;
  cFromStr.Clear;

	with wwFixedCatsTbl do
  begin
     DisableControls;
     for i := 0 to FieldCount - 1 do  //put record to be moved into a stringlist
     	cFromStr.Add(Fields[i].asString);

     Delete;
     if RecNo = RecordCount then
     	AppendRecord([cFromStr.Strings[0],cFromStr.Strings[1],
        											 cFromStr.Strings[2],
        											 cFromStr.Strings[3]])
     else
     begin
        Next;
     	InsertRecord([cFromStr.Strings[0],cFromStr.Strings[1],
        											 cFromStr.Strings[2],
        											 cFromStr.Strings[3]]);
     end;

     // renumber the order in which the report items will be displayed
     TheRec := RecNo;
     First;
    	for i := 0 to RecordCount - 1 do
  	begin
  		Edit;
  		FieldValues['Report Order'] := i + 1;
     	post;
        next;
  	end; //for

     RecNo := TheRec;
     EnableControls;
  end;  //with

  CancelBtn.Enabled := True;
  AcceptBtn.Enabled := True;
  cFromStr.Free;
  CheckCursPos;
end;

procedure TfrmMainConfig.CheckCursPos;
begin
	if (wwFixedCatsTbl.RecNo = 1) or
  	(wwFixedCatsTbl.RecordCount = 0) then
  	UpBtn.Enabled := False
  else
  	UpBtn.Enabled := True;

  if (wwFixedCatsTbl.RecNo = wwFixedCatsTbl.RecordCount) or
  	(wwFixedCatsTbl.RecordCount = 0) then
  	DownBtn.Enabled := False
  else
  	DownBtn.Enabled := True;
end;

procedure TfrmMainConfig.wwFixedCatGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
	if Key = VK_DELETE then
  	RemoveBtnClick(sender);
  if Key = VK_INSERT then
  	FInsertBtnClick(sender);
end;

procedure TfrmMainConfig.wwCodedCatGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
	if Key = VK_DELETE then
  	CRemoveBtnClick(sender);
  if Key = VK_INSERT then
  	CInsertBtnClick(sender);
end;

procedure TfrmMainConfig.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_WEEKLY_PURCH_REPORT_CONFIG);
end;

end.
 