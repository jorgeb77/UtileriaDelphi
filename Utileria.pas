unit Utileria;
{ En esta unidad estan hechos y declarados todos los procedimientos y funciones }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, ExtCtrls,
  StdCtrls, Forms, DBCtrls, ComCtrls, Grids, DBgrids, Buttons, Variants,
  Vcl.ActnList, Printers, DateUtils, DB, System.Win.ComObj, Vcl.OleAuto,
  ShellApi, System.Zip, WinSpool, StrUtils, NB30, WinSock, System.UITypes,
  Vcl.WinXCtrls, IniFiles, Clipbrd, Generics.Collections, Math, IOUtils,
  Threading,


  CxControls, CxContainer, CxEdit, CxTextEdit, CxMaskEdit, cxImage,
  CxDropDownEdit, CxCalendar, CxDBEdit, CxLookAndFeelPainters, CxButtons,
  CxLookupEdit, CxDBLookupEdit, CxDBLookupComboBox, CxCurrencyEdit,
  CxCheckBox, cxRadioGroup, cxMemo, cxSpinEdit, cxTimeEdit, cxListView,
  CxNavigator, cxButtonEdit, CxDBNavigator, CxFormats, dxmdaset,
  cxGridCustomView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;


const
  OneDay           = 1.0;
  OneHour          = OneDay / 24;
  OneMinute        = OneHour / 60;
  OneSecond        = OneMinute / 60;
  OneMillisecond   = OneSecond / 1000;
  OneWeek          = OneDay * 7;
  HoursPerDay      = 24;
  MinutesPerHour   = 60;
  MinutesPerDay    = MinutesPerHour * HoursPerDay;
  SecondsPerMinute = 60;
  SecondsPerHour   = SecondsPerMinute * MinutesPerHour;
  SecondsPerDay    = SecondsPerHour * HoursPerDay;

  { DateTruncateFraction is the float value adjustment used when truncating.
    This avoids truncating errors caused by the inexact nature of floating
    point representation. }
  DateTruncateFraction = OneMillisecond / 8.0;


type
  TJusticado = (tjLeft, tjCenter, tjRight);
  TDecimalTimeType = (dtSecond, dtMinute, dtHour);


    procedure Limpiar(Formulario : TForm);
    procedure MostrarForma(Formulario : TFormClass);


    //TRATAMIENTO DE FECHAS
    function EsFechaValida(str : string) : Boolean;
    function EsBisiesto(Ano : Integer) : Boolean;
    function UltimoDia(Valor : TDate) : TDate;
    function CantidadDiaMes(Fecha : TDate) : Integer;
    function FormatoFecha(Fecha : TDateTime; SignoSeparador : Char; Forma : Integer) : String;
    function NombreMes(Mes : Integer) : String;
    function FechaLarga(Fecha: TDate) : String;
    function Edad(FechaNacimiento : TDate) : string;
    function CalcularEdad(FechaNacimiento : TDate) : Integer;
    function DiaDeLaSemana(Fecha : TDateTime) : string;
    function Hora24(HoraCorta : string; IncluyeSegundos : Boolean) : string;
    function PrimerDiaDelMes(const Fecha : TDateTime) : TDateTime;
    function UltimoDiaDelMes(const Fecha : TDateTime) : TDateTime;
    function TiempoEntreFechas(FechaInicial : TDateTime; FechaFinal : TDateTime) : string;
    function CalculaEdad(FechaNacimiento : TDate) : Integer;
    function MayorParaElecciones(FechaNacimiento : TDate) : Boolean;
    function SigloDeFecha(const Fecha : TDateTime) : Integer;
    function SecondToTime(const Seconds : Cardinal) : Double;
    function SegundoAHora(Segundos : Int64) : TDateTime;


    procedure SemanaLaboral(var Fecha1, Fecha2 : TDate);
    function ObtenerPascua(Ano : Integer) : TDate;
    function TiempoTranscurrido(Fecha : TDateTime; var Dias, Meses, Anos : Integer) : TDateTime;
    function LunesDeEstaSemana : TDateTime;
    function DomingoDeEstaSemana : TDateTime;
    function FormatoFechaHoraLarga(FechaHora : TDateTime; SoloHora : Boolean = False; IncluyeSegundos : Boolean = False) : string;
    function FormatoFechaHoraCorta(FechaHora : TDateTime; SoloHora : Boolean = False; IncluyeSegundos : Boolean = False) : string;
    function DateTimeToSqlDateTime(FechaHora : TDateTime; EsFechaFinal : Boolean = False; ConMiliSegundos : Boolean = True) : WideString;
    function TimePart(const D : TDateTime) : Double;
    function IsEqual(const D1, D2 : TDateTime) : Boolean;
    function IsNoon(const D : TDateTime) : Boolean;
    function IsMidnight(const D : TDateTime) : Boolean;
    function IsSunday(const D : TDateTime) : Boolean;
    function IsMonday(const D : TDateTime) : Boolean;
    function IsTuesday(const D : TDateTime) : Boolean;
    function IsWedneday(const D : TDateTime) : Boolean;
    function IsThursday(const D : TDateTime) : Boolean;
    function IsFriday(const D : TDateTime) : Boolean;
    function IsSaturday(const D : TDateTime) : Boolean;
    function IsWeekend(const D : TDateTime) : Boolean;
    function IsWeekday(Day : TDateTime) : Boolean;

    function DatePart(const D : TDateTime) : Integer;
    function Century(const D : TDateTime) : Word;
    function Noon(const D : TDateTime) : TDateTime;
    function Midnight(const D : TDateTime) : TDateTime;
    function NextWorkday(const D : TDateTime) : TDateTime;
    function PreviousWorkday(const D : TDateTime) : TDateTime;
    function LastDayOfMonth(const D : TDateTime) : TDateTime;
    function FirstDayOfMonth(const D : TDateTime) : TDateTime;
    function LastDayOfYear(const D : TDateTime) : TDateTime;
    function FirstDayOfYear(const D : TDateTime) : TDateTime;
    function AddMilliseconds(const D : TDateTime; const N : Int64) : TDateTime;
    function AddSeconds(const D : TDateTime; const N : Int64) : TDateTime;
    function AddMinutes(const D : TDateTime; const N : Integer) : TDateTime;
    function AddHours(const D : TDateTime; const N : Integer) : TDateTime;
    function AddDays(const D : TDateTime; const N : Integer) : TDateTime;
    function AddWeeks(const D : TDateTime; const N : Integer) : TDateTime;
    function AddMonths(const D : TDateTime; const N : Integer) : TDateTime;
    function AddYears(const D : TDateTime; const N : Integer) : TDateTime;
    function DiffDateTime(const D1, D2 : TDateTime; const Period : Double) : Int64;
    function DiffMilliseconds(const D1, D2 : TDateTime) : Int64;
    function DiffSeconds(const D1, D2 : TDateTime) : Int64;
    function DiffMinutes(const D1, D2 : TDateTime) : Int64;
    function DiffHours(const D1, D2 : TDateTime) : Int64;
    function DiffDays(const D1, D2 : TDateTime) : Integer;
    function DiffWeeks(const D1, D2 : TDateTime) : Integer;
    function DiffMonths(const D1, D2 : TDateTime) : Integer;
    function DiffYears(const D1, D2 : TDateTime) : Integer;
    function GetDecimalTime(Count : Integer; DecimalTimeType : TDecimalTimeType) : Double;
    function IntTimeToTime(Time : Integer) : TTime;


    procedure CambiaColorSoloLectura(Form : TForm);
    procedure CambiaColorModifica(Form : TForm);

    function InputValor(const aCaption : string; APrompt : string; var aValor : string; Password : Boolean = False; SoloNumero : Boolean = False) : Boolean;

    //TRATAMIENTO DE CADENAS...

    function EnDeCrypt(const Value : string) : string;
    function NPos(Cadena : string; SubCadena : string; Posicion : Integer) : Integer;
    function LastPos(SubStr, S : string) : Integer;
    function Capitalizar(const Cadena : string) : string;
    function CambiarARomano(Numero : Integer) : string;
    function EsNumero(const Num : string) : Boolean;
    function IsSeparator(Caracter : Char) : Boolean;
    function EliminarCaracteres(Cadena : string; Posicion, N : Integer) : string;
    function CopyEntre(Cadena : string; Desde, Hasta : string) : string;
    function DeleteEntre(var Cadena : string; const Desde, Hasta :string; const Tags : Boolean) : Boolean;
    function ExtraerHastaUltimo(Cadena : string; Caracter : Char) : string;
    function CopyRange(const S: String; const StartIndex, StopIndex: Integer): String;
    function CopyFrom(const S: String; const Index: Integer): String;
    function CopyLeft(const S: String; const Count: Integer): String;
    function CopyRight(const S: String; const Count: Integer): String;
    function LPad(Value: string; Key: Char = ' '; ALenght: Integer = 0): string;
    function RPad(Value: string; Key: Char = ' '; ALenght: Integer = 0): string;
    function AlineaDerecha(S : string; N : Integer) : string;
    function AlineaIzquierda(S : string; N : Integer) : string;
    function Alinea(S : string; N : Integer) : string;
    function RellenaLinea (Longitud : SmallInt; Rellena : Char) : String;
    function Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;
    function EliminarEspacios(Str : string) : string;
    function EliminarCaracter(Cadena, Caracter : string) : string;
    function CambiarCaracterEspecial(Cadena : string; EliminarExtras : Boolean) : string;
    function Before(const Cadena, Buscar : string) : string;
    function After(const Cadena, Buscar : string) : string;
    function ContieneNumero(Numero : string) : Boolean;
    function IsEmptyOrNull(const Value : Variant) : Boolean;
    function LetraExcell(I : Integer) : string;
    function AlphaBase(Num : Integer) : string; overload;
    function AlphaBase(Letra : string) : Integer; overload;

    function Verifica_Digito_Verificador(Cedula : string) : Boolean;
    function Calcula_Verificador(Numero : string) : Integer;
    function WriteRawDataToPrinter(PrinterName : String; Str: String) : Boolean;
    function NumLetra(const MNum : Currency; const IIdioma, IModo : Smallint) : string;
    function ValidarEmail(const Value : string) : Boolean;
    function PasswordRandom(const Tamano : Integer; Numeros : Boolean = True;
                                   Mayusculas : Boolean = True; Minusculas : Boolean = True) : string;



    function ObtenerMacAdress : string;
    function ObtenerIP : string;
    procedure GetIPList(const List : TStrings);
    function ObtenerGrupoTrabajo : AnsiString;
    function ObtenerNombrePC() : AnsiString;
    function NombreUsuarioWindows : string;
    function SinFormato(Str : string) : Double;
    procedure LimpiarMemData(MemData : TdxMemData);

    function IsGridFocused : Boolean;
    function GetEditor : TcxCustomEdit;
    function GetListBox : TcxCustomEditContainer;
    function GetLookupComboBox : TcxCustomLookupComboBox;
    function GetCurrencyEdit : TcxCustomCurrencyEdit;
    function GetListView : TcxCustomListView;
    function GetTimeEdit : TcxCustomTimeEdit;

    procedure Centralizar(Componente : TControl);
    function GetDefaultPrinterName : string;
    procedure SetDefaultPrinter(NewDefPrinter : string);
    function VarToIntDef(const V : Variant; const ADefault : Integer) : Integer;
    function VarToDoubleDef(const V : Variant; const ADefault : Double) : Double;
    function VarToDateDef(const V : Variant; const ADefault : TDate) : TDate;
    procedure HabilitaControles(Form : TForm; Estado : Boolean);
    procedure HabilitarBotones(Form : TForm; Estado : Boolean);
    function MascaraCedula(Cedula : string) : string;
    function MascaraRNC(RNC : string) : string;
    function MascaraTelefono(Telefono : string) : string;
    function Mascara(Edt, Mascara : string) : string;
    function ValidaRNC(sRNC : string) : Boolean;
    function ObtenerPorciento(Valor : Real; Percent : Real) : Real;
    function GetAppVersion : string;
    function GetAppInfo(De : string) : string;



    function BotonesEnfocados(Form : TForm) : Boolean;
    function SumarColumna(ADataset : TDataSet; ColumnName, Condicion : string) : Double;
    function ContarRegistros(ADataset : TDataSet; Condicion : string = '') : Integer;
    function VerificarElementosRepetidos(ATable : TDataSet; Campo : string) : string;
    function SeparadoPorComas(Dataset : TDataSet; ColumnName, Condicion : string; EntreComillas : Boolean) : string;
    procedure SaveToCSV(DataSet : TDataSet; FileName : string);
    function GetTableNameByDataSet(ADataSet : TDataSet) : string;
    procedure LoadPictureFromField(Field : TBlobField; Picture : TPicture);
    procedure LoadPictureFromFile(aImage : TcxImage; Filename : string);
    procedure SavePictureFileToField(PictureFile : TFileName; Field : TBlobField);
    function TotalCampo(Dataset : TDataSet; Campo : string) : Double;


    //TRATAMIENTO DE ARCHIVOS
    function GetTempDir : string;
    function DeleteFolder(Path : string) : Integer;
    procedure DeleteAllDir(Path, Mask : string; Recursive : Boolean);
    function MoverCarpeta(const vOrigen, vDestino: string) : Boolean;
    function DirectoryIsEmpty(Directory : string) : Boolean;
    procedure RenameDir(DirFrom, DirTo : string);
    function ListaArchivos(DirectorioPadre : string; Filtro : string = '*') : TStringList;
    function ListaDirectorios(DirectorioPadre : string) : TStringList;
    procedure CopiarDirectorio(Origen, Destino : string);
    function TamanioArchivo(Archivo : string) : string;
    function IsFileInUse(FileName : TFileName) : Boolean;
    function CantidadLineas(Archivo : string) : Integer;
    procedure ComprimirArchivo(Archivo : string);
    procedure DescomprimirArchivo(Archivo : string; ExtraerEnCarpeta : Boolean);
    procedure ComprimirCarpeta(Carpeta : string);
    procedure DescomprimirCarpeta(Archivo : string);
    function FechaUltimoAcceso(const Archivo : string) : TDateTime;
    procedure CambiarFechaModificacionArchivo(Archivo : string; Fecha : TDateTime);
    function CantFilas(ArhivoExcel : string; nHoja, nColumnaLectura, nFilaInicio : Integer) : Integer;
    function GetFileSizeEx(const Arquivo : string) : string;



    //TRATAMIENTO DE COLORES

    function ColorToStr(Color : TColor) : string;
    function StrToColor(Color : string) : TColor;
    function ConvertColorToInteger(Color : TColor) : LongInt;
    procedure ColorToRGB(const Color : Integer; out R, G, B : Byte);
    function RGBToInteger(const R, G, B : Byte) : Integer;
    function RGBToColor(R, G, B : Integer) : TColor;
    function HexToTColor(sColor : string) : TColor;
    function ColorToHtml(Color : TColor) : string;
    function HtmlToColor(Color : string) : TColor;




    //FUNCION PARA BLOQUEAR EL TECLADO DE WINDOWS...
    function BlockInput(fbLookIt : Boolean) : Integer; stdcall; external 'user32.dll';

implementation

{ METODO PARA HACER QUE LOS COMPONENTES DBEDIT, DBMEMO Y DBGRID SOLO PUEDAN SER VISTOS Y NO MODIFICADOS }
procedure CambiaColorSoloLectura(Form : TForm);
var
  I : Integer;
begin
  for I := 0 to Form.ComponentCount - 1 do
    begin
      if Form.Components[I] is TDBLookupComboBox then
        with Form.Components[I] as TDBLookupComboBox do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TDBComboBox then
        with Form.Components[I] as TDBComboBox do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBLookupComboBox then
        with Form.Components[I] as TcxDBLookupComboBox do
          begin
            Properties.ReadOnly := True;
            Style.Color         := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBComboBox then
        with Form.Components[I] as TcxDBComboBox do
          begin
            Properties.ReadOnly := True;
            Style.Color         := $00B0FFFF;
          end;

      if Form.Components[I] is TDBEdit then
        with Form.Components[I] as TDBEdit do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBTextEdit then
        with Form.Components[I] as TcxDBTextEdit do
          begin
            Properties.ReadOnly := True;
            Style.Color         := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBMaskEdit then
        with Form.Components[I] as TcxDBMaskEdit do
          begin
            Properties.ReadOnly := True;
            Style.Color         := $00B0FFFF;
          end;

      if Form.Components[I] is TDBMemo then
        with Form.Components[I] as TDBMemo do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBMemo then
        with Form.Components[I] as TcxDBMemo do
          begin
            Properties.ReadOnly := True;
            Style.Color         := $00B0FFFF;
          end;

      if Form.Components[I] is TDBGrid then
        with Form.Components[I] as TDBGrid do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TDBRadioGroup then
        with Form.Components[I] as TDBRadioGroup do
          begin
            ReadOnly := True;
          end;

      if Form.Components[I] is TcxDBRadioGroup then
        with Form.Components[I] as TcxDBRadioGroup do
          begin
            Properties.ReadOnly:= True;
          end;

      if Form.Components[I] is TDBCheckBox then
        with Form.Components[I] as TDBCheckBox do
          begin
            ReadOnly := True;
          end;

      if Form.Components[I] is TcxDBCheckBox then
        with Form.Components[I] as TcxDBCheckBox do
          begin
//            Style.Color         := $00B0FFFF;
            Properties.ReadOnly := True;
          end;

      if Form.Components[I] is TEdit then
        with Form.Components[I] as TEdit do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TMemo then
        with Form.Components[I] as TMemo do
          begin
            ReadOnly := True;
            Color    := $00B0FFFF;
          end;

      if Form.Components[I] is TcxDBDateEdit then
        with Form.Components[I] as TcxDBDateEdit do
          begin
            Style.Color         := $00B0FFFF;
            Properties.ReadOnly := True;
          end;

      if Form.Components[I] is TcxDBCurrencyEdit then
        with Form.Components[I] as TcxDBCurrencyEdit do
          begin
            Style.Color := $00B0FFFF;
            Properties.ReadOnly := True;
          end;
    end; { for }
end;

{ METODO PARA HACER QUE LOS COMPONENTES DBEDIT, DBMEMO Y DBGRID PUEDAN SER MODIFICADOS }
procedure CambiaColorModifica(Form : TForm);
var
  I : Integer;
begin
  for I:= 0 to Form.ComponentCount - 1 do
    begin
      if Form.Components[I] is TDBLookupComboBox then
        with Form.Components[I] as TDBLookupComboBox do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TDBComboBox then
        with Form.Components[I] as TDBComboBox do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TcxDBLookupComboBox then
        with Form.Components[I] as TcxDBLookupComboBox do
          begin
            Properties.ReadOnly := False;
            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TcxDBComboBox then
        with Form.Components[I] as TcxDBComboBox do
          begin
            Properties.ReadOnly := False;
            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TDBEdit then
        with Form.Components[I] as TDBEdit do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TcxDBTextEdit then
        with Form.Components[I] as TcxDBTextEdit do
          begin
            Properties.ReadOnly := False;
            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TcxDBMaskEdit then
        with Form.Components[I] as TcxDBMaskEdit do
          begin
            Properties.ReadOnly := False;
            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TDBMemo then
        with Form.Components[I] as TDBMemo do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TcxDBMemo then
        with Form.Components[I] as TcxDBMemo do
          begin
            Properties.ReadOnly := False;
            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TDBGrid then
        with Form.Components[I] as TDBGrid do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TDBRadioGroup then
        with Form.Components[I] as TDBRadioGroup do
          begin
            ReadOnly := False;
          end;

      if Form.Components[I] is TcxDBRadioGroup then
        with Form.Components[I] as TcxDBRadioGroup do
          begin
            Properties.ReadOnly:= False;
          end;

      if Form.Components[I] is TDBCheckBox then
        with Form.Components[I] as TDBCheckBox do
          begin
            ReadOnly := False;
          end;

      if Form.Components[I] is TcxDBCheckBox then
        with Form.Components[I] as TcxDBCheckBox do
          begin
            Properties.ReadOnly := False;
//            Style.Color         := clWindow;
          end;

      if Form.Components[I] is TEdit then
        with Form.Components[I] as TEdit do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TMemo then
        with Form.Components[I] as TMemo do
          begin
            ReadOnly := False;
            Color    := clWindow
          end;

      if Form.Components[I] is TcxDBDateEdit then
        with Form.Components[I] as TcxDBDateEdit do
          begin
            Style.Color := clWindow;
            Properties.ReadOnly := False;
          end;

      if Form.Components[I] is TcxDBCurrencyEdit then
        with Form.Components[I] as TcxDBCurrencyEdit do
          begin
            Style.Color := clWindow;
            Properties.ReadOnly := False;
          end;
    end; { for }
end;

procedure Limpiar(Formulario : TForm);
var
  I : Integer;
begin
  with Formulario do
    begin
      for I:= 0 to ComponentCount - 1 do
        if Components[I] is TEdit then
          TEdit(Components[I]).Clear;

      for I:= 0 to ComponentCount - 1 do
        if Components[I] is TComboBox then
          TComboBox(Components[I]).Text := '';

      for I:= 0 to ComponentCount - 1 do
        if Components[I] is TDBLookupComboBox then
          TDBLookupComboBox(Components[I]).KeyValue := Null;
    end;
end;

procedure MostrarForma(Formulario : TFormClass);
var
  F : TForm;
begin
  F := Application.Findcomponent(Copy(Formulario.ClassName, 2, 255)) as TForm;
  if Assigned(F) then
    F.Show
  else
    Formulario.Create(Application);
end;

// Funcion para validar una fecha...
function EsFechaValida(str : string) : Boolean;
begin
  if Length(str) = 10 then {length must be 10}
    if (Copy(str,3,1) = '-') and (Copy(str,6,1) = '-') then  {checks that both slashes should be in correct places}
      try
        StrToDate(str);
        Result := True;
      except
        Result := False;
      end;

end;

// Funcion que determina si un año es bisiesto... ( igual a IsLeapYear )
function EsBisiesto(Ano : Integer) : Boolean;
begin
  EsBisiesto := (Ano mod 4 = 0) and (Ano mod 100 <> 0) or (Ano mod 400 = 0);
end;

// FUNCION QUE DEVUELVE EL ULTIMO DIA DE UNA FECHA CUALQUIERA
function UltimoDia(Valor : TDate) : TDate;
var
  Mes, Ano, Fecha, Dia : string;
begin
  Dia    := IntToStr(CantidadDiaMes(Valor));
  Mes    := IntToStr(MonthOf(Valor));
  Ano    := IntToStr(YearOf(Valor));
  Fecha  := Mes + '/' + Dia + '/' + Ano;
  Result := StrToDate(Fecha);
end;

// FUNCION QUE DETERMINA CUANTOS DIAS TIENE UN MES
function CantidadDiaMes(Fecha : TDate) : Integer;
var
  Dia, Mes, Ano : Integer;
begin
  Mes := MonthOf(Fecha);
  Ano := YearOf(Fecha);

  case Mes of
    1, 3, 5, 7, 8, 10, 12 :
      Dia := 31;
    4, 6, 9, 11 :
      Dia := 30;
  else
    if IsLeapYear(Ano) then // Es Bisiesto
    begin
      Dia := 29;
    end
    else
    begin
      Dia := 28;
    end;
  end; // case

  Result := Dia;

end;

//FUNCION PARA EXTRAER LA FECHA DE ACUERDO A UN FORMATO ESPECIFICO
function FormatoFecha(Fecha : TDateTime; SignoSeparador : Char; Forma : Integer) : String;
var
  Present : TDateTime;
  Year, Month, Day : Word;
  Dia, Mes, Ano : String;
begin
  Present := Fecha;
  DecodeDate(Present, Year, Month, Day);
  Mes := FloatToStr(Month);
  Ano := FloatToStr(Year);
  Dia := FloatToStr(Day);

  case Forma of
    1 : Result := Ano + SignoSeparador + Mes + SignoSeparador + Dia; //Año,Mes,Dia
    2 : Result := Mes + SignoSeparador + Dia + SignoSeparador + Ano; //Mes,Dia,Año
    3 : Result := Dia + SignoSeparador + Mes + SignoSeparador + Ano; //Dia,Mes,Año
  end;

end;


function NombreMes(Mes : Integer) : String;
var Str : String;
begin
  Str := '';
  case Mes of         //Extraemos el mes de la fecha
     1 : Str := 'Enero';
     2 : Str := 'Febrero';
     3 : Str := 'Marzo';
     4 : Str := 'Abril';
     5 : Str := 'Mayo';
     6 : Str := 'Junio';
     7 : Str := 'Julio';
     8 : Str := 'Agosto';
     9 : Str := 'Septiembre';
    10 : Str := 'Octubre';
    11 : Str := 'Noviembre';
    12 : Str := 'Diciembre';
  end;
//
//  Str:= Str + 'del '+ FloatToStr(YearOf(Fecha)); //Extraemos el año de la fecha
//
  Result := Str;
end;



//FUNCION QUE DEVUELVE LA FECHA EN FORMATO LARGO EN ESPAÑOL NO IMPORTANDO EL IDIOMA DEL S.O.
function FechaLarga(Fecha : TDate) : String;
var Str : String;
begin
  Str:= '';
  case DayOfWeek(Fecha) of   //Extraemos el dia de semana de la fecha
    1 : Str := 'Domingo ';
    2 : Str := 'Lunes ';
    3 : Str := 'Martes ';
    4 : Str := 'Miércoles ';
    5 : Str := 'Jueves ';
    6 : Str := 'Viernes ';
    7 : Str := 'Sábado ';
  end;

  Str := Str + FloatToStr(DayOf(Fecha));  //Extraemos el dia de la fecha
  Str := Str + ' de';

  case MonthOf(Fecha) of         //Extraemos el mes de la fecha
     1 : Str := Str + ' Enero ';
     2 : Str := Str + ' Febrero ';
     3 : Str := Str + ' Marzo ';
     4 : Str := Str + ' Abril ';
     5 : Str := Str + ' Mayo ';
     6 : Str := Str + ' Junio ';
     7 : Str := Str + ' Julio ';
     8 : Str := Str + ' Agosto ';
     9 : Str := Str + ' Septiembre ';
    10 : Str := Str + ' Octubre ';
    11 : Str := Str + ' Noviembre ';
    12 : Str := Str + ' Diciembre ';
  end;

  Str:= Str + 'del '+ FloatToStr(YearOf(Fecha)); //Extraemos el año de la fecha

  Result:= Str;
end;

function Edad(FechaNacimiento : TDate) : string;
  var
    An,    Mn,     Dn    : Word;
    Ahoy,  Mhoy,   Dhoy  : Word;
    RAnos, Rmeses, Rdias : Word;
    Resultado : string;
begin
  DecodeDate(FechaNacimiento, An, Mn, Dn);
  DecodeDate(Now, Ahoy, Mhoy, Dhoy);

  if (Mn > Mhoy) or ((Mn = Mhoy) and (Dn > Dhoy)) then
    Ranos := Ahoy - An - 1
  else
    RAnos := Ahoy - An;

  if (Mn - Mhoy) < 0 then
    RMeses := 12 + (Mn - Mhoy);

  if (Mn - Mhoy) = 0 then
    Rmeses := 0;

  if (Mn - Mhoy) > 0 then
    RMeses := Mn - Mhoy;
  //
  if Ranos = 0 then
    begin
      case Rmeses of
        0 :
          Resultado := '';
        1 :
          Resultado := 'Un mes';
        // else
        // Resultado := inttostr(Rmeses) + ' meses';
      end;
    end
  else
    begin
      if Ranos = 1 then
        Resultado := 'Un año'
      else
        Resultado := Inttostr(Ranos) + ' años'
    end;
  case Rmeses of
    0 :
      Resultado := Resultado + '';
    1 :
      Resultado := Resultado + 'Un mes';
    else
      Resultado := Resultado + ', ' + Inttostr(Rmeses) + ' meses';
  end;
  Result := Resultado;
end;

//function Edad(Fecha : TDateTime) : string;
//var
//  Anos, Meses : Integer;
//begin
//  Anos  := YearOf(Date) - YearOf(Fecha);
//  Meses := MonthOf(Date) - MonthOf(Fecha);
//  if Meses < 0 then
//    begin
//      Anos  := Anos - 1;
//      Meses := 12 + Meses;
//    end;
//
//  Result := IntToStr(Anos) + ' años ' + IntToStr(Meses) + ' meses';
//end;


//PARA CALCULAR LA EDAD DE UNA PERSONA...
function CalcularEdad(FechaNacimiento : TDate) : Integer;
var
  an, mn, dn : Word;
  ahoy, mhoy, dhoy : Word;
begin
  DecodeDate(FechaNacimiento, an, mn, dn);
  DecodeDate(Now, ahoy, mhoy, dhoy);

  if (mn > mhoy) or ((mn = mhoy) and (dn > dhoy)) then
    Result := ahoy - an - 1
  else
    Result := ahoy - an;
end;

function DiaDeLaSemana(Fecha : TDateTime) : string;
const
  Dias : array[1..7] of string = ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo');
begin
  Result := Dias[DayOfTheWeek(Fecha)];
end;

function Hora24(HoraCorta : string; IncluyeSegundos : Boolean) : string;
var
 Fecha : TDateTime;
 Resultado : string;
begin
  // hora a convertir
  Fecha:= StrToTime(HoraCorta);

  // convertir hora a string
  if IncluyeSegundos = True then
    DateTimeToString(Resultado, 'hh:mm:ss', Fecha)
  else
    DateTimeToString(Resultado, 'hh:mm', Fecha);

  Result:= Resultado;
end;

function PrimerDiaDelMes(const Fecha : TDateTime) : TDateTime;
var
  Anio, Mes, Dia : Word;
begin
  DecodeDate(Fecha, Anio, Mes, Dia);
  Result := EncodeDate(Anio, Mes, 1);
end;

function UltimoDiaDelMes(const Fecha : TDateTime) : TDateTime;
var
  Anio, Mes, Dia : Word;
begin
  DecodeDate(Fecha, Anio, Mes, Dia);
//  Result := EndOfTheDay(EncodeDate(Anio, Mes, DaysInAMonth(Anio,Mes)));
  Result := EncodeDate(Anio, Mes, DaysInAMonth(Anio, Mes));
end;

function TiempoEntreFechas(FechaInicial : TDateTime; FechaFinal : TDateTime) : String;
var
  DiaIni, MesIni, AnioIni, DiaFin, MesFin, AnioFin : Word;
  HoraIni, MinIni, SegIni, MilSegIni, HoraFin, MinFin, SegFin, MilSegFin : Word;
  CantAnio, CantMeses, CantDias, MesesSumados, AniosSumados : Integer;
  Salida : string;
Begin
  CantAnio  := 0;
  CantMeses := 0;
  CantDias  := 0;

  FechaFinal   := Trunc(FechaFinal);

  DecodeDateTime(FechaInicial, AnioIni, MesIni, DiaIni, HoraIni, MinIni, SegIni, MilSegIni);
  DecodeDateTime(FechaFinal,   AnioFin, MesFin, DiaFin, HoraFin, MinFin, SegFin, MilSegFin);

  CantAnio  := YearsBetween(FechaFinal, FechaInicial);

  Salida := '';
  If CantAnio > 0 Then
    If CantAnio > 1 Then
      Salida := IntToStr(CantAnio) + ' años '
    Else
      Salida := IntToStr(CantAnio) + ' año ';

  AniosSumados := AnioIni + CantAnio;
  FechaInicial := RecodeDate(FechaInicial, AniosSumados, MesIni, DiaIni);
  FechaInicial := Trunc(FechaInicial);

  CantMeses    := MonthsBetween(FechaFinal, FechaInicial);

  If CantMeses > 0 Then
    If CantMeses > 1 Then
      Salida := Salida + IntToStr(CantMeses) + ' meses '
    Else
      Salida := Salida + IntToStr(CantMeses) + ' mes ';

  MesesSumados := MesIni + CantMeses;
  If MesesSumados > 12 Then
    Begin
      MesesSumados := MesesSumados - 12;
      AniosSumados := AnioIni + CantAnio + 1;
    End;

  If ((MesesSumados = 02) Or (MesesSumados = 04) Or (MesesSumados = 06) Or
      (MesesSumados = 09) Or (MesesSumados = 11)) And (DiaIni > 30) Then
    Begin
      DiaIni       := 1;
      MesesSumados := MesesSumados + 1;
    End;

  FechaInicial := RecodeDate(FechaInicial, AniosSumados, MesesSumados, DiaIni);
  CantDias := DaysBetween(FechaFinal, FechaInicial);
  If CantDias > 0 Then
    If CantDias > 1 Then
      Salida := Salida + IntToStr(CantDias) + ' días '
    Else
      Salida := Salida + IntToStr(CantDias) + ' día ';

   Result := Salida;
end;

function CalculaEdad(FechaNacimiento : TDate) : Integer;
var
  vMesFecha, vAnyFecha, vDiaFecha, vMesActual, vAnyActual, vDiaActual : Word;
  vEdad : Integer;
begin
  DecodeDate(FechaNacimiento,vAnyFecha,vMesFecha,vDiaFecha);
  DecodeDate(Now,vAnyActual,vMesActual,vDiaActual);
  if vAnyActual > vAnyFecha then
    begin
      vEdad := vAnyActual - vAnyFecha;
      if vMesActual < vMesFecha then
        vEdad := vEdad - 1
      else
        if vMesActual = vMesFecha then
          if vDiaActual < vDiaFecha then
            vEdad := vEdad - 1;
      Result := vEdad;
    end
  else
    Result := 0;

  if FechaNacimiento = 0 then
    Result := 0;
end;

// ES VERDADERO CUANDO LA FECHA NAC. LO HACE MAYOR PARA LAS PROXIMAS ELECCIONES
function MayorParaElecciones(FechaNacimiento : TDate) : Boolean;
var
  AnoActual     : SmallInt;
  FechaEleccion : TDate;
  Ano           : string;
begin
  AnoActual := StrToInt(FormatDateTime('yyyy',Date));

  if (AnoActual mod 2 ) = 0 then
    FechaEleccion := StrTodate('16/05/'+IntToStr(AnoActual))
  else
    FechaEleccion := StrTodate('16/05/'+IntToStr(AnoActual + 1));

  Ano := FormatDateTime('yyyy', (FechaEleccion - FechaNacimiento + 2));

  Result := StrToInt(Ano) > 1917;
end;

//FUNCION PARA HALLAR EL SIGLO DE UNA FECHA
function SigloDeFecha(const Fecha : TDateTime) : Integer;
var
 D,M,A : Word;
begin
  DecodeDate(Fecha,A,M,D);
  Result := (A div 100) + (A div Abs(A));
end;

{FUNCION PARA CONVERTIR SEGUNDOS A FORMATO DE HORA
 FORMATO DE SEGUNDOS COMO (hh:mm:ss) [5411 s --> 01:30:11]
  EJEMPLO : label1.Caption := DateTimeToStr(Date + SecondToTime(86543));
}
function SecondToTime(const Seconds : Cardinal) : Double;
const
  SecPerDay = 86400;
  SecPerHour = 3600;
  SecPerMinute = 60;
var
  ms, ss, mm, hh, dd : Cardinal;
begin
  dd := Seconds div SecPerDay;
  hh := (Seconds mod SecPerDay) div SecPerHour;
  mm := ((Seconds mod SecPerDay) mod SecPerHour) div SecPerMinute;
  ss := ((Seconds mod SecPerDay) mod SecPerHour) mod SecPerMinute;
  ms := 0;
  Result := dd + EncodeTime(hh, mm, ss, ms);
end;

//OTRO METODO....
function SegundoAHora(Segundos : Int64) : TDateTime;
var
 dt : TDateTime;
begin
  dt     := Segundos / MSecsPerSec / SecsPerDay;
  Result := dt;
end;


{PROCEDIMIENTO QUE DEVUELVE LA FECHA LABORAL DE LA SEMANA EN CURSO DE LUNES Y VIERNES
  ejemplo de uso :
 var
   D1, D2 : TDate;
   SemanaLaboral(D1, D2);
   DateTimePicker1.Date := D1;
   DateTimePicker2.Date := D2;
}
procedure SemanaLaboral(var Fecha1, Fecha2 : TDate);
  function GetMonday : TDate;
  var
    DoW : Integer;
    DateOffset : Integer;
  begin
    DoW := DayOfWeek(Now);
    if DoW = 1 then
      DateOffset := -6
    else
      DateOffset := Dow - 2;
    Result := Now - DateOffset;
  end;
  function GetFriday : TDate;
  var
    DoW : Integer;
    DateOffset : Integer;
  begin
    DoW := DayOfWeek(Now);
    if DoW = 1 then
      DateOffset := -2
    else
      DateOffset := Dow - 6;
    Result := Now - DateOffset;
  end;
//  function GetSunday : TDateTime;
//  var
//    Hoy : Integer;
//  begin
//    Hoy := DayOfWeek(Now);
//    if Hoy = 1 then
//      Result := Now
//    else
//      Result := Now + (8-Hoy);
//  end;
begin
  Fecha1 := GetMonday;
  Fecha2 := GetFriday;
end;

//Calendario de Semana Santa
{ El problema de las fiestas anuales para ver los dias laborables,
  no siempre es fácil. Un tema especialmente difícil son las fiestas
  de la Semana Santa. Aquí esta la forma de calcularlas : }

{ Este es el Domingo de Pascua. El jueves Santo será, Pascua-3
  y el Viernes Santo, Pascua-2. }
function ObtenerPascua(Ano : Integer) : TDate;
var
  a, b, c, AA, BB : Integer;
begin
   // Limites de la Semana Santa 22 de marzo hasta 25 de abril
   // Solo desde 1900 hasta el año 2100 las cifras 24 y 5 son cte y válidas
   a  := Ano mod 19;
   b  := Ano mod 4;
   c  := Ano mod 7;
   AA := (19 * a + 24) mod 30;
   BB := (2  * b + 4 * c + 6 * AA + 5) mod 7;

   Result:= EncodeDate(Ano,3,1) + AA + BB + 22 -1;
end;


  //Calcular meses, dias, años - Tiempo vivido después del nacimiento
{
var
  Dia, Mes, Ano : Integer;
  Fecha : TDateTime;
--
  Fecha := TiempoTranscurrido(DateTimePicker1.Date, Dia, Mes, Ano);
  Memo1.Lines.Add( 'Transcurrido : ' + IntToStr(Ano) + ' ano(s) ' +
                   IntToStr(Mes) + ' mes(es) ' + IntToStr(Dia) + ' dia(s)');
}
function TiempoTranscurrido(Fecha : TDateTime; var Dias, Meses, Anos : Integer) : TDateTime;
var
  TiempoVivido : TDateTime;
begin
  TiempoVivido := Date - (Fecha - 1);
  Dias   := StrToInt(FormatDateTime('dd', TiempoVivido)) - 1;
  Meses  := StrToInt(FormatDateTime('mm', TiempoVivido)) - 1;
  Anos   := StrToInt(FormatDateTime('yy', TiempoVivido));
  Result := TiempoVivido;
end;

{
//Hallar el Lunes y el Domingo de la semana en curso

Util por ejemplo para limitar un MonthCalendar a la semana en curso...

 procedure TForm1.MonthCalendar1GetMonthInfo(Sender: TObject;
   Month: Cardinal; var MonthBoldInfo: Cardinal);
 begin
   MonthCalendar1.MinDate:= LunesDeEstaSemana;
   MonthCalendar1.MaxDate:= DomingoDeEstaSemana;
 end;
}

//DEVUELVE EL LUNES DE LA SEMANA EN CURSO
function LunesDeEstaSemana : TDateTime;
var
 Hoy : Integer;
begin
  Hoy := DayOfWeek(Now);
  if Hoy = 1 then
    Result := Now-6
  else
    Result := Now-(Hoy-2);
end;

//DEVUELVE EL DOMINGO DE LA SEMANA EN CURSO
function DomingoDeEstaSemana : TDateTime;
var
 Hoy : Integer;
begin
  Hoy := DayOfWeek(Now);
  if Hoy = 1 then
    Result := Now
  else
    Result := Now + (8-Hoy);
end;

function FormatoFechaHoraLarga(FechaHora : TDateTime; SoloHora : Boolean = False; IncluyeSegundos : Boolean = False) : string;
var
 Dt : string;
begin
  if SoloHora = True then
    begin
      case IncluyeSegundos of
        True  : Dt := FormatDateTime('hh:mm:ss', FechaHora);
        False : Dt := FormatDateTime('hh:mm', FechaHora);
      end;
    end
  else
    begin
      case IncluyeSegundos of
        True  : Dt := FormatDateTime('dd/mm/yyyy hh:mm:ss', FechaHora);
        False : Dt := FormatDateTime('dd/mm/yyyy hh:mm', FechaHora);
      end;
    end;
  Result := Dt;
end;

function FormatoFechaHoraCorta(FechaHora : TDateTime; SoloHora : Boolean = False; IncluyeSegundos : Boolean = False) : string;
var
 Dt : string;
begin
  if SoloHora = True then
    begin
      case IncluyeSegundos of
        True  : Dt := FormatDateTime('hh:mm:ss am/pm', FechaHora);
        False : Dt := FormatDateTime('hh:mm am/pm', FechaHora);
      end;
    end
  else
    begin
      case IncluyeSegundos of
        True  : Dt := FormatDateTime('dd/mm/yyyy hh:mm:ss am/pm', FechaHora);
        False : Dt := FormatDateTime('dd/mm/yyyy hh:mm am/pm', FechaHora);
      end;
    end;
  Result := Dt;
end;

//PARA USAR EN RANGO DE FECHAS EN SQL SERVER
function DateTimeToSqlDateTime(FechaHora : TDateTime; EsFechaFinal : Boolean = False; ConMiliSegundos : Boolean = True) : WideString;
begin
  case EsFechaFinal of
    True  : ReplaceTime(FechaHora, StrToTime('23:59:59.999'));
    False : ReplaceTime(FechaHora, StrToTime('00:00:00.000'));
  end;
  case ConMiliSegundos of
    True  : Result := FormatDateTime('yyyy-MM-dd', FechaHora) + ' ' + FormatDateTime('hh:mm:ss.zzz', FechaHora);
    False : Result := FormatDateTime('yyyy-MM-dd', FechaHora) + ' ' + FormatDateTime('hh:mm:ss', FechaHora);
  end;
end;


function TimePart(const D : TDateTime) : Double;
begin
  Result := Abs(Frac(D));
end;

function IsEqual(const D1, D2 : TDateTime) : Boolean;
begin
  Result := Abs(D1 - D2) < OneMillisecond;
end;

function IsNoon(const D : TDateTime) : Boolean;
var
 T : Double;
begin
  T := TimePart(D);
  Result := (T >= 0.5) and (T < 0.5 + OneMillisecond);
end;

function IsMidnight(const D : TDateTime) : Boolean;
begin
  Result := TimePart(D) < OneMillisecond;
end;

function IsSunday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 1;
end;

function IsMonday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 2;
end;

function IsTuesday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 3;
end;

function IsWedneday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 4;
end;

function IsThursday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 5;
end;

function IsFriday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 6;
end;

function IsSaturday(const D : TDateTime) : Boolean;
begin
  Result := DayOfWeek(D) = 7;
end;

function IsWeekend(const D : TDateTime) : Boolean;
begin
  Result := Byte(DayOfWeek(D)) in [1, 7];
end;

//PROPÓSITO: SE UTILIZA PARA DETERMINAR SI UN DATETIME ES UN DÍA DE LA SEMANA.
function IsWeekday(Day : TDateTime) : Boolean;
begin
  Result := (DayOfWeek(Day) >= 2) and (DayOfWeek(Day) <= 6);
end;

function DatePart(const D : TDateTime) : Integer;
begin
  // Adjust away from zero before truncating
  if D < 0 then
    Result := Trunc(D - DateTruncateFraction)
  else
    Result := Trunc(D + DateTruncateFraction);
end;

function Century(const D : TDateTime) : Word;
begin
  Result := YearOf(D) div 100;
end;

function Noon(const D : TDateTime) : TDateTime;
const
  OneDay = 1.0;
begin
  Result := DatePart(D) + 0.5 * OneDay;
end;

function Midnight(const D : TDateTime) : TDateTime;
var
  Ye, Mo, Da : Word;
begin
  DecodeDate(D, Ye, Mo, Da);
  Result := EncodeDate(Ye, Mo, Da);
end;

function NextWorkday(const D : TDateTime) : TDateTime;
begin
  case DayOfWeek(D) of
    1..5 : Result := DatePart(D) + OneDay;      // 1..5 Sun..Thu
    6    : Result := DatePart(D) + 3 * OneDay;  // 6    Fri
  else
    Result := DatePart(D) + 2 * OneDay;         // 7    Sat
  end;
end;

function PreviousWorkday(const D : TDateTime) : TDateTime;
begin
  case DayOfWeek(D) of
    1 : Result := DatePart(D) - 2 * OneDay;  // 1    Sun
    2 : Result := DatePart(D) - 3 * OneDay;  // 2    Mon
  else
    Result := DatePart(D) - OneDay;          // 3..7 Tue-Sat
  end;
end;

function LastDayOfMonth(const D : TDateTime) : TDateTime;

  function DaysInMonth(const Ye, Mo: Word): Integer;
  const
    DaysInNonLeapMonth : array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  begin
    Result := DaysInNonLeapMonth[Mo];
    if (Mo = 2) and IsLeapYear(Ye) then
      Inc(Result);
  end;

var
  Ye, Mo, Da : Word;
begin
  DecodeDate(D, Ye, Mo, Da);
  Result := EncodeDate(Ye, Mo, Word(DaysInMonth(Ye, Mo)));
end;

function FirstDayOfMonth(const D : TDateTime) : TDateTime;
var
  Ye, Mo, Da : Word;
begin
  DecodeDate(D, Ye, Mo, Da);
  Result := EncodeDate(Ye, Mo, 1);
end;

function LastDayOfYear(const D : TDateTime) : TDateTime;
var
  Ye, Mo, Da : Word;
begin
  DecodeDate(D, Ye, Mo, Da);
  Result := EncodeDate(Ye, 12, 31);
end;

function FirstDayOfYear(const D : TDateTime) : TDateTime;
var
 Ye, Mo, Da : Word;
begin
  DecodeDate(D, Ye, Mo, Da);
  Result := EncodeDate(Ye, 1, 1);
end;

function AddMilliseconds(const D : TDateTime; const N : Int64) : TDateTime;
var
  R : Integer;
  T : Double;
begin
  R := DatePart(D) + (N div 86400000);
  T := TimePart(D) + (N mod 86400000) / 86400000.0;
  if T >= 1.0 then
  begin
    if R >= 0 then
      Inc(R)
    else
      Dec(R);
    T := Frac(T);
  end;
  if R >= 0 then
    Result := R + T
  else
    Result := R - T;
end;

function AddSeconds(const D : TDateTime; const N : Int64) : TDateTime;
var
  R : Integer;
  T : Double;
begin
  R := DatePart(D) + (N div 86400);
  T := TimePart(D) + (N mod 86400) / 86400.0;
  if T >= 1.0 then
  begin
    if R >= 0 then
      Inc(R)
    else
      Dec(R);
    T := Frac(T);
  end;
  if R >= 0 then
    Result := R + T
  else
    Result := R - T;
end;

function AddMinutes(const D : TDateTime; const N : Integer) : TDateTime;
var
  R : Integer;
  T : Double;
begin
  R := DatePart(D) + (N div 1440);
  T := TimePart(D) + (N mod 1440) / 1440.0;
  if T >= 1.0 then
  begin
    if R >= 0 then
      Inc(R)
    else
      Dec(R);
    T := Frac(T);
  end;
  if R >= 0 then
    Result := R + T
  else
    Result := R - T;
end;

function AddHours(const D : TDateTime; const N : Integer) : TDateTime;
var
  R : Integer;
  T : Double;
begin
  R := DatePart(D) + (N div 24);
  T := TimePart(D) + (N mod 24) / 24.0;
  if T >= 1.0 then
  begin
    if R >= 0 then
      Inc(R)
    else
      Dec(R);
    T := Frac(T);
  end;
  if R >= 0 then
    Result := R + T
  else
    Result := R - T;
end;

function AddDays(const D : TDateTime; const N : Integer) : TDateTime;
begin
  Result := D + N;
end;

function AddWeeks(const D : TDateTime; const N : Integer) : TDateTime;
begin
  Result := D + N * 7 * OneDay;
end;

function AddMonths(const D : TDateTime; const N : Integer) : TDateTime;
var
  Ye, Mo, Da : Word;
  IMo : Integer;
  T : Double;
begin
  DecodeDate(D, Ye, Mo, Da);
  Inc(Ye, N div 12);
  IMo := Mo;
  Inc(IMo, N mod 12);
  if IMo > 12 then
    begin
      Dec(IMo, 12);
      Inc(Ye);
    end else
    if IMo < 1 then
      begin
        Inc(IMo, 12);
        Dec(Ye);
      end;
  Mo := Word(IMo);
//  Da := Word(MinInt(Da, DaysInMonth(Ye, Mo)));
  Result := EncodeDate(Ye, Mo, Da);
  T := TimePart(D);
  if DatePart(Result) >= 0 then
    Result := Result + T
  else
    Result := Result - T;
end;

function AddYears(const D : TDateTime; const N : Integer) : TDateTime;
var
  Ye, Mo, Da : Word;
  T : Double;
begin
  DecodeDate(D, Ye, Mo, Da);
  Inc(Ye, N);
//  Da := Word(MinInt(Da, DaysInMonth(Ye, Mo)));
  Result := EncodeDate(Ye, Mo, Da);
  T := TimePart(D);
  if DatePart(Result) >= 0 then
    Result := Result + T
  else
    Result := Result - T;
end;

function DiffDateTime(const D1, D2 : TDateTime; const Period : Double) : Int64;
var
  R : Double;
begin
  R := D2 - D1;
  // Adjust away from zero to ensure correct result when truncating
  if R < 0.0 then
    R := R - DateTruncateFraction
  else
    R := R + DateTruncateFraction;
  Result := Trunc(R / Period);
end;

function DiffMilliseconds(const D1, D2 : TDateTime) : Int64;
begin
  Result := DiffDateTime(D1, D2, OneMillisecond);
end;

function DiffSeconds(const D1, D2 : TDateTime) : Int64;
begin
  Result := DiffDateTime(D1, D2, OneSecond);
end;

function DiffMinutes(const D1, D2 : TDateTime) : Int64;
begin
  Result := DiffDateTime(D1, D2, OneMinute);
end;

function DiffHours(const D1, D2 : TDateTime) : Int64;
begin
  Result := DiffDateTime(D1, D2, OneHour);
end;

function DiffDays(const D1, D2 : TDateTime) : Integer;
begin
  Result := DatePart(D2 - D1);
end;

function DiffWeeks(const D1, D2 : TDateTime) : Integer;
begin
  Result := DatePart(D2 - D1) div 7;
end;

function DiffMonths(const D1, D2 : TDateTime) : Integer;
var
  Ye1, Mo1, Da1 : Word;
  Ye2, Mo2, Da2 : Word;
  ModMonth1, ModMonth2 : TDateTime;
begin
  DecodeDate(D1, Ye1, Mo1, Da1);
  DecodeDate(D2, Ye2, Mo2, Da2);
  Result := (Ye2 - Ye1) * 12 + (Mo2 - Mo1);
  ModMonth1 := Da1 + TimePart(D1);
  ModMonth2 := Da2 + TimePart(D2);
  if (D2 > D1) and (ModMonth2 < ModMonth1) then
    Dec(Result);
  if (D2 < D1) and (ModMonth2 > ModMonth1) then
    Inc(Result);
end;

function DiffYears(const D1, D2 : TDateTime) : Integer;
var
 Ye1, Mo1, Da1 : Word;
 Ye2, Mo2, Da2 : Word;
 ModYear1, ModYear2 : TDateTime;
begin
  DecodeDate(D1, Ye1, Mo1, Da1);
  DecodeDate(D2, Ye2, Mo2, Da2);
  Result := Ye2 - Ye1;
  ModYear1 := Mo1 * 31 + Da1 + TimePart(Da1);
  ModYear2 := Mo2 * 31 + Da2 + TimePart(Da2);
  if (D2 > D1) and (ModYear2 < ModYear1) then
    Dec(Result);
  if (D2 < D1) and (ModYear2 > ModYear1) then
    Inc(Result);
end;

{PROPÓSITO: DEVUELVE HORAS, MINUTOS O SEGUNDOS EN FORMATO DECIMAL PARA USAR
 EN CÁLCULOS DE FECHA Y HORA. }
function GetDecimalTime(Count : Integer; DecimalTimeType : TDecimalTimeType) : Double;
const
  Second = 1/86400;
  Minute = 1/1440;
  Hour   = 1/24;
begin
  Result := 0;
  case DecimalTimeType of
    dtSecond  : Result := Count * Second;
    dtMinute  : Result := Count * Minute;
    dtHour    : Result := Count * Hour;
  end;
end;

//PROPÓSITO: CONVIERTE UN TIEMPO ENTERO DE ESTILO MS EN UN TIEMPO TTIME
function IntTimeToTime(Time : Integer) : TTime;
var
  S : string;
begin
  S := IntToStr(Time);
  //La cadena debe tener 5 ó 6 caracteres
  if (Length(S) < 5) or (Length(S) > 6) then
    Result := 0
  else
    begin
      if (Length(S) = 5) then //En la mañana
        S := Copy(S, 1, 1) + ':' + Copy(S, 2, 2) + ':' + Copy(S, 4, 2)
      else //En la tarde
        S := Copy(S, 1, 2) + ':' + Copy(S, 3, 2) + ':' + Copy(S, 5, 2);
      Result := StrToTime(S);
    end;
end;


//// Validando Si El Formulario Ya Esta Creado y/o Abierto.
//procedure TUtilidades.Forma(Unidad : TFormClass; var Forma : TForm);
//var
//  Indice : Integer;
//  Creada : Boolean;
//begin
//  Creada := False;
//
//  if (MDIChildCount < 1) then
//  begin
//    // Si No Existe Ningun Formulario Creado Entonces Lo Crea.
//    Application.CreateForm(Unidad, Forma);
//  end
//  else
//  begin
//    // Si Ya Existen Formularios Creados.
//    with Application.MainForm do
//      // Hago un Loop Entre los Formularios Creados
//      for Indice := 0 to MDIChildCount - 1 do
//        if (MDIChildren[Indice] = TForm(Forma)) then
//        begin
//          // Si El Formulario Ya Existe Interrumpo el Proceso de Busqueda.
//          Creada := True;
//          Break;
//        end;
//
//    if not Creada then
//    begin
//      // Si Despues de Validar El Formulario No Esta Creado Entonces Lo Creo.
//      Application.CreateForm(Unidad, Forma);
//    end
//    else
//    begin
//      // Si Despues de Validar El Formulario Ya Esta Creado Entonces Lo Muestro al Frente.
//      MDIChildren[Indice].BringToFront;
//    end;
//  end;
//end;

{
FUNCION QUE EMULA EL INPUTBOX DE DELPHI.
EJEMPLO :

var
  vTest : string;
begin
  if (InputValor('Title','Digite el valor', vTest) = True) then
    ShowMessage(vTest);
end;

}

function InputValor(const aCaption : string; APrompt : string; var aValor : string; Password : Boolean = False; SoloNumero : Boolean = False) : Boolean;
var
  vForm      : TForm;
  vLabel     : TLabel;
  vBtnOk     : TBitBtn;
  vValor     : TEdit;
  vBtnCancel : TBitBtn;
begin
  vForm      := TForm.Create(Application);
  vLabel     := TLabel.Create(vForm);
  vValor     := TEdit.Create(vForm);
  vBtnOk     := TBitBtn.Create(vForm);
  vBtnCancel := TBitBtn.Create(vForm);

  with vForm do
    begin
      Name           := 'frmValor';
      Position       := poScreenCenter;
      BorderIcons    := [biSystemMenu];
      BorderStyle    := bsDialog;
      Caption        := aCaption;
      ClientHeight   := 150;
      ClientWidth    := 515;
      Color          := clBtnFace;
//      OldCreateOrder := False;
      Font.Charset   := DEFAULT_CHARSET;
      Font.Color     := clWindowText;
      Font.Height    := -11;
      Font.Name      := 'Tahoma';
      Font.Style     := [];
//      OldCreateOrder := False;
      PixelsPerInch  := 96;
      Left           := 0;
      Top            := 0;
      Height         := 130;
      Width          := 280;
    end;

  with vLabel do
    begin
      Name     := 'vLabel';
      Parent   := vForm;
      AutoSize := False;
      Left     := 18;
      Top      := 15;
      Width    := 484;
      Height   := 41;
      Caption  := APrompt;
      WordWrap := True;
    end;

  with vValor do
    begin
      Name   := 'vValorEdit';
      Parent := vForm;
      Left   := 18;
      Top    := 30;
      Width  := 225;
      Height := 21;
      Text   := '';
      if Password = True then
        PasswordChar := '*';

      NumbersOnly := SoloNumero;
    end;

  with vBtnOk do
    begin
      Name        := 'vBtnOk';
      Parent      := vForm;
      Caption     := 'Aceptar';
      Left        := 80;
      Top         := 60;
      Width       := 75;
      Height      := 25;
      TabOrder    := 1;
      ModalResult := mrOk;
    end;

  with vBtnCancel do
    begin
      Name        := 'vBtnCancel';
      Parent      := vForm;
      Caption     := 'Cancelar';
      Left        := 167;
      Top         := 60;
      Width       := 75;
      Height      := 25;
      TabOrder    := 2;
      ModalResult := mrCancel;
    end;

  vForm.ShowModal;

  if (vForm.ModalResult = mrOk) and (vValor.Text <> '') then
    begin
      Result := True;
      aValor := vValor.Text;
    end
  else
    begin
      Result := False;
      aValor := '';
    end;

  FreeAndNil(vForm);
end;

//FUNCION PARA ENCRIPTAR Y DESENCRIPTAR UNA CADENA DE CARACTERES
function EnDeCrypt(const Value : string) : string;
var
  CharIndex : Integer;
begin
  Result := Value;
  for CharIndex := 1 to Length(Value) do
    Result[CharIndex] := Chr(not(ord(Value[CharIndex])));
end;

function NPos(Cadena : string; SubCadena : string; Posicion : Integer) : Integer;
var
  Temp : string;
  N, I : Integer;
begin
  N := Posicion;
  Temp := '';
  I := 1;
  while I <= N do
    begin
      Posicion:= Pos(SubCadena, Cadena);
      if Posicion <> 0 then
        begin
          Temp := Temp + Copy(Cadena, 1, Posicion);
          Delete(Cadena, 1, Posicion);
        end
      else
        Temp := Cadena;
        Inc(I);
    end;

  Result := Length(Temp);
end;

//Devuelve la última posición de SubString en S.
function LastPos(SubStr, S : string) : Integer;
var
  Found, Len, Pos : Integer;
begin
  Pos := Length(S);
  Len := Length(SubStr);
  Found := 0;
  while (Pos > 0) and (Found = 0) do
    begin
      if Copy(S, Pos, Len) = SubStr then
        Found := Pos;
      Dec(Pos);
    end;
  Result := Found;
end;

//FUNCION PARA PONER LA PRIMERA LETRA EN MAYUSCULA DEJANDO EL RESTO EN MINUSCULAS
function Capitalizar(const Cadena : string) : string;
var
  Flag : Boolean;
  I : Integer;
  Resultado : string;
begin
  Flag := True;
  Resultado := '';
  for I := 1 to Length(Cadena) do
    begin
      if Flag then
        Resultado:= Resultado + UpCase(Cadena[I])
      else
        Resultado:= Resultado + Cadena[I];
      Flag := (Cadena[I] = ' ');
    end;

  Result := Resultado;
end;

function CambiarARomano(Numero : Integer) : string;
const
  Numeros : array[1..13] of integer = (1,4,5,9,10,40,50,90,100,400,500,900,1000);
  Romanos : array[1..13] of string = ('I','IV','V','IX','X','XL','L','XC','C','CD','D','CM','M');
var
  Cont : Byte;
begin
  for Cont:= 13 downto 1 do
    while (Numero >= Numeros[Cont]) do
      begin
        Numero:= Numero - Numeros[Cont];
        Result:= Result + Romanos[Cont];
      end;
end;

function EsNumero(const Num : string) : Boolean;
begin
  Result:= True;
  try
    StrToFloat(Num);
  except
    Result:= False;
  end;
end;

//function IsNumber(Num : string) : Boolean;
//var
//  I : Integer;
//begin
//  Result := False;
//  for I := 1 to Length(Num) do
//    case Num[I] of
//      '0'..'9':;
//      else
//        Exit;
//    end;
//  Result := True;
//end;

function IsSeparator(Caracter : Char) : Boolean;
begin
  case Caracter of
    '.', ';', ',', ':', '،', '!', '·', '"', '''', '^', '+', '-', '*', '/', '\', '¨', ' ',
    '`', '[', ']', '(', ')', '؛', 'ھ', '{', '}', '?', '؟', '%', '=': Result := True;
    else
      Result := False;
  end;
end;

//ELIMINAR DE UNA CADENA LOS N CARACTERES QUE APARECEN A PARTIR DE LA POSICION P
function EliminarCaracteres(Cadena : string; Posicion, N : Integer) : string;
begin
  if (Posicion <= 0) or (N <= 0) then
    Result := Cadena
  else
    Result := Copy(Cadena,1,Posicion-1) + Copy(Cadena, Posicion + N, Length(Cadena));
end;

function CopyEntre(Cadena : string; Desde, Hasta : string) : string;
var
 Inicio, Final : Integer;
begin
  Inicio := Pos(Desde,Cadena) + Length(Desde);
  Final  := PosEx(Hasta,Cadena,Inicio);
  if (Inicio > 0) and (Final > Inicio) then
    Result := Copy(Cadena, Inicio, Final - Inicio);
end;

function DeleteEntre(var Cadena : string; const Desde, Hasta :string; const Tags : Boolean) : Boolean;
   {
    Elimina la sub-string de la string 'Cadena' comprendida
    entre las primeras ocurrencias de 'Desde' y 'Hasta'.
    Si Tags=TRUE tambien elimina las cadenas de inicio y final
    Ejemplo, TAG=FALSE:
            Cadena:= '44444444|Delete Esto|5555555';
            Cadena:= DeleteEntre(Cadena,'|','|',FALSE);
    Cadena valdría: '44444444||5555555'

    Ejemplo, TAG=TRUE:
            Cadena:= '44444444|Delete Esto|5555555';
            Cadena:= DeleteEntre(Cadena,'|','|',TRUE);
    Cadena valdría: '444444445555555'
   }
var
 Inicio, Final : Integer;
begin
  Result := False;
  if Tags then
    begin
      {Si hay que eliminar tambien el inicio y final}
      Inicio := AnsiPos(Desde,Cadena);
      Final  := AnsiPos(Hasta,Cadena) + Length(Hasta);
    end
  else
    begin
      Inicio := AnsiPos(Desde,Cadena) + Length(Desde);
      Final  := AnsiPos(Hasta,Cadena);
    end;

  {Si se encontraron 'Desde' y 'Hasta'}
  if (Inicio > 0) and (Final > Inicio) then
    begin
      Delete(Cadena, Inicio, Final - Inicio);
      Result := True;
    end;
end;

//FUNCION QUE EXTRAE CADENA HASTA EL ULTIMO CARACTER ESPECIFICADO
function ExtraerHastaUltimo(Cadena : string; Caracter : Char) : string;
var
  I : Integer;
begin
  I:= Length(Cadena);
  while (I > 0) and (Cadena[I] <> Caracter) do
    Dec(I);

  Result := Copy(Cadena, 1, I-1);
end;

function CopyRange(const S : String; const StartIndex, StopIndex: Integer): String;
var
  J, I : Integer;
begin
  J := Length(S);
  if (StartIndex > StopIndex) or (StopIndex < 1) or (StartIndex > J) or (J = 0) then
    Result := ''
  else
    begin
      if StartIndex <= 1 then
        if StopIndex >= J then
          begin
            Result := S;
            exit;
          end
        else
          I := 1
      else
        I := StartIndex;
      Result := Copy(S, I, StopIndex - I + 1);
    end;
end;

function CopyFrom(const S: String; const Index: Integer): String;
var
  I : Integer;
begin
  if Index <= 1 then
    Result := S
  else
    begin
      I := Length(S);
      if (I = 0) or (Index > I) then
        Result := ''
      else
        Result := Copy(S, Index, I - Index + 1);
    end;
end;

function CopyLeft(const S: String; const Count: Integer): String;
var
  I : Integer;
begin
  I := Length(S);
  if (I = 0) or (Count <= 0) then
    Result := ''
  else
    if Count >= I then
      Result := S
    else
      Result := Copy(S, 1, Count);
end;

function CopyRight(const S: String; const Count: Integer): String;
var
  I : Integer;
begin
  I := Length(S);
  if (I = 0) or (Count <= 0) then
    Result := ''
  else
    if Count >= I then
      Result := S
    else
      Result := Copy(S, I - Count + 1, Count);
end;

function LPad(Value: string; Key : Char = ' '; ALenght : Integer = 0) : string;
var
  iLen : Integer;
begin
  iLen:= Length(Value);

  if (iLen > ALenght) then
    Result:= Copy(Value, 1, ALenght)
  else
    Result:= StringOfChar(Key, ALenght - iLen) + Value;
end;

function RPad(Value: string; Key : Char = ' '; ALenght : Integer = 0) : string;
var
  iLen : integer;
begin
  iLen:= Length(Value);

  if (iLen > ALenght) then
    Result:= Copy(Value, 1, ALenght)
  else
    Result:= Value + StringOfChar(Key, ALenght - iLen);
end;

function AlineaDerecha(S : string; N : Integer) : string;
begin
  Result:= StringOfChar(' ',N-Length(S)) + S;
end;

function AlineaIzquierda(S : string; N : Integer) : string;
begin
  Result:= S + StringOfChar(' ',N-Length(S));
end;

function Alinea(S : string; N : Integer) : string;
begin
  while Length(S) < N do
   Insert(' ',S,Length(S) + 1);
  Result:= S;
end;

function RellenaLinea (Longitud : SmallInt; Rellena : Char) : String;
begin
   Result := '';
   while Length(Result) < Longitud do
      Result := Result + Rellena;
end;

function Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;
var
  LongTexto : SmallInt;
begin
  LongTexto := Length(Texto);
  if  LongTexto  < Longitud then
    begin
      LongTexto := Longitud - LongTexto;
      case Justificado of
        tjLeft   : Texto := Texto + RellenaLinea(LongTexto, Rellena);
        tjRight  : Texto := RellenaLinea(LongTexto, Rellena) + Texto;
        tjCenter : Texto := RellenaLinea((LongTexto - Round(LongTexto/ 2)), Rellena) +
                            Texto + RellenaLinea((Round(LongTexto/ 2)), Rellena);
      end;
    end;
   Result := Texto;
end;

//FUNCION PARA ELIMINAR LOS ESPACIOS DE UNA CADENA
function EliminarEspacios(Str : string) : string;
var
  I : Integer;
begin
  I:= 0;
  while I <= Length(Str) do
    if Str[I] = ' ' then
      Delete(Str,I,1)
    else
      Inc(I);
  Result:= Str;
end;

//FUNCION PARA ELIMINAR UN CARACTER ESPECIFICO DE UNA CADENA
function EliminarCaracter(Cadena, Caracter : string) : string;
var
  I : Integer;
begin
  I:= 0;
  while I <= Length(Cadena) do
    if Cadena[I] = Caracter then
      Delete(Cadena,I,1)
    else
      Inc(I);
  Result:= Cadena;
end;

//REEMPLAZAR CARACTERES ESPECIALES (MEJORADO)
function CambiarCaracterEspecial(Cadena : string; EliminarExtras : Boolean) : string;
const
  //Lista de caracteres especiales
  Especiales : array[1..38] of string = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                      'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                      'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                      'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para cambiar
  Cambiar : array[1..38] of string = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                      'e', 'e','E', 'E','i', 'i','I', 'I',
                                      'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                      'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  //Lista de Caracteres Extras
  Extras : array[1..48] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                      '(',')','_','+','=','{','}','[',']','?',
                                      ';',':',',','|','*','"','~','^','´','`',
                                      '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                      '®','½','¼','ß','µ','þ','ý','Ý');
var
  xTexto : string;
  I : Integer;
begin
  xTexto := Cadena;
  for I:= 1 to 38 do
    xTexto := StringReplace(xTexto, Especiales[I], Cambiar[I], [rfreplaceall]);
  //Según el parámetro EliminarExtras, elimina caracteres extra.
  if (EliminarExtras) then
    for I:= 1 to 48 do
      xTexto := StringReplace(xTexto, Extras[I], '', [rfreplaceall]);
   Result := xTexto;
end;

{Devuelve una cadena de caracteres que preceden a una parte de la cadena seleccionada.
 ejemplo: Before(La casa de jorge es bonita, 'jorge') devuelve : La casa de  }
function Before(const Cadena, Buscar : string) : string;
const
  BlackSpace = [#33..#126];
var
  Index : Byte;
begin
  Index := Pos(Buscar, Cadena);
  if Index = 0 then
    Result := Cadena
  else
    Result := Copy(Cadena, 1, Index - 1);
end;

{Devuelve una cadena después de la parte seleccionada de la cadena.
 ejemplo: After(La casa de jorge es bonita, 'jorge') devuelve : es bonita. }
function After(const Cadena, Buscar : string) : string;
var
  Index : Byte;
begin
  Index := Pos(Buscar, Cadena);
  if Index = 0 then
    begin
      Result := '';
    end
  else
    begin
      Result := Copy(Cadena, Index + Length(Buscar), 255);
    end;
end;

function ContieneNumero(Numero : string) : Boolean;
var
 I : Integer;
begin
 Result:= False;
 for I:= 1 to Length(Numero) do
   if Numero[I] in ['0'..'9'] then
     begin
       Result:= True;
       Break;
     end;
end;

{ FUNCION QUE VERIFICA SI UN VARIANT ESTA VACIO O NULO (DEVUELVE TRUE SI EL VARIANT ESTA VACIO O NULO)
  NOTA : PARA EVITAR LOS NULL EN LOS VARIANT PONER ESTA LINEA ANTES DE PROCESAR
  NullStrictConvert := False;  //evitar el error de conversión NULL OLE }
function IsEmptyOrNull(const Value : Variant) : Boolean;
begin
  Result := VarIsClear(Value) or VarIsEmpty(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
  if (not Result) and VarIsStr(Value) then
    Result := Value = '';
end;

//FUNCION QUE DEVUELVE LA LETRA DE LA COLUMNA DE EXCEL DE ACUERDO A SU NUMERO
function LetraExcell(I : Integer) : string;
const Letras = 'ABCDEFGHIJKLMNOPKRSTUVWXYZ';
begin
  Result := '';
  while I > 0 do
    begin
      Result := Letras[1 + ((I - 1) mod Length(Letras))] + Result;
      I := (I - 1) div Length(Letras);
    end;
end;

//SE OBTIENE LA LETRA DE LA COLUMNA TOMANDO COMO PARAMETRO EL NÚMERO DE COLUMNA EN EXCEL
function AlphaBase(Num : Integer) : string;
begin
  Result := '';
  if Num < 1 then
    Exit;
  Result := Chr(((Num-1) mod 26)+65);
  if Num > 26 then
    Result := AlphaBase((Num-1) div 26) + Result;
end;

//SE OBTIENE EL NÚMERO DE COLUMNA TOMANDO COMO PARAMETRO LA LETRA DE LA COLUMNA EN EXCEL
function AlphaBase(Letra : string) : Integer;
var
  I : Integer;
begin
  Letra  := UpperCase(Letra);
  Result := 0;
  I := Length(Letra);
  if I < 1 then
    Exit;
  Result := Ord(Letra[I])-64;
  if I > 1 then
    Result := AlphaBase(LeftStr(Letra,I-1)) * 26 + Result;
end;

{ *** FUNCIONES PARA EL MANEJO DE CADENAS DELIMITADAS *** }

//PARA OBTENER EL TOKEN DE ACUERDO A SU NUMERO EN LA CADENA DELIMITADA...
function GetToken(Cadena, Separador : string; Token : Integer) : string;
 {
 Cadena     es la string delimitada en la que buscamos el token
 Separador  es la string que separa cada token
 Token      es el número de token que buscamos
 }
 var
   Posicion : Integer;
begin
  while Token > 1 do
    begin
      Delete(Cadena,1,Pos(Separador,Cadena));
      Dec(Token);
    end;

  Posicion:= Pos(Separador,Cadena);

  if Posicion = 0 then
    Result := Cadena
  else
    Result:= Trim(Copy(Cadena,1,Posicion - Length(Separador)));
end;

//PARA OBTENER LA CANTIDAD DE TOKENS EN LA CADENA DELIMITADA...
function GetTokenCount(Cadena, Separador : string) : Integer;
var
  I, xLen, TotalTokens : Integer;
  xFlag : Boolean;
begin
  TotalTokens := 0;
  xLen        := Length(Cadena);
  I           := 1;
  xFlag := False;
  while (I <= xLen) and (xLen <> 0) do
    begin
      if (Cadena[I] = Separador) then
        xFlag := False
      else
        begin
          if (not xFlag) then
            begin
              xFlag := True;
              Inc(TotalTokens);
            end;
        end;
      Inc(I);
    end;
  Result := TotalTokens;
end;

//PARA OBTENER EL ULTIMO TOKEN EN LA CADENA DELIMITADA...
function LastToken(Cadena, Separador : string) : string;
begin
  Result := GetToken(Cadena, Separador, GetTokenCount(Cadena, Separador));
end;

//PARA SABER SI EL VALOR DEL TOKEN ES EL ULTIMO EN LA CADENA DELIMITADA...
function IsLastToken(Cadena, Separador : string; TokenName : string) : Boolean;
var
  I, NumToken, TotalTokens : Integer;
begin
  NumToken    := 0;
  TotalTokens := GetTokenCount(Cadena, Separador);

  for I:= 1 to TotalTokens do
    begin
      if Trim(TokenName) = Trim(GetToken(Cadena, Separador, I)) then
        begin
          NumToken := I;
          Break;
        end;
    end;

  if NumToken = TotalTokens then
    Result := True
  else
    Result := False;
end;

//CALCULA EL DIGITO VERIFICADOR DEL NUMERO DE CEDULA (ALGORITMO JCE)
function Calcula_Verificador(Numero : string) : Integer;
var
 Valor, Digito1, Digito2, Suma, I, Longitud : Integer;
begin
  Suma:= 0;
  I:= 0;
  Longitud:= Length(Numero);

  while (I < Longitud) do
    begin
      Inc(I);
      if (I mod 2 = 1) then
        Valor:= StrToInt(Copy(Numero, I, 1)) * 1
      else
        Valor:= StrToInt(Copy(Numero, I, 1)) * 2;

      if (Valor > 9) then
        begin
          Digito1:= Valor div 10;
          Digito2:= Valor mod 10;
          Suma:= Suma + Digito1 + Digito2;
        end
      else
        Suma:= Suma + Valor;
    end;
  if (Suma mod 10 = 0) then
    Suma:= 0
  else
    Suma:= Abs(10 - (Suma mod 10));

  Result:= Suma;
end;

//CON ESTA FUNCION VALIDAMOS SI UNA CEDULA ES VALIDA...
function Verifica_Digito_Verificador(Cedula : string) : Boolean;
var
 Salida : Integer;
 Numero : string;
 Longitud :  Integer;
begin
  Longitud:= Length(Cedula) - 1;
  Numero:= AnsiLeftStr(Cedula,Longitud);
  Salida:= Calcula_Verificador(Numero);

  if (Salida = StrToInt(AnsiRightStr(Cedula,1))) then
    Result:= True
  else
    Result:= False;
end;

//PARA VALIDAR UNA DIRECCIÓN DE CORREO ELECTRÓNICO (E-MAIL)
function ValidarEmail(const Value : string) : Boolean;
  function CheckAllowed(const s : string) : Boolean;
  var i : Integer;
  begin
    Result:= False;
    for i:= 1 to Length(s) do //illegal char in s -> no valid address
    if not (s[i] in ['a'..'z','A'..'Z','0'..'9','_','-','.']) then
      Exit;
      Result:= True;
  end;

var
  i, len : Integer;
  namePart, serverPart : string;
begin // of IsValidEmail
  Result:= False;
  i:= Pos('@', Value);
  if (i=0) or (Pos('..',Value) > 0) then
    Exit;
  namePart:= Copy(Value, 1, i - 1);
  serverPart:= Copy(Value,i+1,Length(Value));
  len:= Length(serverPart);
  // must have dot and at least 3 places from end, 2 places from begin
  if (len<4) or (Pos('.',serverPart)=0) or (serverPart[1]='.') or
    (serverPart[len]= '.') or (serverPart[len-1]='.') then
    Exit;
  Result:= CheckAllowed(namePart) and CheckAllowed(serverPart);
end;

// FUNCIÓN PARA GENERAR CONTRASEÑAS ALEATORIAMENTE
function PasswordRandom(const Tamano : Integer; Numeros : Boolean = True;
  Mayusculas : Boolean = True; Minusculas : Boolean = True) : string;
var
  Num, Mai, Min : Integer;
begin
  Result := '';
  Randomize;

  if (not Numeros) and (not Mayusculas) and (not Minusculas) then
    Exit;

  while Length(Result) < Tamano do
    begin
      Num := Trunc(Random(10)); // Número randomico
      Mai := Trunc(Random(26)) + 65; // 65 -  90
      Min := Trunc(Random(26)) + 97; // 97 - 122
      case Trunc(Random(3) + 1) of
        1 : if Numeros then
              Result := Result + IntToStr(Num)
            else
              Continue;

        2 : if Minusculas then
              Result := Result + Chr(Min)
            else
              Continue;

        3 : if Mayusculas then
              Result := Result + Chr(Mai)
            else
              Continue;
      end;
    end;
end;

//FUNCION PARA OBTENER LA MAC DE LA TARJETA DE RED DEL EQUIPO
function ObtenerMacAdress : string;
var
  NCB : PNCB;
  Adapter : PAdapterStatus;
  URetCode : PChar;
  RetCode : AnsiChar;
  I : integer;
  Lenum : PlanaEnum;
  _SystemID : string;
  TMPSTR : string;
begin
  Result    := '';
  _SystemID := '';
  Getmem(NCB, SizeOf(TNCB));
  Fillchar(NCB^, SizeOf(TNCB), 0);

  Getmem(Lenum, SizeOf(TLanaEnum));
  Fillchar(Lenum^, SizeOf(TLanaEnum), 0);

  Getmem(Adapter, SizeOf(TAdapterStatus));
  Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);

  Lenum.Length    := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(Lenum);
  NCB.ncb_length  := SizeOf(Lenum);
  RetCode         := Netbios(NCB);

  i:= 0;
  repeat
    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBRESET);
    Ncb.ncb_lana_num := lenum.lana[I];
    RetCode          := Netbios(Ncb);

    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBASTAT);
    Ncb.ncb_lana_num := lenum.lana[I];
    // Must be 16
    Ncb.ncb_callname := '*               ';

    Ncb.ncb_buffer := Pointer(Adapter);
    Ncb.ncb_length := SizeOf(TAdapterStatus);
    RetCode        := Netbios(Ncb);
    //---- calc _systemId from mac-address[2-5] XOR mac-address[1]...
    if (RetCode = chr(0)) or (RetCode = chr(6)) then
      begin
        _SystemId:= IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[1]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[2]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[3]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[4]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[5]), 2);
      end;
    Inc(i);
  until (I >= Ord(Lenum.Length)) or (_SystemID <> '00-00-00-00-00-00');
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
  Result:= _SystemID;
end;

//FUNCIÓN PARA OBTENER EL NUMERO DE IP DEL PC
function ObtenerIP : string;
var
  Buffer: array[0..127] of char;
  WSAData: TWSADATA;
  HostEnt: phostent;
begin
  Result:= '';
  FillChar(Buffer,Sizeof(Buffer),#0);
  if WSAStartup(MAKEWORD(1, 1), WSADATA) = 0 then
  begin
    if GetHostName(@Buffer,Sizeof(Buffer)) = 0 then
    begin
      HostEnt:= gethostbyname(@Buffer);
      if HostEnt <> nil then
        Result:= String(inet_ntoa(PInAddr(HostEnt.h_addr_list^)^));
    end;
    WSACleanup;
  end;
end;

{ Funcion para Obtener la IP del equipo y la IP pública con la que
  nos identificamos en Internet. Ej. GetIpList(Memo1.Lines) }

procedure GetIPList(const List : TStrings);
var
  WSAData: TWSAData;
  HostName: array[0..255] of AnsiChar;
  HostInfo: PHostEnt;
  InAddr: ^PInAddr;
begin
  List.Clear;
  if WSAStartup($0101, WSAData) = 0 then
  try
    if gethostname(HostName, SizeOf(HostName)) = 0 then
    begin
      HostInfo := gethostbyname(HostName);
      if HostInfo <> nil then
      begin
        InAddr := Pointer(HostInfo^.h_addr_list);
        if (InAddr <> nil) then
          while InAddr^ <> nil do
          begin
            List.Add(inet_ntoa(InAddr^^));
            Inc(InAddr);
          end;
      end;
    end;
  finally
    WSACleanup;
  end;
end;

//FUNCION PARA OBTENER GRUPO DE TRABAJO Ó DOMINIO DE UN PC
function ObtenerGrupoTrabajo : AnsiString;
type
 WKSTA_INFO_100 = record
 wki100_platform_id : Integer;
 wki100_computername : PWideChar;
 wki100_langroup : PWideChar;
 wki100_ver_major : Integer;
 wki100_ver_minor : Integer;
end;

 WKSTA_USER_INFO_1 = record
 wkui1_username: PChar;
 wkui1_logon_domain: PChar;
 wkui1_logon_server: PChar;
 wkui1_oth_domains: PChar;
end;

type
 //Win9X ANSI prototypes from RADMIN32.DLL and RLOCAL32.DLL

 TWin95_NetUserGetInfo = function(ServerName, UserName: PChar; Level: DWORD; var
   BfrPtr: Pointer): Integer; stdcall;
 TWin95_NetApiBufferFree = function(BufPtr: Pointer): Integer; stdcall;
 TWin95_NetWkstaUserGetInfo = function(Reserved: PChar; Level: Integer; var
   BufPtr: Pointer): Integer; stdcall;

 //WinNT UNICODE equivalents from NETAPI32.DLL

 TWinNT_NetWkstaGetInfo = function(ServerName: PWideChar; level: Integer; var
   BufPtr: Pointer): Integer; stdcall;
 TWinNT_NetApiBufferFree = function(BufPtr: Pointer): Integer; stdcall;

 function IsWinNT : Boolean;
 var
   VersionInfo : TOSVersionInfo;
 begin
   VersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
   Result:= GetVersionEx(VersionInfo);
   if Result then
     Result:= VersionInfo.dwPlatformID = VER_PLATFORM_WIN32_NT;
 end;

var
 Win95_NetUserGetInfo: TWin95_NetUserGetInfo;
 Win95_NetWkstaUserGetInfo: TWin95_NetWkstaUserGetInfo;
 Win95_NetApiBufferFree: TWin95_NetApiBufferFree;

 WinNT_NetWkstaGetInfo: TWinNT_NetWkstaGetInfo;
 WinNT_NetApiBufferFree: TWinNT_NetApiBufferFree;

 WSNT: ^WKSTA_INFO_100;
 WS95: ^WKSTA_USER_INFO_1;

 EC : DWORD;
 hNETAPI : THandle;
begin
  try
   Result:= '';
   if IsWinNT then
     begin
       hNETAPI:= LoadLibrary('NETAPI32.DLL');
       if hNETAPI <> 0 then
       begin
         @WinNT_NetWkstaGetInfo:= GetProcAddress(hNETAPI, 'NetWkstaGetInfo');
         @WinNT_NetApiBufferFree := GetProcAddress(hNETAPI, 'NetApiBufferFree');

         EC:= WinNT_NetWkstaGetInfo(nil, 100, Pointer(WSNT));
         if EC = 0 then
           begin
             Result:= WideCharToString(WSNT^.wki100_langroup);
             WinNT_NetApiBufferFree(Pointer(WSNT));
           end;
       end;
     end
   else
     begin
       hNETAPI:= LoadLibrary('RADMIN32.DLL');
       if hNETAPI <> 0 then
         begin
           @Win95_NetApiBufferFree:= GetProcAddress(hNETAPI, 'NetApiBufferFree');
           @Win95_NetUserGetInfo:= GetProcAddress(hNETAPI, 'NetUserGetInfoA');
           EC:= Win95_NetWkstaUserGetInfo(nil, 1, Pointer(WS95));
           if EC = 0 then
             begin
               Result:= WS95^.wkui1_logon_domain;
               Win95_NetApiBufferFree(Pointer(WS95));
             end;
         end;
     end;
  finally
    if hNETAPI <> 0 then
      FreeLibrary(hNETAPI);
  end;
end;

//FUNCIÓN EN DELPHI QUE OBTIENE EL NOMBRE DEL PC EN LA RED
function ObtenerNombrePC() : AnsiString;
var
  Nombre : AnsiString;
  DatosSocket : WSAData;
begin
  WSAStartup($0101, DatosSocket);
  SetLength(nombre, MAX_PATH);
  gethostname(PAnsiChar(Nombre), MAX_PATH);
  SetLength(Nombre, StrLen(PansiChar(Nombre)));
  Result := Nombre;
end;

// OBTIENE EL NOMBRE DEL USUARIO LOGUEADO EN WINDOWS
function NombreUsuarioWindows : string;
var
  Buffer : array[0..31] of Char;
begin
  GetEnvironmentVariable('USERNAME', @Buffer, SizeOf(Buffer));
  Result := Buffer;
end;

{ Funcion que quita los caracteres invalidos a un monto para
  poder hacer calculos con dicho monto. }
function SinFormato(Str : string) : Double;
var
 I : Integer;
begin
  for I:= Length(Str) downto 1 do
    begin
      if not (Str[I] in ['0'..'9','-','.']) then
        Delete(Str,I,1);
    end;
  Result:= StrToFloat(Str);
end;

procedure LimpiarMemData(MemData : TdxMemData);
begin
  MemData.Close;
  MemData.Open;
end;

//function CerosIzquierda(S : string; N : Integer) : string;
//begin
//  Result:= StringOfChar('0', N - Length(S)) + S;
//end;
//
//function CerosDerecha(Texto : string; I : Byte) : string;
//var X, Y : Byte;
//begin
//  X:= I - Length(Texto);
//  if Length(Texto) < X then
//    begin
//      Result:= Texto;
//      for Y:= 1 to X do
//        Result:= Result + '0';
//    end
//  else
//    Result:= Texto;
//end;


{
  Me gustaría saber si una red se centra en utilizar la propiedad ActiveControl
  y sus propiedades. Pero por desgracia no puedo averiguar cómo hacer esto.
  Por favor, ayúdame.

  solución :

  En realidad, es necesario escribir código adicional para determinar si una
  red o una de sus controles internos tiene el foco. Esto se debe a la
  ActiveControl nunca puede ser del tipo TcxGrid. O es un objeto TcxGridSite o
  un editor interno del editor en el lugar de la cuadrícula. Por lo tanto, usted
  debe tener cuidado de esta circunstancia al escribir el código que hemos
  mencionado. A continuación encontrará una función personalizada que muestra
  cómo hacer esto. Esperemos que sea útil para usted.
}

//Para determinar si un CxGrid esta activo
function IsGridFocused : Boolean;
var
  AContainer : TcxCustomEdit;
begin
  Result:= Screen.ActiveControl is TcxGridSite;
  if not Result then
    begin
      AContainer:= nil;
      if Screen.ActiveControl is TcxCustomEdit then
        begin
          AContainer:= TcxCustomEdit(Screen.ActiveControl);
          Result:= True;
        end
      else
        if (Screen.ActiveControl.Parent <> nil) and
          (Screen.ActiveControl.Parent is TcxCustomEdit) then
          begin
            AContainer:= TcxCustomEdit(Screen.ActiveControl.Parent);
            Result:= True;
          end;
      Result:= Result and (AContainer.Parent is TcxGridSite);
    end;
end;

{
  Cuando un TcxDBTextEdit se centra, el Screen.ActiveControl tiene la
  TcxCustomInnerTextEdit tipo. En mi opinión, el ActiveControl deben ser del
  tipo TcxDBTextEdit. ¿Cómo podría yo determinar si ActiveControl es del tipo
  o TcxTextEdit TcxDBTextEdit?

  solución :

  Por su diseño, nuestros editores son contenedores (para apoyar estilos CX)
  para los editores de interior que implementan la funcionalidad de edición.
  Usted puede utilizar código similar al siguiente para obtener el editor
  correspondiente a un control interno en particular:
}

function GetEditor : TcxCustomEdit;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomEdit(AControl.Owner)
  else
    if AControl is TcxCustomEdit then
      Result:= TcxCustomEdit(AControl);
end;

{EJEMPLO DE USO :
  if (Key in [VK_UP,VK_DOWN,VK_RETURN])
  and (not (GetListBox is TcxListBox)) then
}
function GetListBox : TcxCustomEditContainer;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomEditContainer(AControl.Owner)
  else
    if AControl is TcxCustomEditContainer then
      Result:= TcxCustomEditContainer(AControl);
end;

{EJEMPLO DE USO :
  if (Key in [VK_UP,VK_DOWN,VK_RETURN])
  and (not (GetLookupComboBox is TcxLookupComboBox)) then
}

function GetLookupComboBox : TcxCustomLookupComboBox;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomLookupComboBox(AControl.Owner)
  else
    if AControl is TcxCustomLookupComboBox then
      Result:= TcxCustomLookupComboBox(AControl);
end;

{EJEMPLO DE USO :
  if (Key in [VK_UP,VK_DOWN,VK_RETURN])
  and (not (GetCurrencyEdit is TcxCurrencyEdit)) then
}

function GetCurrencyEdit : TcxCustomCurrencyEdit;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomCurrencyEdit(AControl.Owner)
  else
    if AControl is TcxCustomCurrencyEdit then
      Result:= TcxCustomCurrencyEdit(AControl);
end;

function GetListView : TcxCustomListView;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomListView(AControl.Owner)
  else
    if AControl is TcxCustomListView then
      Result:= TcxCustomListView(AControl);
end;

function GetTimeEdit : TcxCustomTimeEdit;
 var
  AControl : TWinControl;
begin
  Result:= nil;
  AControl:= Screen.ActiveControl;
  if Supports(AControl, IcxInnerEditHelper) or
    Supports(AControl, IcxContainerInnerControl) then
    Result:= TcxCustomTimeEdit(AControl.Owner)
  else
    if AControl is TcxCustomTimeEdit then
      Result:= TcxCustomTimeEdit(AControl);
end;


{ Util para centrar un componente en el area cliente de su componente parent
  En el siguiente ejemplo, se centra un TLabel (Label1) dentro del area
  cliente de su parent (la form, o un TPanel, etc...) }
procedure Centralizar(Componente : TControl);
begin
  with Componente.Parent do
    begin
      Componente.Left:= (ClientWidth  div 2) - (Componente.Width  div 2);
      Componente.Top := (ClientHeight div 2) - (Componente.Height div 2);
    end;

  if Componente.Left < 0 then
    Componente.Left:= 0;
  if Componente.Top < 0 then
    Componente.Top:= 0;
end;

//FUNCION PARA OBTENER LA IMPRESORA QUE ESTA POR DEFECTO EN WINDOWS
function GetDefaultPrinterName : string;
begin
  if (Printer.PrinterIndex > 0)then
    begin
      Result:= Printer.Printers[Printer.PrinterIndex];
    end
  else
    begin
      Result := '';
    end;
end;

//PROCEDURE PARA FIJAR IMPRESORA POR DEFECTO
procedure SetDefaultPrinter(NewDefPrinter : string);
var
  ResStr : array[0..255] of Char;
begin
  StrPCopy(ResStr, NewdefPrinter);
  WriteProfileString('windows', 'device', ResStr);
  StrCopy(ResStr, 'windows');
  SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, Longint(@ResStr));
end;

function VarToIntDef(const V : Variant; const ADefault : Integer) : Integer;
begin
  if not VarIsNull(V) then
    Result := StrToIntDef(V, ADefault)
  else
    Result := ADefault;
end;

function VarToDoubleDef(const V : Variant; const ADefault : Double) : Double;
begin
  if not VarIsNull(V) then
    Result := StrToFloatDef(V, ADefault)
  else
    Result := ADefault;
end;

function VarToDateDef(const V : Variant; const ADefault : TDate) : TDate;
begin
  if not VarIsNull(V) then
    Result := StrToDateDef(V, ADefault)
  else
    Result := ADefault;
end;

procedure HabilitaControles(Form : TForm; Estado : Boolean);
var
  I : Byte;
begin
  for I := 0 to Form.ComponentCount -1 do
    begin
      if Form.Components[I] is TcxTextEdit then
        TcxTextEdit(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxMaskEdit then
        TcxMaskEdit(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxCurrencyEdit then
        TcxCurrencyEdit(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxMemo then
        TcxMemo(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxLookupComboBox then
        TcxLookupComboBox(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxRadioGroup then
        TcxRadioGroup(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxCheckBox then
        TcxCheckBox(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxDateEdit then
        TcxDateEdit(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxComboBox then
        TcxComboBox(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxButtonEdit then
        TcxButtonEdit(Form.Components[I]).Properties.ReadOnly := not Estado;

      if Form.Components[I] is TcxSpinEdit then
        TcxSpinEdit(Form.Components[I]).Properties.ReadOnly := not Estado;
    end;

  //MANEJAMOS LOS COLORES DE LOS CONTROLES...
  if Estado = False then
    begin
      for I := 0 to Form.ComponentCount -1 do
        begin
          if Form.Components[I] is TcxTextEdit then
            TcxTextEdit(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxMaskEdit then
            TcxMaskEdit(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxCurrencyEdit then
            TcxCurrencyEdit(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxMemo then
            TcxMemo(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxLookupComboBox then
            TcxLookupComboBox(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxDateEdit then
            TcxDateEdit(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxComboBox then
            TcxComboBox(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxButtonEdit then
            TcxButtonEdit(Form.Components[I]).Style.Color:= $00B0FFFF;

          if Form.Components[I] is TcxSpinEdit then
            TcxSpinEdit(Form.Components[I]).Style.Color:= $00B0FFFF;
        end;
    end
  else
    begin
      for I := 0 to Form.ComponentCount -1 do
        begin
          if Form.Components[I] is TcxTextEdit then
            TcxTextEdit(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxMaskEdit then
            TcxMaskEdit(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxCurrencyEdit then
            TcxCurrencyEdit(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxMemo then
            TcxMemo(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxLookupComboBox then
            TcxLookupComboBox(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxDateEdit then
            TcxDateEdit(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxComboBox then
            TcxComboBox(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxButtonEdit then
            TcxButtonEdit(Form.Components[I]).Style.Color:= clWindow;

          if Form.Components[I] is TcxSpinEdit then
            TcxSpinEdit(Form.Components[I]).Style.Color:= clWindow;
        end;
    end;

end;

procedure HabilitarBotones(Form : TForm; Estado : Boolean);
var
  I : Integer;
begin
  //RECORREMOS EL FORMULARIO Y COMPRUEBO LOS BOTONES
  for I:= 0 to Form.ComponentCount -1 do
    if Form.Components[I] is TcxButton then
      begin
        if (Form.Components[I] as TcxButton).Name = 'BtAgregar' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtModificar' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtEliminar' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtBuscar' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtCancelar' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtGrabar' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtImprimir' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtSalir' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtCargarFoto' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtEliminarFoto' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtClienteCorporativo' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtElegirLogoEmpresa' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

      //DEBIDO A QUE EN EL FORMULARIO DE CONTROL DE ACCESO ESTOS BOTONES ESTAN REPETIDOS
      //TENDRE QUE REPETIR EL MISMO CHEQUEO PERO AGREGANDO UN 1 AL NOMBRE DEL BOTON
      //PARA PODER HACER LA DISTINCION...
        if (Form.Components[I] as TcxButton).Name = 'BtAgregar1' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtModificar1' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtEliminar1' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtBuscar1' then
           (Form.Components[I] as TcxButton).Enabled := Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtCancelar1' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

        if (Form.Components[I] as TcxButton).Name = 'BtGrabar1' then
           (Form.Components[I] as TcxButton).Enabled := not Estado;

      end;
end;

function MascaraCedula(Cedula : string) : string;
begin
  If Length(Cedula) = 11 then
     Result := Copy(Cedula, 1, 3) + '-' + Copy(Cedula, 4, 7) + '-' + Copy(Cedula, 11, 1)
  else
    Result := '';
end;

function MascaraRNC(RNC : string) : string;
begin
  Result := Copy(RNC, 1, 3) + '-' + Copy(RNC, 4, 5) + '-' + Copy(RNC, 9, 1);
end;

function MascaraTelefono(Telefono : string) : string;
begin
//  Result:= '(' + Copy(Telefono,1,3) + ')' + Copy(Telefono,4,3) + '-' + Copy(Telefono,7,4);
  Result := Copy(Telefono, 1, 3) + '-' + Copy(Telefono, 4, 3) + '-' + Copy(Telefono, 7, 4);
end;

{ FUNCION QUE SERVIRA PARA ESTABLECER LA MASCARA DE FORMATO MIENTRAS EL USUARIO
  ESCRIBE.
  EJEMPLO DE USO (PONER EL CODIGO EN EL EVENTO ONCHANGE):
  Edit1.Text     := Mascara(Edit1.Text,'(999)-999-9999'); //telefono
  Edit1.SelStart := Length(Edit1.Text);
  }
function Mascara(Edt, Mascara : string) : string;
var
  I : Integer;
begin
  for I := 1 to Length(Edt) do
    begin
       if (Mascara[I] = '9') and not (Edt[I] in ['0'..'9'])
       and (Length(Edt) = Length(Mascara)+1) then
         Delete(Edt,I,1);
       if (Mascara[I] <> '9') and (Edt[I] in ['0'..'9']) then
         Insert(Mascara[I],Edt, I);
    end;
  Result := Edt;
end;

function ValidaRNC(sRNC : string) : Boolean;
var
  Multiplica, Longitud : SmallInt;
  Resto, Digito, Valor, Suma, I : Integer;
  T : string;
const
  Peso : array[0..7] of Integer = (7, 9, 8, 6, 5, 4, 3, 2);
begin
  T := sRNC;
  sRNC := Trim(StringReplace(sRNC, '-', '', [rfReplaceAll]));

  if sRNC = EmptyStr then
    begin
      Result := False;
      Exit;
    end;

  Longitud := Length(sRNC);

  //Inicializar la variable Suma
  Suma := 0;
  if Length(sRNC) = 9 then  //Asumimos como Valor de RNC con 9 caracteres
    begin
      {Calculo del R N C  modulo 11}
      for I := 0 to Longitud - 2 do
        begin
          Multiplica := Peso[I];
          Valor      := StrToIntDef(sRNC[I + 1], -1) * Multiplica;

          //Si el Digito que se encontro no es numerico.
          if Valor < 0 then
            Break;

          Suma := Suma + Valor;
        end;

        //ahora  la variable Valor toma el Digito verificador
      Valor := StrToIntDef(Copy(sRNC, Longitud, 1), 0);
      Resto := Trunc(Suma - (Integer(Trunc(Suma / 11)) * 11));

      case Resto of
        0 : Digito := 2;
        1 : Digito := 1;
      else
        Digito := 11 - Resto;
      end;

      Result := Valor = Digito;
    end
  else
    Result := sRNC <> EmptyStr;
end;

// DEVUELVE EL PORCENTAJE DE UN VALOR
function ObtenerPorciento(Valor : Real; Percent : Real) : Real;
begin
  Percent := Percent / 100;
  try
    Valor := Valor * Percent;
  finally
    Result := Valor;
  end;
end;

function GetAppVersion : string;
var
 Size, Size2 : DWord;
 Pt, Pt2 : Pointer;
begin
  Size := GetFileVersionInfoSize(PChar(ParamStr(0)), Size2);
  if Size > 0 then
    begin
      GetMem (Pt, Size);
      try
        GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Pt);
        VerQueryValue (Pt, '\', Pt2, Size2);
        with TVSFixedFileInfo (Pt2^) do
          begin
            Result:= {' Versión '+}
                    IntToStr (HiWord (dwFileVersionMS)) + '.' +
                    IntToStr (LoWord (dwFileVersionMS)) + ' Build ' +
                    IntToStr (HiWord (dwFileVersionLS)) + '.' +
                    IntToStr (LoWord (dwFileVersionLS));
          end;
      finally
        FreeMem(Pt);
      end;
    end;
end;

function GetAppInfo(De : string) : string;
  {Se pueden pedir los siguientes datos :
     CompanyName
     FileDescription
     FileVersion
     InternalName
     LegalCopyright
     OriginalFilename
     ProductName
     ProductVersion }
type
  PaLeerBuffer = array [0..MAX_PATH] of Char;
var
 Size, Size2 : DWord;
 Pt, Pt2     : Pointer;
 Idioma      : string;
begin
  Result := '';
  Size := GetFileVersionInfoSize(PChar (Application.Exename), Size2);
  if Size > 0 then
    begin
      GetMem(Pt, Size);
      GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Pt);
       {Obtenemos la cadena de translacion, requerida para obtener el resto
        de datos del Versioninfo}
      VerQueryValue( Pt, '\VarFileInfo\Translation',Pt2, Size2);
      Idioma:= IntToHex( DWord(Pt2^) ,8 );
      {Le damos la vuelta (Es windows, que quieres...}
      Idioma:= Copy(Idioma,5,4)+Copy(Idioma,1,4);

       {Pedimos la info requerida...}
      VerQueryValue(Pt, Pchar('\StringFileInfo\'+Idioma+'\'+De),Pt2, Size2);
      if Size2 > 0 then
        begin
          {Y la devolvemos}
          Result := Copy(PaLeerBuffer(Pt2^),1,Size2);
        end
      else
        raise Exception.Create( 'No existe esa informacion en este ejecutable');
      FreeMem (Pt);
    end
  else
    raise Exception.Create('Lo siento, no hay VersionInfo disponible '+
                             'en este ejecutable.');
end;


{FUNCION QUE SERVIRA PARA CANCELAR EL DISPARO DEL EVENTO ONEXIT AL PRESIONAR
 UN BOTON CUANDO EN DICHO EVENTO EXISTA UN CODIGO DE VALIDACION. }
function BotonesEnfocados(Form : TForm) : Boolean;
var
  I : Integer;
begin
  for I:= 0 to Form.ComponentCount - 1 do
    begin
      if Form.Components[I] is TcxButton then
        begin
          if (Form.Components[I] as TcxButton).Focused then
            begin
              Result:= True;
              Break;
            end;
        end;
    end;
end;

function SumarColumna(ADataset : TDataSet; ColumnName, Condicion : string) : Double;
var
  RecordMark : TBookMark;
  OldFilter : string;
begin
  RecordMark := ADataset.GetBookmark;
  ADataset.CheckBrowseMode;

  with ADataset do
    begin
      if Condicion <> '' then
        begin
          if ADataset.Filter <> '' then
            begin
              OldFilter := ADataset.Filter;
              ADataset.Filter := ' AND ' + Condicion;
            end
          else
            ADataset.Filter := Condicion;
          ADataset.Filtered := True;
        end;

      ADataset.First;
      ADataset.DisableControls;
      Result := 0;
      while not ADataset.Eof do
        begin
          Result := Result + ADataset.FieldByName(ColumnName).AsFloat;
          ADataset.Next;
        end;

      if Condicion <> '' then
        begin
          if OldFilter <> '' then
            ADataset.Filter := OldFilter
          else
            ADataset.Filter := '';

          ADataset.Filtered := True;
        end;

      ADataset.GotoBookmark(RecordMark);
      ADataset.FreeBookmark(RecordMark);
      ADataset.EnableControls;
    end;
end;

//DESCRIPCION: CUENTA LOS REGISTRO DE UN DATASET
function ContarRegistros(ADataset : TDataSet; Condicion : string = '') : Integer;
var
  RecordMark : TBookMark;
  OldFilter : string;
begin
  RecordMark := ADataset.GetBookmark;
  ADataset.CheckBrowseMode;

  with ADataset do
    begin
      if Condicion <> '' then
        begin
          if ADataset.Filter <> '' then
            begin
              OldFilter := ADataset.Filter;
              ADataset.Filter := ' AND ' + Condicion;
            end
          else
            ADataset.Filter := Condicion;
          ADataset.Filtered := True;
        end;

      ADataset.First;
      ADataset.DisableControls;
      Result := 0;
      while not ADataset.Eof do
        begin
          Result := Result + 1;
          ADataset.Next;
        end;

      if Condicion <> '' then
        begin
          if OldFilter <> '' then
            ADataset.Filter := OldFilter
          else
            ADataset.Filter := '';

          ADataset.Filtered := True;
        end;

      ADataset.GotoBookmark(RecordMark);
      ADataset.FreeBookmark(RecordMark);
      ADataset.EnableControls;
    end;
end;

//FUNCION PARA VERIFICAR SI EXISTEN ELEMENTOS REPETIDOS EN UNA TABLA...
function VerificarElementosRepetidos(ATable : TDataSet; Campo : string) : string;
var
  Lista : TStringList;
  I, P : Integer;
  Repetidos : string;
begin
  Lista := TStringList.Create;
  try
    ATable.DisableControls;
    ATable.First;
    while not ATable.Eof do
      begin
        Lista.Add(ATable.FieldByName(Campo).AsString);
        ATable.Next;
      end;
  finally
    ATable.EnableControls;
  end;

  Lista.Sort;
  I:= 0;
  while I <= Lista.Count -1 do
    begin
      if (Lista.Find(Lista[I],P)) and (I <> P) then
//        Lista.Delete(P);
        Repetidos := Repetidos + Lista.Strings[P] + #13;
      Inc(I);
    end;

  Lista.Free;
  Result := Repetidos;
end;

{
 Descripcion : Separa por comas el contenido del campo de un Dataset.
 Parametros  : ElDataset : TDataSet; ColumnName, Condicion : string; EntreComillas : Boolean;
 Retorno     : El string concatenado y separado por comas, si el ultimo parametro
               esta en True devolvera cada registro entre comillas simples.

 Ejemplo de llamada :

 //EXTRAE TODOS LOS REGISTROS DEL CAMPO
 SeparadoPorComas(Query1,'ID_DOCTOR','',False);

 //AQUI EXTRAEMOS TODOS LOS REGISTROS DE ACUERDO A UNA CONDICION EN EL DATASET
 SeparadoPorComas(Query1,'ID_DOCTOR','ID_SUCURSAL = 1',False));
}

function SeparadoPorComas(Dataset : TDataSet; ColumnName, Condicion : string; EntreComillas : Boolean) : string;
var
  Marcador : TBookMark;
  OldFilter : string;
begin
  Marcador := Dataset.GetBookmark;
  Dataset.CheckBrowseMode;

  with Dataset do
    begin
      if Condicion <> '' then
        begin
          if Dataset.Filter <> '' then
            begin
              OldFilter      := Dataset.Filter;
              Dataset.Filter := ' AND ' + Condicion;
            end
          else
            Dataset.Filter := Condicion;
          Dataset.Filtered := True;
        end;

      Dataset.First;
      Dataset.DisableControls;
      Result := EmptyStr;
      while not Dataset.Eof do
        begin
          if EntreComillas = True then
            Result := Result + QuotedStr(Dataset.FieldByName(ColumnName).AsString) + ','
          else
            Result := Result + Dataset.FieldByName(ColumnName).AsString + ',';

          Dataset.Next;
        end;

//      Delete(Result,Length(Result),1);
      Result:= Copy(Result,1,Length(Result)-1); //QUITAMOS LA ULTIMA COMA...

      if Condicion <> '' then
        begin
          if OldFilter <> '' then
            Dataset.Filter := OldFilter
          else
            Dataset.Filter := '';
          Dataset.Filtered := True;
        end;

      Dataset.GotoBookmark(Marcador);
      Dataset.FreeBookmark(Marcador);
      Dataset.EnableControls;
    end;
end;

{ PROCEDIMIENTO PARA EXPORTAR UN DATASET A UN ARCHIVO CSV
  Ejemplo de uso :   SaveToCSV(UniTable1,'C:\Datos\MiTabla.csv');  }
procedure SaveToCSV(DataSet : TDataSet; FileName : string);
const
  Delimiter : Char = ';';
  // In order to be automatically recognized in Microsoft Excel use ";", not ","
  Enclosure : Char = '"';
var
  List : TStringList;
  S : string;
  I : Integer;
  function EscapeString(S : string) : string;
  var
    I : Integer;
  begin
    Result := StringReplace(S, Enclosure, Enclosure + Enclosure,
      [rfReplaceAll]);
    if (Pos(Delimiter, S) > 0) or (Pos(Enclosure, S) > 0) then
    // Comment this line for enclosure in every fields
      Result := Enclosure + Result + Enclosure;
  end;
  procedure AddHeader;
  var
    I: Integer;
  begin
    S := '';
    for I := 0 to DataSet.FieldCount - 1 do
    begin
      if S > '' then
        S := S + Delimiter;
      S := S + EscapeString(DataSet.Fields[I].FieldName);
    end;
    List.Add(S);
  end;
  procedure AddRecord;
  var
    I: Integer;
  begin
    S := '';
    for I := 0 to DataSet.FieldCount - 1 do
    begin
      if S > '' then
        S := S + Delimiter;
      S := S + EscapeString(DataSet.Fields[I].AsString);
    end;
    List.Add(S);
  end;

begin
  List := TStringList.Create;
  try
    DataSet.DisableControls;
    DataSet.First;
    AddHeader; // Comment if header not required
    while not DataSet.Eof do
    begin
      AddRecord;
      DataSet.Next;
    end;
  finally
    List.SaveToFile(FileName);
    DataSet.First;
    DataSet.EnableControls;
    List.Free;
  end;
end;

function GetTableNameByDataSet(ADataSet : TDataSet) : string;
var
  qrDataSet : TFDQuery;
  SQL : string;
begin
  if (ADataSet is TFDQuery) then
    begin
      qrDataSet := (ADataSet as TFDQuery);
      SQL := qrDataSet.SQL.Text;
      SQL := Copy(SQL, Pos('FROM', SQL) + 5, Length(SQL));
      SQL := TrimLeft(SQL);

      if Pos(' ', SQL) > 0 then
        SQL := Copy(SQL, 1, Pos(' ', SQL) - 1);
    end;

  SQL := TrimRight(SQL);
  Result := SQL;
end;

//PROCEDIMIENTO PARA MOSTRAR UNA IMAGEN ALMACENADA EN UN CAMPO BLOB
//EJEMPLO DE USO : LoadPictureFromField(TBlobField(QryCEDULA.FieldByName('IMAGEN')), Image1.Picture);
//EJEMPLO DE USO :
//  if FileOpenDialog1.Execute then
//    LoadBitmapFromFile(Image1, FileOpenDialog1.FileName);
procedure LoadPictureFromField(Field : TBlobField; Picture : TPicture);
var
  lWICImage : TWICImage;
begin
  if (Field.BlobSize > 0) then
    begin
      lWICImage := TWICImage.Create;
      try
        lWICImage.Assign(Field);
        Picture.Assign(lWICImage);
      finally
        lWICImage.Free;
      end;
    end
  else
    begin
      Picture.Assign(nil);
    end;
end;

//PROCEDIMIENTO PARA MOSTRAR UNA IMAGEN EN UN COMPONENTE IMAGE...
procedure LoadPictureFromFile(aImage : TcxImage; Filename : string);
//procedure LoadPictureFromFile(aImage : TImage; Filename : string);
var
  Imagen : TWICImage;
  Ext : string;
begin
  Ext := ExtractFileExt(Filename);
  if (Ext = '.tif') or (Ext = '.tiff') or (Ext = '.png') or (Ext = '.jpg')
  or (Ext = '.bmp') or (Ext = '.jpeg')then
    aImage.Picture.LoadFromFile(Filename)
  else
    begin
      Imagen:= TWICImage.Create;
      try
        Imagen.LoadFromFile(Filename);
        aImage.Picture.Bitmap.Assign(Imagen);
      finally
        Imagen.Free;
      end;
    end;
end;

//PROCEDIMIENTO PARA GUARDAR LA FOTO EN UN CAMPO BLOB DE UNA TABLA

//  EJEMPLO DE USO : SavePictureFileToField
//  if OpenPictureDialog1.Execute then
//    begin
//      if (TableImage.State = TDataSetState.dsBrowse) then
//        TableImage.Edit;
//      SavePictureFileToField(OpenPictureDialog1.FileName, TableImagePICTURE);
//    end;
procedure SavePictureFileToField(PictureFile : TFileName; Field : TBlobField);
var
  Imagen : TWICImage;
begin
  Imagen := TWICImage.Create;
  try
    Imagen.LoadFromFile(PictureFile);
    Field.Assign(Imagen);
  finally
    Imagen.Free;
  end;
end;

{FUNCION PARA OBTENER EL TOTAL DE UN CAMPO.
 NOTA : SI QUIERES FORMATEAR (FormatFloat) EL RESULTADO APLICAS ESTAS MASCARAS :
 SI EL CAMPO ES DECIMAL '##,##0.00' SI ES ENTERO ',0'
 EJEMPLO :
 Label1.Caption := FormatFloat( '##,##0.00', TotalCampo(UniTable1,'CUADRADO'));
 Label1.Caption := FormatFloat(',0', TotalCampo(UniTable1,'CUADRADO')); }
function TotalCampo(Dataset : TDataSet; Campo : string) : Double;
var
  B : TBookmark;
  Total : Double;
begin
  Result := 0;
  B := Dataset.GetBookmark;
  Dataset.DisableControls;

  //Validamos el tipo de dato del campo
  if not (Dataset.FieldByName(Campo).DataType in [ftFloat, ftCurrency,
          ftBCD, ftInteger, ftSmallint, ftWord, ftByte, ftShortint,
          ftLongWord, ftLargeint]) then
    Exit;

  Total := 0;
   try
     Dataset.First;
     while not Dataset.Eof do
       begin
         Total := Total + Dataset.FieldByName(Campo).AsFloat;
         Dataset.Next;
       end;
   finally
     Dataset.GotoBookmark(B);
     Dataset.EnableControls;
     Dataset.FreeBookmark(B);
   end;
  Result := Total;
end;

{  La siguiente función envía secuencias de escape directamente a la impresora.

"PrinterName" es el nombre de la impresora tal como aparece en la carpeta de
impresoras de windows, esto permite que nos olvidemos de si la impresora es
serie, paralelo o usb, funcionara en todos los casos. Si la impresora se
conecta por el puerto serie o paralelo y no quieres instalar los drivers,
instala una impresora "Genérica / solo texto" indicándole el puerto donde esta.
Por otro lado el parámetro Str es una cadena de texto donde los caracteres
especiales están precedidos por el carácter "\" seguido de 3 cifras decimales
o de "x" y dos cifras hexadecimales.

Por ejemplo, para que la impresora emita un pitido (las secuencias pueden
variar de una impresora a otra):

\x1B@\x0A\x0D\x1B\x07\x0A\x0D

Para que corte el papel:

\x1B@\x0A\x0D\x1Bi\x0A\x0D

Para abrir el cajon de monedas abrir caja
\x1B@\x0A\x0D\027\112\000\100\250\x0A\x0D

Para que escriba "Hola mundo"
\x1B@\x0A\x0DHola mundo\x0A\x0D


tambien sirve para que la impresora funcione sin tinta, es un ahorro increible,
prueba y veras.

Claro. Para imprimir tickets es muy habitual usar pequeñas impresoras que
imprimen en rollos de papel (seguro que las has visto en alguna tienda).
Aunque las mas modernas ya permiten imprimir como si fuera una impresora
normal (usando el Canvas), una de las formas mas habituales de usar estas
impresoras es mediante secuencias de escape enviadas directamente al puerto de
la impresora. Las ventajas de este método es que es muy rápido, no se necesita
instalar ningún driver y permite usar funciones especiales como la de abrir el
cajón portamonedas o imprimir un logo previamente grabado en la eeprom de la
impresora.

Personalmente creo que usar secuencias de escape es el mejor método para
manejar impresoras de tickets. Precisamente tengo estos días problemas con un
programa (que no hice yo   ) que utiliza el driver de windows para imprimir
tickets y, además de ser terriblemente lento, tiene muchos problemas para
imprimir bien la negrita, fijar los margenes, etc ... cuando si utilizara
secuencias de escape solo habría que indicarle las correspondientes al modelo
de impresora y listo.

}

//uses Printers, WinSpool;
function WriteRawDataToPrinter(PrinterName : String; Str: String) : Boolean;
var
  PrinterHandle : THandle;
  DocInfo : TDocInfo1;
  i : Integer;
  B : Byte;
  Escritos : DWORD;
begin
  Result:= False;
  if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
    try
      FillChar(DocInfo, Sizeof(DocInfo), #0);
      with DocInfo do
        begin
          pDocName:= PChar('Printer Test');
          pOutputFile:= nil;
          pDataType:= 'RAW';
        end;
      if StartDocPrinter(PrinterHandle, 1, @DocInfo) <> 0 then
        try
          if StartPagePrinter(PrinterHandle) then
            try
              while Length(Str) > 0 do
                begin
                  if Copy(Str, 1, 1) = '\' then
                    begin
                      if Uppercase(Copy(Str, 2, 1)) = 'X' then
                        Str[2]:= '$';
                        if not TryStrToInt(Copy(Str, 2, 3), i) then
                          Exit;
                          B:= Byte(i);
                          Delete(Str, 1, 3);
                    end
                  else
                    B:= Byte(Str[1]);
                    Delete(Str, 1, 1);
                    WritePrinter(PrinterHandle, @B, 1, Escritos);
                end;
              Result:= True;
            finally
              EndPagePrinter(PrinterHandle);
            end;
        finally
          EndDocPrinter(PrinterHandle);
        end;
    finally
      ClosePrinter(PrinterHandle);
    end;
end;

// CONVERTIR NUMEROS A LETRAS

(* ************************************ *)
(* Conversión Número -> Letra *)
(* *)
(* Parámetros: *)
(* *)
(* mNum: Número a convertir *)
(* iIdioma: Idioma de conversión *)
(* 1 -> Castellano *)
(* 2 -> Catalán *)
(* iModo: Modo de conversión *)
(* 1 -> Masculino *)
(* 2 -> Femenino *)
(* *)
(* Restricciones: *)
(* *)
(* - Redondeo a dos decimales *)
(* - Rango: 0,00 a 999.999.999.999,99 *)
(* *)
(* ************************************ *)

function NumLetra(const MNum : Currency; const IIdioma, IModo : Smallint) : string;
const
  ITopFil : Smallint = 6;
  ITopCol : Smallint = 10;
  ACastellano: array [0 .. 5, 0 .. 9] of PChar =
  (('UNA ',   'DOS ',   'TRES ', 'CUATRO ', 'CINCO ', 'SEIS ', 'SIETE ',
    'OCHO ',  'NUEVE ', 'UN '), ('ONCE ', 'DOCE ', 'TRECE ', 'CATORCE ',
    'QUINCE ', 'DIECISEIS ', 'DIECISIETE ', 'DIECIOCHO ', 'DIECINUEVE ', '')
    , ('DIEZ ', 'VEINTE ', 'TREINTA ', 'CUARENTA ', 'CINCUENTA ',
    'SESENTA ', 'SETENTA ', 'OCHENTA ', 'NOVENTA ', 'VEINTI'),
  ('CIEN ', 'DOSCIENTAS ', 'TRESCIENTAS ', 'CUATROCIENTAS ', 'QUINIENTAS ',
    'SEISCIENTAS ', 'SETECIENTAS ', 'OCHOCIENTAS ', 'NOVECIENTAS ',
    'CIENTO '), ('CIEN ', 'DOSCIENTOS ', 'TRESCIENTOS ', 'CUATROCIENTOS ',
    'QUINIENTOS ', 'SEISCIENTOS ', 'SETECIENTOS ', 'OCHOCIENTOS ',
    'NOVECIENTOS ', 'CIENTO '), ('MIL ', 'MILLON ', 'MILLONES ', 'CERO ',
    'Y ', 'UN ', 'DOS ', 'CON ', '', ''));
  ACatalan : array [0 .. 5, 0 .. 9] of PChar =
  (('UNA ', 'DUES ', 'TRES ', 'QUATRE ', 'CINC ', 'SIS ', 'SET ', 'VUIT ',
    'NOU ', 'UN '), ('ONZE ', 'DOTZE ', 'TRETZE ', 'CATORZE ', 'QUINZE ',
    'SETZE ', 'DISSET ', 'DIVUIT ', 'DINOU ', ''), ('DEU ', 'VINT ',
    'TRENTA ', 'QUARANTA ', 'CINQUANTA ', 'SEIXANTA ', 'SETANTA ',
    'VUITANTA ', 'NORANTA ', 'VINT-I-'), ('CENT ', 'DOS-CENTES ',
    'TRES-CENTES ', 'QUATRE-CENTES ', 'CINC-CENTES ', 'SIS-CENTES ',
    'SET-CENTES ', 'VUIT-CENTES ', 'NOU-CENTES ', 'CENT '),
  ('CENT ', 'DOS-CENTS ', 'TRES-CENTS ', 'QUATRE-CENTS ', 'CINC-CENTS ',
    'SIS-CENTS ', 'SET-CENTS ', 'VUIT-CENTS ', 'NOU-CENTS ', 'CENT '),
  ('MIL ', 'MILIO ', 'MILIONS ', 'ZERO ', '-', 'UN ', 'DOS ', 'AMB ', '',''));

var
  ATexto : array [0 .. 5, 0 .. 9] of PChar;
  CTexto, CNumero : string;
  ICentimos, IPos : Smallint;
  BHayCentimos, BHaySigni : Boolean;

// Cargar Textos según Idioma / Modo
procedure NumLetra_CarTxt;
var
  I, J : Smallint;
begin
  //Asignación según Idioma

  for I:= 0 to ITopFil - 1 do
    for J:= 0 to ITopCol - 1 do
      case IIdioma of
        1 : ATexto[I, J]:= ACastellano[I, J];
        2 : ATexto[I, J]:= ACatalan[I, J];
      else
        ATexto[I, J]:= ACastellano[I, J];
      end;

  //Asignación si Modo Masculino
  if (IModo = 1) then
    begin
      for J:= 0 to 1 do
        ATexto[0, J]:= ATexto[5, J + 5];

      for J:= 0 to 9 do
        ATexto[3, J]:= ATexto[4, J];
    end;
end;

//Traducir Dígito -Unidad
procedure NumLetra_Unidad;
begin
  if not((CNumero[IPos] = '0') or (CNumero[IPos - 1] = '1') or
      ((Copy(CNumero, IPos - 2, 3) = '001') and ((IPos = 3) or (IPos = 9)))) then
    if (CNumero[IPos] = '1') and (IPos <= 6) then
      CTexto:= CTexto + ATexto[0, 9]
    else
      CTexto:= CTexto + ATexto[0, StrToInt(CNumero[IPos]) - 1];

  if ((IPos = 3) or (IPos = 9)) and (Copy(CNumero, IPos - 2, 3) <> '000') then
    CTexto:= CTexto + ATexto[5, 0];

  if (IPos = 6) then
    if (Copy(CNumero, 1, 6) = '000001') then
      CTexto:= CTexto + ATexto[5, 1]
    else
      CTexto:= CTexto + ATexto[5, 2];
end;

//Traducir Dígito -Decena-
procedure NumLetra_Decena;
begin
  if (CNumero[IPos] = '0') then
    Exit
  else
    if (CNumero[IPos + 1] = '0') then
      CTexto:= CTexto + ATexto[2, StrToInt(CNumero[IPos]) - 1]
  else
    if (CNumero[IPos] = '1') then
      CTexto:= CTexto + ATexto[1, StrToInt(CNumero[IPos + 1]) - 1]
  else
    if (CNumero[IPos] = '2') then
      CTexto:= CTexto + ATexto[2, 9]
  else
    CTexto:= CTexto + ATexto[2, StrToInt(CNumero[IPos]) - 1] + ATexto[5, 4];
end;

//Traducir Dígito -Centena-
procedure NumLetra_Centena;
var
  IPos2 : Smallint;
begin
  if (CNumero[IPos] = '0') then
    Exit;

  IPos2:= 4 - Ord(IPos > 6);

  if (CNumero[IPos] = '1') and (Copy(CNumero, IPos + 1, 2) <> '00') then
    CTexto:= CTexto + ATexto[IPos2, 9]
  else
    CTexto:= CTexto + ATexto[IPos2, StrToInt(CNumero[IPos]) - 1];
end;

//Eliminar Blancos previos a guiones
procedure NumLetra_BorBla;
var
  I : Smallint;
begin
  I:= Pos(' -', CTexto);

  while (I > 0) do
    begin
      Delete(CTexto, I, 1);
      I:= Pos(' -', CTexto);
    end;
end;

begin
  //Control de Argumentos
  if (MNum < 0.00) or (MNum > 999999999999.99) or (IIdioma < 1) or
    (IIdioma > 2) or (IModo < 1) or (IModo > 2) then
    begin
      Result:= 'ERROR EN ARGUMENTOS';
      Abort;
    end;

  //Cargar Textos según Idioma / Modo *)
  NumLetra_CarTxt;

  { Bucle Exterior -Tratamiento Céntimos-
    NOTA: Se redondea a dos dígitos decimales }

  CNumero:= Trim(Format('%12.0f', [Int(MNum)]));
  CNumero:= StringOfChar('0', 12 - Length(CNumero)) + CNumero;
  ICentimos:= Trunc((Frac(MNum) * 100) + 0.5);

  repeat
    //Detectar existencia de Céntimos
    if (ICentimos <> 0) then
      BHayCentimos:= True
    else
      BHayCentimos:= False;

    //Bucle Interior -Traducción-
    BHaySigni:= False;

    for IPos:= 1 to 12 do
      begin
        //Control existencia Dígito significativo
        if not(BHaySigni) and (CNumero[IPos] = '0') then
          Continue
        else
          BHaySigni:= True;

        //Detectar Tipo de Dígito
        case ((IPos - 1) mod 3) of
          0 : NumLetra_Centena;
          1 : NumLetra_Decena;
          2 : NumLetra_Unidad;
        end;
      end;

    //Detectar caso 0
    if (CTexto = '') then
      CTexto:= ATexto[5, 3];

    //Traducir Céntimos -si procede-
    if (ICentimos <> 0) then
      begin
        CTexto:= CTexto + ATexto[5, 7];
        CNumero:= Trim(Format('%.12d', [ICentimos]));
        ICentimos := 0;
      end;
  until not(BHayCentimos);

  //Eliminar Blancos innecesarios -sólo Catalán-
  if (IIdioma = 2) then
    NumLetra_BorBla;

  //Retornar Resultado
  Result:= Trim(CTexto);
end;

//FUNCION PARA OBTENER LA RUTA DEL DIRECTORIO TEMPORAL DE WINDOWS
function GetTempDir : string;
var
  Buffer : array[0..Max_path] of Char;
begin
  FillChar(Buffer, Max_Path + 1, 0);
  GetTempPath(Max_path, Buffer);
  Result := String(Buffer);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
end;

//FUNCION PARA BORRAR EL CONTENIDO DE UNA CARPETA INCLUYENDO CARPETAS

{ Maneja caracteres comodín y puede borrar carpetas o archivos.
  Ejemplos :

  DeleteFolder('C:\Users\jorgeb\Documents\Mi Carpeta');

  // si solo quieres borrar los de una determinada extensión de una carpeta determinada
  DeleteFolder('C:\Users\jorgeb\Documents\Mi Carpeta\*.txt');
}

function DeleteFolder(Path : string) : Integer;
var
  FS : SHFILEOPSTRUCT;
begin
  ZeroMemory(@FS, sizeof(SHFILEOPSTRUCT));
  FS.wFunc:= FO_DELETE;
  FS.pFrom:= PCHAR(Path + #0);
  FS.fFlags:= FOF_NOCONFIRMATION or FOF_ALLOWUNDO;
  Result:= SHFileOperation(FS);
end;

//PROCEDIMIENTO PARA ELIMINAR TODOS LOS ARCHIVOS DE UN DIRECTORIO
procedure DeleteAllDir(Path: string; Mask: string; Recursive: Boolean);
var
  Files    : TArray<string>;
  Dirs     : TArray<string>;
  Dir, FileName : string;
begin
  Path := TPath.Combine(Path, ''); // Asegura que termine en \

  // Elimina archivos que coincidan con la máscara
  Files := TDirectory.GetFiles(Path, Mask);
  for FileName in Files do
  begin
    try
      TFile.Delete(FileName);
    except
      // Si falla, intenta quitar atributos y volver a eliminar
      FileSetAttr(FileName, 0);
      TFile.Delete(FileName);
    end;
  end;

  if Recursive then
    begin
      Dirs := TDirectory.GetDirectories(Path);
      for Dir in Dirs do
      begin
        DeleteAllDir(Dir, Mask, True);
        TDirectory.Delete(Dir, False); // False porque ya está vacío
      end;
    end;
end;

{ FUNCION PARA SABER SI UN DIRECTORIO ESTA VACIO.
// Example:
  if DirectoryIsEmpty('C:\test') then
    Label1.Caption := 'empty'
  else
    Label1.Caption := 'not empty';
}
function DirectoryIsEmpty(Directory : string) : Boolean;
begin
  Result := TDirectory.IsEmpty(Directory);
end;

{ FUNCION PARA OBTENER TODOS LOS ARCHIVOS DE UN DIRECTORIO O RUTA ESPECIFICA
  EJEMPLO DE LLAMADA
  ListBox1.Items := ListaArchivos('C:\Windows\');  //Todos los archivos
  ListBox1.Items := ListaArchivos('C:\Windows\','xml');  //Solo con extension xml
}

function ListaArchivos(DirectorioPadre : string; Filtro : string = '*') : TStringList;
var
  Files : TArray<string>;
begin
  Result := TStringList.Create;
  if Filtro <> '*' then
    Filtro := '*.' + Filtro;

  Files := TDirectory.GetFiles(DirectorioPadre, Filtro);
  Result.AddStrings(Files);
end;

{ FUNCION PARA OBTENER TODOS LOS DIRECTORIOS DE UN DIRECTORIO O RUTA ESPECIFICA
  EJEMPLO DE LLAMADA
  ListBox1.Items := ListaDirectorios('C:\Windows\');
}
function ListaDirectorios(DirectorioPadre : string) : TStringList;
var
  Dirs : TArray<string>;
begin
  Result := TStringList.Create;
  Dirs   := TDirectory.GetDirectories(DirectorioPadre);
  Result.AddStrings(Dirs);
end;

//PROCEDIMIENTO PARA COPIAR UN DIRECTORIO Y SUS FICHEROS EN OTRO
procedure CopiarDirectorio(Origen, Destino : string);
var
  Files, Dirs : TArray<string>;
  FileName, DirName : string;
begin
  // Asegurarse de que el directorio destino existe
  if not TDirectory.Exists(Destino) then
    TDirectory.CreateDirectory(Destino);

  // Copiar archivos
  Files := TDirectory.GetFiles(Origen);
  for FileName in Files do
  begin
    try
      TFile.Copy(
        FileName,
        TPath.Combine(Destino, TPath.GetFileName(FileName)),
        True  // Sobrescribir si existe
      );
    except
      MessageDlg('No se pudo copiar el fichero : ' +
                 TPath.GetFileName(FileName), TMsgDlgType.mtError,
                 [TMsgDlgBtn.mbOK], 0);
    end;
  end;

  // Copiar subdirectorios recursivamente
  Dirs := TDirectory.GetDirectories(Origen);
  for DirName in Dirs do
  begin
    var NewDestDir := TPath.Combine(Destino, TPath.GetFileName(DirName));
    try
      if not TDirectory.Exists(NewDestDir) then
        TDirectory.CreateDirectory(NewDestDir);
      CopiarDirectorio(DirName, NewDestDir);
    except
      MessageDlg('No se pudo crear el directorio : ' +
                 TPath.GetFileName(DirName), TMsgDlgType.mtError,
                 [TMsgDlgBtn.mbOK], 0);
    end;
  end;
end;



{ FUNCION PARA MOVER UNA CARPETA
uso :
 if MoverCarpeta(PChar('c:\carpeta1'), PChar('c:\carpeta2')) then
    Showmessage('Se movió con éxito')
  else
    Showmessage('No se pudo mover la carpeta');
}
function MoverCarpeta(const vOrigen, vDestino: string) : Boolean;
var
  vCarpetas: TSHFileOpStruct;
begin
  // Inicializamos la variable vCarpetas
  FillChar(vCarpetas, SizeOf(vCarpetas), #0);

  // Preparamos las propiedades de vCarpetas para mover
  vCarpetas.wFunc := FO_MOVE;
  vCarpetas.Wnd := GetDesktopWindow;
  vCarpetas.pTo := PChar(vOrigen); // Carpeta Origen
  vCarpetas.pFrom := PChar(vDestino+#0#0); // Carpeta Destino

  // Cargamos las banderas de
  // FOF_NOCONFIRMATION -> no pide confirmación para copiar
  // FOF_SILENT -> no muestra el dialogo de progreso
  // FOF_ALLOWUNDO -> preserva la información para deshacer, si es posible
  vCarpetas.fFlags := FOF_NOCONFIRMATION or FOF_SILENT or FOF_ALLOWUNDO;

  //Ejecutamos el proceso con ShFileOperation y si devuelve 0, la operación es un éxito
  Result := (ShFileOperation(vCarpetas) = 0);
end;


{ PROCEDIMIENTO PARA RENOMBRAR UN DIRECTORIO
  ejemplo : RenameDir('C:\Dir1', 'C:\Dir2');
}
procedure RenameDir(DirFrom, DirTo : string);
var
  ShellInfo : TSHFileOpStruct;
begin
  with ShellInfo do
    begin
      Wnd    := 0;
      wFunc  := FO_RENAME;
      pFrom  := PChar(DirFrom);
      pTo    := PChar(DirTo);
      fFlags := FOF_FILESONLY or FOF_ALLOWUNDO or FOF_SILENT or FOF_NOCONFIRMATION;
    end;
  SHFileOperation(ShellInfo);
end;

//FUNCION PARA OBTENER EL TAMAÑO DE UN ARCHIVO
function TamanioArchivo(Archivo : string) : string;
  function BytesToStr(Bytes : Double) : string;
  const
    Factor = 1024; //Factor de conversión
    //Array con los literales de las unidades
    Arr : array [0..4] of String = ('Bytes','KB','MB','GB','TB');
  var
    I : Integer;
  begin
    I := 0;

    //Vamos dividiendo por el Factor hasta que estamos en el tamaño adecuado
    while (I < High(Arr)) and  (Bytes >= Factor) do
      begin
        Bytes := Bytes / Factor;
        Inc(I);
      end;

    //En función de las vueltas que hemos dado al bucle escojemos el literal
    Result := FormatFloat('0.00',Bytes) + ' ' + Arr[I];
  end;
var
  F : File of Byte;
  N : Double;
begin
  AssignFile(F, Archivo);
  Reset(F);
  N := FileSize(F);
  Result := BytesToStr(N);
  CloseFile(F);
end;

{FUNCION QUE VERIFICA SI UN ARCHIVO ESTA EN USO.
  USO :
  if IsFileInUse('c:\Programs\delphi6\bin\delphi32.exe') then
    ShowMessage('File is in use.');
  else
    ShowMessage('File not in use.');
}
function IsFileInUse(FileName : TFileName) : Boolean;
var
  HFileRes : HFILE;
begin
  Result := False;
  if not FileExists(FileName) then Exit;
  HFileRes := CreateFile(PChar(FileName),
                         GENERIC_READ or GENERIC_WRITE,
                         0, nil, OPEN_EXISTING,
                         FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

//FUNCION QUE OBTIENE LA CANTIDAD DE LINEAS QUE TIENE UN ARCHIVO DE TEXTO
function CantidadLineas(Archivo : string) : Integer;
var
  Cant : Integer;
  Lista : TStringList;
begin
  Lista := TStringList.Create;
  try
    Lista.LoadFromFile(Archivo);
    Cant := Lista.Count;
  finally
    Lista.Free;
  end;

  Result := Cant;
end;

procedure ComprimirArchivo(Archivo : string);
var
  ArchZIP : TZipFile;
  Str, Ruta, FileZip : string;
begin
  Ruta    := ExtractFilePath(Archivo);
  Str     := ExtractFileName(Archivo);
  FileZip := Ruta + ChangeFileExt(Str, '.zip');
  ArchZIP := TZIPFile.Create();
  try
    ArchZIP.Open(FileZip, zmWrite);
    ArchZIP.Add(Archivo);
    ArchZIP.Close;
  finally
    ArchZIP.Free;
  end;
end;

procedure DescomprimirArchivo(Archivo : string; ExtraerEnCarpeta : Boolean);
var
  ArchZIP : TZipFile;
  Carpeta, Ruta : string;
begin
  Ruta    := ExtractFilePath(Archivo);
  Carpeta := ChangeFileExt(ExtractFileName(Archivo), '');
  ArchZIP := TZipFile.Create;
  try
    if ArchZIP.IsValid(Archivo) then
      begin
        ArchZIP.Open(Archivo, zmRead);
        if ExtraerEnCarpeta = True then
          ArchZIP.ExtractAll(Ruta + IncludeTrailingPathDelimiter(Carpeta)) //Extraer en carpeta especifica
        else
          ArchZIP.Extract(0,Ruta, False);  //Extraer solo el archivo
      end;
  finally
    ArchZIP.Free;
  end;
end;

procedure ComprimirCarpeta(Carpeta : string);
var
  ArchZIP : TZIPFile;
  Str, Ruta, FileZip : string;
begin
  Ruta    := ExtractFilePath(Carpeta);
  Str     := Ruta;
  Delete(Str, LastDelimiter('\', Str), Length(Str));  //Quitamos el ultimo delimitador
  FileZip := Str + '.zip';
  ArchZIP := TZIPFile.Create();
  try
    ArchZIP.ZipDirectoryContents(FileZip,Ruta,zcDeflate,nil);
    //ArchZIP.ZipDirectoryContents(FileZip,Ruta,zcDeflate,OnZipProgressEvent);  //PARA MOSTRAR BARRA DE PROGRESO EN EL PROCESO
    ArchZIP.Close;
  finally
    ArchZIP.Free;
  end;
end;

procedure DescomprimirCarpeta(Archivo : string);
var
  ArchZIP : TZipFile;
  Carpeta, Ruta : string;
begin
  Ruta    := ExtractFilePath(Archivo);
  Carpeta := ChangeFileExt(ExtractFileName(Archivo), '');
  ArchZIP := TZipFile.Create;
  try
    if ArchZIP.IsValid(Archivo) then
      begin
        ArchZIP.Open(Archivo, zmRead);
        ArchZIP.ExtractAll(Ruta + IncludeTrailingPathDelimiter(Carpeta));
      end;
  finally
    ArchZIP.Free;
  end;
end;

//FECHA ULTIMO ACCESO DE UN ARCHIVO
function FechaUltimoAcceso(const Archivo : string) : TDateTime;
var
  Win32FindData : TWin32FindData;
  FileTime : TFileTime;
  SystemTime : TSystemTime;
  Handle : THandle;
begin
  Handle := FindFirstFile(PChar(Archivo),Win32FindData);
  if Handle <> INVALID_HANDLE_VALUE then
    begin
      FileTimeToLocalFileTime(Win32FindData.ftLastAccessTime, FileTime);
      FileTimeToSystemTime(FileTime, SystemTime);
      with SystemTime do
        Result := EncodeDate(wYear,wMonth,wDay) +
                  EncodeTime(wHour,wMinute,wSecond,wMilliseconds);
//      FindClose(Handle);
    end
  else
    raise EInOutError.Create('Archivo inválido');
end;

// Cambiar fecha de modificacion de un archivo
procedure CambiarFechaModificacionArchivo(Archivo : string; Fecha : TDateTime);
var
  HFile : Integer;
begin
  if not FileExists(Archivo) then
    begin
      MessageDlg('El Archivo no fue encontrado', mtError, [mbOK], 0);
      Exit;
    end;

  HFile := FileOpen(Archivo, fmOpenWrite);
  If HFile > 0 then
    begin
      FileSetDate(HFile, DateTimeToFileDate(Fecha));
      FileClose(HFile);
    end;
end;


//PARA LEER ARCHIVOS DE EXCEL

{ FUNCION PARA SABER LA CANTIDAD DE FILAS QUE VAN A SER TRATATADAS EN EL ARCHIVO DE EXCEL
  USANDO LOS COMPONENTES NATIVE EXCEL  }


//USANDO LOS OLE VARIANT NATIVO DE DELPHI
function CantFilas(ArhivoExcel : string; nHoja, nColumnaLectura, nFilaInicio : Integer) : Integer;
var
  V, WS, WBk : Variant;
  Fila : string;
  I : Integer;
begin
  I    := nFilaInicio; //EMPEZAMOS EN LA FILA ESPECIFICADA
  Fila := IntToStr(I);

  V   := CreateOleObject('Excel.Application');  // Crear objeto
  WBk := V.Workbooks.Open(ArhivoExcel);  // Acceder al libro
  WS  := WBk.Worksheets.Item[nHoja];  // Acceder a la hoja
//  WS.Cells[1,1].Value := "Valor";  // Poner el valor en la celda

  //AHORA SÓLO QUEDA IR RECORRIENDO CADA FILA HASTA QUE ENCONTREMOS UNA FILA VACÍA
  repeat
    Inc(I);
    Fila := IntToStr(I-1);
  until Length(Trim(WS.Range[LetraExcell(nColumnaLectura)+Fila,LetraExcell(nColumnaLectura)+Fila].Value)) = 0;
  //Comparamos el valor de cada celda, de ese modo sabemos cuando hemos terminado de leer datos.

  //Cerramos la aplicacion de excel
  if not VarIsEmpty(V) then  // Asignado?
    begin
      V.Quit; // Cerrar
    end;

  Result := StrToInt(Fila) - nFilaInicio;
end;

{Para mostrar el tamaño de un archivo igual al Windows Explorer
   Ejemplos :
   Label1.Caption := GetFileSizeEx('C:\App Referencia\Imagenes\Imagen_OffLine\Imagen.exe');
   Label1.Caption := GetFileSizeEx('C:\App Referencia\Imagenes\Imagen_OffLine');
}
function GetFileSizeEx(const Arquivo : string) : string;
type
  TFileSizeEx = function(dw : Integer; pszBuf : PAnsiChar; cchBuf : Integer): PAnsiChar; stdcall;
var
  shlwapi_handle : THandle;
  iFile, iFile_FileSize : Integer;
  Calculate_Size : TFileSizeEx;
  lpSize         : array[0..50] of Ansichar;
begin
  iFile:= FileOpen(Arquivo, fmShareCompat or fmShareDenyNone);
  if iFile > 0 then
    begin
      iFile_FileSize := GetFileSize(iFile, nil);
      shlwapi_handle := LoadLibrary('shlwapi.dll');
      if shlwapi_handle = 0 then
        Result := InttoStr(iFile_FileSize) + ' bytes'
      else
        begin
          @Calculate_Size := GetProcAddress(shlwapi_handle, 'StrFormatByteSizeA');
          if @Calculate_Size = nil then
            Result := InttoStr(iFile_FileSize) + ' bytes'
          else
            begin
              Calculate_Size(iFile_FileSize, lpSize, 50);
              Result := lpSize;
            end;
        end;
    end
  else
    Result := 'File not found';
  FreeLibrary(shlwapi_handle);
  FileClose(iFile);
end;


//PARA PONER BARRA DE PROGRESO MIENTRAS SE COMPRIME (UTIL PARA CARPETAS CON MUCHOS ARCHIVOS)
//procedure OnZipProgressEvent(Sender: TObject; FileName: string; Header: TZipHeader; Position : Int64);
//begin
////declarar la variable PreviousFilename : string; y el procedimiento OnZipProgressEvent en la parte privada del formulario
////por ultimo coloca un componente ProgressBar en el formulario
//  if PreviousFilename <> FileName then
//    begin
//      PreviousFilename := FileName;
//      ProgressBar1.Position := 0;
//    end
//  else
//    ProgressBar1.Position := (Position * 100) div Header.UncompressedSize;
//  Application.ProcessMessages;
//end;

function ColorToStr(Color : TColor) : string;
begin
  Result:= IntToHex(Color,6);
  Result:= Copy(Result,5,2) + Copy(Result,3,2) + Copy(Result,1,2);
end;

//MEJOR USE StringToColor INCLUIDA EN DELPHI
function StrToColor(Color : string) : TColor;
begin    //NO USE ESTA FUNCION... MEJOR USE StringToColor INCLUIDA EN DELPHI
  while Length(Color) < 6 do
    Color:= '0' + Color;
  Color  := Copy(Color,5,2) + Copy(Color,3,2) + Copy(Color,1,2);
  Result := StrToIntDef('$'+Color,0);
end;


{ FUNCION PARA CONVERTIR UN TCOLOR A INTEGER

 Esta funcion sirve para guardar el color en formato numerico en la
 base de datos para luego asignar ese color a cualquier componente.

 EJEMPLO DE USO :

  var
    Color : LongInt;
  begin
    Color       := ConvertColorToInteger(ColorBox1.Color);  //Obtenemos su valor numerico
    Edit1.Color := StringToColor(IntToStr(Color)); //Con la funcion StringToColor obtenemos el TColor
  end;
}
function ConvertColorToInteger(Color : TColor) : LongInt;
var
  _Color : LongInt;
  r, g, b : Byte;
begin
  _Color := Vcl.Graphics.ColorToRGB(Color);
  r      := _Color;
  g      := _Color shr 8;
  b      := _Color shr 16;
  Result := RGB(r,g,b);
end;

// PROCEDIMIENTO PARA CONVERTIR UN COLOR DE NUMERO ENTERO A RGB
procedure ColorToRGB(const Color : Integer; out R, G, B : Byte);
begin
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

// FUNCION PARA CONVERTIR UN COLOR RGB A NUMERO ENTERO
function RGBToInteger(const R, G, B : Byte) : Integer;
begin
  Result := R or (G shl 8) or (B shl 16);
end;

// FUNCION PARA CONVERTIR UN COLOR RGB A TCOLOR
function RGBToColor(R, G, B : Integer) : TColor;
begin
  Result := TColor((B * 65536) + (G * 256) + R);
end;

{ FUNCION PARA CONVERTIR UN COLOR HEXAHECIMAL A TCOLOR
  Nota : si el color hex viene con #, se le debe quitar para que funcione. }
function HexToTColor(sColor : string) : TColor;
begin
  Result := RGB(StrToInt('$'+Copy(sColor, 1, 2 )),
                StrToInt('$'+Copy(sColor, 3, 2 )),
                StrToInt('$'+Copy(sColor, 5, 2 )));
end;

function ColorToHtml(Color : TColor) : string;
var
  COL : LongInt;
begin
  COL := Vcl.Graphics.ColorToRGB(Color);
  { first convert TColor to Integer to remove the higher bits }
  { erst TColor zu Integer, da die Unnötigen höheren Bit entfernt werden }
  Result := '#' + IntToHex(COL and $FF, 2) + IntToHex(COL shr 8 and $FF, 2) + IntToHex(COL shr 16 and $FF, 2);
end;

function HtmlToColor(Color : string) : TColor;
begin
  Result := StringToColor('$' + Copy(Color, 6, 2) + Copy(Color, 4, 2) + Copy(Color, 2, 2));
end;

//function IsNull(Value, Default : Variant) : Variant;
//begin
//  if (Value <> Null) then
//    Result:= Value
//  else
//    Result:= Default;
//end;


end.
