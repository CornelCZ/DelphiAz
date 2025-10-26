unit FrmEventsMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, WmiAbstract,
  WmiComponent, WmiSystemEvents;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    tlbNewHost: TToolButton;
    ToolButton1: TToolButton;
    tlbRefresh: TToolButton;
    ToolButton4: TToolButton;
    ToolButton2: TToolButton;
    tlbAbout: TToolButton;
    tvBrowser: TTreeView;
    Splitter1: TSplitter;
    ilToolbar: TImageList;
    PageControl1: TPageControl;
    tsWatch: TTabSheet;
    Setup: TTabSheet;
    ListBox1: TListBox;
    WmiSystemEvents1: TWmiSystemEvents;
    GroupBox1: TGroupBox;
    chbApplication: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox3: TGroupBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    GroupBox5: TGroupBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    GroupBox6: TGroupBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    GroupBox7: TGroupBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    TabSheet1: TTabSheet;
    memSetup: TMemo;
    pnlTop: TPanel;
    lblNameSpace: TLabel;
    cmnNameSpaces: TComboBox;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    Button1: TButton;
    memQuery: TMemo;
    Label1: TLabel;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  // this class keeps user's credentials for host.
  TCredentials = class
  private
    FUserName: widestring;
    FPassword: widestring;
  public
    constructor Create(AUserName, APassword: widestring);

    property UserName: widestring read FUserName;
    property Password: widestring read FPassword;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';
  CNST_CAPTION = 'Watch for events on ';

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  InitItems;
  WmiSystemEvents1.Active := true;
end;


procedure TForm1.InitItems;
var
  vItem: TTreeNode;
begin
  tvBrowser.Items.Add(nil, LOCAL_HOST);
  vItem := tvBrowser.Items.Add(nil, NETWORK);
  tvBrowser.Items.AddChild(vItem, NO_DATA);
end;

end.
