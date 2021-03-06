unit CashVibor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfCashVibor = class(TForm)
    lNameCheck: TLabel;
    sbAdd: TSpeedButton;
    pDetail: TPanel;
    bCancel: TButton;
    bOK: TBitBtn;
    pDetail_but: TPanel;
    lKateg: TLabel;
    lbKateg: TListBox;
    eKateg: TEdit;
    SpeedButton1: TSpeedButton;
    procedure eKategChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lbKategClick(Sender: TObject);
    procedure LoadTable;
    procedure FormShow(Sender: TObject);
    procedure NewDetail;
    procedure bCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCashVibor: TfCashVibor;
  index: TStringList;
  id_kateg: integer;

implementation

uses CashDM, SpravPokup, CachMain;

{$R *.dfm}

procedure TfCashVibor.eKategChange(Sender: TObject);
begin
  with dmCash do
    begin
      if length(eKateg.Text) > 2 then
        begin
          adoqSprav.Filter := 'name_kat LIKE ''*' + eKateg.Text +'*''';
          adoqSprav.Filtered := true;

          if adoqSprav.RecordCount > 0 then
            begin
              lbKateg.Clear;
              index.Clear;

              adoqSprav.First;

              while not (adoqSprav.Eof) do
                begin
                  lbKateg.Items.Append(adoqSprav.FieldByName('name_kat').AsString);
                  index.Append(adoqSprav.FieldByName('id').AsString);

                  adoqSprav.Next;
                end;

              if lbKateg.Count <= 5 then
                lbKateg.Height := 20 * lbKateg.Count
              else
                lbKateg.Height := 110;

              lbKateg.Visible := true;
            end
          else
            lbKateg.Visible := false;
        end
      else
        begin
          lbKateg.Visible := false;
          adoqSprav.Filtered := false;
        end;
    end;
end;

procedure TfCashVibor.SpeedButton1Click(Sender: TObject);
begin
  fSprav.ShowModal;
end;

procedure TfCashVibor.lbKategClick(Sender: TObject);
begin
  with dmCash do
    begin
      adoqSprav.Filtered := false;

      fMainCash.iIDCheck := StrToInt(index[lbKateg.ItemIndex]);
      eKateg.Text := lbKateg.Items[lbKateg.ItemIndex];

      adoqSprav.Filtered := false;
      lbKateg.Visible := false;
    end;
end;

procedure TfCashVibor.LoadTable;
begin
  with  dmCash.adoqSprav do
    begin
      SQL.Clear;

      SQL.Append('SELECT * FROM sprav_pokup');
      SQL.Append('WHERE id_kat <> null');
      SQL.Append('ORDER BY d_r, name_kat ASC');
      
      Open;
    end;
end;

procedure TfCashVibor.FormShow(Sender: TObject);
begin
  LoadTable;
  NewDetail;
end;

procedure TfCashVibor.NewDetail;
begin
  eKateg.Text := '';
end;

procedure TfCashVibor.bCancelClick(Sender: TObject);
begin
  if MessageDlg('���������� �������� �����?', mtWarning, mbOkCancel, 0) = mrOk then
    fMainCash.bExit := true;
  Close;
end;

procedure TfCashVibor.FormCreate(Sender: TObject);
begin
  index := TStringList.Create;
end;

procedure TfCashVibor.FormDestroy(Sender: TObject);
begin
  index.Free;
end;

end.
