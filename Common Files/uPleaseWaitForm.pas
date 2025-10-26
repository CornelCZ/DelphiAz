unit uPleaseWaitForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TPleaseWaitForm = class(TForm)
    lblMessage: TLabel;
    Label1: TLabel;
  private
    procedure SetMessage( msg : string );
  public
    class function ShowPleaseWait(title, msg : string) : TPleaseWaitForm;
    property Message : string write SetMessage;
  end;

implementation

{$R *.dfm}

{ TPleaseWaitForm }

procedure TPleaseWaitForm.SetMessage(msg: string);
begin
  lblMessage.Caption := msg;
  Repaint;
end;

class function TPleaseWaitForm.ShowPleaseWait(title, msg: string): TPleaseWaitForm;
begin
  Result := TPleaseWaitForm.Create(nil);
  Result.Caption := title;
  Result.lblMessage.Caption := msg;
  Result.Show;
  Result.Repaint;
end;

end.
