unit UResolucionPantalla;

{ UNITS PARA OBTENER LA RESOLUCION DE PANTALLA DE WINDOWS.

  ESTA UNIDAD ES UTIL PARA CAMBIAR EL TAMAÑO DE LOS FORMULARIOS DE TU APLICACION
  SEGUN LA RESOLUCION QUE TENGA WINDOWS. MUY UTIL PARA QUE TU APLICACION SE VEA
  CON EL TAMAÑO CORRECTO INDEPENDIENTEMENTE DEL TAMAÑO DE LA RESOLUCIÓN QUE TENGA
  WINDOWS.

  NOTA :

  Para manejar la resolución de pantalla (DPI) en Delphi, se recomienda
  habilitar el modo "Per-Monitor v2" en la configuración del manifiesto
  del proyecto. Esto indica a Windows que la aplicación está preparada para
  manejar DPI alto y escalado de pantalla, evitando que los elementos de la
  interfaz de usuario se vean borrosos o desproporcionados en pantallas
  de alta resolución.

  - Pasos para habilitar DPI alto en Delphi:

  1 - Acceder a las opciones del proyecto (Project => Options...).
  2 - En el apartado Application seleccione la sección Manifest (Manifiesto).
  3 - En el campo "DPI Awareness", seleccione "Per-Monitor v2".

  - Configurar el diseñador de formularios (opcional):

  1 - En Tools > Options > User Interface > Form Designer, marque la opción "High DPI".
  2 - En el campo VCL Designer High DPI mode selecciona Automatic (Screen PPI)
      y marca la opción Scale grid size / snap tolerance to design PPI
      para que la interfaz de usuario del diseñador de formularios también se
      ajuste a las nuevas resoluciones.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;


type
  TScreenResolution = (stLowRes,     // < 1366x768
                       stHD,         // 1366x768
                       stFullHD,     // 1920x1080
                       stQHD,        // 2560x1440
                       st4K);        // 3840x2160

function GetScreenResolution : TScreenResolution;

implementation

// Determina el tipo de pantalla según la resolución
function GetScreenResolution : TScreenResolution;
var
  ScreenWidth : Integer;
begin
  ScreenWidth := Screen.Width;

  if ScreenWidth < 1366 then
    Result := stLowRes
  else if ScreenWidth = 1366 then
    Result := stHD
  else if ScreenWidth <= 1920 then
    Result := stFullHD
  else if ScreenWidth <= 2560 then
    Result := stQHD
  else
    Result := st4K;
end;


end.
