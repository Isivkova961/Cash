program Cash;

uses
  Forms,
  CachMain in 'CachMain.pas' {fMainCash},
  SpravPokup in 'SpravPokup.pas' {fSprav},
  CashDM in 'CashDM.pas' {dmCash: TDataModule},
  CashDetail in 'CashDetail.pas' {fCashDetail},
  SpravNE in 'SpravNE.pas' {fSpravNE},
  SpisokPokup in 'SpisokPokup.pas' {fSpisokPokup},
  CashStatus in 'CashStatus.pas' {fStatus},
  SpisokLekar in 'SpisokLekar.pas' {fSpisokLekar},
  SpisokBlud in 'SpisokBlud.pas' {fSpisokBlud},
  CashBludo in 'CashBludo.pas' {fBluda};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cash 1.1';
  Application.CreateForm(TfMainCash, fMainCash);
  Application.CreateForm(TfStatus, fStatus);
  Application.CreateForm(TfSprav, fSprav);
  Application.CreateForm(TfCashDetail, fCashDetail);
  Application.CreateForm(TdmCash, dmCash);
  Application.CreateForm(TfSpravNE, fSpravNE);
  Application.CreateForm(TfSpisokPokup, fSpisokPokup);
  Application.CreateForm(TfSpisokLekar, fSpisokLekar);
  Application.CreateForm(TfSpisokBlud, fSpisokBlud);
  Application.CreateForm(TfBluda, fBluda);
  Application.Run;
end.
