unit Pessoa;

interface

type

  TPessoa = class
  private
    FNome: String;
    FDATAALTERACAO: TDateTime;
    FSTATUS: Integer;
    FSENHA: String;
    FDATACADASTRO: TDateTime;
    FGUUID: String;
    FTIPO: String;
    procedure SetNome(const Value: String);
    procedure SetDATAALTERACAO(const Value: TDateTime);
    procedure SetDATACADASTRO(const Value: TDateTime);
    procedure SetGUUID(const Value: String);
    procedure SetSENHA(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetTIPO(const Value: String);
  public
    Procedure ValidarCampos;
  published
    function TratarCPFCNJP(aValue: String): String;
    property Nome: String read FNome write SetNome;
    property GUUID: String read FGUUID write SetGUUID;
    property SENHA: String read FSENHA write SetSENHA;
    property TIPO: String read FTIPO write SetTIPO;
    property STATUS: Integer read FSTATUS write SetSTATUS;
    property DATACADASTRO: TDateTime read FDATACADASTRO write SetDATACADASTRO;
    property DATAALTERACAO: TDateTime read FDATAALTERACAO
      write SetDATAALTERACAO;
  end;

implementation

uses
  System.SysUtils;

{ TPessoa }

procedure TPessoa.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TPessoa.SetDATACADASTRO(const Value: TDateTime);
begin
  FDATACADASTRO := Value;
end;

procedure TPessoa.SetGUUID(const Value: String);
begin
  FGUUID := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPessoa.SetSENHA(const Value: String);
begin
  FSENHA := Value;
end;

procedure TPessoa.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TPessoa.SetTIPO(const Value: String);
begin
  FTIPO := Value;
end;

function TPessoa.TratarCPFCNJP(aValue: String): String;
var
  I: Integer;
begin
  for I := 1 to Length(aValue) do
  begin
    if aValue[I] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
      Result := Result + aValue[I];

  end;

end;

procedure TPessoa.ValidarCampos;
begin
  if FNome = '' then
    raise Exception.Create('Nome não pode ficar vazio');
end;

end.
