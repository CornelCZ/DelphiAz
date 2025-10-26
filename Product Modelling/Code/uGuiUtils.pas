unit uGuiUtils;

(*
 * Unit contains various GUI utility procedures.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)

interface
  uses ComCtrls, Math, Controls, DBCtrls, Classes, ExtCtrls, uAztecDBComboBox, StdCtrls;

type
  TMakeVisibleHandler = procedure ( ctl: TWinControl ) of object;

  // Fills in the pick list for a combo box.  If the list of strings is the same as the
  // list already in the combobox, then no action is performed (This latter step avoids
  // an annoying problem where setting the pick list for a combo box causes the dropdown
  // list to close.  The application frequently needs to change the picks lists in certain comboboxes.
  // combobox - the combo box on which to set the pick list.
  // strings  - the list of strings to put in the combo box.
  procedure setComboBoxItems( combobox: TAztecDBComboBox; strings: TStrings );
  // Is the current value in the combobox one of the dropdown items?  If yes, then
  // fix the case to match the dropdown item.  If allowBlank is true and combobox
  // is blank, function returns true
  function doesComboTextMatchPickList( combo: TComboBox; allowBlank: boolean ): boolean;
  // Set focus to a particular control.  If the control is hidden because it is in a tab of
  // a tab dialog which is not currently visible, this procedure will switch tabs to make
  // the control visible.  Any errors generated while switching focus are swallowed silently.
  procedure PrizmSetFocus( ctl: TWinControl );
  // This is a way to provide a specific procedure which makes a particular control visible.
  // This function is used by PrizmSetFocus when it wants to make a particular control
  // visible.  This allows PrizmSetFocus to make the Aztec/Pre-Aztec panels on the LineEdit
  // window visible as appropriate.
  procedure SetMakeVisibleHandler( ctl: TWinControl; handler: TMakeVisibleHandler );
  // This procedure customizes the keyboard handling on a control and all its children.
  // This procedure can be called for a form, and its effects will be applied to all
  // child controls on the form.
  // This is done to overcome the following bugs in the standard controls:
  // - If you press Escape in a TDBComboBox, the behaviour is not correct.  This procedure
  //   fixes that behaviour.
  // - The tab stop behaviour of a TDBRadioGroup is not correct.  This procedure fixes the
  //   tab stop behaviour.
  // - ... if any more bugs are found, this procedure will be updated to fix them.
  procedure installCustomKeyboardHandling( parent: TControl );

  type
    StandardWindowsIcon = (
      IDI_APPLICATION = 32512,
      IDI_HAND = 32513,
      IDI_QUESTION = 32514,
      IDI_EXCLAMATION = 32515,
      IDI_ASTERISK = 32516 );
  // This procedure retrieves the standard windows icon, and places it into
  // the given form icon (if possible).
  procedure setImageToStandardIcon( image: TImage; icon: StandardWindowsIcon );

  // Ensure that this application is not already running - if it is, then bring
  // the other app into focus and raise an EAbort exception.
  procedure ensureSingleInstanceApp;

  function doesControlContainFocus( winCtl : TWinControl ) : boolean;

  procedure setCbStateWithNoEvent( cb : TCheckBox; checked: boolean );
  
implementation

uses Windows, DBGrids, FlexiDBGrid, uLog, Forms, Messages, SysUtils;

type
  TMakeVisibleHandlerEntry = record
    ctl : TWinControl;
    handler : TMakeVisibleHandler;
  end;

var
  MakeVisibleHandlers : array of TMakeVisibleHandlerEntry;

procedure PrizmSetFocus( ctl: TWinControl );

  procedure makeVisible( child: TWinControl );
  var
    i : Integer;
  begin
    // First of all ensure parent is visible
    if child.Parent <> nil then
      makeVisible( child.Parent );

    // Now ensure this control is visible

    // Switch the the correct tab sheet if child is a tab of a tabbed control
    if (child is TTabSheet) and (child.Parent is TPageControl) then
        TPageControl(child.Parent).ActivePage := TTabSheet( child );

    // Use custom routine defined for this control to make it visible
    for i := Low(MakeVisibleHandlers) to High(MakeVisibleHandlers) do
      if MakeVisibleHandlers[i].ctl = child then
        MakeVisibleHandlers[i].handler( child );
  end;

begin
  try
    // Make sure the control is visible before attempting to set focus to it
    makeVisible( ctl );

    // Now set focus to the control
    ctl.SetFocus;
  except else
    Log.Event('PrizmSetFocus - Exception occurred.');
    // Ignore all exceptions
  end;
end;

procedure SetMakeVisibleHandler( ctl: TWinControl; handler: TMakeVisibleHandler );
var
  index : Integer;
begin
  index := Length( MakeVisibleHandlers );
  SetLength( MakeVisibleHandlers, index + 1 );
  MakeVisibleHandlers[index].ctl := ctl;
  MakeVisibleHandlers[index].handler := handler;
end;

procedure setComboBoxItems( combobox: TAztecDBComboBox; strings: TStrings );
var
  changeitems: boolean;
  i: integer;
begin
  //
  // Only update the Items array if it is different to the current one.
  //
  // This prevents problems when selecting a new unit in the Std Portion Unit
  // combo box.  Making the selection causes the table to go into Edit mode
  // which causes the Items property for the Std Portion Unit combo box to be
  // updated.
  //
  // If this happens the ComboBox gets confused and thinks the user has
  // selected a blank string.  The code below prevents this problem.
  //

  changeitems := false;

  // Do not change items if combobox is dropped down!  The users selection will
  // be lost...
  if (combobox.Items.Count <> strings.Count + 1) and (not ComboBox.DroppedDown) then
    changeitems := true;

  if not changeitems then begin
    for i := 0 to strings.Count - 1 do
      if strings[i] <> combobox.Items[i] then begin
        changeitems := true;
        Break;
      end;
  end;

  if changeitems then
    combobox.Items := strings;
end;

function doesComboTextMatchPickList( combo: TComboBox;
                                     allowBlank: boolean ): boolean;
var
  i : Integer;
begin
  if Length( combo.Text ) = 0 then begin
    Result := allowBlank;
  end else begin
    i := combo.Items.IndexOf( combo.Text );
    if i <> -1 then begin
      // String is in list

      // If dataset is editing, fix the case of the string.
      if combo.Text <> combo.Items[i] then
        combo.Text := combo.Items[i];

      Result := true;
    end else begin
      // String is not in list
      Result := false;
    end;
  end;
end;


type
  // Class override keypress event on a combo box.
  TDBComboKeyPressHandler = class(TComponent)
  public
    keyPressHandler: TKeyPressEvent; // the original key press handler on the control.
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;
var
  // Parent object used to own all instances of TDBComboKeyPressHandler
  handlerOwner: TComponent;

procedure TDBComboKeyPressHandler.OnKeyPress(Sender: TObject; var Key: Char);
begin
  // TDBComboBox Escape handling is broken - fix it.
  with Sender as TDBComboBox do begin
    if Key = #27 then begin
      // When escape is pressed, we want the drop down to close, but without messing up
      // the value written to the field.  The only way to achieve this is to set the
      // keystroke to #9 - tab.  Setting this to #0 doesn't work.
      Key := #9;
    end;

    // Invoke the original key press handler.
    if Assigned( keyPressHandler ) then
      keyPressHandler( Sender, Key );
  end;
end;

// Fix up keyboard handling
procedure installCustomKeyboardHandling( parent: TControl );
var
  i: Integer;
  dbComboKeyPressHandler: TDBComboKeyPressHandler;
begin
  // Create a parent object for all the handlers.
  if handlerOwner = nil then
    handlerOwner := TComponent.Create( nil );

  // Recursively invoke this procedure on all children of this component.
  if parent is TWinControl then begin
    with parent as TWinControl do begin
      // Install handlers on children
      for i := 0 to ControlCount - 1 do
        installCustomKeyboardHandling( Controls[i] );
    end;
  end;

  // Now perform customization actions on this control

  // When you hit Escape in a TDBComboBox the behaviour is totally broken:
  // The text in the combo box is updated to reflect the selected item, but
  // the field in the database table reverts to its previous value!
  // This handler fixes this problem.
  if parent is TDBComboBox then
    with parent as TDBComboBox do begin
      dbComboKeyPressHandler := TDBComboKeyPressHandler.Create( handlerOwner );
      dbComboKeyPressHandler.keyPressHandler := OnKeyPress;
      OnKeyPress := dbComboKeyPressHandler.OnKeyPress;
    end;

  // It is impossible to get the Tab behaviour of a TDBRadioGroup correct in
  // the designer.  The children of the control should be tab stops, but the
  // control itself should not.
  // In order to get the correct behaviour,  make the TDBRadioGroup a tab stop
  // in the designer (this causes its children to be tab stops).  This piece
  // of code then stops the parent being a tab stop.
  if parent is TDBRadioGroup then
    with parent as TDBRadioGroup do
      TabStop := false;
end;

// Sets the icon to the given windows standard icon
procedure setImageToStandardIcon( image: TImage; icon: StandardWindowsIcon );
var
  hdl: HIcon;
begin
  hdl := LoadImage( 0, Pointer(Ord(icon)), IMAGE_ICON, 0, 0,
                    LR_DEFAULTSIZE or LR_DEFAULTCOLOR or LR_SHARED );

  if hdl <> 0 then begin
    image.Picture.Icon.ReleaseHandle;
    image.Picture.Icon.Handle := hdl;
  end;
end;



//
// Code to ensure application single instance
//
var
  ThisAppRestoreMessage : Integer;
  OldMainWindowProc : Pointer;

function NewMainFormWindowProc(WindowHandle : hWnd; TheMessage : LongInt;
       ParamW : LongInt; ParamL : LongInt) : LongInt stdcall;
begin
  if TheMessage = ThisAppRestoreMessage then
  begin {Tell the application to restore, let it restore the form}
    if Application.MainForm.WindowState <> wsMinimized then
    begin  // do this to bring app to the top instead of just flashing on tool bar
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    end
    else
      SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);

    SetForegroundWindow(Application.Handle);
    {We handled the message - we are done}
    Result := 0;
    exit;
  end;
  {Call the original winproc}
  Result := CallWindowProc(OldMainWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
end;

procedure ensureSingleInstanceApp;
var
  msgName, mutexName : string;
begin
  msgName := Application.Title + '_Restore';
  mutexName := Application.Title + '_Mutex';

  ThisAppRestoreMessage := RegisterWindowMessage( PChar(msgName) );
  CreateMutex(nil, false, PChar(mutexName) );

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, ThisAppRestoreMessage, 0, 0);
    {Lets quit}
    SysUtils.Abort;
  end;

  // Install a custom event handler on the main form to detect the restore
  // message and restore the app when we receive it
  OldMainWindowProc := Pointer(SetWindowLong(Application.MainForm.Handle, GWL_WNDPROC, LongInt(@NewMainFormWindowProc)));
end;

function doesControlContainFocus( winCtl : TWinControl ) : boolean;
var
  i : Integer;
begin
  Result := false;
  for i := 0 to winCtl.ControlCount - 1 do
    if winCtl.Controls[ i ] is TWinControl then begin
      if TWinControl( winCtl.Controls[ i ] ).Focused then begin
        Result := true;
        Break;
      end;
      if doesControlContainFocus( TWinControl( winCtl.Controls[ i ] ) ) then begin
        Result := true;
        Break;
      end;
    end;
end;

procedure setCbStateWithNoEvent( cb : TCheckBox; checked: boolean );
var
  ev : TNotifyEvent;
begin
  ev := cb.OnClick;
  try
    cb.OnClick := nil;
    cb.Checked := checked;
  finally
    cb.OnClick := ev;
  end;
end;

end.
