unit SpravNE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfSpravNE = class(TForm)
    pSpravNE: TPanel;
    pSpravNE1: TPanel;
    lKateg: TLabel;
    lName: TLabel;
    cobKateg: TComboBox;
    eName: TEdit;
    bSave: TButton;
    bCancel: TButton;
    cebMed: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure LoadTable;
    procedure bCancelClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure NewEditData;
    procedure cobKategChange(Sender: TObject);
    procedure cobKategKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSpravNE: TfSpravNE;

implementation

uses CashDM, SpravPokup;

{$R *.dfm}

procedure TfSpravNE.FormShow(Sender: TObject);
begin
  LoadTable;
  NewEditData;

  cobKateg.SetFocus;
end;

procedure TfSpravNE.LoadTable;
begin
  with dmCash do
    begin
      adoqDohod.SQL.Clear;

      adoqDohod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqDohod.SQL.Append('WHERE d_r = true');
      adoqDohod.SQL.Append('ORDER BY name_kat ASC');

      adoqDohod.Open;

      adoqRashod.SQL.Clear;

      adoqRashod.SQL.Append('SELECT * FROM sprav_pokup');
      adoqRashod.SQL.Append('WHERE d_r = false');
      adoqRashod.SQL.Append('ORDER BY name_kat ASC');

      adoqRashod.Open;
    end;

  cobKateg.Clear;

  if fSprav.bDoh_Rosh = true then
    begin
      with dmCash.adoqDohod do
        begin
          DisableControls;
          cobKateg.Items.BeginUpdate;
          First;

          while not Eof do
            begin
              if fSprav.bNew_Edit = true then
                cobKateg.Items.AddObject(FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger))
              else
                if FieldByName('id').AsInteger <> fSprav.iid_sp then
                  cobKateg.Items.AddObject(FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger));

              Next;
            end;

          cobKateg.Items.EndUpdate;
          EnableControls;
        end;
    end
  else
    begin
      with dmCash.adoqRashod do
        begin
          DisableControls;
          cobKateg.Items.BeginUpdate;
          First;

          while not Eof do
            begin
              if fSprav.bNew_Edit = true then
                cobKateg.Items.AddObject(FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger))
              else
                if FieldByName('id').AsInteger <> fSprav.iid_sp then
                  cobKateg.Items.AddObject(FieldByName('name_kat').AsString, Pointer(FieldByName('id').AsInteger));

              Next;
            end;

          cobKateg.Items.EndUpdate;
          EnableControls;
        end;
    end;
end;

procedure TfSpravNE.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfSpravNE.bSaveClick(Sender: TObject);
var
  dr: string;
  id_:integer;
begin
  if fSprav.bNew_Edit = true then
    begin
      with dmCash do
        begin
          adoqSpravData.SQL.Clear;

          adoqSpravData.SQL.Append('INSERT INTO sprav_pokup (name_kat, id_kat, d_r, lek)');
          adoqSpravData.SQL.Append('VALUES (:n_k, :i_k, :dr, :lk)');

          adoqSpravData.Parameters.ParamByName('n_k').Value := eName.Text;
          adoqSpravData.Parameters.ParamByName('dr').Value := fSprav.bDoh_Rosh;
          adoqSpravData.Parameters.ParamByName('lk').Value := cebMed.Checked;

          if cobKateg.ItemIndex = -1 then
            adoqSpravData.Parameters.ParamByName('i_k').Value := null
          else
            adoqSpravData.Parameters.ParamByName('i_k').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);

          adoqSpravData.ExecSQL;
        end;
    end
  else
    begin
      with dmCash do
        begin
          adoqSpravData.SQL.Clear;

          adoqSpravData.SQL.Append('UPDATE sprav_pokup SET name_kat = :n_k, id_kat = :i_k, d_r = :dr, lek = :lk');
          adoqSpravData.SQL.Append('WHERE id = :iid');

          adoqSpravData.Parameters.ParamByName('n_k').Value := eName.Text;
          adoqSpravData.Parameters.ParamByName('dr').Value := fSprav.bDoh_Rosh;
          adoqSpravData.Parameters.ParamByName('iid').Value := fSprav.iid_sp;
          adoqSpravData.Parameters.ParamByName('lk').Value := cebMed.Checked;

          if cobKateg.ItemIndex = -1 then
            adoqSpravData.Parameters.ParamByName('i_k').Value := null
          else
            adoqSpravData.Parameters.ParamByName('i_k').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);

          adoqSpravData.ExecSQL;
        end;
    end;

  Close;
end;

procedure TfSpravNE.NewEditData;
begin
  with dmCash.adoqSprav do
    begin
      SQL.Clear;
      SQL.Append('SELECT * FROM sprav_pokup');

      if fSprav.bDoh_Rosh = true then
        SQL.Append('WHERE d_r = true')
      else
        SQL.Append('WHERE d_r = false');

      Open;
    end;

  if fSprav.bNew_Edit = true then
    begin
      cobKateg.ItemIndex := - 1;
      cebMed.Checked := false;
      eName.Text := '';
    end
  else
    begin
      if dmCash.adoqSprav.Locate('id', fSprav.id_kat,[]) then
        cobKateg.ItemIndex := cobKateg.Items.IndexOf(dmCash.adoqSprav.FieldByName('name_kat').AsString)
      else
        cobKateg.ItemIndex := - 1;

      eName.Text := fSprav.name_sp;

      if dmCash.adoqSprav.Locate('name_kat', fSprav.name_sp,[]) then
        cebMed.Checked := dmCash.adoqSprav.FieldByName('lek').Value;
    end;
end;

procedure TfSpravNE.cobKategChange(Sender: TObject);
begin
  dmCash.adoqSprav.Locate('name_kat', cobKateg.Text, []);
  cebMed.Checked := dmCash.adoqSprav.FieldByName('lek').Value;
end;

procedure TfSpravNE.cobKategKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 8 then
    cobKateg.ItemIndex := - 1;
end;

procedure TfSpravNE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    bSave.Click;
    
  if Key = 27 then
    Close;
end;

end.
