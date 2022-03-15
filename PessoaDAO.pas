unit PessoaDAO;

interface

uses
  Pessoa, FireDAC.Comp.Client;

type
  TPessoaDAO = class
  private
    FPessoa: TPessoa;
    FQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    function Entidade: TPessoa;
    procedure ValidarCampos;
    procedure Insert;
    procedure Update;
    procedure Delete;
    procedure BuscarID(aID: String);
  end;

implementation

uses
  Conexao, System.SysUtils;

{ TPessoaDAO }

procedure TPessoaDAO.BuscarID(aID: String);
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPessoa.GUUID));
  FQuery.First;
  FPessoa.GUUID         := FQuery.FieldByName('GUUID').AsString;
  FPessoa.Nome          := FQuery.FieldByName('Nome').AsString;
  FPessoa.SENHA         := FQuery.FieldByName('SENHA').AsString;
  FPessoa.TIPO          := FQuery.FieldByName('TIPO').AsInteger;
  FPessoa.STATUS        := FQuery.FieldByName('STATUS').AsInteger;
  FPessoa.DATACADASTRO  := FQuery.FieldByName('DATACADASTRO').AsDateTime;
  FPessoa.DATAALTERACAO := FQuery.FieldByName('DATAALTERACAO').AsDateTime;
end;

constructor TPessoaDAO.Create;
begin
   FPessoa := TPessoa.Create;

   if not Assigned(DataModule1) then
      DataModule1 := TDataModule1.Create(nil);

   FQuery := DataModule1.FDQuery1;
end;

procedure TPessoaDAO.Delete;
begin
  FQuery.Open( 'SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPessoa.Guuid));
  FQuery.Delete;
  FQuery.ApplyUpdates(0);

end;

destructor TPessoaDAO.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

function TPessoaDAO.Entidade: TPessoa;
begin
   Result := FPessoa;
end;

procedure TPessoaDAO.Insert;
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE 1=2');
  FQuery.Append;
  FQuery.FieldByName('GUUID').AsString              :=  FPessoa.GUUID        ;
  FQuery.FieldByName('Nome').AsString               :=  FPessoa.Nome         ;
  FQuery.FieldByName('SENHA').AsString              :=  FPessoa.SENHA        ;
  FQuery.FieldByName('TIPO').AsInteger              :=  FPessoa.TIPO         ;
  FQuery.FieldByName('STATUS').AsInteger            :=  FPessoa.STATUS       ;
  FQuery.FieldByName('DATACADASTRO').AsDateTime     :=  FPessoa.DATACADASTRO ;
  FQuery.FieldByName('DATAALTERACAO').AsDateTime    :=  FPessoa.DATAALTERACAO;
  FQuery.Post;
  FQuery.ApplyUpdates(0);
end;

procedure TPessoaDAO.Update;
begin
  FQuery.Open( 'SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPessoa.Guuid));
  FQuery.Append;
  FQuery.FieldByName('GUUID').AsString              :=  FPessoa.GUUID        ;
  FQuery.FieldByName('Nome').AsString               :=  FPessoa.Nome         ;
  FQuery.FieldByName('SENHA').AsString              :=  FPessoa.SENHA        ;
  FQuery.FieldByName('TIPO').AsInteger              :=  FPessoa.TIPO         ;
  FQuery.FieldByName('STATUS').AsInteger            :=  FPessoa.STATUS       ;
  FQuery.FieldByName('DATACADASTRO').AsDateTime     :=  FPessoa.DATACADASTRO ;
  FQuery.FieldByName('DATAALTERACAO').AsDateTime    :=  FPessoa.DATAALTERACAO;
  FQuery.Post;
  FQuery.ApplyUpdates(0);
end;

procedure TPessoaDAO.ValidarCampos;
begin
 // if FPessoa.Nome = '' then
  //   raise Exception.Create('Nome não ode ser Vazio');
end;

end.
