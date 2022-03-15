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
    [Test]
    [TestCase('CaseCPF', '123.123.123-12,12312312312')]
    [TestCase('CaseCNPJ','12.123.123-0001-12,12123123000112')]
    procedure TratarCPFCNPJ(aValue : String; aResult : String);

    [Test]
    procedure ValidaNome;

    [Test]
    Procedure ValidarCampos;
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

procedure TMyTestObject.TratarCPFCNPJ(aValue, aResult: String);
var
   Resultado : String;
begin
   Resultado :=  FPessoa.TratarCPFCNJP(aValue);
   //Assert.IsTrue(Resultado = aResult, 'TPessoa.TratarCPFCNPJ');
   Assert.AreEqual(Resultado, aResult);

end;

procedure TMyTestObject.ValidaNome;
begin
   FPessoa.Nome := 'Franlley';
   Assert.IsNotEmpty(FPessoa.Nome, 'TPessoa.Nome está retornando vázio');
end;

procedure TMyTestObject.ValidarCampos;
begin
   FPessoa.Nome := '';
   Assert.WillRaise( FPessoa.ValidarCampos, nil, 'TPessoa.ValidarCampos');

end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
