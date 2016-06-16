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
    procedure FormShow(Sender: TObject);
    procedure LoadTable;
    procedure bCancelClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure NewEditData;
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
end;

procedure TfSpravNE.LoadTable;
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
begin
  if fSprav.bNew_Edit = true then
    begin
      with dmCash do
        begin
          adoqSpravData.SQL.Clear;
          adoqSpravData.SQL.Append('INSERT INTO sprav_pokup (name_kat, id_kat, d_r)');
          adoqSpravData.SQL.Append('VALUES (:n_k, :i_k, :dr)');
          adoqSpravData.Parameters.ParamByName('n_k').Value := eName.Text;
          if cobKateg.ItemIndex = -1 then
            adoqSpravData.Parameters.ParamByName('i_k').Value := null
          else
            adoqSpravData.Parameters.ParamByName('i_k').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          adoqSpravData.Parameters.ParamByName('dr').Value := fSprav.bDoh_Rosh;
          adoqSpravData.ExecSQL;
        end;
    end
  else
    begin
      with dmCash do
        begin
          adoqSpravData.SQL.Clear;
          adoqSpravData.SQL.Append('UPDATE sprav_pokup SET name_kat = :n_k, id_kat = :i_k, d_r = :dr');
          adoqSpravData.SQL.Append('WHERE id = :iid');
          adoqSpravData.Parameters.ParamByName('n_k').Value := eName.Text;
          if cobKateg.ItemIndex = -1 then
            adoqSpravData.Parameters.ParamByName('i_k').Value := null
          else
            adoqSpravData.Parameters.ParamByName('i_k').Value := integer(cobKateg.Items.Objects[cobKateg.ItemIndex]);
          adoqSpravData.Parameters.ParamByName('dr').Value := fSprav.bDoh_Rosh;
          adoqSpravData.Parameters.ParamByName('iid').Value := fSprav.iid_sp;
          adoqSpravData.ExecSQL;
        end;
    end;
  Close;
end;

procedure TfSpravNE.NewEditData;
begin
  if fSprav.bNew_Edit = true then
    begin
      cobKateg.ItemIndex := -1;
      eName.Text := '';
    end
  else
    begin
      dmCash.adoqSprav.Locate('id', fSprav.id_kat,[]);
      cobKateg.ItemIndex := cobKateg.Items.IndexOf(dmCash.adoqSprav.FieldByName('name_kat').AsString);
      eName.Text := fSprav.name_sp;
    end;
end;

end.
