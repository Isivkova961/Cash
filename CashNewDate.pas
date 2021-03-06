unit CashNewDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ExtCtrls;

type
  TfCashNewDate = class(TForm)
    pNewDate: TPanel;
    pNewDate1: TPanel;
    lNewDate: TLabel;
    deNewDate: TDateEdit;
    bOk: TButton;
    bCancel: TButton;
    procedure bCancelClick(Sender: TObject);
    procedure bOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCashNewDate: TfCashNewDate;

implementation

uses CashDM, CachMain;

{$R *.dfm}

procedure TfCashNewDate.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCashNewDate.bOkClick(Sender: TObject);
var
  s: string;
begin
  with dmCash do
    begin
      adoqDataCopy.SQL.Clear;

      adoqDataCopy.SQL.Append('SELECT * FROM virtual_pokup');
      adoqDataCopy.SQL.Append('WHERE date_v = :d_v');

      adoqDataCopy.Parameters.ParamByName('d_v').Value := StrToDate(fMainCash.Date_data);

      adoqDataCopy.Open;

      if fMainCash.cobMonth.ItemIndex <> fMainCash.cobMonth.Items.Count - 1 then
        s := fMainCash.cobMonth.Items[fMainCash.cobMonth.ItemIndex + 1] + ' ' + fMainCash.spGod.Text
      else
        s := fMainCash.cobMonth.Items[0] + ' ' + IntToStr(fMainCash.spGod.Value + 1);

      while not (adoqDataCopy.Eof) do
        begin
          adoqCopy.SQL.Clear;

          adoqCopy.SQL.Append('INSERT INTO virtual_pokup');
          adoqCopy.SQL.Append('(month_v, date_v, id_prod, sum_d, koshel, comment, kol)');
          adoqCopy.SQL.Append('VALUES(:m_v, :d_v, :i_p, :s_d, :kos, :com, :kl)');

          adoqCopy.Parameters.ParamByName('m_v').Value := s;
          adoqCopy.Parameters.ParamByName('d_v').Value := deNewDate.Date;
          adoqCopy.Parameters.ParamByName('i_p').Value := adoqDataCopy.FieldByName('id_prod').Value;
          adoqCopy.Parameters.ParamByName('s_d').Value := adoqDataCopy.FieldByName('sum_d').Value;
          adoqCopy.Parameters.ParamByName('kos').Value := adoqDataCopy.FieldByName('koshel').Value;
          adoqCopy.Parameters.ParamByName('com').Value := adoqDataCopy.FieldByName('comment').Value;
          adoqCopy.Parameters.ParamByName('kl').Value := adoqDataCopy.FieldByName('kol').Value;

          adoqCopy.ExecSQL;
          adoqDataCopy.Next;
        end;
    end;
    
  Close;
end;

end.
