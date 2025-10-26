unit uwait;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  Tfwait = class(TForm)
    Bar: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure UpdateBar(thestep: integer;info: String);
  end;

var
  fwait: Tfwait;

implementation

{$R *.DFM}

//////////////////////////////////  MH  ///////////////////////////////////////
//  Date: 06 apr 99
//  Inputs: thestep, info
//  Outputs: None
//  Globals (R): None
//  Globals (W): None
//  Objects Used: None
//
//  Update the position of the progress bar with the Step.
//  Display a message with info.
//
///////////////////////////////////////////////////////////////////////////////
Procedure Tfwait.UpdateBar(thestep: integer;info: String);
begin
  Label3.Caption := info;
	Label2.Caption := IntToStr(theStep)+'%';
  Bar.position := theStep;
  Application.ProcessMessages;
end;

procedure Tfwait.FormCreate(Sender: TObject);
begin
	Screen.Cursor := crHourglass;
end;

procedure Tfwait.FormDestroy(Sender: TObject);
begin
	Screen.Cursor := crDefault;
end;

end.
