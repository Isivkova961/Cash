unit CachMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls, ToolWin, GridsEh, DBGridEh,
  Spin, ImgList, RXSplit, Gauges, Buttons, VirtualTrees,DateUtils, Grids,
  DBGrids,ComObj, DB;

type
  TfMainCash = class(TForm)
    mmCash: TMainMenu;
    nFile: TMenuItem;
    pButton: TPanel;
    pSpec: TPanel;
    sSpec_Month: TSplitter;
    pDataMonth: TPanel;
    pDataDay: TPanel;
    sMonth_Dat: TSplitter;
    lPrognoz: TLabel;
    pcPrognoz: TPageControl;
    tsPrognoz: TTabSheet;
    tsDiagram: TTabSheet;
    lData: TLabel;
    lDetail: TLabel;
    tbDetail: TToolBar;
    pcDetail: TPageControl;
    tsReal: TTabSheet;
    tsVirtual: TTabSheet;
    cobMonth: TComboBox;
    spGod: TSpinEdit;
    dbgReal: TDBGridEh;
    ilCash: TImageList;
    tbNew: TToolButton;
    tbEdit: TToolButton;
    tbDelete: TToolButton;
    tbCopy: TToolButton;
    ToolButton5: TToolButton;
    sbSprav: TSpeedButton;
    vtW: TVirtualStringTree;
    pmData: TPopupMenu;
    nNew: TMenuItem;
    nEdit: TMenuItem;
    nDelete: TMenuItem;
    sgData: TStringGrid;
    dbgVirtual: TDBGridEh;
    procedure vtWGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtWFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure InitNode(node:PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure VivodData;
    procedure vtWBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure LoadData;
    procedure LoadDate;
    procedure FormShow(Sender: TObject);
    procedure sgDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cobMonthChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TabSheet;
    procedure pcDetailChange(Sender: TObject);
    procedure nNewClick(Sender: TObject);
    procedure nEditClick(Sender: TObject);
    procedure OutData;
    procedure sgDataSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ButEnabled;
    procedure SummaDate;
    procedure tbDeleteClick(Sender: TObject);
    procedure DeleteRow;
    procedure nDeleteClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbEditClick(Sender: TObject);
    procedure VivodKat;
    procedure dbgRealDblClick(Sender: TObject);
    procedure dbgVirtualDblClick(Sender: TObject);
    procedure sbSpravClick(Sender: TObject);
    procedure spGodChange(Sender: TObject);
  private
    { Private declarations }
  public
    bReal_Virt,bNew_Edit: boolean;
    Date_data: string;
    { Public declarations }
  end;
  
  // ��������� ������ ����
  RvtWinfo = record
    ID: integer;
    tname: string;
    pID: integer;
    v_sum,r_sum: real;
  end;

  // ��������� �� ��������� ������ ����
  PvtWinfo = ^RvtWinfo;

var
  fMainCash: TfMainCash;
  RowCel: integer;
  id_prod: array [1..2] of TStringList;

implementation

uses CashDM, CashDetail, SpravPokup;

{$R *.dfm}

//����� �������� ��������� � ������
procedure TfMainCash.vtWGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
     begin
        case Column of
          0: CellText := Data.tname;
          1: CellText := FloatToStr(Data.r_sum)+' �� '+FloatToStr(Data.v_sum);
        end;
     end;
end;

//������������ ������
procedure TfMainCash.vtWFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
     Finalize(Data^);
end;

//������ ������ �� ������
procedure TfMainCash.InitNode(node: PVirtualNode);
var
  Data: PvtWinfo;
begin
  with dmCash do
    begin
      Data := vtW.GetNodeData(Node);
      Data.ID := adoqDrevo1.FieldByName('id').AsInteger;
      Data.tname := adoqDrevo1.FieldByName('name_kat').AsString;
      Data.pID := adoqDrevo1.FieldByName('id_kat').AsInteger;
      if adoqDrevo1.FieldByName('virtual_sum').AsFloat < 0 then
        Data.v_sum := - adoqDrevo1.FieldByName('virtual_sum').AsFloat
      else
        Data.v_sum := adoqDrevo1.FieldByName('virtual_sum').AsFloat;
      if adoqDrevo1.FieldByName('real_sum').AsFloat < 0 then
        Data.r_sum := - adoqDrevo1.FieldByName('real_sum').AsFloat
      else
        Data.r_sum := adoqDrevo1.FieldByName('real_sum').AsFloat;
    end;
end;

procedure TfMainCash.FormCreate(Sender: TObject);
begin
  //��������� ������ ��� ���������
  vtW.NodeDataSize := SizeOf(RvtWinfo);
end;

//�������� ������
procedure TfMainCash.VivodData;
var
  i: Byte;
  node,node1: PVirtualNode;
  Data: PvtWinfo;
  iid: array of integer;
  index: integer;
  Access: Variant;

  //������ � ������� ������ �� ���������� � ���������� ������ ���������� ���� �� ������ ���������
  procedure VivodTableKat;
  var
    j, k, l: integer;
    summa_r_v: array [1..5] of TStringList;  //������ ������ �� ������ � ����������
  begin
    for k := 1 to 5 do
      summa_r_v[k] := TStringList.Create;

    with dmCash do
      begin
        adoqSumRV.SQL.Text := 'SELECT * FROM summa_real';
        adoqSumRV.Open;

        adoqSprav.SQL.Text := 'SELECT * FROM sprav_pokup';
        adoqSprav.Open;

        while not (adoqSumRV.Eof) do   //���� �� ������ �� ���� �� �������� ��������
          begin
            j := 0;
            while j < id_prod[1].Count do //���� �� ������ �� ������ �� ����������� ������ �������
              begin
                if (pos(' ' + adoqSumRV.FieldByName('id').AsString + ',', id_prod[2][j]) > 0) //���� ����� �������� ���� � ������������ ����������� ������
                    or (id_prod[1][j] = adoqSumRV.FieldByName('id').AsString) then   //��� ����� �������� ����� ����������
                  begin
                    adoqSprav.Locate('id',id_prod[1][j],[]);     //������� � ����������� ���� �����
                    l := summa_r_v[1].IndexOf(adoqSprav.FieldByName('id').AsString);   //�������, ���� �� ����� �� ���������� � ������
                    if l > - 1 then
                      summa_r_v[4][l] := FloatToStr(StrToFloat(summa_r_v[4][l]) + adoqSumRV.FieldByName('real_sum').AsFloat)  //���� ����, ��
                                                                                                //��������� � ����� ������ �� ����� �� ��������
                    else
                      begin
                        summa_r_v[1].Append(adoqSprav.FieldByName('id').AsString);        //��������� ������ �� ���������� � ���� ��������
                        summa_r_v[2].Append(adoqSprav.FieldByName('name_kat').AsString);
                        summa_r_v[3].Append(adoqSprav.FieldByName('id_kat').AsString);
                        summa_r_v[4].Append(adoqSumRV.FieldByName('real_sum').AsString);
                        summa_r_v[5].Append('0');     //������ �� ���������, � �������� ����������� �� ����
                      end;
                    j := j + 1;
                  end
                else
                  j := j + 1;
              end;
            adoqSumRV.Next;
          end;

        adoqSumRV.SQL.Text := 'SELECT * FROM Summa_virtual';
        adoqSumRV.Open;

        while not (adoqSumRV.Eof) do   //���� �� ������ �� ���� �� ���������
          begin
            j := 0;
            while j < id_prod[1].Count do   //���� �� ������ �� ������ �� ����������� ������ �������
              begin
                if (pos(' ' + adoqSumRV.FieldByName('id').AsString + ',', id_prod[2][j]) > 0)   //���� ����� �������� ���� � ������������ ����������� ������
                    or (id_prod[1][j] = adoqSumRV.FieldByName('id').AsString) then  //��� ����� �������� ����� ����������
                  begin
                    adoqSprav.Locate('id',id_prod[1][j],[]);        //������� � ����������� ���� �����
                    l := summa_r_v[1].IndexOf(adoqSprav.FieldByName('id').AsString);  //�������, ���� �� ����� �� ���������� � ������
                    if l > - 1 then
                      summa_r_v[5][l] := FloatToStr(StrToFloat(summa_r_v[5][l]) + adoqSumRV.FieldByName('virtual_sum').AsFloat) //���� ����, ��
                                                                                               //��������� � ����� ������ �� ����� �� ��������
                    else
                      begin
                        summa_r_v[1].Append(adoqSprav.FieldByName('id').AsString);            //��������� ������ �� ���������� � ���� ��������
                        summa_r_v[2].Append(adoqSprav.FieldByName('name_kat').AsString);
                        summa_r_v[3].Append(adoqSprav.FieldByName('id_kat').AsString);
                        summa_r_v[4].Append('0');      //������ �� ��������, � ��������� ����������� �� ����
                        summa_r_v[5].Append(adoqSumRV.FieldByName('virtual_sum').AsString);
                      end;
                    j := j + 1;
                  end
                else
                  j := j + 1;
              end;
            adoqSumRV.Next;
          end;

        adoqDrevo.SQL.Text := 'DELETE FROM itog';    //������� ������ �� ������ �������
        adoqDrevo.ExecSQL;

        //��������� ���������� ������ � �������� �������
        for k := 0 to summa_r_v[1].Count - 1 do
          begin
            adoqDrevo.SQL.Clear;
            adoqDrevo.SQL.Append('INSERT INTO itog (id, name_kat, id_kat, real_sum, virtual_sum)');
            adoqDrevo.SQL.Append('VALUES (:iid, :n_k, :i_k, :r_s, :v_s)');
            adoqDrevo.Parameters.ParamByName('iid').Value := StrToInt(summa_r_v[1][k]);
            adoqDrevo.Parameters.ParamByName('n_k').Value := summa_r_v[2][k];
            if summa_r_v[3][k] <> '' then
              adoqDrevo.Parameters.ParamByName('i_k').Value := StrToInt(summa_r_v[3][k])
            else
              adoqDrevo.Parameters.ParamByName('i_k').Value := null;
            adoqDrevo.Parameters.ParamByName('r_s').Value := summa_r_v[4][k];
            adoqDrevo.Parameters.ParamByName('v_s').Value := summa_r_v[5][k];
            adoqDrevo.ExecSQL;
          end;
      end;
  end;
begin
  VivodTableKat;
  vtW.Clear;
  vtW.BeginUpdate;
  with dmCash do
    begin
      adoqDrevo1.SQL.Clear;
      adoqDrevo1.SQL.Text := 'SELECT * FROM itog';
      adoqDrevo1.Open;

      //������ ������ �� ������ ������ �� �������� �������
      while not (adoqDrevo1.EOF) do
      begin
        if adoqDrevo1.FieldByName('id_kat').Value = null then
          begin
            node := vtW.addChild(NIL);
          end
        else
          begin
            node1 := vtW.GetFirst();
            while (node1 <> nil) do
              begin
                Data := vtW.GetNodeData(node1);
                if (Assigned(Data)) and (Data.ID = adoqDrevo1.FieldByName('id_kat').Value) then
                  begin
                    node := vtW.addChild(node1);
                    break;
                  end;
                node1 := vtW.GetNext(node1);
              end;
          end;
        initNode(node);
        adoqDrevo1.Next;
      end;
    end;
  vtW.EndUpdate;
end;

//��������� ������� ����������
procedure TfMainCash.vtWBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  ProgressBarRect: TRect;
  Data: PvtWinfo;
  procent: real;
begin
  if Assigned(node) then
  begin
    Data := vtW.GetNodeData(node);

    if Assigned(Data) then
    begin

      // ��������-��� ������ ������ � ������� ������ �������
      if Column = 1 then
      begin
        // ������� ��������-����

        // � ��� ���� ���������� ���� ������� ����� ������ ������� ������
        // � ���������� CellRect
        // � ���� ����� ���� �� ��������� ���������� ��������������, ������� ��
        // ���� ������ �������� ��� ����� ������ ������� ������� � 1 �������

        ProgressBarRect.Left := CellRect.Left + 1; // ������ �� ���� � 1 ������� �����
        ProgressBarRect.Top := CellRect.Top + 1;   // ������ �� ���� � 1 ������� ������

        // ���������� ������ ������������� �� ������� �������:
        // ((���������� �������� ����� ����� � ������ ����� ������) / 100 * ������� �������) + ���������� ������ ����
        // � ��������� ��������� �� ��������
        if Data.r_sum = 0 then
          procent := 0
        else
        if Data.r_sum > Data.v_sum then
          procent := 100
        else
          procent := (Data.r_sum / Data.v_sum) * 100;
        ProgressBarRect.Right := round((CellRect.Right - CellRect.Left) / 100 * procent)  + CellRect.Left;
        ProgressBarRect.Bottom := CellRect.Bottom - 1; // ������ �� ���� � 1 ������� �����


        // ���� ���������� ����� ����� � ������ ������ ������������� ��������������
        // ������ 1 �������, �� ����� ������ ������ �� �������� ��� ����� ����������
        if (ProgressBarRect.Right - ProgressBarRect.Left) > 0 then
        begin
          if Data.r_sum > Data.v_sum then
            TargetCanvas.Brush.Color := RGB(255,64,69) // ���� �������� ������ �����������, ����� �������
          else
            if procent = 100 then
              TargetCanvas.Brush.Color := RGB(0,255,10)  //���� 100% ������ �������
            else
              TargetCanvas.Brush.Color := RGB(23,133,253);  //����� �����

          TargetCanvas.FillRect(ProgressBarRect);       // � ������
        end;

        // ����, ������ ��� �� ���������� �������������, ������� ������������ ������
        // ����� ������ �������� ��������-���� ������� � 1 �������.
        // ������ ������ ����� ������� ������������� ������.

        // ���� ����� ���������� �� � ���� - ��������� ���� ��������.

        inc(ProgressBarRect.Left);   // ����������� �� 1 �������� ������ �����
        inc(ProgressBarRect.Top);    // � ������
        dec(ProgressBarRect.Right);  // ��������� �� 1 ������� ������ ������
        dec(ProgressBarRect.Bottom); // � �����

        // ���� ���������� ����� ����� � ������ ������ ������������� ��������������
        // ������ 1 �������, �� ����� ������ ������ �� �������� ��� ����� ����������
        if (ProgressBarRect.Right - ProgressBarRect.Left) > 0 then
        begin
          if Data.r_sum > Data.v_sum then
            TargetCanvas.Brush.Color := RGB(255,64,69) // ���� �������� ������ �����������, ����� �������
          else
            if procent = 100 then
              TargetCanvas.Brush.Color := RGB(0,255,10)  //���� 100% ������ �������
            else
              TargetCanvas.Brush.Color := RGB(23,133,253); //����� �����

          TargetCanvas.FillRect(ProgressBarRect);
        end;
      end;
    end;
  end;
end;

//�������� ������ � �������
procedure TfMainCash.LoadData;
var
  days, WD: integer;
  i, j: integer;
  dw, month_: string;
begin
  month_ := cobMonth.Text;
  delete(month_, pos(' ', month_), length(month_));
  sgData.Cells[0,1] := '���� ������';
  sgData.Cells[1,1] := '����';
  sgData.Cells[2,1] := '�����';
  sgData.Cells[3,1] := '�������';
  sgData.Cells[4,1] := '�����';
  sgData.Cells[5,1] := '�������';
  days := DaysInMonth(StrToDate('01.' + month_ + '.' + spGod.Text));
  sgData.RowCount := days + 2;
  DateSeparator := '.';
  ShortDateFormat := 'dd/mm/yyyy';
  WD:=DayOfTheWeek(StrToDate('01.' + month_ + '.' + spGod.Text));
  Date_data := DateToStr(Date);
  RowCel := 2;
  for i := 1 to days do
    begin
      if length(IntToStr(i)) = 2 then
        sgData.Cells[1,i + 1] := IntToStr(i) + '.'+month_ + '.' + spGod.Text
      else
        sgData.Cells[1,i + 1] := '0'+IntToStr(i) + '.'+month_ + '.'+spGod.Text;
      if sgData.Cells[1,i + 1] = DateToStr(Date) then
        RowCel := i + 1;
    end;

  //������ � ������� ���� ������ � ��������
  for i := 1 to days do
    begin
      sgData.Cells[0,i + 1] := IntToStr(i);
      sgData.Cells[3,i + 1] := '0,00 ���.';
      sgData.Cells[5,i + 1] := '0,00 ���.';
      case WD of
         1: dw := '��';
         2: dw := '��';
         3: dw := '��';
         4: dw := '��';
         5: dw := '��';
         6: dw := '��';
         7: dw := '��';
      end;
      sgData.Cells[0, i + 1] := dw;
      Inc(WD);
      if WD = 8 then
        WD := 1;
    end;
end;

//�������� ���
procedure TfMainCash.LoadDate;
begin
  cobMonth.ItemIndex := MonthOf(Date) - 1; //���������� ������ � ������
  spGod.Value := YearOf(Date);             //����������� ����
end;

procedure TfMainCash.FormShow(Sender: TObject);
begin
  LoadDate; //�������� ������ � ����
  LoadData; //�������� ������ � �������
  SummaDate;//����� ���� �� �������� � ���������
  TabSheet; //����������� ����� �� ������ ����� �� ������ � ����� �������������
  sgData.Row := RowCel; //����� ��������� ������
  ButEnabled; //���������� ������ �������������� � ��������
  VivodKat; //������ ��������� � ������������ � ������
  VivodData; //����� ������
end;

//��������� ������ ������� � ������
procedure TfMainCash.sgDataDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  s: string;
begin
  //���� ������ �������� �����, �� ��� ���� ��������� � ������� �������
  if (gdSelected in State) then
    begin
      sgData.Canvas.Brush.Color := RGB(24,231,112); //���� ���� �������
      sgData.Canvas.Font.Style := [fsBold];         //����� ������
    end
  else
    begin
      if ARow > 1 then
        begin
          if (ARow mod 2 = 0) then
            sgData.Canvas.Brush.Color := RGB(214,254,252) //���� ���� �������
          else
            sgData.Canvas.Brush.Color := RGB(254,254,214);//���� ���� ������
          sgData.Canvas.Font.Style := [];                 //����� �������
        end;
    end;
    //���������
    if ARow <= 1 then
      begin
        sgData.Canvas.Font.Color := RGB(28,3,252);           //���� ������ �����
        sgData.Canvas.Font.Style := [fsBold];                //����� ������
        sgData.Canvas.Brush.Color := clGradientActiveCaption;//���� ����
      end
    else
      begin
        if (ACol = 0) then  //������ �������
          begin
            if (sgData.Cells[ACol, ARow] = '��') or (sgData.Cells[ACol, ARow] = '��') then  //���� �� ��� ��
              sgData.Canvas.Font.Color := RGB(254,78,52)  //���� ������ �������
            else
              sgData.Canvas.Font.Color := RGB(0,0,0);     //���� ������ ������
          end
        else
        if (ACol = 3) or (ACol = 5) then  //��������� � ������, ��� ��� �������
          begin
            s := sgData.Cells[ACol, ARow];
            delete(s, pos(' ', s), length(s));
            if StrToFloat(s) = 0 then
              sgData.Canvas.Font.Color := RGB(192,192,192) //���� 0, �� ���� ������ �����
            else
            if StrToFloat(s) > 0 then
              sgData.Canvas.Font.Color := RGB(28,3,252) //������ 0, �� �����
            else
              sgData.Canvas.Font.Color := RGB(254,78,52); //������ 0, �� �������
          end
        else
        if (ACol = 2) or (ACol = 4) then  //������ � �����, ��� ��� �����
          begin
            s := sgData.Cells[ACol, ARow];
            if s <> '' then
              begin
                if StrToFloat(s) >= 0 then
                  sgData.Canvas.Font.Color := RGB(28,3,252)  //������ ��� ����� 0, �� �����
                else
                  sgData.Canvas.Font.Color := RGB(254,78,52);  //������ 0, �� �������
              end;
          end
        else
          sgData.Canvas.Font.Color := RGB(0,0,0);  //������ �������, ���� ������ ������
      end;

  sgData.Canvas.Font.Name := 'Times New Roman'; //����� ������
  sgData.Canvas.Font.Size := 10;                //������ ������

  sgData.Canvas.FillRect(Rect);
  if (ACol = 1) and (ARow = 0) then
    sgData.Canvas.TextOut(Rect.Left - 10, Rect.Top + 4, '����');   //������ ������������ ������ - ����
  if (ACol = 3) and (ARow = 0) then
    sgData.Canvas.TextOut(Rect.Left - 20, Rect.Top + 4, '�������');//������ ������������ ������ - �������
  if (ACol = 5) and (ARow = 0) then
    sgData.Canvas.TextOut(Rect.Left - 20, Rect.Top + 4, '��������'); //������ ������������ ������ - ��������
  //������������ ������ � ������� �� ����������� � ��������� �� ������
  DrawText(sgData.Canvas.Handle, PChar(sgData.Cells[ACol, ARow]), Length(sgData.Cells[ACol, ARow]), Rect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
end;

procedure TfMainCash.cobMonthChange(Sender: TObject);
begin
  LoadData; //�������� ������ � �������
  sgData.Row := RowCel; //����� ���������� ������
  ButEnabled;  //���������� ������ �������������� � ��������
  SummaDate;   //����� ���� �� �������� � ���������
end;

procedure TfMainCash.FormResize(Sender: TObject);
var
  i: integer;
begin
  //��������� �������� �������� StringGrid � ����������� �� �������� ������ StringGrid
  for i := 0 to sgData.ColCount - 1 do
    if i <= 1 then
      sgData.ColWidths[i] := round(sgData.Width / 10) - 2
    else
      sgData.ColWidths[i] := round(sgData.Width / 5) - 6;
  for i := 0 to sgData.RowCount - 1 do
    sgData.RowHeights[i] := 19;
  //��������� �������� �������� dbgReal � ����������� �� �������� ������ dbgReal
  for i := 0 to dbgReal.Columns.Count - 1 do
    dbgReal.Columns[i].Width := round(dbgReal.Width / dbgReal.Columns.Count) - 6;
  //��������� �������� �������� dbgVirtual � ����������� �� �������� ������ dbgVirtual
  for i := 0 to dbgVirtual.Columns.Count - 1 do
    dbgVirtual.Columns[i].Width := round(dbgVirtual.Width / dbgVirtual.Columns.Count) - 6;
end;

//����������� ����� �� ������ ����� �� ������ � ����� �������������
procedure TfMainCash.TabSheet;
var
  i: integer;
begin
  if pcDetail.ActivePage = tsReal then
    bReal_Virt := true
  else
    bReal_Virt := false;
  //��������� �������� �������� dbgReal � ����������� �� �������� ������ dbgReal
  for i := 0 to dbgReal.Columns.Count - 1 do
    dbgReal.Columns[i].Width := round(dbgReal.Width / dbgReal.Columns.Count) - 6;
  //��������� �������� �������� dbgVirtual � ����������� �� �������� ������ dbgVirtual
  for i := 0 to dbgVirtual.Columns.Count - 1 do
    dbgVirtual.Columns[i].Width := round(dbgVirtual.Width / dbgVirtual.Columns.Count) - 6;
  ButEnabled;
end;

//��������� ���������� �����: ������� ��� ��������
procedure TfMainCash.pcDetailChange(Sender: TObject);
begin
  TabSheet;
end;

//������� � ���� ������ �����
procedure TfMainCash.nNewClick(Sender: TObject);
begin
  bNew_Edit := true;
  fCashDetail.ShowModal;
  VivodData;
end;

//������� � ���� ������ �������������
procedure TfMainCash.nEditClick(Sender: TObject);
begin
  bNew_Edit := false;
  fCashDetail.ShowModal;
  VivodData;
end;

//����� ������ �� ������ �������� � ���������
procedure TfMainCash.OutData;
begin
  with dmCash do
    begin
      //���������� ������� �������
      adoqReal.SQL.Clear;
      adoqReal.SQL.Append('SELECT real_pokup.*,name_kat');
      adoqReal.SQL.Append('FROM real_pokup,sprav_pokup');
      adoqReal.SQL.Append('WHERE real_pokup.id_prod=sprav_pokup.id AND date_v=:d_v');
      adoqReal.Parameters.ParamByName('d_v').Value:=StrToDate(Date_data);
      adoqReal.Open;
      //����� ���������� ������� �������

      //���������� ������� ��������
      adoqVirtual.SQL.Clear;
      adoqVirtual.SQL.Append('SELECT virtual_pokup.*,name_kat');
      adoqVirtual.SQL.Append('FROM virtual_pokup,sprav_pokup');
      adoqVirtual.SQL.Append('WHERE virtual_pokup.id_prod=sprav_pokup.id AND date_v=:d_v');
      adoqVirtual.Parameters.ParamByName('d_v').Value:=StrToDate(Date_data);
      adoqVirtual.Open;
      //����� ���������� ������� ��������
    end;
  ButEnabled;
end;

//��������� ����� ������ ��������
procedure TfMainCash.sgDataSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if ARow > 1 then
    if sgData.Cells[1, ARow] <> '' then
      begin
        Date_data := sgData.Cells[1, ARow];
        OutData;
      end;
end;

//���������� ������ �������������� � ��������
procedure TfMainCash.ButEnabled;
begin
  with dmCash do
    begin
      if bReal_Virt = true then
        if adoqReal.RecordCount = 0 then
          begin
            tbEdit.Enabled := false;
            tbDelete.Enabled := false;
            nEdit.Enabled := false;
            nDelete.Enabled := false;
          end
        else
          begin
            tbEdit.Enabled := true;
            tbDelete.Enabled := true;
            nEdit.Enabled := true;
            nDelete.Enabled := true;
          end
      else
        if adoqVirtual.RecordCount = 0 then
          begin
            tbEdit.Enabled := false;
            tbDelete.Enabled := false;
            nEdit.Enabled := false;
            nDelete.Enabled := false;
          end
        else
          begin
            tbEdit.Enabled := true;
            tbDelete.Enabled := true;
            nEdit.Enabled := true;
            nDelete.Enabled := true;
          end;
    end;
end;

//����� ���� �� �������� � ���������
procedure TfMainCash.SummaDate;
var
  Row_Cel, i: integer;
  summa: real;
begin
  for i := 1 to sgData.RowCount do
    begin
      sgData.Cells[2, i + 1] := '';
      sgData.Cells[4, i + 1] := '';
    end;
  //������� �� ��������
  with dmCash do
    begin
      adoqSumDate.SQL.Text:='SELECT date_v,sum(sum_d) as Date_sum FROM ' +
                            'real_pokup WHERE month_v=:m_v' +
                            ' GROUP BY date_v '+
                            'ORDER BY date_v ASC';
      adoqSumDate.Parameters.ParamByName('m_v').Value := cobMonth.Text +
                                                        ' ' + spGod.Text;
      adoqSumDate.Open;
      adoqSumDate.First;
      while not (adoqSumDate.Eof) do
        begin
          Row_Cel := DayOf(adoqSumDate.FieldByName('date_v').Value);
          sgData.Cells[2, Row_Cel + 1] := FloatToStrF(adoqSumDate.FieldByName('Date_sum').AsFloat, ffFixed, 8, 2);
          adoqSumDate.Next;
        end;
      summa := 0;
      for i := 1 to sgData.RowCount do
        begin
          if sgData.Cells[2, i + 1]<>'' then
            summa := summa + StrToFloat(sgData.Cells[2, i + 1]);
          sgData.Cells[3, i + 1] := FloatToStrF(summa, ffFixed, 8, 2)+' ���.';
        end;
    end;
  //����� ������� �� ��������

  //������� �� ���������
  with dmCash do
    begin
      adoqSumDate.SQL.Text:='SELECT date_v,sum(sum_d) as Date_sum FROM ' +
                            'virtual_pokup WHERE month_v=:m_v' +
                            ' GROUP BY date_v '+
                            'ORDER BY date_v ASC';
      adoqSumDate.Parameters.ParamByName('m_v').Value:=cobMonth.Text +
                                                      ' ' + spGod.Text;
      adoqSumDate.Open;
      adoqSumDate.First;
      while not (adoqSumDate.Eof) do
        begin
          Row_Cel := DayOf(adoqSumDate.FieldByName('date_v').Value);
          sgData.Cells[4, Row_Cel + 1] := FloatToStrF(adoqSumDate.FieldByName('Date_sum').AsFloat, ffFixed, 8, 2);
          adoqSumDate.Next;
        end;
      summa := 0;
      for i := 1 to sgData.RowCount do
        begin
          if sgData.Cells[4, i + 1]<>'' then
            summa := summa + StrToFloat(sgData.Cells[4, i + 1]);
          sgData.Cells[5, i + 1] := FloatToStrF(summa, ffFixed, 8, 2)+' ���.';
        end;
    end;
  //����� ������� �� ���������
end;

//������� �� ������ �������
procedure TfMainCash.tbDeleteClick(Sender: TObject);
begin
  if MessageDlg('�� ������� ��� ������ �������?', mtWarning, mbOkCancel, 0) = mrOk then
    DeleteRow;
  VivodData;
  SummaDate;
end;

procedure TfMainCash.DeleteRow;
begin
  with dmCash do
    begin
      if bReal_Virt = true then
        begin
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM real_pokup');
          adoqDetail.SQL.Append('WHERE id=:iid');
          adoqDetail.Parameters.ParamByName('iid').Value := adoqReal.FieldByName('id').Value;
          adoqDetail.ExecSQL;
        end
      else
        begin
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM virtual_pokup');
          adoqDetail.SQL.Append('WHERE id=:iid');
          adoqDetail.Parameters.ParamByName('iid').Value := adoqVirtual.FieldByName('id').Value;
          adoqDetail.ExecSQL;
        end;
    end;
  OutData;
end;

//������� � ���� �� ����� �������
procedure TfMainCash.nDeleteClick(Sender: TObject);
begin
  if MessageDlg('�� ������� ��� ������ �������?',mtWarning,mbOkCancel,0) = mrOk then
    DeleteRow;
  VivodData;
  SummaDate;
end;

procedure TfMainCash.tbNewClick(Sender: TObject);
begin
  bNew_Edit := true;
  fCashDetail.ShowModal;
  VivodData;
end;

procedure TfMainCash.tbEditClick(Sender: TObject);
begin
  bNew_Edit := false;
  fCashDetail.ShowModal;
  VivodData;
end;

//���� ������ � ���������� � �������������
procedure TfMainCash.VivodKat;
var
  i, j: integer;
  s, s1: string;
begin
  for i := 1 to 2 do
    id_prod[i] := TStringList.Create;

  with dmCash do
    begin
      adoqDrevo.SQL.Text:='SELECT * FROM sprav_pokup';
      adoqDrevo.Open;

      while not (adoqDrevo.Eof) do
        begin
          id_prod[1].Append(adoqDrevo.FieldByName('id').AsString);
          id_prod[2].Append('');
          adoqDrevo.Next;
        end;
      for j:=0 to id_prod[1].Count - 1 do
        begin
          adoqDrevo.Filter := 'id_kat = ' + id_prod[1][j];
          adoqDrevo.Filtered := true;
          adoqDrevo.First;
          while not (adoqDrevo.Eof) do
            begin
              s := ' ';
              id_prod[2][j] := id_prod[2][j] + s + adoqDrevo.FieldByName('id').AsString + ',';
              adoqDrevo.Next;
            end;
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

procedure TfMainCash.dbgRealDblClick(Sender: TObject);
begin
  bNew_Edit := false;
  fCashDetail.ShowModal;
  VivodData;  
end;

procedure TfMainCash.dbgVirtualDblClick(Sender: TObject);
begin
  bNew_Edit := false;
  fCashDetail.ShowModal;
  VivodData;
end;

procedure TfMainCash.sbSpravClick(Sender: TObject);
begin
  fSprav.ShowModal;
end;

procedure TfMainCash.spGodChange(Sender: TObject);
begin
  LoadData; //�������� ������ � �������
  sgData.Row := RowCel; //����� ���������� ������
  ButEnabled;  //���������� ������ �������������� � ��������
  SummaDate;   //����� ���� �� �������� � ���������
end;

end.
