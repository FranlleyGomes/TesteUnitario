unit Pessoa;



interface

type

  TPessoa = class
  private
    FNome: String;
    procedure SetNome(const Value: String);
    public
    Procedure ValidarCampos;
  published
    function TratarCPFCNJP(aValue: String): String;
    property Nome : String read FNome write SetNome;
  end;

implementation

uses
  System.SysUtils;

{ TPessoa }

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

function TPessoa.TratarCPFCNJP(aValue: String): String;
var
  I : integer;
begin
  for I := 1 to Length(aValue) do
    begin
        if aValue[I]in ['0','1','2','3','4','5','6','7','8','9'] then
           Result := Result + aValue[I];

    end;

end;

procedure TPessoa.ValidarCampos;
begin
    if FNome = '' then
      raise Exception.Create('Nome não pode ficar vazio');
end;

end.
