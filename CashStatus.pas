unit CashStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, StdCtrls, Mask, ToolEdit, ComCtrls,
  VirtualTrees;

type
  TfStatus = class(TForm)
    pStatus: TPanel;
    pStatus1: TPanel;
    cebDatePokup: TCheckBox;
    deDatePokup: TDateEdit;
    cebStatus: TCheckBox;
    cebYesStatus: TCheckBox;
    cebOpen: TCheckBox;
    cebName: TCheckBox;
    cobName: TComboBox;
    pData: TPanel;
    dbgStatus: TDBGridEh;
    vsgStatus: TVirtualStringTree;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure LoadTable;
    procedure cobNameChange(Sender: TObject);
    procedure FilterBase;
    procedure deDatePokupChange(Sender: TObject);
    procedure cebYesStatusClick(Sender: TObject);
    procedure cebDatePokupClick(Sender: TObject);
    procedure cebNameClick(Sender: TObject);
    procedure cebOpenClick(Sender: TObject);
    procedure cebStatusClick(Sender: TObject);
    procedure LoadData(str: string);
    procedure dbgStatusKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgStatusCellClick(Column: TColumnEh);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vsgStatusGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vsgStatusFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure InitNode(node: PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure LoadDrevo;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // структура даннах узла
  RvtWinfo = record
    ID: integer;
    tname: string;
    pID: integer;
  end;

  // указатель на структуру данных узла
  PvtWinfo = ^RvtWinfo;

var
  fStatus: TfStatus;

implementation

uses CashDM, CachMain;

{$R *.dfm}

procedure TfStatus.FormShow(Sender: TObject);
begin
  LoadTable;
  LoadData('WHERE f_show = false and the_end = false');
  dbgStatus.EvenRowColor := RGB(214,254,252); //цвет фона голубой
  dbgStatus.OddRowColor := RGB(254,254,214);  //цвет фона желтый
  LoadDrevo;
end;

procedure TfStatus.LoadTable;
begin
  with dmCash do
    begin
      adoqRashod.SQL.Clear;
      adoqRashod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqRashod.SQL.Append('WHERE d_r = false');
      adoqRashod.SQL.Append('ORDER BY name_kat ASC');
      adoqRashod.Open;
    end;
  cobName.Clear;
  with dmCash.adoqRashod do
    begin
      DisableControls;
      cobName.Items.BeginUpdate;
      First;
      while not Eof do
        begin
          cobName.Items.Add(FieldByName('name_kat').AsString);
          Next;
        end;
      cobName.Items.EndUpdate;
      EnableControls;
    end;
end;

procedure TfStatus.cobNameChange(Sender: TObject);
begin
  if cobName.Text <> '' then
    cebName.Checked := true;
  FilterBase;
end;

procedure TfStatus.deDatePokupChange(Sender: TObject);
begin
  if pos(' ', deDatePokup.Text) = 0 then
    cebDatePokup.Checked := true;
  FilterBase;
end;

procedure TfStatus.cebYesStatusClick(Sender: TObject);
begin
  if cebYesStatus.Checked = true then
    cebStatus.Checked := true;
  FilterBase;
end;

procedure TfStatus.cebDatePokupClick(Sender: TObject);
begin
  if cebDatePokup.Checked = false then
    deDatePokup.Text := '';
  FilterBase;
end;

procedure TfStatus.cebNameClick(Sender: TObject);
begin
  if cebName.Checked = false then
    cobName.ItemIndex := - 1;
  FilterBase;
end;

procedure TfStatus.cebOpenClick(Sender: TObject);
begin
  if cebOpen.Checked then
    LoadData('')
  else
    LoadData('WHERE f_show = false');
  FilterBase;
end;

procedure TfStatus.cebStatusClick(Sender: TObject);
begin
  if cebStatus.Checked = false then
    cebYesStatus.Checked := false;
  FilterBase;
end;

procedure TfStatus.FilterBase;
var
  Filtr: string;

  procedure Filteretion(var str: string);
  var
    s, stat: string;
  begin
    if cebDatePokup.Checked then
      if s = '' then
        s := s + 'date_pokup = ' + #39 + deDatePokup.Text + #39
      else
        s := s + ' and date_pokup = ' + #39 + deDatePokup.Text + #39;
    if cebName.Checked then
      if s = '' then
        s := s + 'name_pokup = ' + #39 + cobName.Text + #39
      else
        s := s + ' and name_pokup = ' + #39 + cobName.Text + #39;
    if cebYesStatus.Checked then
      stat := 'true'
    else
      stat := 'false';
    if cebStatus.Checked then
      if s = '' then
        s := s + 'the_end = ' + stat
      else
        s := s + ' and the_end = ' + stat;
    str := s;
  end;
begin
  Filteretion(Filtr);
  with dmCash do
    begin
      adoqStatus.Filter := Filtr;
      adoqStatus.Filtered := (Filtr <> '');
    end;
end;

//Загрузка данных по статусу покупок
procedure TfStatus.LoadData(str: string);
begin
  with dmCash do
    begin
      adoqStatus.SQL.Clear;
      adoqStatus.SQL.Append('SELECT * FROM status_pokup');
      adoqStatus.SQL.Append(str);
      adoqStatus.Open;
    end;
end;

procedure TfStatus.dbgStatusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmCash.adoqStatus.RecordCount > 0 then
    if Key = 13 then
      begin
        dbgStatus.Options := dbgStatus.Options - [dgRowSelect];
        dbgStatus.Options := dbgStatus.Options + [dgEditing];
        dbgStatus.ReadOnly := false;
        with dmCash.adoqStatus do
          begin
            Edit;
            Post;
            if dbgStatus.SelectedIndex = 4 then
              begin
                LoadData('WHERE f_show = false');
              end;
          end;
      end;
end;

procedure TfStatus.dbgStatusCellClick(Column: TColumnEh);
begin
  if dbgStatus.SelectedIndex = 2 then
    begin
      dmCash.adoqStatus.Edit;
      if dbgStatus.SelectedField.Value = false then
        begin
          dbgStatus.SelectedIndex := dbgStatus.SelectedIndex + 1;
          dbgStatus.SelectedField.Value := Date;
        end;
    end;
end;

procedure TfStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dbgStatus.Options := dbgStatus.Options + [dgRowSelect];
  dbgStatus.ReadOnly := true;
end;

procedure TfStatus.vsgStatusGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data.tname;
end;

procedure TfStatus.vsgStatusFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
     Finalize(Data^);
end;

//запись данных по ветвям
procedure TfStatus.InitNode(node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  with dmCash do
    begin
      Data := vsgStatus.GetNodeData(Node);
      Data.ID := adoqSprav.FieldByName('id').AsInteger;
      Data.tname := adoqSprav.FieldByName('name_kat').AsString;
      Data.pID := adoqSprav.FieldByName('id_kat').AsInteger;
    end;
end;

procedure TfStatus.FormCreate(Sender: TObject);
begin
  //выделение памяти под структуру
  vsgStatus.NodeDataSize := SizeOf(RvtWinfo);
end;

procedure TfStatus.LoadDrevo;
var
  iid_prod, s: string;
  prod_id: TStringList;
  index: integer;
begin
  prod_id := TStringList.Create;
  prod_id.Sorted := true;
  prod_id.Duplicates := dupIgnore;
  with dmCash do
    begin
      LoadData('WHERE f_show = false');
      adoqStatus.First;
      while not (adoqStatus.Eof) do
        begin
          index := fMainCash.id_prod[1].IndexOf(adoqStatus.FieldByName('id_prod').AsString);
          if index > - 1 then
            s := fMainCash.id_prod[2][index];
          while length(s) > 0 do
            begin
              prod_id.Append(copy(s, pos(' ', s) + 1, pos(',', s) - pos(' ', s) - 1));
              delete(s, pos(' ', s), pos(',',s) - pos(' ', s) + 1);
            end;
          adoqStatus.Next;
        end;
      adoqSpravoch.SQL.Clear;
      adoqSpravoch.SQL.Append('SELECT sprav_pokup.*');
      adoqSpravoch.SQL.Append('FROM sprav_pokup LEFT JOIN status_pokup');
      adoqSpravoch.SQL.Append('ON sprav_pokup.id = status_pokup.id');
      adoqSpravoch.SQL.Append('WHERE sprav_pokup.id in ('+iid_prod+')');
    end;
end;

end.
