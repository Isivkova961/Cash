unit SpravPokup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, ComCtrls, VirtualTrees, ImgList, ExtCtrls, ToolWin, ActiveX;

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
  private
    { Private declarations }
  public
    bDoh_Rosh, bNew_Edit: boolean;
    iid_sp, id_kat: integer;
    name_sp: string;
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
  fSprav: TfSprav;

implementation

uses CashDM, SpravNE;

{$R *.dfm}

procedure TfSprav.LoadTable;
begin
  with dmCash do
    begin
      adoqDohod.SQL.Clear;
      adoqDohod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqDohod.SQL.Append('WHERE d_r = true');
      adoqDohod.Open;

      adoqRashod.SQL.Clear;
      adoqRashod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqRashod.SQL.Append('WHERE d_r = false');
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
begin
  //��������� ������ ��� ���������
  vstDohod.NodeDataSize := SizeOf(RvtWinfo);
  //��������� ������ ��� ���������
  vstRashod.NodeDataSize := SizeOf(RvtWinfo);
end;

//�������� ������
procedure TfSprav.VivodData;
var
  i: Byte;
  node,node1: PVirtualNode;
  Data: PvtWinfo;
  iid: array of integer;
  index: integer;

begin
  vstDohod.Clear;
  vstDohod.BeginUpdate;
  with dmCash do
    begin
      adoqDohod.First;
      //������ ������ �� ������ ������ �� �������� �������
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

  //���� ����� ��� ��������
  vstRashod.Clear;
  vstRashod.BeginUpdate;
  with dmCash do
    begin
      adoqRashod.First;
      //������ ������ �� ������ ������ �� �������� �������
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
end;

procedure TfSprav.FormShow(Sender: TObject);
begin
  LoadTable;
  VivodData;
  TabSheet;
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
end;

procedure TfSprav.tbEditClick(Sender: TObject);
var
  Data: PvtWinfo;
  node: PVirtualNode;
begin
  if bDoh_Rosh = true then
    begin
      Data := vstDohod.GetNodeData(vstDohod.FocusedNode);
      iid_sp := Data.ID;
      name_sp := Data.tname;
      id_kat := Data.pID;
    end
  else
    begin
      Data := vstRashod.GetNodeData(vstRashod.FocusedNode);
      iid_sp := Data.ID;
      name_sp := Data.tname;
      id_kat := Data.pID;
    end;
  bNew_Edit := false;
  fSpravNE.ShowModal;
  LoadTable;
  VivodData;
end;

procedure TfSprav.tbNewClick(Sender: TObject);
begin
  bNew_Edit := true;
  fSpravNE.ShowModal;
  LoadTable;
  VivodData;
end;

procedure TfSprav.tbDeleteClick(Sender: TObject);
begin
  if MessageDlg('�� ������� ��� ������ �������?', mtWarning, mbOkCancel, 0) = mrOk then
    DeleteRow;
  LoadTable;
  VivodData;
end;

procedure TfSprav.DeleteRow;
var
  Data: PvtWinfo;
  node: PVirtualNode;
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
      adoqSpravData.SQL.Text := 'DELETE FROM sprav_pokup WHERE id = :iid';
      adoqSpravData.Parameters.ParamByName('iid').Value := iid_sp;
      adoqSpravData.ExecSQL;
    end;
end;

procedure TfSprav.pcSpravChange(Sender: TObject);
begin
  TabSheet;
end;

end.
