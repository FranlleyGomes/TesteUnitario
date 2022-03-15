unit ProjetoTeste.Principal;

interface
uses
  DUnitX.TestFramework, Pessoa;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  private
    FPessoa : TPessoa;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TesteTratarCPFCNPJ;
  end;

implementation

procedure TMyTestObject.Setup;
begin
  FPessoa := TPessoa.Create;
end;

procedure TMyTestObject.TearDown;
begin
end;


procedure TMyTestObject.TesteTratarCPFCNPJ;
var
  Resultado : string;
begin
  Resultado :=  FPessoa.TratarCPFCNJP('123.123.123-12');
  Assert.IsTrue(Resultado = '12312312312','TPessoa.TratarCPFCNPJ retornou um erro');
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
