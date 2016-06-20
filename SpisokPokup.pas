unit SpisokPokup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls;

type
  TfSpisokPokup = class(TForm)
    pSpisok: TPanel;
    pSpisok1: TPanel;
    dbgSpisok: TDBGridEh;
    procedure FormShow(Sender: TObject);
    procedure LoadData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSpisokPokup: TfSpisokPokup;

implementation

uses CashDM;

{$R *.dfm}

procedure TfSpisokPokup.FormShow(Sender: TObject);
begin
  LoadData;
end;

procedure TfSpisokPokup.LoadData;
begin
  with dmCash do
    begin
      adoqSpisok.SQL.Clear;
      adoqSpisok.SQL.Append('SELECT name_pokup, status');
      adoqSpisok.SQL.Append('FROM spisok_pokup');
      adoqSpisok.SQL.Append('WHERE status = false');
      adoqSpisok.SQL.Append('GROUP BY name_pokup, status');
      adoqSpisok.SQL.Append('ORDER BY name_pokup');
      adoqSpisok.Open;
    end;
end;

end.
