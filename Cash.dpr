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
  CashCar in 'CashCar.pas' {fCarExpen};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cash 1.5.1';
  Application.CreateForm(TfMainCash, fMainCash);
  Application.CreateForm(TdmCash, dmCash);
  Application.Run;
end.
