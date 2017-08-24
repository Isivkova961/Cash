unit CachMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, StdCtrls, ToolWin, GridsEh, DBGridEh,
  Spin, ImgList, RXSplit, Gauges, Buttons, VirtualTrees,DateUtils, Grids,
  DBGrids, ComObj, DB, TeEngine, Series, TeeProcs, Chart, DbChart, ADODB,
  sSkinManager;

type
  TfMainCash = class(TForm)
    mmCash: TMainMenu;
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
    nStatus: TMenuItem;
    nPokup: TMenuItem;
    nLekar: TMenuItem;
    sbLekar: TSpeedButton;
    sbStatus: TSpeedButton;
    sbSpisokPokup: TSpeedButton;
    nBludo: TMenuItem;
    sbSpisokBlud: TSpeedButton;
    cVirtual: TDBChart;
    Series1: TPieSeries;
    DBChart1: TDBChart;
    Series2: TPieSeries;
    nOtchet: TMenuItem;
    nMonthV: TMenuItem;
    nMonthR: TMenuItem;
    nViewSpisok: TMenuItem;
    nOtchetKoshel: TMenuItem;
    nEvent: TMenuItem;
    nPayMent: TMenuItem;
    nCopyDate: TMenuItem;
    nGoal: TMenuItem;
    nCarExpen: TMenuItem;
    nYearR: TMenuItem;
    nFile: TMenuItem;
    nImportData: TMenuItem;
    nExportData: TMenuItem;
    skCash: TsSkinManager;
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
    procedure nStatusClick(Sender: TObject);
    procedure nPokupClick(Sender: TObject);
    procedure nLekarClick(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbSpisokPokupClick(Sender: TObject);
    procedure sbLekarClick(Sender: TObject);
    procedure TestData;
    procedure nBludoClick(Sender: TObject);
    procedure sbSpisokBludClick(Sender: TObject);
    procedure LoadDiagram;
    procedure nMonthVClick(Sender: TObject);
    procedure VivodExcel(str: string);
    procedure nMonthRClick(Sender: TObject);
    procedure nOtchetKoshelClick(Sender: TObject);
    procedure ExcelOthet;
    procedure nEventClick(Sender: TObject);
    procedure nPayMentClick(Sender: TObject);
    procedure tbCopyClick(Sender: TObject);
    procedure nCopyDateClick(Sender: TObject);
    procedure nGoalClick(Sender: TObject);
    procedure nCarExpenClick(Sender: TObject);
    procedure nYearRClick(Sender: TObject);
    procedure nExportDataClick(Sender: TObject);
    procedure nImportDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    bReal_Virt, bNew_Edit: boolean;
    Date_data: string;
    id_prod: array [1..2] of TStringList;
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


implementation

uses CashDM, CashDetail, SpravPokup, SpisokPokup, CashStatus, SpisokLekar,
  SpisokBlud, CashEvent, CashZKH, CashNewDate, CashGoal, CashCar,
  CashImport;

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
        //� ����������� �� ������ ������� ���������� � ������
        case Column of
          0: CellText := Data.tname;  //������ � ������ �������� ���������
          1: CellText := FloatToStr(Data.r_sum)+' �� '+FloatToStr(Data.v_sum);  //����� �������� � ����� ���������
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
  //������� ��� ������ � ����������� ������
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
var
  i: integer;
begin
  //��������� ������ ��� ���������
  vtW.NodeDataSize := SizeOf(RvtWinfo);

  for i := 1 to 2 do
    id_prod[i] := TStringList.Create;
end;

//�������� ������
procedure TfMainCash.VivodData;
var
  node,node1: PVirtualNode;
  Data: PvtWinfo;

  //������ � ������� ������ �� ���������� � ���������� ������ ���������� ���� �� ������ ���������
  procedure VivodTableKat;
  var
    j, k, l: integer;
    summa_r_v: array [1..6] of TStringList;  //������ ������ �� ������ � ����������
  begin
    for k := 1 to 6 do
      summa_r_v[k] := TStringList.Create;

    with dmCash do
      begin
        adoqSprav.SQL.Text := 'SELECT * FROM sprav_pokup';
        adoqSprav.Open;

        adoqSumRV.SQL.Text := 'SELECT * FROM summa_real WHERE month_v = :m_v';
        adoqSumRV.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
        adoqSumRV.Open;

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

                    if l > - 1 then  //���� ����, �� ��������� � ����� ������ �� ����� �� ��������
                      summa_r_v[4][l] := FloatToStr(StrToFloat(summa_r_v[4][l]) + adoqSumRV.FieldByName('real_sum').AsFloat)
                    else
                      begin
                        summa_r_v[1].Append(adoqSprav.FieldByName('id').AsString);        //��������� ������ �� ���������� � ���� ��������
                        summa_r_v[2].Append(adoqSprav.FieldByName('name_kat').AsString);
                        summa_r_v[3].Append(adoqSprav.FieldByName('id_kat').AsString);
                        summa_r_v[4].Append(adoqSumRV.FieldByName('real_sum').AsString);
                        summa_r_v[5].Append('0');     //������ �� ���������, � �������� ����������� �� ����
                        summa_r_v[6].Append(adoqSprav.FieldByName('d_r').AsString);
                      end;

                    j := j + 1;
                  end
                else
                  j := j + 1;

              end;

            adoqSumRV.Next;
          end;

        adoqSumRV.SQL.Text := 'SELECT * FROM Summa_virtual WHERE month_v = :m_v';
        adoqSumRV.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
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

                    if l > - 1 then    //���� ����, ��  ��������� � ����� ������ �� ����� �� ��������
                      summa_r_v[5][l] := FloatToStr(StrToFloat(summa_r_v[5][l]) + adoqSumRV.FieldByName('virtual_sum').AsFloat)
                    else
                      begin
                        summa_r_v[1].Append(adoqSprav.FieldByName('id').AsString);            //��������� ������ �� ���������� � ���� ��������
                        summa_r_v[2].Append(adoqSprav.FieldByName('name_kat').AsString);
                        summa_r_v[3].Append(adoqSprav.FieldByName('id_kat').AsString);
                        summa_r_v[4].Append('0');      //������ �� ��������, � ��������� ����������� �� ����
                        summa_r_v[5].Append(adoqSumRV.FieldByName('virtual_sum').AsString);
                        summa_r_v[6].Append(adoqSprav.FieldByName('d_r').AsString);
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
            adoqDrevo.SQL.Append('INSERT INTO itog (id, name_kat, id_kat, real_sum, virtual_sum, r_d)');
            adoqDrevo.SQL.Append('VALUES (:iid, :n_k, :i_k, :r_s, :v_s, :rd)');

            adoqDrevo.Parameters.ParamByName('iid').Value := StrToInt(summa_r_v[1][k]);
            adoqDrevo.Parameters.ParamByName('n_k').Value := summa_r_v[2][k];
            adoqDrevo.Parameters.ParamByName('r_s').Value := summa_r_v[4][k];
            adoqDrevo.Parameters.ParamByName('v_s').Value := summa_r_v[5][k];

            if summa_r_v[6][k] = 'True' then
              adoqDrevo.Parameters.ParamByName('rd').Value := '0'
            else
              adoqDrevo.Parameters.ParamByName('rd').Value := '1';

            if summa_r_v[3][k] <> '' then
              adoqDrevo.Parameters.ParamByName('i_k').Value := StrToInt(summa_r_v[3][k])
            else
              adoqDrevo.Parameters.ParamByName('i_k').Value := null;

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
      adoqDrevo1.SQL.Text := 'SELECT * FROM itog ORDER BY id_kat, - r_d, name_kat ASC';
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

  LoadDiagram;
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
              TargetCanvas.Brush.Color := RGB(255, 64, 69) // ���� �������� ������ �����������, ����� �������
            else
              if procent = 100 then
                TargetCanvas.Brush.Color := RGB(0, 255, 10)  //���� 100% ������ �������
              else
                TargetCanvas.Brush.Color := RGB(23, 133, 253);  //����� �����

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
              TargetCanvas.Brush.Color := RGB(255, 64, 69) // ���� �������� ������ �����������, ����� �������
            else
              if procent = 100 then
                TargetCanvas.Brush.Color := RGB(0, 255, 10)  //���� 100% ������ �������
              else
                TargetCanvas.Brush.Color := RGB(23, 133, 253); //����� �����

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
  i: integer;
  dw, month_: string;
begin
  month_ := cobMonth.Text;
  delete(month_, pos(' ', month_), length(month_));

  sgData.Cells[0, 1] := '���� ������';
  sgData.Cells[1, 1] := '����';
  sgData.Cells[2, 1] := '������';
  sgData.Cells[3, 1] := '�����';
  sgData.Cells[4, 1] := '�������';
  sgData.Cells[5, 1] := '�����';
  sgData.Cells[6, 1] := '�������';

  days := DaysInMonth(spGod.Value, StrToInt(month_));
  sgData.RowCount := days + 2;
  DateSeparator := '.';
  ShortDateFormat := 'dd/mm/yyyy';
  WD:=DayOfTheWeek(StrToDate('01.' + month_ + '.' + spGod.Text));
  Date_data := DateToStr(Date);
  RowCel := 2;

  for i := 1 to days do
    begin
      if length(IntToStr(i)) = 2 then
        sgData.Cells[1, i + 1] := IntToStr(i) + '.'+month_ + '.' + spGod.Text
      else
        sgData.Cells[1, i + 1] := '0'+IntToStr(i) + '.'+month_ + '.'+spGod.Text;

      if sgData.Cells[1, i + 1] = DateToStr(Date) then
        RowCel := i + 1;
    end;

  //������ � ������� ���� ������ � ��������
  for i := 1 to days do
    begin
      sgData.Cells[0, i + 1] := IntToStr(i);
      sgData.Cells[4, i + 1] := '0,00 ���.';
      sgData.Cells[6, i + 1] := '0,00 ���.';

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

  dbgReal.EvenRowColor := RGB(214, 254, 252);
  dbgReal.OddRowColor := RGB(254, 254, 214);

  dbgVirtual.EvenRowColor := RGB(214, 254, 252);
  dbgVirtual.OddRowColor := RGB(254, 254, 214);

  TestData; //�������� ������, ����� ��� ���� �������� �������� � ����
  LoadDiagram;  //�������� ��������
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
      sgData.Canvas.Brush.Color := RGB(24, 231, 112); //���� ���� �������
      sgData.Canvas.Font.Style := [fsBold];         //����� ������
    end
  else
    begin
      if ARow > 1 then
        begin
          if (ARow mod 2 = 0) then
            sgData.Canvas.Brush.Color := RGB(214, 254, 252) //���� ���� �������
          else
            sgData.Canvas.Brush.Color := RGB(254, 254, 214);//���� ���� ������

          sgData.Canvas.Font.Style := [];                 //����� �������
        end;
    end;

    //���������
    if ARow <= 1 then
      begin
        sgData.Canvas.Font.Color := RGB(28, 3, 252);           //���� ������ �����
        sgData.Canvas.Font.Style := [fsBold];                //����� ������
        sgData.Canvas.Brush.Color := clGradientActiveCaption;//���� ����
      end
    else
      begin
        if sgData.Cells[ACol, ARow] = DateToStr(Date) then
          sgData.Canvas.Brush.Color := RGB(153, 251, 180);

        if (ACol = 0) then  //������ �������
          begin
            if (sgData.Cells[ACol, ARow] = '��') or (sgData.Cells[ACol, ARow] = '��') then  //���� �� ��� ��
              sgData.Canvas.Font.Color := RGB(254,78,52)  //���� ������ �������
            else
              sgData.Canvas.Font.Color := RGB(0,0,0);     //���� ������ ������
          end
        else
        if (ACol = 4) or (ACol = 6) then  //����� � �������, ��� ��� �������
          begin
            s := sgData.Cells[ACol, ARow];
            delete(s, pos(' ', s), length(s));

            if StrToFloat(s) = 0 then
              sgData.Canvas.Font.Color := RGB(192, 192, 192) //���� 0, �� ���� ������ �����
            else
            if StrToFloat(s) > 0 then
              sgData.Canvas.Font.Color := RGB(28, 3, 252) //������ 0, �� �����
            else
              sgData.Canvas.Font.Color := RGB(254, 78, 52); //������ 0, �� �������
          end
        else
        if (ACol = 2) or (ACol = 5) or (ACol = 3) then  //������ � ������ � ���������, ��� ��� �����
          begin
            s := sgData.Cells[ACol, ARow];

            if s <> '' then
              begin
                if StrToFloat(s) >= 0 then
                  sgData.Canvas.Font.Color := RGB(28, 3, 252)  //������ ��� ����� 0, �� �����
                else
                  sgData.Canvas.Font.Color := RGB(254, 78, 52);  //������ 0, �� �������
              end;
          end
        else
          sgData.Canvas.Font.Color := RGB(0, 0, 0);  //������ �������, ���� ������ ������
      end;

  sgData.Canvas.Font.Name := 'Times New Roman'; //����� ������
  sgData.Canvas.Font.Size := 10;                //������ ������

  sgData.Canvas.FillRect(Rect);

  if (ACol = 1) and (ARow = 0) then
    sgData.Canvas.TextOut(Rect.Left - 10, Rect.Top + 4, '����');   //������ ������������ ������ - ����

  if (ACol = 3) and (ARow = 0) then
    sgData.Canvas.TextOut(Rect.Left + 40, Rect.Top + 4, '�������');//������ ������������ ������ - �������

  if (ACol = 6) and (ARow = 0) then
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
  VivodData;
end;

procedure TfMainCash.FormResize(Sender: TObject);
var
  i: integer;
begin
  //��������� �������� �������� StringGrid � ����������� �� �������� ������ StringGrid
  for i := 0 to sgData.ColCount - 1 do
    if i <= 1 then
      sgData.ColWidths[i] := round(sgData.Width / 12) + 4
    else
      sgData.ColWidths[i] := round(sgData.Width / 6) - 10;

  for i := 0 to sgData.RowCount - 1 do
    sgData.RowHeights[i] := 19;

  //��������� �������� �������� dbgReal � ����������� �� �������� ������ dbgReal
  for i := 0 to dbgReal.Columns.Count - 1 do
    dbgReal.Columns[i].Width := round(dbgReal.Width / dbgReal.Columns.Count) - 2;

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

      adoqReal.SQL.Append('SELECT real_pokup.*, name_kat');
      adoqReal.SQL.Append('FROM real_pokup, sprav_pokup');
      adoqReal.SQL.Append('WHERE real_pokup.id_prod = sprav_pokup.id AND date_v = :d_v');
      adoqReal.SQL.Append('ORDER BY name_kat ASC');

      adoqReal.Parameters.ParamByName('d_v').Value := StrToDate(Date_data);

      adoqReal.Open;
      //����� ���������� ������� �������

      //���������� ������� ��������
      adoqVirtual.SQL.Clear;

      adoqVirtual.SQL.Append('SELECT virtual_pokup.*, name_kat');
      adoqVirtual.SQL.Append('FROM virtual_pokup, sprav_pokup');
      adoqVirtual.SQL.Append('WHERE virtual_pokup.id_prod = sprav_pokup.id AND date_v = :d_v');
      adoqVirtual.SQL.Append('ORDER BY name_kat ASC');

      adoqVirtual.Parameters.ParamByName('d_v').Value := StrToDate(Date_data);

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
      sgData.Cells[3, i + 1] := '';
      sgData.Cells[5, i + 1] := '';
    end;

  //������� �� ��������
  with dmCash do
    begin
      for i := 1 to 2 do
        begin
          case i of
            1:  begin
                  adoqSumDate.SQL.Text:='SELECT date_v, sum(sum_d) as Date_sum FROM ' +
                                        'real_pokup WHERE month_v = :m_v and sum_d < 0 ' +
                                        'GROUP BY date_v ' +
                                        'ORDER BY date_v ASC ';
                end;
            2:  begin
                  adoqSumDate.SQL.Text:='SELECT date_v, sum(sum_d) as Date_sum FROM ' +
                                        'real_pokup WHERE month_v = :m_v and sum_d > 0 ' +
                                        'GROUP BY date_v ' +
                                        'ORDER BY date_v ASC ';
                end;
          end;

        adoqSumDate.Parameters.ParamByName('m_v').Value := cobMonth.Text +
                                                        ' ' + spGod.Text;
        adoqSumDate.Open;
        adoqSumDate.First;

        while not (adoqSumDate.Eof) do
          begin
            Row_Cel := DayOf(adoqSumDate.FieldByName('date_v').Value);

            if adoqSumDate.FieldByName('Date_sum').AsFloat < 0 then
              sgData.Cells[2, Row_Cel + 1] := FloatToStrF(adoqSumDate.FieldByName('Date_sum').AsFloat, ffFixed, 8, 2)
            else
              sgData.Cells[3, Row_Cel + 1] := FloatToStrF(adoqSumDate.FieldByName('Date_sum').AsFloat, ffFixed, 8, 2);

            adoqSumDate.Next;
          end;

        end;

      summa := 0;

      for i := 1 to sgData.RowCount do
        begin
          if sgData.Cells[2, i + 1] <> '' then
            summa := summa + StrToFloat(sgData.Cells[2, i + 1]);
          if sgData.Cells[3, i + 1] <> '' then
            summa := summa + StrToFloat(sgData.Cells[3, i + 1]);

          sgData.Cells[4, i + 1] := FloatToStrF(summa, ffFixed, 8, 2) + ' ���.';
        end;

    end;
  //����� ������� �� ��������

  //������� �� ���������
  with dmCash do
    begin
      adoqSumDate.SQL.Text:='SELECT date_v, sum(sum_d) as Date_sum FROM ' +
                            'virtual_pokup WHERE month_v = :m_v' +
                            ' GROUP BY date_v '+
                            'ORDER BY date_v ASC';
      adoqSumDate.Parameters.ParamByName('m_v').Value:=cobMonth.Text +
                                                      ' ' + spGod.Text;
      adoqSumDate.Open;
      adoqSumDate.First;

      while not (adoqSumDate.Eof) do
        begin
          Row_Cel := DayOf(adoqSumDate.FieldByName('date_v').Value);
          sgData.Cells[5, Row_Cel + 1] := FloatToStrF(adoqSumDate.FieldByName('Date_sum').AsFloat, ffFixed, 8, 2);
          adoqSumDate.Next;
        end;

      summa := 0;

      for i := 1 to sgData.RowCount do
        begin
          if sgData.Cells[5, i + 1] <> '' then
            summa := summa + StrToFloat(sgData.Cells[5, i + 1]);

          sgData.Cells[6, i + 1] := FloatToStrF(summa, ffFixed, 8, 2) + ' ���.';
        end;
    end;
  //����� ������� �� ���������
end;

//������� �� ������ �������
procedure TfMainCash.tbDeleteClick(Sender: TObject);
begin
  if MessageDlg('�� ������� ��� ������ �������?', mtWarning, mbOkCancel, 0) = mrOk then
    DeleteRow;

  VivodKat;
  VivodData;
  SummaDate;
end;

procedure TfMainCash.DeleteRow;
var
  iid: integer;
begin
  with dmCash do
    begin
      if bReal_Virt = true then
        begin
          iid := adoqReal.FieldByName('id').Value;
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM real_pokup');
          adoqDetail.SQL.Append('WHERE id = :iid');
          adoqDetail.Parameters.ParamByName('iid').Value := iid;
          adoqDetail.ExecSQL;

          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM status_pokup');
          adoqDetail.SQL.Append('WHERE id_pokup = :iid');
          adoqDetail.Parameters.ParamByName('iid').Value := iid;
          adoqDetail.ExecSQL;

          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM spisok_lekar');
          adoqDetail.SQL.Append('WHERE id_pokup = :iid');
          adoqDetail.Parameters.ParamByName('iid').Value := iid;
          adoqDetail.ExecSQL;
        end
      else
        begin
          adoqDetail.SQL.Clear;
          adoqDetail.SQL.Append('DELETE FROM virtual_pokup');
          adoqDetail.SQL.Append('WHERE id = :iid');
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
    id_prod[i].Clear;

  with dmCash do
    begin
      adoqKat.SQL.Text:='SELECT * FROM sprav_pokup';
      adoqKat.Open;

      while not (adoqKat.Eof) do
        begin
          id_prod[1].Append(adoqKat.FieldByName('id').AsString);
          id_prod[2].Append('');
          adoqKat.Next;
        end;

      for j:=0 to id_prod[1].Count - 1 do
        begin
          adoqKat.Filter := 'id_kat = ' + id_prod[1][j];
          adoqKat.Filtered := true;
          adoqKat.First;

          while not (adoqKat.Eof) do
            begin
              s := ' ';
              id_prod[2][j] := id_prod[2][j] + s + adoqKat.FieldByName('id').AsString + ',';
              adoqKat.Next;
            end;

          adoqKat.Filtered := false;
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
  VivodData;
end;

procedure TfMainCash.nStatusClick(Sender: TObject);
begin
  fStatus.ShowModal;
end;

procedure TfMainCash.nPokupClick(Sender: TObject);
begin
  fSpisokPokup.ShowModal;
end;

procedure TfMainCash.nLekarClick(Sender: TObject);
begin
  fSpisokLekar.ShowModal;
end;

procedure TfMainCash.sbStatusClick(Sender: TObject);
begin
  fStatus.ShowModal;  
end;

procedure TfMainCash.sbSpisokPokupClick(Sender: TObject);
begin
  fSpisokPokup.ShowModal;
end;

procedure TfMainCash.sbLekarClick(Sender: TObject);
begin
  fSpisokLekar.ShowModal;
end;

procedure TfMainCash.TestData;
var
  lekar, goal: string;
begin
  //����� ������ ��������, � ������� ���������� ���� ��������
  with dmCash do
    begin
      adoqLekar.SQL.Clear;
      adoqLekar.SQL.Append('SELECT * FROM spisok_lekar');
      adoqLekar.SQL.Append('WHERE f_show = false and the_end = false');
      adoqLekar.Open;

      while not (adoqLekar.Eof) do
        begin
          if (adoqLekar.FieldByName('date_srok_god').Value <= Date)
            and (adoqLekar.FieldByName('date_srok_god').Value <> null) then
            lekar := lekar + adoqLekar.FieldByName('name_lek').AsString + ' - ' +
                    adoqLekar.FieldByName('date_srok_god').AsString + #10 + #13;

          adoqLekar.Next;
        end;

      if lekar <> '' then
        begin
          lekar := '����� ���� �������� � ��������� ��������:' + #10 + #13 + lekar;
          ShowMessage(lekar);
        end;
    end;

  //����� ��������� � ������ �������
  with dmCash do
    begin
      adoqSpisok.SQL.Text := 'SELECT * FROM spisok_pokup';
      adoqSpisok.Open;

      if adoqSpisok.RecordCount > 0 then
        ShowMessage('������� ������ �������! ���������� ����������!');
    end;

  //����� �������
  with dmCash do
    begin
      adoqEvent.SQL.Text := 'SELECT * FROM event';
      adoqEvent.Open;

      while not (adoqEvent.Eof) do
        begin
          if adoqEvent.FieldByName('date_recall').Value = Date then
            ShowMessage(adoqEvent.FieldByName('message').AsString);

          if ((Date - adoqEvent.FieldByName('date_exe').Value) mod adoqEvent.FieldByName('repet').Value) = 0 then
            ShowMessage(adoqEvent.FieldByName('message').AsString);

          adoqEvent.Next;
        end;
    end;

  //����� �����
  with dmCash do
    begin
      adoqGoal.SQL.Text := 'SELECT * FROM goal ORDER BY goal ASC';
      adoqGoal.Open;

      while not (adoqGoal.Eof) do
        begin
          goal := goal + adoqGoal.FieldByName('goal').AsString + ' - ' +
                  adoqGoal.FieldByName('cost').AsString + #10 + #13;

          adoqGoal.Next;
        end;

      if goal <> '' then
        begin
          goal := '�� ������ ������ � ��� ���� ������������� ����:' + #10 + #13 + goal;
          ShowMessage(goal);
        end;
    end;

end;

procedure TfMainCash.nBludoClick(Sender: TObject);
begin
  fSpisokBlud.ShowModal;
end;

procedure TfMainCash.sbSpisokBludClick(Sender: TObject);
begin
  fSpisokBlud.ShowModal;
end;

//��������� �������� ������ � ���������
procedure TfMainCash.LoadDiagram;
const
  clColor : array [1..17] of TColor = (clRed, clBlue, clGreen, clYellow, clMoneyGreen, clLime, clAqua, clFuchsia,
                                      clBlack, clMaroon, clOlive, clNavy, clPurple, clTeal, clGray, clSilver, clSkyBlue);
var
  i: integer;
begin
  with dmCash do
    begin
      adoqVirtualD.SQL.Clear;
      adoqVirtualD.SQL.Append('SELECT name_kat, virtual_sum FROM itog');
      adoqVirtualD.SQL.Append('WHERE virtual_sum < 0 and id_kat is null');
      adoqVirtualD.Open;

      adoqVirtualD.Active := true;
      Series1.Clear;
      i := 1;

      while not (adoqVirtualD.Eof) do
        begin
          Series1.Add(- adoqVirtualD.FieldByName('virtual_sum').Value, adoqVirtualD.FieldByName('name_kat').AsString, clColor[i]);
          adoqVirtualD.Next;
          inc(i);
        end;

      adoqRealD.SQL.Clear;
      adoqRealD.SQL.Append('SELECT name_kat, real_sum FROM itog');
      adoqRealD.SQL.Append('WHERE real_sum < 0 and id_kat is null');
      adoqRealD.Open;

      adoqRealD.Active := true;
      Series2.Clear;
      i := 1;

      while not (adoqRealD.Eof) do
        begin
          Series2.Add(- adoqRealD.FieldByName('real_sum').Value, adoqRealD.FieldByName('name_kat').AsString, clColor[i]);
          adoqRealD.Next;
          inc(i);
        end;
    end;
end;

procedure TfMainCash.nMonthVClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqOtchet.SQL.Clear;
      adoqOtchet.SQL.Append('SELECT virtual_pokup.*, name_kat FROM virtual_pokup, sprav_pokup');
      adoqOtchet.SQL.Append('WHERE month_v = :m_v and sprav_pokup.id = virtual_pokup.id_prod');
      adoqOtchet.SQL.Append('ORDER BY date_v ASC');
      adoqOtchet.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
      adoqOtchet.Open;
    end;

  VivodExcel('�������� �� ' + cobMonth.Text + ' ' + spGod.Text);
end;

procedure TfMainCash.VivodExcel(str: string);
var
    XLApp, Sheet, Colum: Variant;
    index: Integer;
begin
  XLApp:=CreateOleObject('Excel.Application');
  XLApp.Visible := false;
  XLApp.Workbooks.Add(-4167);
  XLApp.Workbooks[1].WorkSheets[1].Name := str;

  Colum := XLApp.Workbooks[1].WorkSheets[1].Columns;
  Colum.Columns[1].ColumnWidth := 9;
  Colum.Columns[2].ColumnWidth := 15;
  Colum.Columns[3].ColumnWidth := 11.29;
  Colum.Columns[4].ColumnWidth := 11.29;
  Colum.Columns[5].ColumnWidth := 11.29;
  Colum.Columns[6].ColumnWidth := 11.29;

  Sheet:=XLApp.Workbooks[1].WorkSheets[1];
  XLApp.Selection.WrapText := true;
  Sheet.Cells[1, 1] := '����';
  Sheet.Cells[1, 2] := '������������';
  Sheet.Cells[1, 3] := '����������';
  Sheet.Cells[1, 4] := '�����';
  Sheet.Cells[1, 5] := '�������';
  Sheet.Cells[1, 6] := '�����������';
  Sheet.Cells[1, 7] := '����� �� ���� �� ��������';

  index:=2;
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[1, 7]].Select;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.HorizontalAlignment := - 4108;
  XLApp.Selection.Font.Bold := true;

  with dmCash do
    begin
      adoqOtchet.First;

      while not (adoqOtchet.Eof) do
        begin
          Sheet.Cells[index, 1] := adoqOtchet.FieldByName('date_v').AsString;
          Sheet.Cells[index, 2] := adoqOtchet.FieldByName('name_kat').AsString;
          Sheet.Cells[index, 3] := adoqOtchet.FieldByName('kol').AsString;
          Sheet.Cells[index, 4] := adoqOtchet.FieldByName('sum_d').AsFloat;
          Sheet.Cells[index, 5] := adoqOtchet.FieldByName('koshel').AsString;
          Sheet.Cells[index, 6] := adoqOtchet.FieldByName('comment').AsString;
          Sheet.Cells[index, 7].Formula := '=IF(A' + IntToStr(index) + '<>A' + IntToStr(index - 1) + ',' +
                                            'SUMIFS(D:D,A:A,A' + IntToStr(index) + ',E:E,E' + IntToStr(index) + '),' +
                                            'IF(E' + IntToStr(index) + '<>E' + IntToStr(index - 1) + ',' +
                                            'SUMIFS(D:D,A:A,A' + IntToStr(index) + ',E:E,E' + IntToStr(index) + '),' +
                                            '""))';
          adoqOtchet.Next;
          inc(index);
        end;
    end;

  Sheet.Cells[index, 3] := '�����:';
  Sheet.Cells[index, 4].Formula := '=sum(D2:D' + IntToStr(index - 1) + ')';

  XLApp.Range[XLApp.Cells[index, 1], XLApp.Cells[index, 3]].Select;
  XLApp.Selection.Merge;
  XLApp.Selection.HorizontalAlignment := -4152;

  inc(index);
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[index - 1, 7]].Select;
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

  ShowMessage('����� �����!');
  XLApp.Visible := true;
end;

procedure TfMainCash.nMonthRClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqOtchet.SQL.Clear;
      adoqOtchet.SQL.Append('SELECT real_pokup.*, name_kat FROM real_pokup, sprav_pokup');
      adoqOtchet.SQL.Append('WHERE month_v = :m_v and sprav_pokup.id = real_pokup.id_prod');
      adoqOtchet.SQL.Append('ORDER BY date_v, koshel, name_kat ASC');
      adoqOtchet.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
      adoqOtchet.Open;
    end;

  VivodExcel('������� �� ' + cobMonth.Text + ' ' + spGod.Text);
end;

procedure TfMainCash.nOtchetKoshelClick(Sender: TObject);
begin
  ExcelOthet;
end;

procedure TfMainCash.ExcelOthet;
var
    XLApp, Sheet, Colum: Variant;
    index: Integer;
begin
  XLApp:=CreateOleObject('Excel.Application');
  XLApp.Visible := false;
  XLApp.Workbooks.Add(-4167);
  XLApp.Workbooks[1].WorkSheets[1].Name := '������ �� ' + cobMonth.Text + ' ' + spGod.Text;

  Colum := XLApp.Workbooks[1].WorkSheets[1].Columns;
  Colum.Columns[1].ColumnWidth := 15;
  Colum.Columns[2].ColumnWidth := 9;

  Sheet:=XLApp.Workbooks[1].WorkSheets[1];
  XLApp.Selection.WrapText := true;
  Sheet.Cells[1, 1] := '�������';
  Sheet.Cells[1, 2] := '������';

  index:=2;
  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[1, 2]].Select;
  XLApp.Selection.WrapText := true;
  XLApp.Selection.HorizontalAlignment := - 4108;
  XLApp.Selection.Font.Bold := true;

  with dmCash do
    begin
      adoqOtchet.SQL.Clear;
      adoqOtchet.SQL.Text := 'SELECT koshel, sum(sum_d) as Summa ' +
                              'FROM real_pokup WHERE sum_d < 0 ' +
                              'AND month_v = :m_v ' +
                              'GROUP BY koshel';
      adoqOtchet.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
      adoqOtchet.Open;

      adoqOtchet.First;

      while not (adoqOtchet.Eof) do
        begin
          Sheet.Cells[index,1] := adoqOtchet.FieldByName('koshel').AsString;
          Sheet.Cells[index,2] := adoqOtchet.FieldByName('summa').AsFloat;
          adoqOtchet.Next;
          inc(index);
        end;
    end;

  Sheet.Cells[index, 1] := '�����:';
  Sheet.Cells[index, 2].Formula := '=sum(B2:B' + IntToStr(index - 1) + ')';

  XLApp.Range[XLApp.Cells[1, 1], XLApp.Cells[index, 2]].Select;
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

  ShowMessage('����� �����!');
  XLApp.Visible := true;
end;

procedure TfMainCash.nEventClick(Sender: TObject);
begin
  fCashEvent.ShowModal;
end;

procedure TfMainCash.nPayMentClick(Sender: TObject);
begin
  fCashZKH.ShowModal;
end;

procedure TfMainCash.tbCopyClick(Sender: TObject);
begin
  if MessageDlg('����������� ������ �� ��������� �����?', mtWarning, mbOkCancel, 0) = mrOk then
    begin
      fCashNewDate.deNewDate.Date := IncMonth(StrToDate(Date_data));
      fCashNewDate.ShowModal;
    end;
end;

procedure TfMainCash.nCopyDateClick(Sender: TObject);
begin
  if MessageDlg('����������� ������ �� ��������� ����?', mtWarning, mbOkCancel, 0) = mrOk then
    with dmCash do
      begin
        adoqCopy.SQL.Clear;
        adoqCopy.SQL.Append('INSERT INTO virtual_pokup');
        adoqCopy.SQL.Append('(month_v, date_v, id_prod, sum_d, koshel, comment, kol)');
        adoqCopy.SQL.Append('VALUES(:m_v, :d_v, :i_p, :s_d, :kos, :com, :kl)');

        adoqCopy.Parameters.ParamByName('m_v').Value := cobMonth.Text + ' ' + spGod.Text;
        adoqCopy.Parameters.ParamByName('d_v').Value := IncDay(StrToDate(Date_data));
        adoqCopy.Parameters.ParamByName('i_p').Value := adoqVirtual.FieldByName('id_prod').Value;
        adoqCopy.Parameters.ParamByName('s_d').Value := adoqVirtual.FieldByName('sum_d').Value;
        adoqCopy.Parameters.ParamByName('kos').Value := adoqVirtual.FieldByName('koshel').Value;
        adoqCopy.Parameters.ParamByName('com').Value := adoqVirtual.FieldByName('comment').Value;
        adoqCopy.Parameters.ParamByName('kl').Value := adoqVirtual.FieldByName('kol').Value;

        adoqCopy.ExecSQL;

        VivodData;
        SummaDate;
      end;
end;

procedure TfMainCash.nGoalClick(Sender: TObject);
begin
  fCashGoal.ShowModal;
end;

procedure TfMainCash.nCarExpenClick(Sender: TObject);
begin
  fCarExpen.ShowModal;
end;

procedure TfMainCash.nYearRClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqOtchet.SQL.Clear;
      adoqOtchet.SQL.Append('SELECT real_pokup.*, name_kat FROM real_pokup, sprav_pokup');
      adoqOtchet.SQL.Append('WHERE sprav_pokup.id = real_pokup.id_prod');
      adoqOtchet.SQL.Append('ORDER BY date_v, koshel, name_kat ASC');
      adoqOtchet.Open;
    end;

  VivodExcel('������� �� ' + spGod.Text);
end;

procedure TfMainCash.nExportDataClick(Sender: TObject);
begin
  fCashImport.ShowModal;
end;

procedure TfMainCash.nImportDataClick(Sender: TObject);
var
  adoc: TADOConnection;
  NameTable: TStringList;
  i: integer;
  data_pole: string;
begin
  NameTable := TStringList.Create;
  adoc := TADOConnection.Create(Self);
  adoc.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source='+ExtractFilePath(ParamStr(0))+'import.mdb;'+
    'Mode=Share Deny None;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";'+
    'Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'+
    'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
    'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
    'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;'+
    'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;';
  adoc.LoginPrompt := false;
  adoc.GetTableNames(NameTable);

  for i := 0 to NameTable.Count - 1 do
    begin
      if NameTable[i] = 'real_pokup' then
        data_pole := 'month_v, date_v, id_prod, sum_d, koshel, comment, kol';
      if NameTable[i] = 'virtual_pokup' then
        data_pole := 'month_v, date_v, id_prod, sum_d, koshel, comment, kol';
      if NameTable[i] = 'car_expen' then
        data_pole := 'replaced, date_rep, cost';
      if NameTable[i] = 'bludo_pr' then
        data_pole := 'date_prig, id_bludo, month_prig';
      if NameTable[i] = 'spisok_pokup' then
        data_pole := 'name_pokup, status';
      if NameTable[i] = 'status_pokup' then
        data_pole := 'date_pokup, name_pokup, kol, the_end, date_end, f_show, id_prod, id_pokup';
      if NameTable[i] = 'sprav_pokup' then
        data_pole := 'id_kat, name_kat, d_r, lek';
      if NameTable[i] = 'goal' then
        data_pole := 'goal, cost, execution';
      if NameTable[i] = 'spisok_lekar' then
        data_pole := 'name_lek, date_srok_god, the_end, date_end, f_show, function, kol, id_pokup';
      if NameTable[i] = 'spisok_blud' then
        data_pole := 'name_bludo, spisok_prod';
      if NameTable[i] = 'event' then
        data_pole := 'event, date_exe, repet, message, date_recall';
      if NameTable[i] = 'payMent' then
        data_pole := 'kateg, mean_before, mean_new, summa, date_pay, month_v';
      with dmCash do
        begin
          adoqExport.SQL.Clear;
          adoqExport.SQL.Append('INSERT INTO data.' + NameTable[i]);
          adoqExport.SQL.Append('(' + data_pole + ')');
          adoqExport.SQL.Append('SELECT ' + data_pole);
          adoqExport.SQL.Append('FROM import.' + NameTable[i]);
          adoqExport.ExecSQL;

          adoqExport.SQL.Clear;
          adoqExport.SQL.Append('DELETE FROM data.' + NameTable[i]);
          adoqExport.SQL.Append('WHERE id NOT IN');
          adoqExport.SQL.Append('(SELECT MIN(id) FROM ' + NameTable[i]);
          adoqExport.SQL.Append('GROUP BY ' + data_pole + ')');
          adoqExport.ExecSQL;
        end;
    end;
  ShowMessage('�������� ������ ���������!');
end;

end.
