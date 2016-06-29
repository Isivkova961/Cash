unit CashDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CurrEdit, Mask, ToolEdit, ExtCtrls,DateUtils;

type
  TfCashDetail = class(TForm)
    pDetail: TPanel;
    lDate: TLabel;
    lSumma: TLabel;
    lKateg: TLabel;
    lKoshel: TLabel;
    lKomment: TLabel;
    deDate: TDateEdit;
    ceSumma: TRxCalcEdit;
    cobKateg: TComboBox;
    cobKoshel: TComboBox;
    eKoment: TEdit;
    bOK: TButton;
    bCancel: TButton;
    pDetail_but: TPanel;
    lKol: TLabel;
    eKol: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadTable;
    procedure FormShow(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure NewDetail;
    procedure bOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCashDetail: TfCashDetail;
  name_table: string;

implementation

uses CashDM, CachMain, SpravNE;

{$R *.dfm}

procedure TfCashDetail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfCashDetail.LoadTable;
var
  sign: string;
begin
  cobKoshel.Clear;
  with  dmCash.adoqSprav do
    begin
      SQL.Clear;
      SQL.Append('SELECT * FROM sprav_pokup WHERE d_r = true');
      SQL.Append('and id_kat <> null');
      SQL.Append('ORDER BY name_kat ASC');
      Open;
      DisableControls;
      cobKoshel.Items.BeginUpdate;
      First;
      while not Eof do
        begin
          cobKoshel.Items.Add(FieldByName('name_kat').AsString);
          Next;
        end;
      cobKoshel.Items.EndUpdate;
      EnableControls;
    end;
  cobKateg.Clear;
  with  dmCash.adoqSprav do
    begin
      SQL.Clear;
      SQL.Append('SELECT * FROM sprav_pokup');
      if fMainCash.bReal_Virt = true then
        SQL.Append('WHERE id_kat <> null');
      SQL.Append('ORDER BY d_r, name_kat ASC');
      Open;
      DisableControls;
      cobKateg.Items.BeginUpdate;
      First;
      while not Eof do
        begin
          if FieldByName('d_r').Value = true then
            sign := '+'
          else
            sign := '-';
          cobKateg.Items.AddObject(sign + FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger));
          Next;
        end;
      cobKateg.Items.EndUpdate;
      EnableControls;
    end;
end;

procedure TfCashDetail.FormShow(Sender: TObject);
begin
  LoadTable;
  NewDetail;
  ceSumma.SetFocus;
end;

procedure TfCashDetail.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCashDetail.NewDetail;
begin
  if fMainCash.bReal_Virt = true then
    name_table := 'real_pokup'
  else
    name_table := 'virtual_pokup';
  if fMainCash.bNew_Edit = true then
    begin
      deDate.Text := fMainCash.Date_data;
      ceSumma.Text := '';
      cobKateg.Text := '';
      cobKoshel.ItemIndex := -1;
      eKoment.Text := '';
      eKol.Text := '1';
    end
  else
    begin
      if fMainCash.bReal_Virt = true then
        with dmCash.adoqReal do
          begin
            deDate.Text := FieldByName('date_v').AsString;
            ceSumma.Text := FloatToStr(Abs(FieldByName('sum_d').AsFloat / FieldByName('kol').AsInteger));
            dmCash.adoqSprav.Locate('id', FieldByName('id_prod').AsInteger, []);
            if dmCash.adoqSprav.FieldByName('d_r').Value = true then
              cobKateg.ItemIndex := cobKateg.Items.IndexOf('+' + dmCash.adoqSprav.FieldByName('name_kat').AsString)
            else
              cobKateg.ItemIndex := cobKateg.Items.IndexOf('-' + dmCash.adoqSprav.FieldByName('name_kat').AsString);
            cobKoshel.ItemIndex := cobKoshel.Items.IndexOf(FieldByName('koshel').AsString);
            eKoment.Text := FieldByName('comment').AsString;
            eKol.Text := FieldByName('kol').AsString;
          end
      else
        with dmCash.adoqVirtual do
          begin
            deDate.Text := FieldByName('date_v').AsString;
            ceSumma.Text := FloatToStr(Abs(FieldByName('sum_d').AsFloat / FieldByName('kol').AsInteger));
            if dmCash.adoqSprav.FieldByName('d_r').Value = true then
              cobKateg.ItemIndex := cobKateg.Items.IndexOf('+' + dmCash.adoqSprav.FieldByName('name_kat').AsString)
            else
              cobKateg.ItemIndex := cobKateg.Items.IndexOf('-' + dmCash.adoqSprav.FieldByName('name_kat').AsString);
            cobKoshel.ItemIndex := cobKoshel.Items.IndexOf(FieldByName('koshel').AsString);
            eKoment.Text := FieldByName('comment').AsString;
            eKol.Text := FieldByName('kol').AsString;
          end;
    end;

end;

procedure TfCashDetail.bOKClick(Sender: TObject);
var
  iid: integer;
begin
  with dmCash do
    begin
      if fMainCash.bNew_Edit = true then
        begin
          //вставка нового
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('INSERT INTO '+name_table);
          adoqDetail.SQL.Append('(month_v,date_v, id_prod, sum_d, koshel, comment, kol)');
          adoqDetail.SQL.Append('VALUES (:m_v, :d_v, :i_p, :sm, :kos, :com, :kl)');
          adoqDetail.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
          adoqDetail.Parameters.ParamByName('d_v').Value := deDate.Date;
          adoqDetail.Parameters.ParamByName('i_p').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          if adoqSprav.Locate('id',integer(cobKateg.Items.Objects[cobKateg.ItemIndex]),[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value * StrToInt(eKol.Text)
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value * StrToInt(eKol.Text);
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
          adoqDetail.ExecSQL;

          if fMainCash.bReal_Virt = true then
            if adoqSprav.FieldByName('d_r').Value = false then
              if adoqSprav.FieldByName('lek').Value = false then
                begin
                  adoqDetail1.SQL.Text := 'SELECT * FROM real_pokup ORDER BY id DESC';
                  adoqDetail1.Open;
                  iid := adoqDetail1.FieldByName('id').AsInteger;

                  adoqDetail.SQL.Clear;
                  adoqDetail.SQL.Append('INSERT INTO status_pokup');
                  adoqDetail.SQL.Append('(date_pokup, name_pokup, id_prod, id_pokup, kol)');
                  adoqDetail.SQL.Append('VALUES (:d_p, :n_p, :i_pr, :i_pok, :kl)');
                  adoqDetail.Parameters.ParamByName('d_p').Value := deDate.Date;
                  adoqDetail.Parameters.ParamByName('n_p').Value := copy(cobKateg.Text, 2, length(cobKateg.Text));
                  adoqDetail.Parameters.ParamByName('i_pr').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
                  adoqDetail.Parameters.ParamByName('i_pok').Value := iid;
                  adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
                  adoqDetail.ExecSQL;
                end
              else
                begin
                  adoqDetail1.SQL.Text := 'SELECT * FROM real_pokup ORDER BY id DESC';
                  adoqDetail1.Open;
                  iid := adoqDetail1.FieldByName('id').AsInteger;

                  adoqDetail.SQL.Clear;
                  adoqDetail.SQL.Append('INSERT INTO spisok_lekar');
                  adoqDetail.SQL.Append('(name_lek, id_pokup, kol)');
                  adoqDetail.SQL.Append('VALUES (:n_l, :i_pok, :kl)');
                  adoqDetail.Parameters.ParamByName('n_l').Value := copy(cobKateg.Text, 2, length(cobKateg.Text));
                  adoqDetail.Parameters.ParamByName('i_pok').Value := iid;
                  adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
                  adoqDetail.ExecSQL;
                end;
          //конец вставка нового
        end
      else
        begin
          //редактирование
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('UPDATE '+name_table);
          adoqDetail.SQL.Append('SET month_v=:m_v, date_v=:d_v, id_prod=:i_p, sum_d=:sm, koshel=:kos, comment=:com, kol = :kl');
          adoqDetail.SQL.Append('WHERE id=:iid');
          adoqDetail.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
          adoqDetail.Parameters.ParamByName('d_v').Value := deDate.Date;
          adoqDetail.Parameters.ParamByName('i_p').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          if adoqSprav.Locate('id',integer(cobKateg.Items.Objects[cobKateg.ItemIndex]),[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value * StrToInt(eKol.Text)
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value * StrToInt(eKol.Text);
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          if fMainCash.bReal_Virt = true then
            adoqDetail.Parameters.ParamByName('iid').Value := adoqReal.FieldByName('id').Value
          else
            adoqDetail.Parameters.ParamByName('iid').Value := adoqVirtual.FieldByName('id').Value;
          adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
          adoqDetail.ExecSQL;

          if fMainCash.bReal_Virt = true then
            if adoqSprav.FieldByName('d_r').Value = false then
              if adoqSprav.FieldByName('lek').Value = false then
                begin
                  adoqDetail.SQL.Clear;
                  adoqDetail.SQL.Append('UPDATE status_pokup SET');
                  adoqDetail.SQL.Append('date_pokup = :d_p, name_pokup = :n_p, id_prod = :i_pr, kol = :kl');
                  adoqDetail.SQL.Append('WHERE id_pokup = :i_pok');
                  adoqDetail.Parameters.ParamByName('d_p').Value := deDate.Date;
                  adoqDetail.Parameters.ParamByName('n_p').Value := copy(cobKateg.Text, 2, length(cobKateg.Text));
                  adoqDetail.Parameters.ParamByName('i_pr').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
                  adoqDetail.Parameters.ParamByName('i_pok').Value := adoqReal.FieldByName('id').Value;
                  adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
                  adoqDetail.ExecSQL;
                end
              else
                begin
                  adoqDetail1.SQL.Text := 'SELECT * FROM real_pokup ORDER BY id DESC';
                  adoqDetail1.Open;
                  iid := adoqDetail1.FieldByName('id').AsInteger;

                  adoqDetail.SQL.Clear;
                  adoqDetail.SQL.Append('UPDATE spisok_lekar SET');
                  adoqDetail.SQL.Append('name_lek = :n_l, kol = :kl');
                  adoqDetail.SQL.Append('WHERE id_pokup = :i_pok');
                  adoqDetail.Parameters.ParamByName('n_l').Value := copy(cobKateg.Text, 2, length(cobKateg.Text));
                  adoqDetail.Parameters.ParamByName('i_pok').Value := adoqReal.FieldByName('id').Value;
                  adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;
                  adoqDetail.ExecSQL;
                end;
          //конец редактирования
        end;
    end;
  fMainCash.OutData;
  fMainCash.SummaDate;
  Close;
end;

end.
