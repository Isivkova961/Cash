unit CashDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CurrEdit, Mask, ToolEdit, ExtCtrls,DateUtils, Buttons;

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
    cobKoshel: TComboBox;
    eKoment: TEdit;
    bCancel: TButton;
    pDetail_but: TPanel;
    lKol: TLabel;
    eKol: TEdit;
    sbAdd: TSpeedButton;
    eKateg: TEdit;
    lbKateg: TListBox;
    bOK: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadTable;
    procedure FormShow(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure NewDetail;
    procedure bOKClick(Sender: TObject);
    procedure eKategChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbKategClick(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    AddSQL: string;
    { Public declarations }
  end;

var
  fCashDetail: TfCashDetail;
  name_table: string;
  index: TStringList;
  id_kateg: integer;
  bOpen: boolean;

implementation

uses CashDM, CachMain, SpravNE, SpravPokup;

{$R *.dfm}

procedure TfCashDetail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfCashDetail.LoadTable;
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

  with  dmCash.adoqSprav do
    begin
      SQL.Clear;
      SQL.Append('SELECT * FROM sprav_pokup');

      if fMainCash.bReal_Virt = true then
        begin
          SQL.Append('WHERE id_kat <> null');
          SQL.Append(AddSQL);
        end;

      SQL.Append('ORDER BY d_r, name_kat ASC');
      Open;
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
      eKateg.Text := '';
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
            eKateg.Text := dmCash.adoqSprav.FieldByName('name_kat').AsString;
            cobKoshel.ItemIndex := cobKoshel.Items.IndexOf(FieldByName('koshel').AsString);
            eKoment.Text := FieldByName('comment').AsString;
            eKol.Text := FieldByName('kol').AsString;
          end
      else
        with dmCash.adoqVirtual do
          begin
            deDate.Text := FieldByName('date_v').AsString;
            ceSumma.Text := FloatToStr(Abs(FieldByName('sum_d').AsFloat / FieldByName('kol').AsInteger));
            eKateg.Text := dmCash.adoqSprav.FieldByName('name_kat').AsString;
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
          adoqDetail.Parameters.ParamByName('i_p').Value := id_kateg;
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;

          if adoqSprav.Locate('id',id_kateg,[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value * StrToInt(eKol.Text)
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value * StrToInt(eKol.Text);

          adoqDetail.ExecSQL;

          if fMainCash.bReal_Virt = true then
            if adoqSprav.FieldByName('d_r').Value = false then
              if adoqSprav.FieldByName('lek').Value = false then
                begin
                  if adoqSprav.FieldByName('sp_pok').Value = true then
                    begin
                      adoqDetail1.SQL.Text := 'SELECT * FROM real_pokup ORDER BY id DESC';
                      adoqDetail1.Open;
                      iid := adoqDetail1.FieldByName('id').AsInteger;

                      adoqDetail.SQL.Clear;

                      adoqDetail.SQL.Append('INSERT INTO status_pokup');
                      adoqDetail.SQL.Append('(date_pokup, name_pokup, id_prod, id_pokup, kol)');
                      adoqDetail.SQL.Append('VALUES (:d_p, :n_p, :i_pr, :i_pok, :kl)');

                      adoqDetail.Parameters.ParamByName('d_p').Value := deDate.Date;
                      adoqDetail.Parameters.ParamByName('n_p').Value := eKateg.Text;
                      adoqDetail.Parameters.ParamByName('i_pr').Value := id_kateg;
                      adoqDetail.Parameters.ParamByName('i_pok').Value := iid;
                      adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;

                      adoqDetail.ExecSQL;
                    end;
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

                  adoqDetail.Parameters.ParamByName('n_l').Value := eKateg.Text;
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
          adoqDetail.Parameters.ParamByName('i_p').Value := id_kateg;
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;

          if adoqSprav.Locate('id',id_kateg,[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value * StrToInt(eKol.Text)
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value * StrToInt(eKol.Text);

          if fMainCash.bReal_Virt = true then
            adoqDetail.Parameters.ParamByName('iid').Value := adoqReal.FieldByName('id').Value
          else
            adoqDetail.Parameters.ParamByName('iid').Value := adoqVirtual.FieldByName('id').Value;

          adoqDetail.ExecSQL;

          if fMainCash.bReal_Virt = true then
            if adoqSprav.FieldByName('d_r').Value = false then
              if adoqSprav.FieldByName('lek').Value = false then
                begin
                  if adoqSprav.FieldByName('sp_pok').Value = true then
                    begin
                      adoqDetail.SQL.Clear;
                      adoqDetail.SQL.Append('UPDATE status_pokup SET');
                      adoqDetail.SQL.Append('date_pokup = :d_p, name_pokup = :n_p, id_prod = :i_pr, kol = :kl');
                      adoqDetail.SQL.Append('WHERE id_pokup = :i_pok');

                      adoqDetail.Parameters.ParamByName('d_p').Value := deDate.Date;
                      adoqDetail.Parameters.ParamByName('n_p').Value := eKateg.Text;
                      adoqDetail.Parameters.ParamByName('i_pr').Value := id_kateg;
                      adoqDetail.Parameters.ParamByName('i_pok').Value := adoqReal.FieldByName('id').Value;
                      adoqDetail.Parameters.ParamByName('kl').Value := eKol.Text;

                      adoqDetail.ExecSQL;
                    end;
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

                  adoqDetail.Parameters.ParamByName('n_l').Value := eKateg.Text;
                  adoqDetail.Parameters.ParamByName('i_pok').Value := iid;
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

procedure TfCashDetail.eKategChange(Sender: TObject);
begin
  with dmCash do
    begin
      if length(eKateg.Text) > 2 then
        begin
          adoqSprav.Filter := 'name_kat LIKE ''*' + eKateg.Text +'*''';
          adoqSprav.Filtered := true;

          if adoqSprav.RecordCount > 0 then
            begin
              lbKateg.Clear;
              index.Clear;

              adoqSprav.First;

              while not (adoqSprav.Eof) do
                begin
                  lbKateg.Items.Append(adoqSprav.FieldByName('name_kat').AsString);
                  index.Append(adoqSprav.FieldByName('id').AsString);

                  adoqSprav.Next;
                end;

              if lbKateg.Count <= 5 then
                lbKateg.Height := 20 * lbKateg.Count
              else
                lbKateg.Height := 110;

              lbKateg.Visible := true;
            end
          else
            lbKateg.Visible := false;
        end
      else
        begin
          lbKateg.Visible := false;
          adoqSprav.Filtered := false;
        end;
    end;
end;

procedure TfCashDetail.FormCreate(Sender: TObject);
begin
  index := TStringList.Create;
end;

procedure TfCashDetail.FormDestroy(Sender: TObject);
begin
  index.Free;
end;

procedure TfCashDetail.lbKategClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqSprav.Filtered := false;

      id_kateg := StrToInt(index[lbKateg.ItemIndex]);
      eKateg.Text := lbKateg.Items[lbKateg.ItemIndex];
      
      adoqSprav.Filtered := false;
      lbKateg.Visible := false;
    end;
end;

procedure TfCashDetail.sbAddClick(Sender: TObject);
begin
  fSprav.ShowModal;
end;

end.
