program Cash;

uses
  Forms,
  CachMain in 'CachMain.pas' {fMainCash},
  SpravPokup in 'SpravPokup.pas' {fSprav},
  CashDM in 'CashDM.pas' {dmCash: TDataModule},
  CashDetail in 'CashDetail.pas' {fCashDetail},
  SpravNE in 'SpravNE.pas' {fSpravNE};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cash 1.0';
  Application.CreateForm(TfMainCash, fMainCash);
  Application.CreateForm(TfSprav, fSprav);
  Application.CreateForm(TfCashDetail, fCashDetail);
  Application.CreateForm(TdmCash, dmCash);
  Application.CreateForm(TfSpravNE, fSpravNE);
  Application.Run;
end.
