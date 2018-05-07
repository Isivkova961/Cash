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
  CashBludo in 'CashBludo.pas' {fBluda},
  CashEvent in 'CashEvent.pas' {fCashEvent},
  CashZKH in 'CashZKH.pas' {fCashZKH},
  CashNewDate in 'CashNewDate.pas' {fCashNewDate},
  CashGoal in 'CashGoal.pas' {fCashGoal},
  CashCar in 'CashCar.pas' {fCarExpen},
  CashImport in 'CashImport.pas' {fCashImport},
  CashVibor in 'CashVibor.pas' {fCashVibor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cash 2.0';
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
  Application.CreateForm(TfCashEvent, fCashEvent);
  Application.CreateForm(TfCashZKH, fCashZKH);
  Application.CreateForm(TfCashNewDate, fCashNewDate);
  Application.CreateForm(TfCashGoal, fCashGoal);
  Application.CreateForm(TfCarExpen, fCarExpen);
  Application.CreateForm(TfCashImport, fCashImport);
  Application.CreateForm(TfCashVibor, fCashVibor);
  Application.Run;
end.
