// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'Introduce un título';

  @override
  String get addItineraryFieldLocation => 'Ubicación';

  @override
  String get addItineraryFieldNotes => 'Notas / confirmación';

  @override
  String get addItineraryFieldTitle => 'Título';

  @override
  String get addItineraryHintLocation => 'Aeropuerto, dirección del hotel…';

  @override
  String get addItineraryHintNotes => 'Localizador, enlaces…';

  @override
  String get addItineraryHintTitle => 'Vuelo a Lisboa';

  @override
  String get addItinerarySave => 'Guardar evento';

  @override
  String get addItineraryTitle => 'Añadir evento al itinerario';

  @override
  String get addPackingAddToList => 'Añadir a la lista';

  @override
  String get addPackingEnterName => 'Introduce el nombre del artículo';

  @override
  String get addPackingHint => 'p. ej. Adaptador de corriente';

  @override
  String get addPackingIcon => 'Icono';

  @override
  String get addPackingQuantity => 'Cantidad';

  @override
  String get addPackingTitle => 'Añadir al equipaje';

  @override
  String get announcementsLatest => 'Novedades';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => 'DIVISA BASE';

  @override
  String get budgetCategoryDialogHint => 'p. ej. Recuerdos';

  @override
  String get budgetCategoryNameExists => 'El nombre ya existe';

  @override
  String get budgetCategoryNameMax => 'Máximo 40 caracteres';

  @override
  String get budgetDailyFood => 'Comida diaria';

  @override
  String get budgetDialogAdd => 'Añadir';

  @override
  String get budgetDialogNewCategory => 'Nueva categoría de gasto';

  @override
  String budgetDialogRemoveBody(String name) {
    return '¿Eliminar \"$name\" y su importe?';
  }

  @override
  String get budgetDialogRemoveTitle => 'Eliminar categoría';

  @override
  String get budgetDialogRename => 'Renombrar';

  @override
  String get budgetDialogRenameCategory => 'Renombrar categoría';

  @override
  String get budgetEdit => 'Editar presupuesto';

  @override
  String get budgetExpenseDailyFood => 'Comida diaria';

  @override
  String get budgetExpenseEatingOut => 'Comer fuera';

  @override
  String get budgetExpenseEntertainment => 'Ocio';

  @override
  String get budgetExpenseFlights => 'Vuelos';

  @override
  String get budgetExpenseGrocery => 'Comestibles';

  @override
  String get budgetExpenseHotels => 'Hoteles';

  @override
  String get budgetExpenseMisc => 'Varios';

  @override
  String get budgetExpensePhoneService => 'Telefonía';

  @override
  String get budgetExpenseShopping => 'Compras';

  @override
  String get budgetExpenseTourism => 'Turismo';

  @override
  String get budgetExpenseTransportation => 'Transporte';

  @override
  String get budgetExpenseTravelInsurance => 'Seguro de viaje';

  @override
  String get budgetInDestinations => 'En tus destinos';

  @override
  String get budgetNoCategories => 'Aún no hay categorías de gasto';

  @override
  String budgetOtherExpenses(String code) {
    return 'OTROS GASTOS ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'Por día (estimación)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / día';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'Restante tras gastos · $code';
  }

  @override
  String get budgetSave => 'Guardar presupuesto';

  @override
  String get budgetSpendingPower => 'Poder adquisitivo';

  @override
  String get budgetSpentVsBudget => 'Gastado vs presupuesto';

  @override
  String budgetTotalBudget(String code) {
    return 'PRESUPUESTO TOTAL ($code)';
  }

  @override
  String budgetTotalForTrip(Object code) {
    return 'Total del viaje ($code)';
  }

  @override
  String get budgetTripDashboard => 'panel';

  @override
  String get budgetTripLengthDays => 'Duración del viaje (días)';

  @override
  String get budgetTripTitle => 'Presupuesto del viaje';

  @override
  String get commonAdd => 'Añadir';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Borrar';

  @override
  String get commonOk => 'Vale';

  @override
  String get commonRemove => 'Eliminar';

  @override
  String get commonRename => 'Renombrar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get countryPickerTitle => 'Seleccionar país';

  @override
  String get cryptoHeader => 'CRIPTOS';

  @override
  String get cryptoPickerTitle => 'Elegir moneda';

  @override
  String get currencyPickerSearchHint => 'Buscar ticker o nombre';

  @override
  String get currencyPickerTitle => 'Elegir divisa';

  @override
  String get exchangeBaseSuffix => ' · Base';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'No se pudieron cargar los tipos\n$error';
  }

  @override
  String get exchangeHeader => 'CAMBIO';

  @override
  String exchangeLastUpdated(String mins) {
    return 'Actualizado hace $mins min';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'Actualizado hace $mins min (sin conexión)';
  }

  @override
  String get exchangeResetOne => 'Restablecer a 1 (base USD)';

  @override
  String get exchangeResetTooltip => 'Restablecer importes';

  @override
  String get exchangeResetZero => 'Borrar a 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'Día $day: $date';
  }

  @override
  String get itineraryEmpty =>
      'Aún no hay eventos.\nToca + para añadir vuelos, hoteles y planes.';

  @override
  String get itineraryHeader => 'ITINERARIO';

  @override
  String itineraryHiveError(String error) {
    return 'No se pudieron abrir los datos del itinerario guardado.\nAún puedes añadir eventos; es posible que no persistan.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'Abrir en el mapa';

  @override
  String get mapAddToTrip => 'Añadir al viaje';

  @override
  String get mapClearRoute => 'Borrar ruta y guía';

  @override
  String get mapClearTooltip => 'Borrar';

  @override
  String get mapDisplayCurrentViewport => 'Vista actual';

  @override
  String get mapDisplaySavedSearch => 'Búsqueda guardada';

  @override
  String get mapDisplayTripDestination => 'Destino del viaje';

  @override
  String get mapDownloadAll => 'Descargar todo';

  @override
  String get mapDownloadCurrentRegion =>
      'Descargar región actual para uso sin conexión';

  @override
  String get mapDownloadThisDestination => 'Descargar este destino';

  @override
  String get mapDownloadedRegions => 'Regiones descargadas';

  @override
  String get mapDownloadingRegion => 'Descargando región...';

  @override
  String mapDownloadingTitle(String title) {
    return 'Descargando $title...';
  }

  @override
  String get mapFromItinerary => 'Desde tu itinerario';

  @override
  String get mapItineraryEmptyHint =>
      'Añade destinos al itinerario para pre-descargarlos aquí.';

  @override
  String get mapLoadingRegions => 'Cargando regiones sin conexión…';

  @override
  String mapLocatingQuery(String query) {
    return 'Localizando $query...';
  }

  @override
  String get mapMarkCategoryBody =>
      'Elige cómo etiquetar este pin sin conexión.';

  @override
  String get mapMarkCategoryTitle => 'Categoría de este marcador';

  @override
  String get mapMarkFood => 'Comida';

  @override
  String get mapMarkHotel => 'Hotel';

  @override
  String get mapMarkLandmark => 'Punto de interés';

  @override
  String get mapMarkOther => 'Otro';

  @override
  String mapNextInstruction(String current, String total) {
    return 'Siguiente instrucción ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'Sin ubicación';

  @override
  String get mapNoRegionsYet => 'Aún no has descargado ninguna región.';

  @override
  String get mapOfflineIntro =>
      'Guarda la región visible o descarga destinos del viaje para navegar sin cobertura.';

  @override
  String get mapOfflineMapsTitle => 'Mapas sin conexión';

  @override
  String get mapRefreshTooltip => 'Actualizar';

  @override
  String get mapRemovePinTooltip => 'Quitar marcador';

  @override
  String get mapSaveOffline => 'Guardar sin conexión';

  @override
  String get mapSavePinToMap => 'Guardar pin en el mapa';

  @override
  String get mapSavedPinsBody =>
      'Marcadores guardados desde la búsqueda. Toca eliminar para quitar uno del mapa.';

  @override
  String get mapSavedPinsTitle => 'Marcadores guardados';

  @override
  String get mapSearchHint => 'Buscar ciudad, dirección o punto de interés…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title añadido a tus marcas sin conexión.';
  }

  @override
  String get mapSnackArrived => 'Has llegado.';

  @override
  String mapSnackCouldNotFind(String query) {
    return 'No se encontró \"$query\".';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'Error al eliminar: $error';
  }

  @override
  String mapSnackDownloadFailed(Object error) {
    return 'Error al descargar sin conexión: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return 'Descargado \"$title\".';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\" no tiene ubicación.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'Descarga finalizada: $count región(es) del itinerario.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'No se pudieron cargar regiones sin conexión: $error';
  }

  @override
  String get mapSnackLocationOff =>
      'El servicio de ubicación está desactivado. Actívalo para la navegación.';

  @override
  String get mapSnackLocationPermission =>
      'Se requiere permiso de ubicación para giro a giro.';

  @override
  String get mapSnackMapNotReady =>
      'El mapa aún no está listo. Espera un momento.';

  @override
  String get mapSnackNavStartFail => 'No se puede iniciar la navegación ahora.';

  @override
  String get mapSnackNavStopped => 'Navegación detenida.';

  @override
  String get mapSnackNoItineraryLocations =>
      'Ningún evento del itinerario tiene ubicación o punto en el mapa para descargar.';

  @override
  String get mapSnackNoManeuver =>
      'Este paso no tiene punto de maniobra preciso.';

  @override
  String get mapSnackNoRoute => 'No hay ruta; mostrando destino.';

  @override
  String get mapSnackRegionDownloaded =>
      '¡Región descargada! Ya puedes navegar sin conexión.';

  @override
  String get mapSnackRemovedPin => 'Marcador eliminado.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'Se eliminó la región sin conexión \"$name\".';
  }

  @override
  String get mapSnackRouteCleared => 'Ruta y guía borradas.';

  @override
  String mapSnackSearchFailed(String error) {
    return 'Error en la búsqueda: $error';
  }

  @override
  String get mapStartNavigation => 'Iniciar navegación';

  @override
  String get mapStartingNav => 'Iniciando navegación...';

  @override
  String get mapStopNavigation => 'Detener navegación';

  @override
  String get mapTravelDriving => 'En coche';

  @override
  String get mapTravelWalking => 'A pie';

  @override
  String mapTurnByTurn(String mode) {
    return 'Giro a giro ($mode)';
  }

  @override
  String get mindMapCaptureFail =>
      'No se pudo capturar el mapa mental. Inténtalo de nuevo.';

  @override
  String get mindMapClearBody =>
      'Elimina todos los nodos y restaura el mapa de demostración centrado.';

  @override
  String get mindMapClearTitle => '¿Borrar el lienzo?';

  @override
  String get mindMapClearTooltip => 'Borrar / Restablecer';

  @override
  String mindMapCouldNotSave(String error) {
    return 'No se pudo guardar: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'No se pudo guardar: $type';
  }

  @override
  String get mindMapEmailShare => 'Correo / Compartir';

  @override
  String get mindMapHelpHint =>
      'Pellizca para zoom · arrastra el lienzo · arrastra tarjetas · toca para editar · + añade hijo';

  @override
  String get mindMapNodeAddLeftTooltip => 'Añadir hijo a la izquierda';

  @override
  String get mindMapNodeAddRightTooltip => 'Añadir hijo a la derecha';

  @override
  String get mindMapNodeDeleteTooltip => 'Eliminar nodo';

  @override
  String get mindMapNodeEditTitle => 'Editar nodo';

  @override
  String get mindMapNodeHint => 'Etiqueta breve';

  @override
  String get mindMapPhotoAccess =>
      'Se necesita acceso a la galería para guardar la imagen.';

  @override
  String get mindMapReset => 'Restablecer';

  @override
  String get mindMapSavePhoto => 'Guardar como foto';

  @override
  String get mindMapSavedPhotos => 'Guardado en Fotos';

  @override
  String get mindMapShareCaptureFail =>
      'No se pudo capturar el mapa mental para compartir.';

  @override
  String get mindMapShareCompleted => 'Compartido';

  @override
  String mindMapShareFailed(String error) {
    return 'Error al compartir: $error';
  }

  @override
  String get mindMapShareReady => 'Imagen lista — elige una app para compartir';

  @override
  String get mindMapShareSheetClosed => 'Hoja de compartir cerrada';

  @override
  String get moreToolsHeader => 'MÁS HERRAMIENTAS';

  @override
  String get moreToolsSubtitle => 'Utilidades de viaje';

  @override
  String get navCurrency => 'Divisa';

  @override
  String get navItinerary => 'Itinerario';

  @override
  String get navMoreTools => 'Más herramientas';

  @override
  String get navOfflineMap => 'Mapa sin conexión';

  @override
  String get packingCatClothing => 'ROPA';

  @override
  String get packingCatDocuments => 'DOCUMENTOS';

  @override
  String get packingCatMedications => 'MEDICAMENTOS';

  @override
  String get packingCatMisc => 'VARIOS';

  @override
  String get packingCatReservations => 'RESERVAS';

  @override
  String get packingEmpty =>
      'Tu lista está vacía.\nToca + para añadir artículos.';

  @override
  String get packingEmptyHidden =>
      'No queda nada por empacar — o desactiva \"Ocultar completados\" para ver lo hecho.';

  @override
  String get packingHeader => 'EQUIPAJE Y LOGÍSTICA';

  @override
  String get packingHideCompleted => 'Ocultar completados';

  @override
  String get packingHideCompletedSubtitle =>
      'Los completados se guardan; solo se ocultan aquí';

  @override
  String get packingStarterPassport => 'Pasaporte';

  @override
  String get packingStarterShirts => 'Camisas';

  @override
  String get packingStarterSocks => 'Calcetines';

  @override
  String get packingStarterTickets => 'Billetes de avión';

  @override
  String get packingStarterToothbrush => 'Cepillo de dientes';

  @override
  String get presentationDeleteBody =>
      '¿Seguro que quieres quitar este documento de la bóveda?';

  @override
  String get presentationDeleteTitle => '¿Eliminar documento?';

  @override
  String get proActive => 'Activo';

  @override
  String get proManageHintFree =>
      'Desbloquea funciones Pro con una suscripción mensual.';

  @override
  String get proManageHintPro => 'Gestiona tu suscripción o restaura compras.';

  @override
  String get proManageSubscription => 'Gestionar suscripción';

  @override
  String get proName => 'Tripmetic Pro';

  @override
  String get proPaywallError =>
      'No se pudo mostrar el paywall. Revisa tu oferta en RevenueCat.';

  @override
  String proRestoreFailed(String message) {
    return 'Error al restaurar: $message';
  }

  @override
  String get proTrialCta => 'Empieza tu prueba gratis de 3 días';

  @override
  String get proWelcome => 'Bienvenido a Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'Bueno';

  @override
  String get schedulerAvailabilityOffHours => 'Fuera de horario';

  @override
  String get schedulerAvailabilityOk => 'Aceptable';

  @override
  String get schedulerBaseLocation => 'Ubicación base';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'La fecha, la hora y el control se aplican al reloj base ($zone). Cada fila muestra el mismo instante en esa zona.';
  }

  @override
  String get schedulerConvertedCities => 'Ciudades convertidas';

  @override
  String get schedulerDayNext => '+1 día';

  @override
  String get schedulerDayPrevious => '-1 día';

  @override
  String get schedulerDaySame => 'Mismo día';

  @override
  String get schedulerMeetingTime => 'Hora de la reunión';

  @override
  String get schedulerSubtitle => 'Solapamiento de reuniones';

  @override
  String get schedulerTitle => 'Planificador global';

  @override
  String get settingsAndInfo => 'Ajustes e información';

  @override
  String get settingsContact => 'Contáctanos';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'No se pudo abrir el enlace';

  @override
  String get settingsHelpFaq => 'Ayuda y preguntas frecuentes';

  @override
  String get settingsPrivacy => 'Política de privacidad';

  @override
  String get settingsSupportLegal => 'Soporte y legal';

  @override
  String get settingsTerms => 'Términos de uso';

  @override
  String get sizeCatBelts => 'Cinturones';

  @override
  String get sizeCatMensJeansCombo => 'Vaqueros hombre — W×L (US)';

  @override
  String get sizeCatMensJeansInseam => 'Vaqueros hombre — largo (L)';

  @override
  String get sizeCatMensJeansWaist => 'Vaqueros hombre — cintura (W)';

  @override
  String get sizeCatMensPants => 'Pantalones hombre';

  @override
  String get sizeCatMensShirts => 'Camisas hombre';

  @override
  String get sizeCatMensShoes => 'Calzado hombre';

  @override
  String get sizeCatMensTshirts => 'Camisetas hombre';

  @override
  String get sizeCatWomensBlouses => 'Blusas mujer';

  @override
  String get sizeCatWomensDresses => 'Vestidos mujer';

  @override
  String get sizeCatWomensPants => 'Pantalones mujer';

  @override
  String get sizeCatWomensShoes => 'Calzado mujer';

  @override
  String get sizeCatWomensTshirts => 'Camisetas mujer';

  @override
  String get sizeConverterAppBarSubtitle => 'Ropa y calzado';

  @override
  String get sizeConverterCategory => 'Categoría';

  @override
  String get sizeConverterHeader => 'ROPA Y CALZADO';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · toca para cambiar';
  }

  @override
  String get sizeConverterYourBaseSize => 'Tu talla base (en la etiqueta)';

  @override
  String get sizeConverterYourCountry => 'Tu país / región';

  @override
  String get sizeTipJeansCombo =>
      'Ejemplo US 38×32: cintura ≈ UE 48; etiqueta JP a menudo ~96–97 cm; largo 32\" ≈ ~81 cm. Las marcas varían: orientativo.';

  @override
  String get sizeTipJeansInseam =>
      'Largo interior en pulgadas (p. ej. 32). Japón puede mostrar ~81 cm para 32\". Escribe 38×32; usamos 32 para largo.';

  @override
  String get sizeTipJeansWaist =>
      'En etiquetas asiáticas un número suele ser cintura: centímetros (38\" ≈ 96–97 cm) o pulgadas US (38). Comprueba con cinta métrica. Puedes escribir 38×32; usamos 38 para cintura.';

  @override
  String get timezonePickerEmpty => 'Sin coincidencias';

  @override
  String get timezonePickerHint => 'Buscar nombre IANA (p. ej. Europe, Tokyo)';

  @override
  String get timezonePickerTitle => 'Elegir zona horaria';

  @override
  String get tipAmount => 'Importe de propina';

  @override
  String get tipAppBarSubtitle => 'Propina y cuenta';

  @override
  String get tipBillHint => 'p. ej. 1.250.000,00 \$';

  @override
  String get tipCountryBrazil => 'Brasil';

  @override
  String get tipCountryChina => 'China';

  @override
  String get tipCountryColombia => 'Colombia';

  @override
  String get tipCountryDominicanRepublic => 'República Dominicana';

  @override
  String get tipCountryEgypt => 'Egipto';

  @override
  String get tipCountryMexico => 'México';

  @override
  String get tipCountrySpain => 'España';

  @override
  String get tipCountryThailand => 'Tailandia';

  @override
  String get tipCountryUsa => 'Estados Unidos';

  @override
  String get tipCurrentCountry => 'País actual';

  @override
  String get tipPeople => 'Personas';

  @override
  String get tipPerPerson => 'Importe por persona';

  @override
  String get tipPercentHint => 'Escribe la propina % (p. ej. 15 o 27,5)';

  @override
  String get tipPercentLabel => 'Propina %';

  @override
  String get tipResults => 'RESULTADOS';

  @override
  String get tipSmartHeader => 'PROPINA INTELIGENTE';

  @override
  String get tipTotalBill => 'Importe total de la cuenta';

  @override
  String get tipTotalWithTip => 'Total con propina';

  @override
  String get toolBrainstorm => 'Lluvia de ideas';

  @override
  String get toolBudget => 'Presupuesto';

  @override
  String get toolBudgetSubtitle =>
      'Planificación del presupuesto y seguimiento de gastos';

  @override
  String get toolBudgetTitle => 'Presupuesto';

  @override
  String get toolCrypto => 'Cripto';

  @override
  String get toolCryptoSubtitle => 'Valores en USD de monedas populares';

  @override
  String get toolCryptoTitle => 'Cripto';

  @override
  String get toolDocumentVault => 'Bóveda de documentos';

  @override
  String get toolMindMapSubtitle =>
      'Ideas en un lienzo infinito · sin conexión';

  @override
  String get toolMindMapTitle => 'Mapa mental';

  @override
  String get toolPacking => 'Equipaje';

  @override
  String get toolPackingSubtitle => 'Listas de equipaje por viaje';

  @override
  String get toolPackingTitle => 'Equipaje';

  @override
  String get toolSchedulerSubtitle => 'Dos zonas horarias · jet lag';

  @override
  String get toolSchedulerTitle => 'Hora y fecha';

  @override
  String get toolSettingsAboutSubtitle =>
      'Avisos, ayuda, privacidad y términos';

  @override
  String get toolSettingsAboutTitle => 'Ajustes y acerca de';

  @override
  String get toolSettingsInfo => 'Ajustes e información';

  @override
  String get toolSizeSubtitle => 'EE. UU. · Reino Unido · UE · Japón (JP)';

  @override
  String get toolSizeTitle => 'Conversor de tallas de ropa';

  @override
  String get toolTimeDate => 'Hora y fecha';

  @override
  String get toolTipSubtitle => 'Normas por país · hasta 20 personas';

  @override
  String get toolTipTitle => 'Propinas y división de cuenta';

  @override
  String get toolUnits => 'Unidades';

  @override
  String get toolUnitsSubtitle => 'Longitud, peso, temperatura, volumen';

  @override
  String get toolUnitsTitle => 'Unidades';

  @override
  String get toolVaultSubtitle =>
      'Almacenamiento sin conexión de documentos importantes';

  @override
  String get toolVaultTitle => 'Bóveda de documentos';

  @override
  String get unitAcres => 'Acres';

  @override
  String get unitCategoryArea => 'Superficie';

  @override
  String get unitCategoryDistance => 'Distancia';

  @override
  String get unitCategoryLength => 'Longitud';

  @override
  String get unitCategoryTemperature => 'Temperatura';

  @override
  String get unitCategoryVolume => 'Volumen';

  @override
  String get unitCategoryWeight => 'Peso';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get unitCentimeters => 'Centímetros';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitFeet => 'Pies';

  @override
  String get unitGrams => 'Gramos';

  @override
  String get unitHectares => 'Hectáreas';

  @override
  String get unitInches => 'Pulgadas';

  @override
  String get unitKilograms => 'Kilogramos';

  @override
  String get unitKilometers => 'Kilómetros';

  @override
  String get unitLiters => 'Litros';

  @override
  String get unitMeters => 'Metros';

  @override
  String get unitMiles => 'Millas';

  @override
  String get unitMilliliters => 'Mililitros';

  @override
  String get unitOunces => 'Onzas';

  @override
  String get unitPounds => 'Libras';

  @override
  String get unitSquareCentimeters => 'Centímetros cuadrados';

  @override
  String get unitSquareFeet => 'Pies cuadrados';

  @override
  String get unitSquareInches => 'Pulgadas cuadradas';

  @override
  String get unitSquareKilometers => 'Kilómetros cuadrados';

  @override
  String get unitSquareMeters => 'Metros cuadrados';

  @override
  String get unitSquareYards => 'Yardas cuadradas';

  @override
  String get unitUsFluidOunces => 'Onzas líquidas US';

  @override
  String get unitUsGallons => 'Galones US';

  @override
  String get unitYards => 'Yardas';

  @override
  String get unitsHeader => 'UNIDADES';

  @override
  String get vaultCategoryArrivalCard => 'Tarjeta de llegada';

  @override
  String get vaultCategoryHotelReservation => 'Reserva de hotel';

  @override
  String get vaultCategoryOther => 'Otro';

  @override
  String get vaultCategoryPassportCopy => 'Copia del pasaporte';

  @override
  String get vaultCategoryReturnFlight => 'Vuelo de vuelta';

  @override
  String get vaultCategoryVisa => 'Visado';

  @override
  String get vaultDocumentTitle => 'Documento';

  @override
  String get vaultIntro =>
      'Guarda documentos de viaje importantes sin conexión y preséntalos rápido en inmigración.';

  @override
  String vaultProcessFailed(String error) {
    return 'Error al procesar el documento: $error';
  }

  @override
  String get vaultVaultWord => 'bóveda';
}
