unit CashDM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmCash = class(TDataModule)
    adocCash: TADOConnection;
    adoqReal: TADOQuery;
    dsReal: TDataSource;
    adoqVirtual: TADOQuery;
    dsVirtual: TDataSource;
    adoqData: TADOQuery;
    adoqSprav: TADOQuery;
    adoqDetail: TADOQuery;
    adoqSumDate: TADOQuery;
    adoqDrevo: TADOQuery;
    adoqSumRV: TADOQuery;
    adoqDrevo1: TADOQuery;
    adoqDohod: TADOQuery;
    adoqRashod: TADOQuery;
    adoqSpravData: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCash: TdmCash;

implementation

{$R *.dfm}

end.
