unit uAztecDialog;

interface

uses Dialogs, Forms, Graphics, Controls, Classes, Windows, Messages, ExtCtrls,
  StdCtrls;

Function  ShowAztecDialog ( Const AHeader, AMessage : String; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons ) : Integer;
Procedure ShowAztecMessage( Const AMessage : String );

implementation

{$R AztecDialog.RES}

Const     AZTEC_FONT_HEADER_STYLE = [fsBold];
          AZTEC_FONT_NAME         = 'Tahoma';
          AZTEC_FONT_SIZE         = 8;
          AZTEC_FONT_COLOR        = clNavy;
          AZTEC_FONT_STYLE        = [];
          AZTEC_FORM_Y            = 25;
          AZTEC_FORM_X            = 24;
          AZTEC_HEADER_X          = 20;
          AZTEC_MESSAGE_Y         = 55;
          AZTEC_SPACE             = 5;
          AZTEC_ICON_X            = 250;
          AZTEC_ICON_Y            = 20;
          AZTEC_DIALOG_BACKGROUND = 'AZTEC_DIALOG_BACKGROUND';


Type      TAztecFormDrag = Class
                             FormToMove : TForm;
                             Procedure EventDragForm (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
                           End;

Var       AztecFormDrag  : TAztecFormDrag;

Procedure SetAztecHeaderFont ( Font : TFont );
// Sets The Header Font
Begin
  With Font Do
  Begin
    Style   := AZTEC_FONT_HEADER_STYLE;
    Name    := AZTEC_FONT_NAME;
    Size    := AZTEC_FONT_SIZE;
    Color   := AZTEC_FONT_COLOR;
  End;
End;

Procedure SetAztecNormalFont ( Font : TFont );
// Sets To Normal Font
Begin
  With Font Do
  Begin
    Style   := AZTEC_FONT_STYLE;
    Name    := AZTEC_FONT_NAME;
    Size    := AZTEC_FONT_SIZE;
    Color   := AZTEC_FONT_COLOR;
  End;
End;

procedure TAztecFormDrag.EventDragForm;
begin
  If Button = mbLeft Then
  Begin
    // Allows The User To Move The Form, Despite The Fact It Does Not Have A Title Bar
    ReleaseCapture;
    SendMessage( ( FormToMove As TForm).Handle, WM_SYSCOMMAND, SC_MOVE Or 2, 0); // SC_MOVE Or 2 Translates To System Messages 61458
  End;
end;


Procedure SetAztecBaseImage ( AForm : TForm; AImage : TImage );
Begin
  With AImage Do
  Begin
    Left := 0;
    Top  := 0;
    AutoSize := TRUE;
    Picture.Bitmap.LoadFromResourceName(hInstance, AZTEC_DIALOG_BACKGROUND);
    AForm.Width := Width;
    AForm.Height := Height;
    AztecFormDrag.FormToMove := AForm;
    OnMouseDown := AztecFormDrag.EventDragForm;
  End;
End;

Procedure SetAztecHeaderLabel ( ALabel : TLabel );
Begin
  With ALabel Do
  Begin
    Transparent := TRUE;
    SetAztecHeaderFont ( Font );
    Left := AZTEC_FORM_X;
    Top  := AZTEC_HEADER_X;
    OnMouseDown := AztecFormDrag.EventDragForm;
  End;
End;

Procedure SetAztecMessageText ( AForm : TForm; Const AMessage : String );
Var       MessageLabel : TLabel;
Begin
  MessageLabel := TLabel.Create ( Nil );
  With MessageLabel Do
  Begin
    Left := AZTEC_FORM_X;
    Top  := AZTEC_MESSAGE_Y;
    WordWrap := TRUE;
    Width := AForm.Width - ( AZTEC_FORM_X * 2 );
    Height:= AForm.Height - ( AZTEC_FORM_X * 5 );
    AutoSize := FALSE;
    SetAztecNormalFont ( Font );
    Transparent := TRUE;
    Caption := AMessage;
    BringToFront;
    OnMouseDown := AztecFormDrag.EventDragForm;
    Parent := AForm;
  End;
End;

Procedure AlignDialogButtons ( AForm : TForm );
// Aligns The Dialog Buttons
Var       i : Integer;
          x : Integer;
          y : Integer;
Begin
  x := AZTEC_FORM_X;
  y := AForm.Height;
  For i := 0 To AForm.ControlCount - 1 Do
  Begin
    If ( AForm.Controls[i] Is TButton ) Then
    Begin
      If y + (AForm.Controls[i] As TButton).Height > AForm.Height Then
         Dec ( Y, (AForm.Controls[i] As TButton).Height + AZTEC_FORM_Y );
      ( AForm.Controls[i] As TButton ).Left := x;
      ( AForm.Controls[i] As TButton ).Top  := y;
      Inc ( x, ( AForm.Controls[i] As TButton ).Width + AZTEC_SPACE );
      If ( x + ( AForm.Controls[i] As TButton ).Width ) > AForm.Width Then
      Begin
        x := AZTEC_FORM_X;
        Dec ( y, ( AForm.Controls[i] As TButton).Height + 5 );
      End;
    End;
  End;
End;


Function  ShowAztecDialog ( Const AHeader, AMessage : String; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons ) : Integer;
Var       DialogForm   : TForm;
          Icon         : TIcon;
          DialogType   : TMsgDlgType;
Begin
  DialogType := DlgType;
  If DlgType = mtCustom Then
     DlgType := mtConfirmation;
  DialogForm := CreateMessageDialog ( AHeader, DlgType, Buttons );
  Icon := TIcon.Create;
  Icon.Assign ((DialogForm.FindComponent('Image') As TImage).Picture.Icon );
  SetAztecBaseImage ( DialogForm, (DialogForm.FindComponent('Image') As TImage) );
  With DialogForm Do
  Begin
    BorderStyle := bsNone;
    AutoSize := TRUE;
    TransparentColor := TRUE;
    TransparentColorValue := clYellow;
  End;
  If DlgType <> mtCustom Then
  Begin
    SetAztecHeaderLabel ((DialogForm.FindComponent('Message') As TLabel));
    SetAztecMessageText ( DialogForm, AMessage );
  End;
  AlignDialogButtons ( DialogForm );
  If DialogType <> mtCustom Then
     (DialogForm.FindComponent('Image') As TImage).Picture.Bitmap.Canvas.Draw ( AZTEC_ICON_X , AZTEC_ICON_Y, Icon );
  Result := DialogForm.ShowModal;
  Icon.Free;
  DialogForm.Free;
End;

Procedure ShowAztecMessage ( Const AMessage : String );
Begin
  ShowAztecDialog ( 'Information', AMessage, mtCustom, [mbOk] );
End;

Initialization

   AztecFormDrag := TAztecFormDrag.Create;

Finalization

   AztecFormDrag.Free;

End.
