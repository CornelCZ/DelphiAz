unit uEditTicketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls;

type
  TEditTicketing = class(TForm)
    btAdd: TButton;
    Label1: TLabel;
    qSequences: TADOQuery;
    dsSequences: TDataSource;
    qSequencesCloakroomSequenceID: TIntegerField;
    qSequencesThemeID: TIntegerField;
    qSequencesName: TStringField;
    qSequencesResetTime: TDateTimeField;
    qSequencesPerTerminal: TBooleanField;
    wwDBGrid1: TwwDBGrid;
    btEdit: TButton;
    btDelete: TButton;
    btClose: TButton;
    btManageTicketImages: TButton;
    Bevel1: TBevel;
    qSequencesPrinteTicketNumber: TBooleanField;
    procedure btDeleteClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btManageTicketImagesClick(Sender: TObject);
  private
    { Private declarations }
    procedure CheckCanEdit(dataset: TDataset);
    procedure RefreshAndLocate(SequenceID: integer);
  public
    { Public declarations }
    theme_id: integer;
    procedure prepare;
  end;

var
  EditTicketing: TEditTicketing;

implementation

uses uDMThemeData, uAddEditTicketSequence, uAztecLog,
  uTicketingImageManagement, uFormNavigate;

{$R *.dfm}

{ TEditTicketing }

procedure TEditTicketing.prepare;
begin
  qSequences.open;
end;

procedure TEditTicketing.btDeleteClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  CheckCanEdit(qSequences);
  if messagedlg(
    format('Are you sure you want to delete ticket sequence "%s"?', [qSequences.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    log('Deleting Ticket Sequence ' + qSequences.fieldbyname('Name').asstring);
    qSequences.delete;
  end;
end;

procedure TEditTicketing.CheckCanEdit(dataset: TDataset);
begin
  if dataset.recordcount = 0 then
    Raise exception.create('Please add some items first!');
end;

procedure TEditTicketing.btEditClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  CheckCanEdit(qSequences);
  with TAddEditTicketSequence.create(nil) do try
    prepare(theme_id, qSequences.fieldbyname('CloakroomSequenceID').asinteger);
    if showmodal = mrok then
      RefreshAndLocate(edit_id);
  finally
    free;
  end;
end;

procedure TEditTicketing.btAddClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  with TAddEditTicketSequence.create(nil) do try
    prepare(theme_id);
    if showmodal = mrok then
      RefreshAndLocate(edit_id);
  finally
    free;
  end;
end;


procedure TEditTicketing.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TEditTicketing.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  nav.MoveBack;
end;

procedure TEditTicketing.btCloseClick(Sender: TObject);
begin
  ButtonClicked(sender);
  Close;
end;

procedure TEditTicketing.RefreshAndLocate(SequenceID: integer);
begin
  qSequences.Requery();
  qSequences.Locate('CloakroomSequenceId', SequenceID, []);
end;

procedure TEditTicketing.btManageTicketImagesClick(Sender: TObject);
var
  TicketingImageManagement: TTicketingImageManagement;
begin
  TicketingImageManagement := TTicketingImageManagement.Create(nil);
  TicketingImageManagement.ThemeId := theme_id;
  nav.Moveforward(TicketingImageManagement, True);
end;

end.
