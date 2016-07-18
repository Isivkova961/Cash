unit SpravPokup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, ComCtrls, VirtualTrees, ImgList, ExtCtrls, ToolWin, ActiveX,
  Grids, DBGrids;

type
  TfSprav = class(TForm)
    tbSprav: TToolBar;
    pSprav: TPanel;
    pSprav_but: TPanel;
    tbNew: TToolButton;
    tbDelete: TToolButton;
    tbSepar: TToolButton;
    ilSprav: TImageList;
    pcSprav: TPageControl;
    tsDohod: TTabSheet;
    tsRashod: TTabSheet;
    vstRashod: TVirtualStringTree;
    vstDohod: TVirtualStringTree;
    tbEdit: TToolButton;
    procedure LoadTable;
    procedure vstDohodGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vstRashodGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vstDohodFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vstRashodFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure InitNodeD(node: PVirtualNode);
    procedure InitNodeR(node: PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure VivodData;
    procedure FormShow(Sender: TObject);
    procedure vstDohodStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TabSheet;
    procedure tbEditClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure DeleteRow;
    procedure pcSpravChange(Sender: TObject);
    procedure vstDohodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButEnabled;
    procedure VivodKat;
    procedure vstRashodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    bDoh_Rosh, bNew_Edit: boolean;
    iid_sp, id_kat: integer;
    name_sp: string;
    id_prod: array [1..2] of TStringList;
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
  fSprav: TfSprav;

implementation

uses CashDM, SpravNE, CachMain;

{$R *.dfm}

procedure TfSprav.LoadTable;
begin
  with dmCash do
    begin
      adoqDohod.SQL.Clear;

      adoqDohod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqDohod.SQL.Append('WHERE d_r = true');
      adoqDohod.SQL.Append('ORDER BY id_kat, name_kat ASC');

      adoqDohod.Open;

      adoqRashod.SQL.Clear;

      adoqRashod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqRashod.SQL.Append('WHERE d_r = false');
      adoqRashod.SQL.Append('ORDER BY id_kat, name_kat ASC');

      adoqRashod.Open;
    end;
end;

procedure TfSprav.vstDohodGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
    CellText := Data.tname;
end;

procedure TfSprav.vstRashodGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
    CellText := Data.tname;
end;

procedure TfSprav.vstDohodFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
     Finalize(Data^);
end;

procedure TfSprav.vstRashodFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
     Finalize(Data^);
end;

procedure TfSprav.InitNodeD(node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  with dmCash do
    begin
      Data := vstDohod.GetNodeData(Node);
      Data.ID := adoqDohod.FieldByName('id').AsInteger;
      Data.tname := adoqDohod.FieldByName('name_kat').AsString;
      Data.pID := adoqDohod.FieldByName('id_kat').AsInteger;
    end;
end;

procedure TfSprav.InitNodeR(node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  with dmCash do
    begin
      Data := vstRashod.GetNodeData(Node);
      Data.ID := adoqRashod.FieldByName('id').AsInteger;
      Data.tname := adoqRashod.FieldByName('name_kat').AsString;
      Data.pID := adoqRashod.FieldByName('id_kat').AsInteger;
    end;
end;

procedure TfSprav.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //выделение пам€ти под структуру
  vstDohod.NodeDataSize := SizeOf(RvtWinfo);
  //выделение пам€ти под структуру
  vstRashod.NodeDataSize := SizeOf(RvtWinfo);

  for i := 1 to 2 do
    id_prod[i] := TStringList.Create;
end;

//создание дерева
procedure TfSprav.VivodData;
var
  node,node1: PVirtualNode;
  Data: PvtWinfo;
begin
  vstDohod.Clear;
  vstDohod.BeginUpdate;

  with dmCash do
    begin
      adoqDohod.First;

      //—троим дерево на основе данных из итоговой таблицы
      while not (adoqDohod.EOF) do
        begin
          if adoqDohod.FieldByName('id_kat').Value = null then
            begin
              node := vstDohod.addChild(NIL);
            end
          else
            begin
              node1 := vstDohod.GetFirst();

              while (node1 <> nil) do
                begin
                  Data := vstDohod.GetNodeData(node1);

                  if (Assigned(Data)) and (Data.ID = adoqDohod.FieldByName('id_kat').Value) then
                    begin
                      node := vstDohod.addChild(node1);
                      break;
                    end;

                  node1 := vstDohod.GetNext(node1);
                end;
            end;

          initNodeD(node);
          adoqDohod.Next;
        end;
    end;

  vstDohod.EndUpdate;

  //“оже самое дл€ расходов
  vstRashod.Clear;
  vstRashod.BeginUpdate;

  with dmCash do
    begin
      adoqRashod.First;

      //—троим дерево на основе данных из итоговой таблицы
      while not (adoqRashod.EOF) do
        begin
          if adoqRashod.FieldByName('id_kat').Value = null then
            begin
              node := vstRashod.addChild(NIL);
            end
          else
            begin
              node1 := vstRashod.GetFirst();

              while (node1 <> nil) do
                begin
                  Data := vstRashod.GetNodeData(node1);

                  if (Assigned(Data)) and (Data.ID = adoqRashod.FieldByName('id_kat').Value) then
                    begin
                      node := vstRashod.addChild(node1);
                      break;
                    end;

                  node1 := vstRashod.GetNext(node1);
                end;
            end;

          initNodeR(node);
          adoqRashod.Next;
        end;
    end;

  vstRashod.EndUpdate;

  if bDoh_Rosh = true then
    vstDohod.FocusedNode := vstDohod.GetFirst()
  else
    vstRashod.FocusedNode := vstRashod.GetFirst()
end;

procedure TfSprav.FormShow(Sender: TObject);
begin
  LoadTable;
  TabSheet;
  VivodData;
  VivodKat;
end;

procedure TfSprav.vstDohodStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragObject := TDragObject.Create;
end;

procedure TfSprav.TabSheet;
begin
  if pcSprav.ActivePage = tsDohod then
    bDoh_Rosh := true
  else
    bDoh_Rosh := false;

  ButEnabled;
end;

procedure TfSprav.tbEditClick(Sender: TObject);
var
  Data: PvtWinfo;
begin
  if bDoh_Rosh = true then
    begin
      if dmCash.adoqDohod.RecordCount > 0 then
        begin
          Data := vstDohod.GetNodeData(vstDohod.FocusedNode);
          iid_sp := Data.ID;
          name_sp := Data.tname;
          id_kat := Data.pID;
        end;
    end
  else
    begin
      if dmCash.adoqRashod.RecordCount > 0 then
        begin
          Data := vstRashod.GetNodeData(vstRashod.FocusedNode);
          iid_sp := Data.ID;
          name_sp := Data.tname;
          id_kat := Data.pID;
        end;
    end;

  bNew_Edit := false;
  fSpravNE.ShowModal;

  LoadTable;
  VivodData;
  ButEnabled;
  VivodKat;
end;

procedure TfSprav.tbNewClick(Sender: TObject);
begin
  bNew_Edit := true;
  fSpravNE.ShowModal;

  LoadTable;
  VivodData;
  ButEnabled;
  VivodKat;
end;

procedure TfSprav.tbDeleteClick(Sender: TObject);
begin
  if MessageDlg('¬ы уверены что хотите удалить?', mtWarning, mbOkCancel, 0) = mrOk then
    DeleteRow;

  LoadTable;
  VivodData;
  ButEnabled;
  VivodKat;
end;

procedure TfSprav.DeleteRow;
var
  Data: PvtWinfo;
  i: integer;
  del_id: string;
begin
  if bDoh_Rosh = true then
    begin
      Data := vstDohod.GetNodeData(vstDohod.FocusedNode);
      iid_sp := Data.ID;
    end
  else
    begin
      Data := vstRashod.GetNodeData(vstRashod.FocusedNode);
      iid_sp := Data.ID;
    end;

  with dmCash do
    begin
      i := id_prod[1].IndexOf(IntToStr(iid_sp));

      if i > - 1 then
        del_id := IntToStr(iid_sp) + ',' + id_prod[2][i];

      delete(del_id, length(del_id), 1);
      adoqSpravData.SQL.Text := 'DELETE FROM sprav_pokup WHERE id in (' + del_id + ')';
      adoqSpravData.ExecSQL;
    end;
end;

procedure TfSprav.pcSpravChange(Sender: TObject);
begin
  TabSheet;
end;

procedure TfSprav.vstDohodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    tbNew.Click;

  if Key = 13 then
    if tbEdit.Enabled then
      tbEdit.Click;

  if Key = 46 then
    if tbDelete.Enabled then
      tbDelete.Click;
end;

procedure TfSprav.ButEnabled;
begin
  if pcSprav.ActivePage = tsDohod then
    begin
      if dmCash.adoqDohod.RecordCount = 0 then
        begin
          tbEdit.Enabled := false;
          tbDelete.Enabled := false;
        end
      else
        begin
          tbEdit.Enabled := true;
          tbDelete.Enabled := true;
        end;
    end
  else
    begin
      if dmCash.adoqRashod.RecordCount = 0 then
        begin
          tbEdit.Enabled := false;
          tbDelete.Enabled := false;
        end
      else
        begin
          tbEdit.Enabled := true;
          tbDelete.Enabled := true;
        end;
    end;
end;

//—бор данных о категори€х и подкатегори€х
procedure TfSprav.VivodKat;
var
  i, j: integer;
  s, s1: string;
begin
  for i := 1 to 2 do
    id_prod[i].Clear;

  with dmCash do
    begin
      adoqDrevo2.SQL.Text := 'SELECT * FROM sprav_pokup';
      adoqDrevo2.Open;

      while not (adoqDrevo2.Eof) do
        begin
          id_prod[1].Append(adoqDrevo2.FieldByName('id').AsString);
          id_prod[2].Append('');
          adoqDrevo2.Next;
        end;

      for j:=0 to id_prod[1].Count - 1 do
        begin
          adoqDrevo2.Filter := 'id_kat = ' + id_prod[1][j];
          adoqDrevo2.Filtered := true;
          adoqDrevo2.First;

          while not (adoqDrevo2.Eof) do
            begin
              s := ' ';
              id_prod[2][j] := id_prod[2][j] + s + adoqDrevo2.FieldByName('id').AsString + ',';
              adoqDrevo2.Next;
            end;

          adoqDrevo2.Filtered := false;
        end;
    end;

  j := 0;

  while j < id_prod[1].Count - 1 do
    begin
      s := id_prod[2][j];

      if s = '' then
        j := j + 1
      else
        begin
          if s <> '' then
            delete(s, 1, 1);

          while length(s) > 0 do
            begin
              if pos(', ', s) > 0 then
                s1 := copy(s, 1, pos(', ', s) - 1)
              else
                s1 := copy(s, 1, pos(',', s) - 1);

              delete(s, 1, length(s1) + 2);
              i := id_prod[1].IndexOf(s1);

              if id_prod[2][i] <> '' then
                begin
                  id_prod[2][j] := id_prod[2][j] + id_prod[2][i];

                  if s <> '' then
                    s := s + ' ';

                  s := s + copy(id_prod[2][i], 2, length(id_prod[2][i]));
                end;
            end;

          j := j + 1;
        end;
    end;
end;


procedure TfSprav.vstRashodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 45 then
    tbNew.Click;

  if Key = 13 then
    if tbEdit.Enabled then
      tbEdit.Click;
      
  if Key = 46 then
    if tbDelete.Enabled then
      tbDelete.Click;
end;

procedure TfSprav.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfSprav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMainCash.id_prod[1] := id_prod[1];
  fMainCash.id_prod[2] := id_prod[2];
end;

end.
