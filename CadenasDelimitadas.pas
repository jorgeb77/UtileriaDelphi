unit CadenasDelimitadas;

interface

type
  /// <summary>
  /// Clase para el manejo de cadenas delimitadas.
  /// Permite manipular strings que contienen valores separados por un delimitador.
  /// </summary>

  TDelimitedString = class
  private
    FText : string;
    FDelimiter : string;
    function GetTokenCount : Integer;
    function GetLastToken : string;
  public
    constructor Create(const AText, ADelimiter : string);

    // Propiedades
    property Text : string read FText write FText;
    property Delimiter : string read FDelimiter write FDelimiter;
    property TokenCount : Integer read GetTokenCount;
    property LastToken : string read GetLastToken;

    // Métodos
    function GetToken(const Index : Integer) : string;
    function TokenExists(const TokenValue : string) : Boolean;
    function IsLastToken(const TokenValue : string) : Boolean; overload;
    function IsLastToken(const Index : Integer) : Boolean; overload;
    function DeleteToken(const Index : Integer) : string;
    procedure AddToken(const Value : string);
    function Split : TArray<string>;

    class function Create(const Values : array of string; const Delimiter : string = ',') : TDelimitedString; static;
  end;

implementation

uses
  System.SysUtils;

{ Constructor principal de la clase }
/// <summary>
/// Crea una nueva instancia de TDelimitedString con el texto y delimitador especificados
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
/// begin
///   DelimStr := TDelimitedString.Create('rojo,verde,azul', ',');
/// end;
/// </example>
constructor TDelimitedString.Create(const AText, ADelimiter : string);
begin
  inherited Create;
  FText      := AText;
  FDelimiter := ADelimiter;
end;

{ Método para obtener la cantidad de tokens }
/// <summary>
/// Cuenta el número de elementos (tokens) en la cadena delimitada
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   Count: Integer;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   Count := DelimStr.TokenCount; // Devuelve 3
/// end;
/// </example>
function TDelimitedString.GetTokenCount : Integer;
var
  I, Len : Integer;
  IsToken : Boolean;
begin
  Result  := 0;
  Len     := Length(FText);
  IsToken := False;

  for I:= 1 to Len do
  begin
    if FText[I] = FDelimiter then
      IsToken := False
    else
      if not IsToken then
        begin
          IsToken := True;
          Inc(Result);
        end;
  end;
end;

{ Método para obtener un token específico }
/// <summary>
/// Obtiene el token en la posición especificada (base 1)
/// Lanza una excepción si el índice está fuera de rango
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   Valor: string;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   Valor := DelimStr.GetToken(2); // Devuelve 'dos'
/// end;
/// </example>
function TDelimitedString.GetToken(const Index : Integer) : string;
var
  StartPos, EndPos : Integer;
  TokenIdx, I : Integer;
begin
  if (Index < 1) or (Index > TokenCount) then
    raise EArgumentOutOfRangeException.Create('Token index out of range');

  StartPos := 1;
  TokenIdx := 1;

  for I:= 1 to Length(FText) do
  begin
    if (FText[I] = FDelimiter) or (I = Length(FText)) then
      begin
        if TokenIdx = Index then
          begin
            if I = Length(FText) then
              EndPos := I
            else
              EndPos := I - 1;

            Result := Trim(Copy(FText, StartPos, EndPos - StartPos + 1));
            Exit;
          end;

        Inc(TokenIdx);
        StartPos := I + 1;
      end;
  end;

  Result := '';
end;

{ Método para obtener el último token }
/// <summary>
/// Obtiene el último token de la cadena delimitada
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   Ultimo: string;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   Ultimo := DelimStr.LastToken; // Devuelve 'tres'
/// end;
/// </example>
function TDelimitedString.GetLastToken : string;
begin
  Result := GetToken(TokenCount);
end;

{ Método para verificar si existe un token }
/// <summary>
/// Verifica si un valor específico existe como token en la cadena
/// La comparación no es sensible a mayúsculas/minúsculas
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   Existe: Boolean;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   Existe := DelimStr.TokenExists('DOS'); // Devuelve True
/// end;
/// </example>
function TDelimitedString.TokenExists(const TokenValue : string) : Boolean;
var
  I : Integer;
begin
  Result := False;
  for I:= 1 to TokenCount do
    if SameText(GetToken(I), TokenValue) then
      begin
        Result := True;
        Break;
      end;
end;

{ Método para verificar si un valor es el último token }
/// <summary>
/// Verifica si el valor especificado es el último token de la cadena
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   EsUltimo: Boolean;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   EsUltimo := DelimStr.IsLastToken('tres'); // Devuelve True
/// end;
/// </example>
function TDelimitedString.IsLastToken(const TokenValue : string) : Boolean;
begin
  Result := SameText(GetLastToken, TokenValue);
end;

{ Método para verificar si una posición es el último token }
/// <summary>
/// Verifica si el índice especificado corresponde al último token
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   EsUltimo: Boolean;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   EsUltimo := DelimStr.IsLastToken(3); // Devuelve True
/// end;
/// </example>
function TDelimitedString.IsLastToken(const Index : Integer) : Boolean;
begin
  Result := Index = TokenCount;
end;

{ Método para eliminar un token }
/// <summary>
/// Elimina el token en la posición especificada y devuelve la nueva cadena
/// También actualiza el texto interno de la clase
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   NuevaCadena: string;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   NuevaCadena := DelimStr.DeleteToken(2); // Devuelve 'uno,tres'
/// end;
/// </example>
function TDelimitedString.DeleteToken(const Index : Integer) : string;
var
  Token : string;
  TokenPos : Integer;
begin
  Token    := GetToken(Index);
  TokenPos := Pos(Token, FText);

  if TokenPos > 0 then
    begin
      if IsLastToken(Index) then
        begin
          if TokenPos > 1 then
            Result := Copy(FText, 1, TokenPos - 2)
          else
            Result := '';
        end
      else
        Result := Copy(FText, 1, TokenPos - 1) +
                  Copy(FText, TokenPos + Length(Token) + Length(FDelimiter));

      FText := Result;
    end
  else
    Result := FText;
end;

{ Método para agregar un nuevo token }
/// <summary>
/// Agrega un nuevo token al final de la cadena
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos', ',');
///   DelimStr.AddToken('tres'); // Resultado: 'uno,dos,tres'
/// end;
/// </example>
procedure TDelimitedString.AddToken(const Value : string);
begin
  if FText = '' then
    FText := Value
  else
    FText := FText + FDelimiter + Value;
end;

{ Método para dividir la cadena en un array }
/// <summary>
/// Divide la cadena delimitada en un array de strings
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
///   Tokens: TArray<string>;
/// begin
///   DelimStr := TDelimitedString.Create('uno,dos,tres', ',');
///   Tokens := DelimStr.Split;
///   // Resultado: ['uno', 'dos', 'tres']
/// end;
/// </example>
function TDelimitedString.Split : TArray<string>;
var
  I : Integer;
begin
  SetLength(Result, TokenCount);
  for I:= 0 to TokenCount - 1 do
    Result[I] := GetToken(I + 1);
end;

{ Constructor de clase para crear desde array }
/// <summary>
/// Constructor de clase que crea una instancia desde un array de strings
/// </summary>
/// <example>
/// var
///   DelimStr: TDelimitedString;
/// begin
///   DelimStr := TDelimitedString.Create(['uno', 'dos', 'tres'], ',');
///   // Resultado: objeto con texto 'uno,dos,tres'
/// end;
/// </example>
class function TDelimitedString.Create(const Values : array of string;
  const Delimiter : string) : TDelimitedString;
var
  Instance : TDelimitedString;
begin
  Instance := TDelimitedString.Create('', Delimiter);
  Instance.Join(Values);
  Result   := Instance;
end;

end.
