unit CashZKH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, Menus, StdCtrls, ComObj;

type
  TfCashZKH = class(TForm)
    pZKH1: TPanel;
    pZKH2: TPanel;
    pZKH3: TPanel;
    dbgZKH: TDBGridEh;
    cebViewNow: TCheckBox;
    mmZKH: TMainMenu;
    nOtchet: TMenuItem;
    procedure dbgZKHKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadData;
    procedure cebViewNowClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nOtchetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditYN(y_n: boolean);
    procedure LoadRealPokup;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCashZKH: TfCashZKH;
  bNewEdit: boolean;

implementation

uses CashDM, CachMain;

{$R *.dfm}

procedure TfCashZKH.dbgZKHKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    begin
      EditYN(true);

      with dmCash.adoqZKH do
        begin
          Edit;
          Post;

          LoadRealPokup;
          bNewEdit := false;

          dbgZKH.SelectedIndex := 0;
        end;
    end;

  if dmCash.adoqZKH.RecordCount > 0 then
    if Key = 46 then
      if MessageDlg('Вы уверены что хотите удалить?', mtWarning, mbOkCancel, 0) = mrOk then
        dmCash.adoqZKH.Delete;

  if Key = 45 then
    begin
      EditYN(true);

      dmCash.adoqZKH.Insert;
      dmCash.adoqZKH.FieldByName('month_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
      bNewEdit := true;
    end;
end;

procedure TfCashZKH.LoadData;
begin
  if cebViewNow.Checked then
    begin
      with dmCash do
        begin
          adoqZKH.SQL.Clear;

          adoqZKH.SQL.Append('SELECT * FROM payment');
          adoqZKH.SQL.Append('WHERE month_v = :m_v');
          adoqZKH.SQL.Append('ORDER BY date_pay, kateg ASC');

          adoqZKH.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;

          adoqZKH.Open;
        end;
    end
  else
    begin
      with dmCash do
        begin
          adoqZKH.SQL.Text := 'SELECT * FROM payment ORDER BY date_pay, kateg ASC';
          adoqZKH.Open;
        end;
    end;
end;

procedure TfCashZKH.cebViewNowClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfCashZKH.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EditYN(false);
  fMainCash.OutData;
  fMainCash.SummaDate;
end;

procedure TfCashZKH.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfCashZKH.nOtchetClick(Sender: TObject);
var
  XLApp, Sheet, Colum: Variant;
  index: Integer;
begin
  XLApp:=CreateOleObject('Excel.Application');
  XLApp.Visible := false;
  XLApp.Workbooks.Add(-4167);
  XLApp.Workbooks[1].WorkSheets[1].Name := 'Данные по оплате ЖКХ';

  Colum := XLApp.Workbooks[1].WorkSheets[1].Columns;
  Colum.Columns[1].ColumnWidth := 15;
  Colum.Columns[2].ColumnWidth := 10;
  Colum.Columns[3].ColumnWidth := 10;
  Colum.Columns[4].ColumnWidth := 10;
  Colum.Columns[5].ColumnWidth := 10;
  Colum.Columns[6].ColumnWidth := 10;

  Sheet:=XLApp.Workbooks[1].WorkSheets[1];
  XLApp.Selection.WrapText := true;
  Sheet.Cells[1, 1]:='Категория';
  Sheet.Cells[1, 2]:='Дата оплаты';
  Sheet.Cells[1, 3]:='Предыдущие показания счетчиков';
  Sheet.Cells[1, 4]:='Новые показания счетчиков';
  Sheet.Cells[1, 5]:='Набежало';
  Sheet.Cells[1, 6]:='Сумма оплаты';

  index:=2;
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[1, 6]].Select;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.HorizontalAlignment := - 4108;
  XLApp.Selection.Font.Bold := true;

  with dmCash do
    begin
      adoqZKH.First;

      while not (adoqZKH.Eof) do
        begin
          Sheet.Cells[index, 1] := adoqZKH.FieldByName('kateg').AsString;
          Sheet.Cells[index, 2] := adoqZKH.FieldByName('date_pay').AsString;
          Sheet.Cells[index, 3] := adoqZKH.FieldByName('mean_before').AsInteger;
          Sheet.Cells[index, 4] := adoqZKH.FieldByName('mean_new').AsInteger;
          Sheet.Cells[index, 5] := adoqZKH.FieldByName('mean_new').AsInteger - adoqZKH.FieldByName('mean_before').AsInteger;
          Sheet.Cells[index, 6] := adoqZKH.FieldByName('summa').AsFloat;

          adoqZKH.Next;
          inc(index);
        end;
    end;

  Sheet.Cells[index, 5] := 'ИТОГО:';
  Sheet.Cells[index, 6].Formula := '=sum(F2:F' + IntToStr(index - 1) + ')';

  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[index, 6]].Select;
  XLApp.Selection.Borders.LineStyle := 1;
  XLApp.Selection.Borders.Weight := 2;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.Font.Size := 10;
  XLApp.Selection.Font.Name := 'Times New Roman';

  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.Orientation := 1;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.LeftMargin := 15;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.RightMargin := 15;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.TopMargin := 15;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.BottomMargin := 15;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.HeaderMargin := 15;
  XLApp.WorkBooks[1].WorkSheets[1].PageSetup.FooterMargin := 15;

  ShowMessage('Отчет готов!');
  XLApp.Visible := true;
end;

procedure TfCashZKH.FormShow(Sender: TObject);
begin
  LoadData;
  
  dbgZKH.EvenRowColor := RGB(214,254,252);
  dbgZKH.OddRowColor := RGB(254,254,214);
end;

procedure TfCashZKH.EditYN(y_n: boolean);
begin
  if y_n = true then
    begin
      dbgZKH.Options := dbgZKH.Options - [dgRowSelect];
      dbgZKH.Options := dbgZKH.Options + [dgEditing];

      dbgZKH.ReadOnly := false;
    end
  else
    begin
      dbgZKH.Options := dbgZKH.Options + [dgRowSelect];
      dbgZKH.Options := dbgZKH.Options - [dgEditing];

      dbgZKH.ReadOnly := true;
    end;
end;

procedure TfCashZKH.LoadRealPokup;
var
  kateg: string;
  iid: integer;
begin
  with dmCash do
    begin
      kateg := adoqZKH.FieldByName('kateg').AsString;

      adoqSprav.SQL.Clear;

      adoqSprav.SQL.Append('SELECT * FROM sprav_pokup WHERE d_r = false');
      adoqSprav.SQL.Append('and id_kat <> null');
      adoqSprav.SQL.Append('ORDER BY name_kat ASC');

      adoqSprav.Open;

      if adoqSprav.Locate('name_kat', kateg, []) then
        begin

          adoqDetail.SQL.Clear;
          if bNewEdit = true then
            begin
              adoqDetail.SQL.Append('INSERT INTO real_pokup');
              adoqDetail.SQL.Append('(month_v,date_v, id_prod, sum_d, koshel, comment, kol)');
              adoqDetail.SQL.Append('VALUES (:m_v, :d_v, :i_p, :sm, :kos, :com, :kl)');
            end
          else
            begin
              adoqDetail1.SQL.Text := 'SELECT * FROM real_pokup ORDER BY id DESC';
              adoqDetail1.Open;

              iid := adoqDetail1.FieldByName('id').AsInteger;

              adoqDetail.SQL.Append('UPDATE real_pokup');
              adoqDetail.SQL.Append('SET month_v=:m_v, date_v=:d_v, id_prod=:i_p, sum_d=:sm, koshel=:kos, comment=:com, kol = :kl');
              adoqDetail.SQL.Append('WHERE id=:iid');

              adoqDetail.Parameters.ParamByName('iid').Value := iid;
            end;

          adoqDetail.Parameters.ParamByName('m_v').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;
          adoqDetail.Parameters.ParamByName('d_v').Value := adoqZKH.FieldByName('date_pay').AsString;
          adoqDetail.Parameters.ParamByName('i_p').Value := adoqSprav.FieldByName('id').Value;
          adoqDetail.Parameters.ParamByName('sm').Value := - adoqZKH.FieldByName('summa').Value;
          adoqDetail.Parameters.ParamByName('kos').Value := 'З/п Иры';
          adoqDetail.Parameters.ParamByName('com').Value := 'Коммунальные услуги';
          adoqDetail.Parameters.ParamByName('kl').Value := '1';

          adoqDetail.ExecSQL;
        end;
    end;
end;

end.
