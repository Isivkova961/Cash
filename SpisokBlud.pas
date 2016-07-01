unit SpisokBlud;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, ImgList, ComCtrls, ToolWin;

type
  TfSpisokBlud = class(TForm)
    pBludo1: TPanel;
    pBludo2: TPanel;
    pBludo3: TPanel;
    dbgBludo: TDBGridEh;
    tbSpisokBlud: TToolBar;
    tbNew: TToolButton;
    tbSep: TToolButton;
    tbDelete: TToolButton;
    ilSpisokBlud: TImageList;
    procedure FormShow(Sender: TObject);
    procedure LoadData;
    procedure tbNewClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure dbgBludoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSpisokBlud: TfSpisokBlud;

implementation

uses CashDM, CachMain, CashBludo;

{$R *.dfm}

procedure TfSpisokBlud.FormShow(Sender: TObject);
begin
  LoadData;
  tbDelete.Enabled := (dmCash.adoqBludoPr.RecordCount > 0);
end;

procedure TfSpisokBlud.LoadData;
begin
  with dmCash do
    begin
      adoqBludoPr.SQL.Clear;

      adoqBludoPr.SQL.Append('SELECT bludo_pr.*, spisok_blud.name_bludo');
      adoqBludoPr.SQL.Append('FROM bludo_pr, spisok_blud');
      adoqBludoPr.SQL.Append('WHERE bludo_pr.id_bludo = spisok_blud.id');
      adoqBludoPr.SQL.Append('AND month_prig = :m_p');

      adoqBludoPr.Parameters.ParamByName('m_p').Value := fMainCash.cobMonth.Text + ' ' + fMainCash.spGod.Text;

      adoqBludoPr.Open;
    end;
end;

procedure TfSpisokBlud.tbNewClick(Sender: TObject);
begin
  fBluda.ShowModal;
  tbDelete.Enabled := (dmCash.adoqBludoPr.RecordCount > 0);
end;

procedure TfSpisokBlud.tbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Вы уверены что хотите удалить?', mtWarning, mbOkCancel, 0) = mrOk then
    begin
      with dmCash do
        begin
          adoqAddBludo.SQL.Clear;

          adoqAddBludo.SQL.Append('DELETE FROM bludo_pr');
          adoqAddBludo.SQL.Append('WHERE id = :iid');

          adoqAddBludo.Parameters.ParamByName('iid').Value := adoqBludoPr.FieldByName('id').Value;

          adoqAddBludo.ExecSQL;
        end;

      LoadData;
    end;

  tbDelete.Enabled := (dmCash.adoqBludoPr.RecordCount > 0);
end;

procedure TfSpisokBlud.dbgBludoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if dmCash.adoqBludoPr.RecordCount > 0 then
    if Key = 46 then
      tbDelete.Click;

  tbDelete.Enabled := (dmCash.adoqBludoPr.RecordCount > 0);
  
  if Key = 45 then
    tbNew.Click;
end;

procedure TfSpisokBlud.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

end.
