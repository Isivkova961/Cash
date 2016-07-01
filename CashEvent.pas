unit CashEvent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls;

type
  TfCashEvent = class(TForm)
    pEvent1: TPanel;
    pEvent2: TPanel;
    pEvent3: TPanel;
    dbgEvent: TDBGridEh;
    procedure dbgEventKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditYN(y_n: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCashEvent: TfCashEvent;

implementation

uses CashDM;

{$R *.dfm}

procedure TfCashEvent.dbgEventKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    begin
      EditYN(true);

      with dmCash.adoqEvent do
        begin
          Edit;
          Post;
        end;
    end;

  if dmCash.adoqEvent.RecordCount > 0 then
    if Key = 46 then
      if MessageDlg('Вы уверены что хотите удалить?', mtWarning, mbOkCancel, 0) = mrOk then
        dmCash.adoqEvent.Delete;

  if Key = 45 then
    begin
      EditYN(true);
      dmCash.adoqEvent.Insert;
    end;
end;

procedure TfCashEvent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfCashEvent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EditYN(false);
end;

procedure TfCashEvent.FormShow(Sender: TObject);
begin
  dmCash.adoqEvent.SQL.Text := 'SELECT * FROM event';
  dmCash.adoqEvent.Open;
  
  dbgEvent.EvenRowColor := RGB(214,254,252);
  dbgEvent.OddRowColor := RGB(254,254,214);
end;

procedure TfCashEvent.EditYN(y_n: boolean);
begin
  if y_n = true then
    begin
      dbgEvent.Options := dbgEvent.Options - [dgRowSelect];
      dbgEvent.Options := dbgEvent.Options + [dgEditing];

      dbgEvent.ReadOnly := false;
    end
  else
    begin
      dbgEvent.Options := dbgEvent.Options + [dgRowSelect];
      dbgEvent.Options := dbgEvent.Options - [dgEditing];

      dbgEvent.ReadOnly := true;
    end;
end;

end.
