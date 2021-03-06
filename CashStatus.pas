unit CashStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, StdCtrls, Mask, ToolEdit, ComCtrls,
  VirtualTrees, Buttons;

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
    sStatus: TSplitter;
    sbAddSpisok: TSpeedButton;
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
    procedure vsgStatusNodeClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditYN(y_n: boolean);
    procedure sbAddSpisokClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // ��������� ������ ����
  RvtWinfo = record
    ID: integer;
    tname: string;
    pID: integer;
  end;

  // ��������� �� ��������� ������ ����
  PvtWinfo = ^RvtWinfo;

var
  fStatus: TfStatus;

implementation

uses CashDM, CachMain, CashDetail;

{$R *.dfm}

procedure TfStatus.FormShow(Sender: TObject);
begin
  LoadTable;

  LoadData('WHERE f_show = false and the_end = false');

  dbgStatus.EvenRowColor := RGB(214,254,252); //���� ���� �������
  dbgStatus.OddRowColor := RGB(254,254,214);  //���� ���� ������

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
      if deDatePokup.Text <> '  .  .    ' then
        if s = '' then
          s := s + 'date_pokup = ' + #39 + deDatePokup.Text + #39
        else
          s := s + ' and date_pokup = ' + #39 + deDatePokup.Text + #39;

    if cebName.Checked then
      if cobName.Text <> '' then
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

//�������� ������ �� ������� �������
procedure TfStatus.LoadData(str: string);
begin
  with dmCash do
    begin
      adoqStatus.SQL.Clear;

      adoqStatus.SQL.Append('SELECT * FROM status_pokup');
      adoqStatus.SQL.Append(str);
      adoqStatus.SQL.Append('ORDER BY date_pokup, name_pokup ASC');

      adoqStatus.Open;
    end;
end;

procedure TfStatus.dbgStatusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmCash.adoqStatus.RecordCount > 0 then
    if Key = 13 then
      begin
        EditYN(true);

        with dmCash.adoqStatus do
          begin
            Edit;
            Post;

            if dbgStatus.SelectedIndex = 5 then
              begin
                LoadData('WHERE f_show = false');
                LoadDrevo;
              end;
          end;
      end;

  if Key = 45 then
    begin
      EditYN(true);

      with dmCash.adoqStatus do
        begin
          Insert;
          Post;
        end;
    end;

  if dmCash.adoqStatus.RecordCount > 0 then
    if key = 46 then
      if MessageDlg('�� ������� ��� ������ �������?', mtWarning, mbOkCancel, 0) = mrOk then
        begin
          dmCash.adoqStatus.Delete;
          LoadDrevo;
        end;
end;

procedure TfStatus.dbgStatusCellClick(Column: TColumnEh);
var
  DayUse: real;
begin
  if dbgStatus.SelectedIndex = 3 then
    begin
      dmCash.adoqStatus.Edit;

      if dbgStatus.SelectedField.Value = false then
        begin
          dbgStatus.SelectedIndex := dbgStatus.SelectedIndex + 1;
          dbgStatus.SelectedField.Value := Date;

          with dmCash do
            begin
              //�������, ������� ���� ��� ����������� �������
              DayUse := (adoqStatus.FieldByName('date_end').AsDateTime - adoqStatus.FieldByName('date_pokup').AsDateTime + 1);

              //���������� ��� ������ � ���������� ��������
              adoqRashod.SQL.Clear;

              adoqRashod.SQL.Append('UPDATE sprav_pokup SET day_use = :day');
              adoqRashod.SQL.Append('WHERE id = :iid');

              adoqRashod.Parameters.ParamByName('day').Value := DayUse;
              adoqRashod.Parameters.ParamByName('iid').Value := adoqStatus.FieldByName('id_prod').Value;

              adoqRashod.ExecSQL;

              //������� ������� ������ �������
              adoqSpisok.SQL.Clear;

              adoqSpisok.SQL.Append('SELECT * FROM spisok_pokup');
              adoqSpisok.SQL.Append('ORDER BY name_pokup ASC');

              adoqSpisok.Open;

              //���������, ���� � ������ ��� ���� ������ �������, �� ������ ������, ���� ���
              if adoqSpisok.Locate('name_pokup',adoqStatus.FieldByName('name_pokup').AsString,[]) = false then
                begin
                  adoqSpisok.Insert;
                  adoqSpisok.FieldByName('name_pokup').Value := adoqStatus.FieldByName('name_pokup').Value;
                  adoqSpisok.Post;
                end
              else
                if adoqSpisok.FieldByName('status').Value = true then
                  begin
                    adoqSpisok.Edit;
                    adoqSpisok.FieldByName('status').Value := false;
                    adoqSpisok.Post;
                  end;
            end;
        end;
    end;
end;

procedure TfStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EditYN(false);
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

//������ ������ �� ������
procedure TfStatus.InitNode(node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  with dmCash do
    begin
      Data := vsgStatus.GetNodeData(Node);
      Data.ID := adoqSpravoch.FieldByName('id').AsInteger;
      Data.tname := adoqSpravoch.FieldByName('name_kat').AsString;
      Data.pID := adoqSpravoch.FieldByName('id_kat').AsInteger;
    end;
end;

procedure TfStatus.FormCreate(Sender: TObject);
begin
  //��������� ������ ��� ���������
  vsgStatus.NodeDataSize := SizeOf(RvtWinfo);
end;

procedure TfStatus.LoadDrevo;
var
  iid_prod, s: string;
  prod_id: TStringList;
  index, i: integer;
  node, node1: PVirtualNode;
  Data: PvtWinfo;
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
          for i := 0 to fMainCash.id_prod[1].Count - 1 do
            if (pos(' ' + adoqStatus.FieldByName('id_prod').AsString + ',', fMainCash.id_prod[2][i]) > 0)
                OR (fMainCash.id_prod[1][i] = adoqStatus.FieldByName('id_prod').AsString) then
              prod_id.Append(fMainCash.id_prod[1][i]);

          adoqStatus.Next;
        end;

      for i := 0 to prod_id.Count - 1 do
        begin
          if iid_prod = ''  then
            iid_prod := prod_id[i]
          else
            iid_prod := iid_prod + ',' + prod_id[i];
        end;

      if iid_prod <> '' then
        begin
          adoqSpravoch.SQL.Clear;
          adoqSpravoch.SQL.Append('SELECT *');
          adoqSpravoch.SQL.Append('FROM sprav_pokup');
          adoqSpravoch.SQL.Append('WHERE sprav_pokup.id in (' + iid_prod + ')');
          adoqSpravoch.SQL.Append('ORDER BY id_kat, name_kat ASC');
          adoqSpravoch.Open;
        end;

      vsgStatus.Clear;
      vsgStatus.BeginUpdate;

      with dmCash do
        begin
          //������ ������ �� ������ ������ �� �������� �������
          while not (adoqSpravoch.EOF) do
            begin
              if adoqSpravoch.FieldByName('id_kat').Value = null then
                begin
                  node := vsgStatus.addChild(NIL);
                end
              else
                begin
                  node1 := vsgStatus.GetFirst();

                  while (node1 <> nil) do
                    begin
                      Data := vsgStatus.GetNodeData(node1);

                      if (Assigned(Data)) and (Data.ID = adoqSpravoch.FieldByName('id_kat').Value) then
                        begin
                          node := vsgStatus.addChild(node1);
                          break;
                        end;

                      node1 := vsgStatus.GetNext(node1);
                    end;
                end;

              initNode(node);
              adoqSpravoch.Next;
            end;
        end;

      vsgStatus.EndUpdate;
    end;
end;

procedure TfStatus.vsgStatusNodeClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  Data: PvtWinfo;
  index: integer;
  iid_: string;
begin
  if Assigned(vsgStatus.FocusedNode) then
    Data := vsgStatus.GetNodeData(vsgStatus.FocusedNode);

  index := fMainCash.id_prod[1].IndexOf(IntToStr(Data.ID));
  
  if index <> - 1 then
    begin
      iid_ := fMainCash.id_prod[2][index];
      delete(iid_, 1, 1);
      iid_ := iid_ + fMainCash.id_prod[1][index];
      LoadData('WHERE id_prod in(' + iid_ + ') and f_show = false');
    end;
end;

procedure TfStatus.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfStatus.EditYN(y_n: boolean);
begin
  if y_n = true then
    begin
      dbgStatus.Options := dbgStatus.Options - [dgRowSelect];
      dbgStatus.Options := dbgStatus.Options + [dgEditing];

      dbgStatus.ReadOnly := false;
      dbgStatus.Columns[0].ReadOnly := true;
      dbgStatus.Columns[1].ReadOnly := true;
      dbgStatus.Columns[2].ReadOnly := true;
    end
  else
    begin
      dbgStatus.Options := dbgStatus.Options + [dgRowSelect];
      dbgStatus.Options := dbgStatus.Options - [dgEditing];

      dbgStatus.ReadOnly := true;
    end;
end;

procedure TfStatus.sbAddSpisokClick(Sender: TObject);
begin
  fMainCash.bNew_Edit := true;
  fCashDetail.AddSQL := 'and sp_pok = true';
  fCashDetail.NewDetail;
  fCashDetail.LoadTable;
  fCashDetail.ShowModal;
  LoadData('WHERE f_show = false');
  fMainCash.VivodData;
end;

end.
