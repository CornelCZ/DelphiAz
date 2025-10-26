{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved}
  
unit uAztecPathLabel;

interface

uses
  Windows,Messages,SysUtils,Classes,Controls,StdCtrls;

type
  TAztecPathLabel=class(TCustomLabel)
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy;override;
  protected
    procedure DoDrawText(var ARect:TRect;AFlags:longint);override;
    procedure CMFontChanged(var AMessage:TMessage);message CM_FONTCHANGED;
  published
    property Caption;
    property Color;
    property Transparent;
    property Font;
    property Alignment;
    property Align;
    property Anchors;
    property ParentFont default TRUE;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Aztec Components', [TAztecPathLabel]);
end;

{ TAztecPathLabel }

procedure TAztecPathLabel.CMFontChanged(var AMessage:TMessage);
begin
  Canvas.Font:=Font;
  Invalidate;
end;

constructor TAztecPathLabel.Create(AOwner:TComponent);
begin
  inherited;
  AutoSize:=FALSE;
  WordWrap:=FALSE;
  Height:=13;
end;

destructor TAztecPathLabel.Destroy;
begin
  inherited;
end;

procedure TAztecPathLabel.DoDrawText(var ARect: TRect; AFlags: Integer);
var
  Format:integer;
begin
  Format:=DT_PATH_ELLIPSIS or DT_MODIFYSTRING;
  case Alignment of
    taLeftJustify:Format:=Format+DT_LEFT;
    taRightJustify:Format:=Format+DT_RIGHT;
    taCenter:Format:=Format+DT_CENTER;
  end;
  InflateRect(ARect,-1,0);
  DrawTextEx(Canvas.Handle,PChar(Caption),Length(Caption),ARect,Format,nil);
end;

end.
