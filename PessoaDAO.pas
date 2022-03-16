unit PessoaDAO;

interface

{$M+}

uses
  Pessoa, FireDAC.Comp.Client;

type

   iLog = interface
     ['{31990ECF-ABBD-4148-9A30-18A269A5DAC5}']
     procedure GravarLogo(aLog : String);
   end;

   iSession = interface
     ['{7DA1462E-8F08-4F54-8E56-E8DE3D89CE30}']
     function User: String;
   end;

  TPessoaDAO = class
  private
    FLog : iLog;
    FSession : iSession;
    FPessoa: TPessoa;
    FQuery: TFDQuery;
  public
    constructor Create (aLog : iLog; aSession: iSession);
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
  Conexao, System.SysUtils, Delphi.Mocks;

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

constructor TPessoaDAO.Create(aLog : iLog; aSession : iSession);
begin
   FLog := aLog;
   FSession := iSession;

   FLog.GravarLogo('User:' + aSession.User);

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
