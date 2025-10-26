{Mike Palmer
 (c) Copyright Zonal Retail Data Systems Ltd.  All Rights Reserved}

unit uAztecLocalProcess;

interface

uses Classes,Contnrs;

type
  TAztecLocalProcess=class
  public
    constructor Create;
    destructor Destroy;override;
  private
  protected
  published
  end;

  TAztecLocalProcessList=class(TObjectList)
  end;

implementation

{ TAztecLocalProcess }

constructor TAztecLocalProcess.Create;
begin

end;

destructor TAztecLocalProcess.Destroy;
begin

  inherited;
end;

end.
