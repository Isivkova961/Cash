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
    adoqSpisok: TADOQuery;
    adoqStatus: TADOQuery;
    adoqSpravoch: TADOQuery;
    dsStatus: TDataSource;
    adoqDetail1: TADOQuery;
    dsSpisok: TDataSource;
    adoqLekar: TADOQuery;
    dsLekar: TDataSource;
    adoqDrevo2: TADOQuery;
    adoqItog: TADOQuery;
    dsItog: TDataSource;
    adoqSpisokBlud: TADOQuery;
    dsSpisokBlud: TDataSource;
    adoqBludoPr: TADOQuery;
    dsBludoPr: TDataSource;
    adoqAddBludo: TADOQuery;
    procedure adoqLekarAfterInsert(DataSet: TDataSet);
    procedure adoqStatusAfterInsert(DataSet: TDataSet);
    procedure adoqSpisokAfterInsert(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCash: TdmCash;

implementation

{$R *.dfm}

procedure TdmCash.adoqLekarAfterInsert(DataSet: TDataSet);
begin
  adoqLekar.FieldByName('f_show').Value := false;
  adoqLekar.FieldByName('the_end').Value := false;
end;

procedure TdmCash.adoqStatusAfterInsert(DataSet: TDataSet);
begin
  adoqStatus.FieldByName('f_show').Value := false;
  adoqStatus.FieldByName('the_end').Value := false;
end;

procedure TdmCash.adoqSpisokAfterInsert(DataSet: TDataSet);
begin
  adoqSpisok.FieldByName('status').Value := false;
end;

end.
