unit ModoOscuroClaro;

{ UNIDAD DESARROLLADA PARA MANEJAR EL MODO OSCURO (DARK MODE) Y EL
  MODO CLARO (LIGHT MODE) EN UNA APLICACION COMO SUCEDE EN LAS PAGINAS WEB. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.ComCtrls,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  cxContainer, cxEdit, cxCustomListBox, cxCheckListBox, cxTextEdit, cxButtons,
  dxBarBuiltInMenu, cxLabel, cxPC, cxCheckBox, dxBevel, cxGroupBox,
  cxCurrencyEdit, cxRadioGroup, cxMemo, cxRichEdit, dxStatusBar,
  dxSkinBlue, dxSkinMoneyTwins, dxSkinOffice2007Blue, dxSkinOffice2010Silver,
  dxSkinVS2010, cxMaskEdit, cxDropDownEdit, cxCalc, cxListBox, cxClasses,
  cxShellBrowserDialog, dxToggleSwitch, dxCore, dxSkinsForm,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxListView, cxTreeView, dximctrl,
  cxImageComboBox,  cxScrollBar, dxBar,
  dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, dxTreeView, cxScheduler,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerAgendaView, cxSchedulerDateNavigator,
  cxSchedulerHolidays, cxSchedulerTimeGridView, cxSchedulerUtils,
  cxSchedulerWeekView, cxSchedulerYearView, cxSchedulerGanttView,
  cxSchedulerRecurrence, cxSchedulerTreeListBrowser,
  cxSchedulerRibbonStyleEventEditor, cxDateNavigator, cxProgressBar, cxTrackBar,
  dxZoomTrackBar, cxColorComboBox, cxCheckComboBox, cxCheckGroup,
  dxColorEdit, cxButtonEdit,  cxTimeEdit,  cxImage,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  dxCheckGroupBox, dxBreadcrumbEdit, cxDateUtils, cxCalendar,
  cxSpinEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxTL, dxSkinOffice2019Black, dxSkinDevExpressDarkStyle,
  dxActivityIndicator, dxShellDialogs, dxColorDialog, cxTLData, cxDBTL,
  cxDBProgressBar, cxDBTrackBar, dxDBZoomTrackBar, cxDBCheckListBox,
  cxDBColorComboBox, cxDBCheckComboBox, cxDBCheckGroup, dxDBColorEdit, cxDBEdit,
  cxDBNavigator, dxDBBreadcrumbEdit, dxDBCheckGroupBox, dxDBToggleSwitch,
  cxGeometry, dxFramedControl, dxPanel;


type
  TAppTema = (Claro, Oscuro);

var
  SkinController : TdxSkinController;
  TemaActual     : TAppTema;

procedure AplicarTema(AForm : TForm);

implementation


{ EL PROCEDIMIENTO COMBINA VARIOS SKINS EN MI APLICACION EN VEZ DE USAR UNO
  SOLO PARA TODA LA APLICACION.
}

procedure AplicarTema(AForm : TForm);
var
  I : Integer;
begin
  if TemaActual = TAppTema.Oscuro then
    begin
      AForm.Color             := $00262626;  //COLOR DEL FORMULARIO EN MODO OSCURO
      SkinController.SkinName := 'VisualStudio2013Dark';
    end
  else
    begin
      //AQUI DEBES ESTABLECER EL COLOR EN TIEMPO DE DISEÑO QUE USAS EN TODOS TUS FORMULARIOS
      AForm.Color             := $00F5F4F4;
      SkinController.SkinName := '';
    end;

  for I:= 0 to AForm.ComponentCount - 1 do
    begin
      if AForm.Components[I] is TcxLabel then
        with AForm.Components[I] as TcxLabel do
          begin
            Transparent := True;

            //AQUI SE MANEJA EL COLOR DE LOS TcxLabel

            if Tag = 0 then
              begin
                if TemaActual = TAppTema.Claro then
                  Style.TextColor := clWindowText
                else
                  Style.TextColor := clWhite;
              end;

          { NOTA : EN EL MANEJO DE LOS MODOS CLARO Y OSCURO EN LA APP
            TODOS LOS LABELS DE COLOR NEGRO DEBEN TENER SU PROPIEDAD TAG
            CON VALOR 0 (ES EL VALOR QUE TIENE POR DEFECTO), PERO SI TENEMOS
            LABELS EN OTRO COLOR ESTOS DEBEN TENER SU PROPIEDAD
            TAG CON VALOR 1 PARA QUE LOS MODOS CLARO-OSCURO NO LOS AFECTEN
            Y SE RESPETE LOS COLORES QUE TIENEN ESTABLECIDOS. }

//            if ModoClaro = False then
//              begin
//                if Style.TextColor = clBlue then
//                  Style.TextColor := clAqua;
//              end;

          end;

      if AForm.Components[I] is TcxButton then
        with AForm.Components[I] as TcxButton do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Office2010Silver'
            else
              LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxListBox then
        with AForm.Components[I] as TcxListBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDateEdit then
        with AForm.Components[I] as TcxDateEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxSpinEdit then
        with AForm.Components[I] as TcxSpinEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxComboBox then
        with AForm.Components[I] as TcxComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxCheckBox then
        with AForm.Components[I] as TcxCheckBox do
          begin
            Transparent := True;

            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'VS2010'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxPageControl then
        with AForm.Components[I] as TcxPageControl do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxGrid then
        with AForm.Components[I] as TcxGrid do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxTreeList then
        with AForm.Components[I] as TcxTreeList do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxListView then
        with AForm.Components[I] as TcxListView do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxTreeView then
        with AForm.Components[I] as TcxTreeView do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxImageComboBox then
        with AForm.Components[I] as TcxImageComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TdxBevel then
        with AForm.Components[I] as TdxBevel do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxGroupBox then
        with AForm.Components[I] as TcxGroupBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Office2007Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxPanel then
        with AForm.Components[I] as TdxPanel do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Office2007Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxScrollBar then
        with AForm.Components[I] as TcxScrollBar do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxBarManager then
        with AForm.Components[I] as TdxBarManager do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxStatusBar then
        with AForm.Components[I] as TdxStatusBar do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Office2007Blue'
            else
              LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TdxTreeViewControl then
        with AForm.Components[I] as TdxTreeViewControl do
          begin
//            LookAndFeel.SkinName := SkinName;
          end;

      if AForm.Components[I] is TcxScheduler then
        with AForm.Components[I] as TcxScheduler do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDateNavigator then
        with AForm.Components[I] as TcxDateNavigator do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxProgressBar then
        with AForm.Components[I] as TcxProgressBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxTrackBar then
        with AForm.Components[I] as TcxTrackBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TdxZoomTrackBar then
        with AForm.Components[I] as TdxZoomTrackBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxCheckListBox then
        with AForm.Components[I] as TcxCheckListBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'SkinAzul'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxColorComboBox then
        with AForm.Components[I] as TcxColorComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxCheckComboBox then
        with AForm.Components[I] as TcxCheckComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxCheckGroup then
        with AForm.Components[I] as TcxCheckGroup do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxColorEdit then
        with AForm.Components[I] as TdxColorEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxTextEdit then
        with AForm.Components[I] as TcxTextEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxMaskEdit then
        with AForm.Components[I] as TcxMaskEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxMemo then
        with AForm.Components[I] as TcxMemo do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxRichEdit then
        with AForm.Components[I] as TcxRichEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxButtonEdit then
        with AForm.Components[I] as TcxButtonEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxCalcEdit then
        with AForm.Components[I] as TcxCalcEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxTimeEdit then
        with AForm.Components[I] as TcxTimeEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxCurrencyEdit then
        with AForm.Components[I] as TcxCurrencyEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxImage then
        with AForm.Components[I] as TcxImage do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxLookupComboBox then
        with AForm.Components[I] as TcxLookupComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxRadioButton then
        with AForm.Components[I] as TcxRadioButton do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxRadioGroup then
        with AForm.Components[I] as TcxRadioGroup do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Office2007Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxCheckGroupBox then
        with AForm.Components[I] as TdxCheckGroupBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxBreadcrumbEdit then
        with AForm.Components[I] as TdxBreadcrumbEdit do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'MoneyTwins'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxToggleSwitch then
        with AForm.Components[I] as TdxToggleSwitch do
          begin
            if TemaActual = TAppTema.Claro then
              begin
                Style.LookAndFeel.SkinName := 'MoneyTwins';
                Style.Color                := $00FFEFE3;  //Controlamos el color de fondo de este componente
                StyleDisabled.Color        := $00FFEFE3;
                StyleFocused.Color         := $00FFEFE3;
                StyleHot.Color             := $00FFEFE3;
              end
            else
              begin
                Style.LookAndFeel.SkinName := 'DevExpressDarkStyle';
                Style.Color                := $00302D2D;
                StyleDisabled.Color        := $00302D2D;
                StyleFocused.Color         := $00302D2D;
                StyleHot.Color             := $00302D2D;
              end;
          end;

      if AForm.Components[I] is TdxActivityIndicator then
        with AForm.Components[I] as TdxActivityIndicator do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TdxSaveFileDialog then
        with AForm.Components[I] as TdxSaveFileDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxOpenFileDialog then
        with AForm.Components[I] as TdxOpenFileDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxOpenPictureDialog then
        with AForm.Components[I] as TdxOpenPictureDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxSavePictureDialog then
        with AForm.Components[I] as TdxSavePictureDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxColorDialog then
        with AForm.Components[I] as TdxColorDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxShellBrowserDialog then
        with AForm.Components[I] as TcxShellBrowserDialog do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;


//========================================================================

      if AForm.Components[I] is TcxDBTreeList then
        with AForm.Components[I] as TcxDBTreeList do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'Blue'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBProgressBar then
        with AForm.Components[I] as TcxDBProgressBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBTrackBar then
        with AForm.Components[I] as TcxDBTrackBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TdxDBZoomTrackBar then
        with AForm.Components[I] as TdxDBZoomTrackBar do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'Office2019Black';
          end;

      if AForm.Components[I] is TcxDBCheckListBox then
        with AForm.Components[I] as TcxDBCheckListBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBColorComboBox then
        with AForm.Components[I] as TcxDBColorComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBCheckComboBox then
        with AForm.Components[I] as TcxDBCheckComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBCheckGroup then
        with AForm.Components[I] as TcxDBCheckGroup do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Office2007Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxDBColorEdit then
        with AForm.Components[I] as TdxDBColorEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBTextEdit then
        with AForm.Components[I] as TcxDBTextEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBMaskEdit then
        with AForm.Components[I] as TcxDBMaskEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBMemo then
        with AForm.Components[I] as TcxDBMemo do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBDateEdit then
        with AForm.Components[I] as TcxDBDateEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBButtonEdit then
        with AForm.Components[I] as TcxDBButtonEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBCheckBox then
        with AForm.Components[I] as TcxDBCheckBox do
          begin
            Transparent := True;

            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'VS2010'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBComboBox then
        with AForm.Components[I] as TcxDBComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBImageComboBox then
        with AForm.Components[I] as TcxDBImageComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBSpinEdit then
        with AForm.Components[I] as TcxDBSpinEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBCalcEdit then
        with AForm.Components[I] as TcxDBCalcEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBTimeEdit then
        with AForm.Components[I] as TcxDBTimeEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBCurrencyEdit then
        with AForm.Components[I] as TcxDBCurrencyEdit do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBImage then
        with AForm.Components[I] as TcxDBImage do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBLookupComboBox then
        with AForm.Components[I] as TcxDBLookupComboBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'MoneyTwins'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBRadioGroup then
        with AForm.Components[I] as TcxDBRadioGroup do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Office2007Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBListBox then
        with AForm.Components[I] as TcxDBListBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TcxDBNavigator then
        with AForm.Components[I] as TcxDBNavigator do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'MoneyTwins'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxDBBreadcrumbEdit then
        with AForm.Components[I] as TdxDBBreadcrumbEdit do
          begin
            if TemaActual = TAppTema.Claro then
              LookAndFeel.SkinName := 'MoneyTwins'
            else
              LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxDBCheckGroupBox then
        with AForm.Components[I] as TdxDBCheckGroupBox do
          begin
            if TemaActual = TAppTema.Claro then
              Style.LookAndFeel.SkinName := 'Office2007Blue'
            else
              Style.LookAndFeel.SkinName := 'VisualStudio2013Dark';
          end;

      if AForm.Components[I] is TdxDBToggleSwitch then
        with AForm.Components[I] as TdxDBToggleSwitch do
          begin
            if TemaActual = TAppTema.Claro then
              begin
                Style.LookAndFeel.SkinName := 'MoneyTwins';
                Style.Color                := $00FFEFE3;  //Controlamos el color de fondo de este componente
                StyleDisabled.Color        := $00FFEFE3;
                StyleFocused.Color         := $00FFEFE3;
                StyleHot.Color             := $00FFEFE3;
              end
            else
              begin
                Style.LookAndFeel.SkinName := 'DevExpressDarkStyle';
                Style.Color                := $00302D2D;
                StyleDisabled.Color        := $00302D2D;
                StyleFocused.Color         := $00302D2D;
                StyleHot.Color             := $00302D2D;
              end;
          end;

//      if AForm.Components[I] is TAdvMemo then
//        with AForm.Components[I] as TAdvMemo do
//          begin
//            if TemaActual = TAppTema.Claro then
//              begin
//                BkColor    := clWhite;
//                Font.Color := clBlack;
//              end
//            else
//              begin
//                BkColor    := clBlack;
//                Font.Color := clWhite;
//              end;
//          end;


    end;

end;


end.
