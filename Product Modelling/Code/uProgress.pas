unit uProgress;
{ TODO : Log text passed to the progress bar }
(*
 * Unit provides visual indication of progress through (lenghty) tasks.
 * Can also give a debugging log (run the application with -progress on
 * the command line)
 *
 * it is recommended that a ratio of no greater
 * than 10:1 of logging messages (ie progressLog) to progress messages
 * (ie progress) is given, for sanity reasons.
 *
 * Call 'markTime' within onerous loops to continue to encourage the user
 * that something is happening, with comforting dots.
 *
 * Author: Stuart Boutell, Ice Cube/Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, ExtCtrls, StrUtils, DateUtils;

type
  pLogLevel = (pLogNone,        // no logging
               pLogWarn,        // non-critical (but user visible) notifications
               pLogProgress,    // progress logging  <- production default
               pLogDevWarn,     // development warnings
               pLogDevProgress, // development progress logging (verbose)
               pLogDevQuery,    // development progress logging including queries
               pLogDevDb);      // development progress including db manipulations

  TProgressForm = class(TForm)
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    ProgressMemo: TMemo;
    ProgressButton: TButton;
    ProgressRatio: TLabel;
    ProgressTimer: TTimer;
    procedure ProgressButtonClick(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    thisLabel:string;
    nextRatio:string;
    nextMemo:TStrings;

    // progress of progress elipsis...
    curDots:integer;
    dotTick:TDateTime;            // after 500 ms, this starts elpsis moving;

    logLevel:pLogLevel;
    canned: boolean;
    canBeClosed: boolean;
    parentForm: TForm;
    progressCurrent: Integer;
    progressTotal: Integer;
    procedure clearProgress;
    procedure memoProgress(txt: String);
    procedure setProgress(form: TForm; title, txt: String; stage,
      stages: Integer);
    procedure startProgress(cancel: Boolean);
    procedure doUpdate;
    { Private declarations }
  public
    procedure progressStart(total: Integer; form: TForm; cancelable: boolean);

    procedure progress(title, task: String; out cancelled: boolean); overload;
    procedure progress(title, task: String); overload;
    property  isProgressCancelled : boolean read canned;

    procedure progressPause;
    procedure progressResume;
    procedure markTime;
    procedure progressSkip(skip: integer);
    procedure progressLog(txt: String; level: pLogLevel);
    procedure progressDone(unused: boolean); // used to take a "shall we wait"

  end;

var
  ProgressForm: TProgressForm;

implementation

uses uLog;

const
  dots:Integer = 10;
  dotStep:Int64 = 100;
  dotFirst:Int64 = 250;

{$R *.dfm}

// -----------------------------------------------------------------------------
// startProgress
//   about to put up a progress box; get everything ready.
//
procedure TProgressForm.startProgress(cancel:Boolean);
begin
  nextRatio := '';
  nextMemo.Clear;

  ProgressTimer.enabled := false;
  Hide; // just in case
  canned := false;
  canBeClosed := false;

  if logLevel > pLogNone then begin
    ClientHeight := 254;      // bit smelly
    ProgressMemo.Clear;
    ProgressMemo.visible := true;
  end else begin
    ClientHeight := 88;
    ProgressMemo.Visible := false;
  end;

  if cancel then begin
    ProgressButton.Tag     := 1;
    ProgressButton.Caption := '&Cancel';
    ProgressButton.Enabled := true;
    ProgressButton.Visible := true;
  end else begin
    ProgressButton.Tag     := 0;
    ProgressButton.Caption := '&OK';
    ProgressButton.Enabled := false;
    ProgressButton.Visible := false;
    ClientHeight := ClientHeight - 30; // no button - remove the space for it
  end;

  ProgressForm.Tag := 1;        // cue us to be shown
  ProgressTimer.Enabled := true;
end;

// setProgress
//   set our current progress indication
//   update our form as appropriate

procedure TProgressForm.setProgress(form:TForm; title, txt:String; stage, stages:Integer);
begin
// update our progress bar
  ProgressBar.Min :=0;
  ProgressBar.Max := Stages;
  ProgressBar.Position := Stage;


// update our textual display
  nextRatio := IntToStr(ProgressBar.Position) + '/' + IntToStr(ProgressBar.Max);
  ProgressRatio.Tag := 1;  // indicate a repaint is nigh;

// update the caption and commentary (if needs be)
  if (ProgressForm.Caption <> title) then begin
    ProgressForm.Caption := title;
  end;
  if ProgressLabel.Caption <> txt then begin
    ProgressLabel.Caption := txt;
    thisLabel := txt;
  end;

// if we're in psycho log mode, log it
  if ProgressMemo.Visible then begin
    memoProgress('--- '+txt+' ['+ nextRatio +'] ---');
  end;

  doUpdate;
// if any messages, process - but does not yield (go idle)
  Application.ProcessMessages;
end;

// -----------------------------------------------------------------------------
// clearProgress
//   after finishing whatever was begin prompted,
//   allow user to dismiss the progress box (and scroll up/down the debug notes)
procedure TProgressForm.clearProgress;
begin
  ProgressBar.Position := ProgressBar.Max; // all done (regardless)
  ProgressTimer.Enabled := false;
  ProgressForm.Tag := 3;
  doUpdate;
  ProgressBar.Position := ProgressBar.Max;
  ProgressButton.Tag := 0;
  ProgressButton.Caption := '&OK';
  ProgressButton.Enabled := true;
  canBeClosed := true;
  // ensure our repaint completes
  Application.ProcessMessages;
  // allow the eye to see.
  sleep(100);
end;

// -----------------------------------------------------------------------------
// memoProgress
//   add a line to the debug box
procedure TProgressForm.memoProgress(txt: String);
begin
  if ProgressMemo.Visible then begin;
    nextMemo.Append(txt);
    ProgressMemo.Tag := 1;
    log.event(txt);
  end;
end;

// -----------------------------------------------------------------------------
// progressOkButtonClick
//   reset, and dismiss, the progress box
procedure TProgressForm.ProgressButtonClick(Sender: TObject);
begin
  if ProgressButton.Tag = 0 then begin
    // OK button - all done
    Close;
  end else begin
    // CANCEL button
    canned := true;
    ProgressButton.Enabled := false;
  end;
end;

// FormCreate
//   called on initialisation
procedure TProgressForm.FormCreate(Sender: TObject);
begin
  // create the scratch pad for pending log messages
  nextMemo := TStringList.Create;

  // if we are debugging (ie -progress specified at runtime) then
  // we will show more detailed progress - not useful for customer though.
  if FindCmdLineSwitch( 'progress', ['-','/'], true ) then
    logLevel := pLogDevDb // development
  else
    logLevel := pLogNone;
end;

// FormDestroy
//   called onDestroy; tidy up any used free space.
procedure TProgressForm.FormDestroy(Sender: TObject);
begin
  // destroy our scratch pad for log messages.
  nextMemo.Free;
end;

// FormCLose
//   called on close - re-enable our parent form if any
procedure TProgressForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if parentForm <> nil then begin
    parentForm.Enabled := true;
  end;
end;

// FormCloseQuery
//   we have to prevent ALT-F4/Close from closing our dialog;
//   only allow closure when closable...
procedure TProgressForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := canBeClosed;
end;


// doUpdate
//   scratch in any changed fields
procedure TProgressForm.doUpdate;
begin
  if ProgressRatio.Tag <> 0 then begin
    ProgressRatio.Tag := 0;
    ProgressRatio.Caption := nextRatio;
  end;

  if ProgressMemo.Tag <> 0 then begin
    ProgressMemo.Lines.AddStrings(nextMemo);
    nextMemo.Clear;
    ProgressMemo.Tag := 0;
  end;

  if ProgressLabel.Tag <> 0 then begin
    ProgressLabel.Caption := thisLabel + DupeString(' .', curDots);
  end;
(*  end; *)

  // queued actions
  case ProgressForm.Tag of
    1: Show;
    2: Hide;
    3: Repaint;
  end;
  ProgressForm.Tag := 0;
end;

// ProgressTimerTimer
//   ticks to update the screen with our progress;
//   we use a timer so as not to waste CPU showing progress instead
//   of actually doing. ;-)
procedure TProgressForm.ProgressTimerTimer(Sender: TObject);
begin
  doUpdate;
end;

// progressPause
//   temporarily dismiss us - eg while a dialog in progress
procedure TProgressForm.progressPause;
begin
  ProgressForm.Tag := 2;
  doUpdate;
end;

// progressResume
//   reshow our window - eg after a dialog
procedure TProgressForm.progressResume;
begin
  ProgressForm.Tag := 1; // show
  doUpdate;
  ProgressForm.Tag := 3; // and repaint
  doUpdate;
end;

// *****************************************************************************
// *****************************************************************************
//  PUBLIC INTERFACES
// *****************************************************************************
// *****************************************************************************


// -----------------------------------------------------------------------------
// progressStart
//   Start the progress indication bar
procedure TProgressForm.progressStart(total:Integer; form:TForm; cancelable:boolean);
begin
  progressCurrent := 0;
  progressTotal := total;
  parentForm := form;
  if parentForm <> nil then
    parentForm.Enabled := false;
  startProgress(cancelable);
end;

// -----------------------------------------------------------------------------
// progress
//   update progress box
procedure TProgressForm.progress(title, task:String; out cancelled:boolean);
begin
// elipsis managemetn
  curDots := 0;
  dotTick := IncMilliSecond(Now, dotFirst);
  progressCurrent := progressCurrent + 1;
  setProgress(Nil, title, task, progressCurrent, progressTotal);
  cancelled := canned;
end;

// -----------------------------------------------------------------------------
// progress
//   update progress box (don't test cancel)
procedure TProgressForm.progress(title, task:String);
begin
// elipsis managemetn
  curDots := 0;
  dotTick := IncMilliSecond(Now, dotFirst);
  progressCurrent := progressCurrent + 1;
  setProgress(Nil, title, task, progressCurrent, progressTotal);
end;

// -----------------------------------------------------------------------------
// progressSkip
//   step forward a number of progress units; does not actually impact screen
procedure TProgressForm.progressSkip( skip:integer );
begin
  progressCurrent := progressCurrent + skip;
end;

// -----------------------------------------------------------------------------
// markTime
//   simply indicate that life is ongoing
procedure TProgressForm.markTime;
begin
  if (Now > dotTick) then begin
    curDots := (curDots + 1) MOD dots;
    ProgressLabel.Tag := 1;
    doUpdate;
    dotTick := IncMilliSecond(Now, dotStep);
  end;
  Application.ProcessMessages;
end;

// ----------------------------------------------------------------------------
// progressDone
//   All finished; Dismiss the progress bar.
procedure TProgressForm.progressDone(unused:boolean);
begin
  clearProgress;
  Close;
end;

// -----------------------------------------------------------------------------
// progressLog
//   Log a message (and log level to compare against)
//   NB ignores cancelled state
procedure TProgressForm.progressLog(txt:String; level:pLogLevel);
begin
  if ProgressMemo.Visible then begin
    if level <= logLevel then begin
      case level of
      pLogWarn: begin
        txt := 'WARNING: '+txt;
        end;
      pLogDevWarn: begin
        txt := '[D]WARN : '+txt;
        end;
      pLogDevProgress: begin
        txt := '[D]     : '+txt;
        end;
      pLogDevQuery: begin
        txt := '[D]QUERY: '+txt;
        end;
      pLogDevDb: begin
        txt := '[D]DB   : '+txt;
        end;
      else
      end;
      memoProgress(txt);
    end;
  end;
  markTime;
  // if any messages, process - but does not yield (go idle)
  Application.ProcessMessages;
end;

end.
