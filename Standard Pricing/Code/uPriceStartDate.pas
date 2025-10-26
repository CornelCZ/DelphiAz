unit uPriceStartDate;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls;

type
  TfPriceStartDate = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MonthCalendar: TMonthCalendar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    function GetChosenDate : TDateTime;
  public
    property ChosenDate : TDateTime read GetChosenDate;
  end;

implementation

{$R *.DFM}

{ TfPriceStartDate }

procedure TfPriceStartDate.FormCreate(Sender: TObject);
begin
  MonthCalendar.MinDate := Date;
end;

function TfPriceStartDate.GetChosenDate : TDateTime;
begin
  Result := MonthCalendar.Date;
end;

end.
