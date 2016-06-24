unit SpisokPokup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, StdCtrls, ImgList, ComCtrls,
  ToolWin, ComObj, Menus;

type
  TfSpisokPokup = class(TForm)
    pSpisok: TPanel;
    pSpisok1: TPanel;
    dbgSpisok: TDBGridEh;
    pSpisok2: TPanel;
    cebOpen: TCheckBox;
    mmSpisok: TMainMenu;
    nExcel: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure LoadData(str: string);
    procedure dbgSpisokKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cebOpenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure nExcelClick(Sender: TObject);
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
  LoadData('WHERE status = false');
  dbgSpisok.EvenRowColor := RGB(214,254,252);
  dbgSpisok.OddRowColor := RGB(254,254,214);
end;

procedure TfSpisokPokup.LoadData(str: string);
begin
  with dmCash do
    begin
      adoqSpisok.SQL.Clear;
      adoqSpisok.SQL.Append('SELECT name_pokup, status');
      adoqSpisok.SQL.Append('FROM spisok_pokup');
      adoqSpisok.SQL.Append(str);
      adoqSpisok.SQL.Append('ORDER BY name_pokup');
      adoqSpisok.Open;
    end;
end;

procedure TfSpisokPokup.dbgSpisokKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmCash.adoqSpisok.RecordCount > 0 then
    if Key = 13 then
      begin
        with dmCash.adoqSpisok do
          begin
            Edit;
            Post;
          end;
        if cebOpen.Checked = false then
          LoadData('WHERE status = false');
      end;
  if key = 45 then
    begin
      with dmCash.adoqSpisok do
        begin
          Insert;
          Post;
        end;
    end;
  if dmCash.adoqSpisok.RecordCount > 0 then
    if Key = 46 then
      if MessageDlg('�� ������� ��� ������ �������?', mtWarning, mbOkCancel, 0) = mrOk then
        dmCash.adoqSpisok.Delete;
end;

procedure TfSpisokPokup.cebOpenClick(Sender: TObject);
begin
  if cebOpen.Checked then
    LoadData('WHERE status = true')
  else
    LoadData('WHERE status = false');
    //��������� �������� �������� dbgSpisok � ����������� �� �������� ������ dbgSpisok
  dbgSpisok.Columns[0].Width := round(dbgSpisok.Width * 7 / 10) - 15;
  dbgSpisok.Columns[1].Width := round(dbgSpisok.Width * 3 / 10) - 15;
end;

procedure TfSpisokPokup.FormResize(Sender: TObject);
begin
  //��������� �������� �������� dbgSpisok � ����������� �� �������� ������ dbgSpisok
  dbgSpisok.Columns[0].Width := round(dbgSpisok.Width * 7 / 10) - 15;
  dbgSpisok.Columns[1].Width := round(dbgSpisok.Width * 3 / 10) - 15;
end;

procedure TfSpisokPokup.nExcelClick(Sender: TObject);
var DateB: TDate;
    XLApp, Sheet, Colum: Variant;
    index, i: Integer;
    str, st: string;
begin
  XLApp:=CreateOleObject('Excel.Application');
  XLApp.Visible := false;
  XLApp.Workbooks.Add(-4167);
  XLApp.Workbooks[1].WorkSheets[1].Name := '������ �������';
  Colum := XLApp.Workbooks[1].WorkSheets[1].Columns;
  Colum.Columns[1].ColumnWidth := 28.86;
  Colum.Columns[2].ColumnWidth := 11.29;
  Sheet:=XLApp.Workbooks[1].WorkSheets[1];
  XLApp.Selection.WrapText := true;
  Sheet.Cells[1, 1]:='������ �������';
  Sheet.Cells[1, 2]:='������';
  index:=2;
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[1, 2]].Select;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.HorizontalAlignment := - 4108;
  XLApp.Selection.Font.Bold := true;

  with dmCash do
    begin
      adoqSpisok.First;
      while not (adoqSpisok.Eof) do
        begin
          Sheet.Cells[index,1] := adoqSpisok.FieldByName('name_pokup').AsString;
          adoqSpisok.Next;
          inc(index);
        end;
    end;

  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[index-1, 2]].Select;
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

  ShowMessage('������ �������!');
  XLApp.Visible := true;
end;

end.
