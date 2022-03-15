unit ProjetoTeste.Principal;

interface
uses
  DUnitX.TestFramework, Pessoa, PessoaDAO;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  private
    FPessoa : TPessoa;
    FPessoaDAO : TPESSOADAO;
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

    [Test]
    procedure Insert;
  end;

implementation

uses
  System.SysUtils;

procedure TMyTestObject.Insert;
begin
  Try
   FPessoaDAO.Entidade.GUUID := '999999';
  FPessoaDAO.Entidade.Nome  := '999999';
  FPessoaDAO.Entidade.SENHA := '999999';
  FPessoaDAO.Entidade.TIPO  := 9;
  FPessoaDAO.Entidade.STATUS  := 9;
  FPessoaDAO.Entidade.DATACADASTRO := Now;
  FPessoaDAO.Entidade.DATAALTERACAO := Now;
  FPessoaDAO.Insert;

  FPessoaDAO.BuscarID('999999');

  Assert.IsTrue(FPessoaDAO.Entidade.GUUID = '999999', 'TPessoaDAO.Insert Erro no Inserir GUUID' );
  Assert.IsTrue(FPessoaDAO.Entidade.Nome = '999999', 'TPessoaDAO.Insert Erro no Inserir Nome' );
  Assert.IsTrue(FPessoaDAO.Entidade.SENHA = '999999', 'TPessoaDAO.Insert Erro no Inserir SENHA' );
  Assert.IsTrue(FPessoaDAO.Entidade.TIPO = 9, 'TPessoaDAO.Insert Erro no Inserir TIPO' );
  Assert.IsTrue(FPessoaDAO.Entidade.STATUS = 9, 'TPessoaDAO.Insert Erro no Inserir STATUS' );
  Assert.IsNotNull(FPessoaDAO.Entidade.DATACADASTRO , 'TPessoaDAO.Insert Erro no Inserir DATACADASTRO' );
  Assert.IsNotNull(FPessoaDAO.Entidade.DATAALTERACAO, 'TPessoaDAO.Insert Erro no Inserir DATAALTERACAO' );
  Finally
      FPessoaDAO.Entidade.GUUID := '999999';
      FPessoaDAO.Delete;
  End;


end;

procedure TMyTestObject.Setup;
begin
  FPessoa := TPessoa.Create;
  FPessoaDAO := TPESSOADAO.Create;
end;

procedure TMyTestObject.TearDown;
begin
  FPessoa.Free;
  FPessoaDAO.Free;
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
