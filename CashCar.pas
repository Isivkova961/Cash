unit CashCar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, ComObj, Menus, StdCtrls, Mask,
  ToolEdit;

type
  TfCarExpen = class(TForm)
    pCar1: TPanel;
    pCar2: TPanel;
    pCar3: TPanel;
    dbgCar: TDBGridEh;
    mmCar: TMainMenu;
    nOtchet: TMenuItem;
    cebDateRep: TCheckBox;
    deDateRep: TDateEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgCarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadData;
    procedure EditYN(y_n: boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nOtchetClick(Sender: TObject);
    procedure cebDateRepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCarExpen: TfCarExpen;

implementation

uses CashDM, CachMain;

{$R *.dfm}

procedure TfCarExpen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfCarExpen.dbgCarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //если нажата клавиша Enter
  if dmCash.adoqCarExpen.RecordCount > 0 then
    if Key = 13 then
      begin
        EditYN(true);

        with dmCash do
          begin
            adoqCarExpen.Edit;  //И сохраняем их в таблицу
            adoqCarExpen.Post;
          end;
      end;

  if Key = 45 then     //если нажата клавиша Insert
    begin
      EditYN(true);

      with dmCash do
        begin
          adoqCarExpen.Insert;  //и сохраняем их в таблицу
        end;
    end;

  if dmCash.adoqCarExpen.RecordCount > 0 then
    if Key = 46 then                //Если нажата клавиша Delete
      if MessageDlg('Вы уверены что хотите удалить?', mtWarning, mbOkCancel, 0) = mrOk then
        dmCash.adoqCarExpen.Delete;
end;

//Процедура загрузки данных по ремонту
procedure TfCarExpen.LoadData;
begin
  with dmCash do
    begin
      adoqCarExpen.SQL.Clear;

      adoqCarExpen.SQL.Append('SELECT * FROM car_expen');
      adoqCarExpen.SQL.Append('ORDER BY date_rep, replaced ASC');

      adoqCarExpen.Open;
    end;

  deDateRep.Text := fMainCash.Date_data;
end;

procedure TfCarExpen.EditYN(y_n: boolean);
begin
  if y_n = true then
    begin
      dbgCar.Options := dbgCar.Options - [dgRowSelect];  //то даем возможность редактировать данные
      dbgCar.Options := dbgCar.Options + [dgEditing];

      dbgCar.ReadOnly := false;
    end
  else
    begin
      dbgCar.Options := dbgCar.Options + [dgRowSelect];  //то убираем возможность редактировать данные
      dbgCar.Options := dbgCar.Options - [dgEditing];

      dbgCar.ReadOnly := true;
    end;
end;

procedure TfCarExpen.FormShow(Sender: TObject);
begin
  LoadData;

  dbgCar.EvenRowColor := RGB(214, 254, 252); //цвет фона голубой
  dbgCar.OddRowColor := RGB(254, 254, 214);  //цвет фона желтый
end;

procedure TfCarExpen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EditYN(false);
end;

procedure TfCarExpen.nOtchetClick(Sender: TObject);
var
  XLApp, Sheet, Colum: Variant;
  index: Integer;
begin
  XLApp:=CreateOleObject('Excel.Application');
  XLApp.Visible := false;
  XLApp.Workbooks.Add(-4167);
  XLApp.Workbooks[1].WorkSheets[1].Name := 'Данные по ремонту';

  Colum := XLApp.Workbooks[1].WorkSheets[1].Columns;
  Colum.Columns[1].ColumnWidth := 28.86;
  Colum.Columns[2].ColumnWidth := 11.29;
  Colum.Columns[3].ColumnWidth := 11.29;

  Sheet := XLApp.Workbooks[1].WorkSheets[1];
  XLApp.Selection.WrapText := true;
  Sheet.Cells[1, 1]:='Заменено';
  Sheet.Cells[1, 2]:='Дата замены';
  Sheet.Cells[1, 3]:='Стоимость';
  Sheet.Cells[1, 4]:='Общая сумма по датам';

  index := 2;
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[1, 4]].Select;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.HorizontalAlignment := - 4108;
  XLApp.Selection.Font.Bold := true;

  with dmCash do
    begin
      adoqCarExpen.First;
      
      while not (adoqCarExpen.Eof) do
        begin
          Sheet.Cells[index, 1] := adoqCarExpen.FieldByName('replaced').AsString;
          Sheet.Cells[index, 2] := adoqCarExpen.FieldByName('date_rep').AsString;
          Sheet.Cells[index, 3] := adoqCarExpen.FieldByName('cost').AsFloat;
          Sheet.Cells[index, 4].Formula := '= IF(B' + IntToStr(index) + '<>B' + IntToStr(index - 1) + ',' +
                                            ' SUMIF(B:B,B' + IntToStr(index)+',C:C),"")';

          adoqCarExpen.Next;
          inc(index);
        end;
    end;

  Sheet.Cells[index, 1] := 'ИТОГО:';
  Sheet.Cells[index, 3].Formula := '=sum(C2:C' + IntToStr(index - 1) + ')';

  XLApp.Range[XLApp.Cells[index, 1], XLApp.Cells[index, 2]].Select;
  XLApp.Selection.Merge;
  XLApp.Selection.HorizontalAlignment := -4152;

  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[index, 4]].Select;
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

  ShowMessage('Список выведен!');
  XLApp.Visible := true;

end;

procedure TfCarExpen.cebDateRepClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqCarExpen.Filter := 'date_rep = ' + QuotedStr(deDateRep.Text);
      adoqCarExpen.Filtered := cebDateRep.Checked;
    end;
end;

end.
