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

uses CashDM, CachMain;

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
      SQL.Text := 'SELECT * FROM sprav_pokup';
      Open;
      DisableControls;
      cobKateg.Items.BeginUpdate;
      First;
      while not Eof do
        begin
          cobKateg.Items.AddObject(FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger));
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
      cobKateg.ItemIndex := -1;
      cobKoshel.ItemIndex := -1;
      eKoment.Text := '';
    end
  else
    begin
      if fMainCash.bReal_Virt = true then
        with dmCash.adoqReal do
          begin
            deDate.Text := FieldByName('date_v').AsString;
            ceSumma.Text := FieldByName('sum_d').AsString;
            cobKateg.ItemIndex := FieldByName('id_prod').AsInteger - 1;
            cobKoshel.ItemIndex := cobKoshel.Items.IndexOf(FieldByName('koshel').AsString);
            eKoment.Text := FieldByName('comment').AsString;
          end
      else
        with dmCash.adoqVirtual do
          begin
            deDate.Text := FieldByName('date_v').AsString;
            ceSumma.Text := FieldByName('sum_d').AsString;
            cobKateg.ItemIndex := FieldByName('id_prod').AsInteger - 1;
            cobKoshel.ItemIndex := cobKoshel.Items.IndexOf(FieldByName('koshel').AsString);
            eKoment.Text := FieldByName('comment').AsString;
          end;
    end;

end;

procedure TfCashDetail.bOKClick(Sender: TObject);
begin
  with dmCash do
    begin
      if fMainCash.bNew_Edit = true then
        begin
          //вставка нового
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('INSERT INTO '+name_table);
          adoqDetail.SQL.Append('(month_v,date_v,id_prod,sum_d,koshel,comment)');
          adoqDetail.SQL.Append('VALUES (:m_v,:d_v,:i_p,:sm,:kos,:com)');
          adoqDetail.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
          adoqDetail.Parameters.ParamByName('d_v').Value := deDate.Date;
          adoqDetail.Parameters.ParamByName('i_p').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          if adoqSprav.Locate('id',integer(cobKateg.Items.Objects[cobKateg.ItemIndex]),[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value;
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          adoqDetail.ExecSQL;
          //конец вставка нового
        end
      else
        begin
          //редактирование
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('UPDATE '+name_table);
          adoqDetail.SQL.Append('SET month_v=:m_v,date_v=:d_v,id_prod=:i_p,sum_d=:sm,koshel=:kos,comment=:com');
          adoqDetail.SQL.Append('WHERE id=:iid');
          adoqDetail.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
          adoqDetail.Parameters.ParamByName('d_v').Value := deDate.Date;
          adoqDetail.Parameters.ParamByName('i_p').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          if adoqSprav.Locate('id',integer(cobKateg.Items.Objects[cobKateg.ItemIndex]),[]) then
            if adoqSprav.FieldByName('d_r').Value = true then
              adoqDetail.Parameters.ParamByName('sm').Value := ceSumma.Value
            else
              adoqDetail.Parameters.ParamByName('sm').Value := - ceSumma.Value;
          adoqDetail.Parameters.ParamByName('kos').Value := cobKoshel.Text;
          adoqDetail.Parameters.ParamByName('com').Value := eKoment.Text;
          if fMainCash.bReal_Virt = true then
            adoqDetail.Parameters.ParamByName('iid').Value := adoqReal.FieldByName('id').Value
          else
            adoqDetail.Parameters.ParamByName('iid').Value := adoqVirtual.FieldByName('id').Value;
          adoqDetail.ExecSQL;
          //конец редактирования
        end;
    end;
  fMainCash.OutData;
  fMainCash.SummaDate;
  Close;
end;

end.
