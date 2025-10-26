unit uStdGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, ExtCtrls, DBGrids;

type
  TfrmStdGrid = class(TForm)
    Panel1: TPanel;
    dsGrid: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
