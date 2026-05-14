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
  String get addPackingFieldCategory => 'Categoría';

  @override
  String get addPackingFieldItemName => 'Nombre del artículo';

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
  String get budgetDestinationSearchHint => 'Buscar país o código de divisa';

  @override
  String get budgetDestinationTitle => 'Añadir destino';

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
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3.000';

  @override
  String get budgetHintZero => '0';

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
  String get commonKeyboardDone => 'Listo';

  @override
  String countryCountriesCount(String count) {
    return '$count países';
  }

  @override
  String get countryPickerTitle => 'Seleccionar país';

  @override
  String get countrySheetSearchHint => 'Buscar país o código ISO';

  @override
  String get countrySheetTitle => 'País / región base';

  @override
  String get cryptoHeader => 'CRIPTOS';

  @override
  String cryptoMockPerUnit(String price) {
    return 'Simulación ~$price / unidad';
  }

  @override
  String get cryptoPickerTitle => 'Elegir moneda';

  @override
  String get cryptoSheetTitle => 'Seleccionar criptomoneda';

  @override
  String get currencyPickerSearchHint => 'Buscar ticker o nombre';

  @override
  String get currencyPickerTitle => 'Elegir divisa';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown de $total mostradas';
  }

  @override
  String get currencySheetSearchHint => 'Buscar código, nombre o ISO numérico';

  @override
  String get currencySheetTitle => 'Seleccionar divisa';

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
  String mapSnackDownloadFailed(String error) {
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
  String mapSnackRoutingFailed(String error) {
    return 'Error al calcular la ruta: $error';
  }

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
  String get mindMapEmptyNode => 'Nodo vacío';

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
  String get mindMapShareSubject => 'Tripmetic — Mapa mental';

  @override
  String get mindMapShareText => 'Exportación de mapa mental desde Tripmetic';

  @override
  String get mindMapTapToEdit => 'Toca para editar';

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
  String get navDashboard => 'Panel';

  @override
  String get navMoreMenu => 'Más';

  @override
  String get navEditNavigation => 'Editar navegación';

  @override
  String get navDoneEditing => 'Listo';

  @override
  String get navSelectSlotHint =>
      'Toca un hueco y luego una herramienta para asignarla.';

  @override
  String get navSavePins => 'Guardar';

  @override
  String get navPinnedSectionTitle => 'Anclado a la barra inferior';

  @override
  String get navAvailableSectionTitle => 'Funciones disponibles';

  @override
  String get navEmptySlot => 'Vacío — añade desde abajo';

  @override
  String get navPinFullHint =>
      'Los cuatro huecos están llenos. Quita uno para añadir otro.';

  @override
  String get navEditPinnedHint =>
      'Usa − para liberar un hueco, + para rellenarlo o arrastra para reordenar. Guarda cuando los cuatro estén llenos.';

  @override
  String get navAddToPinned => 'Añadir a la barra';

  @override
  String get navRemoveFromPinned => 'Quitar de la barra';

  @override
  String get navFeatureBadgeFree => 'Gratis';

  @override
  String get navFeatureBadgePro => 'PRO';

  @override
  String get moreMenuSectionFree => 'Funciones gratuitas';

  @override
  String get moreMenuSectionPro => 'Tripmetic Pro';

  @override
  String get proGlassTeaserTitle => 'Función Tripmetic Pro';

  @override
  String get dashboardWorldExplorerSection => 'Explorador mundial';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'Países visitados';

  @override
  String get dashboardWorldExplorerPercentLabel => 'Del mundo explorado';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent %';
  }

  @override
  String get bucketListDisplayNameLabel => 'Nombre para mostrar';

  @override
  String get bucketListAuthValidationDisplayName => 'Introduce tu nombre';

  @override
  String get authSignUpScreenTitle => 'Crea tu cuenta Tripmetic';

  @override
  String get authSignUpScreenSubtitle =>
      'Opcional: solo si quieres copia en la nube. Puedes usar todas las herramientas en este dispositivo sin registrarte.';

  @override
  String get authSignInScreenTitle => 'Iniciar sesión en Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      'Opcional: para sincronizar tu lista y los viajes en grupo en la nube. El resto de Tripmetic funciona sin cuenta.';

  @override
  String get authForgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get authPasswordResetConfirmation =>
      'Si existe una cuenta con ese correo, recibirás un enlace para restablecer la contraseña.';

  @override
  String get authUnexpectedError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get authBackupBulletBucketList =>
      'Los destinos de la lista se guardan en la nube y se combinan al iniciar sesión.';

  @override
  String get authBackupBulletGroupTrips =>
      'Los viajes en grupo que creas o a los que te unes quedan asociados a tu cuenta.';

  @override
  String get authBackupBulletMultiDevice =>
      'Inicia sesión en otro dispositivo para recuperar tus datos sincronizados.';

  @override
  String get authLinkAlreadyHaveAccount => '¿Ya tienes cuenta? Iniciar sesión';

  @override
  String get authLinkNeedAccount => '¿Necesitas cuenta? Crear una';

  @override
  String get authFullSignUpCta => 'Abrir registro completo';

  @override
  String get authFullSignInCta => 'Abrir inicio de sesión completo';

  @override
  String dashboardGreeting(String name) {
    return 'Hola, $name';
  }

  @override
  String get dashboardGuestName => 'Viajero';

  @override
  String get dashboardWelcomeSubtitle =>
      'Planifica en grupo, mantén el orden y abre herramientas al instante.';

  @override
  String get dashboardPlanGroupTrip => 'Planificar un viaje en grupo';

  @override
  String get dashboardAddBucketList => 'Añadir a la lista de deseos';

  @override
  String get dashboardActiveTripSection => 'Tu próximo viaje';

  @override
  String get dashboardNoUpcomingTripTitle => 'Sin viaje en grupo próximo';

  @override
  String get dashboardNoUpcomingTripBody =>
      'Cuando planifiques con amigos, aquí verás un resumen del viaje.';

  @override
  String get dashboardQuickToolsSection => 'Accesos rápidos';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'Empieza en $days días';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'Termina en $days días';
  }

  @override
  String get navDashboardBody =>
      'Tu centro del viaje: abre herramientas desde la barra o el menú Más.';

  @override
  String get appSettings => 'Ajustes de la app';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic Pro';

  @override
  String get settingsSubscriptionActive => 'Suscripción activa';

  @override
  String get settingsSubscriptionFree => 'Plan gratuito';

  @override
  String get settingsManageBilling => 'Gestionar facturación';

  @override
  String get settingsTestModeSectionTitle => 'Modo de prueba';

  @override
  String get settingsTestModeProTitle => 'Probar como Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'Anulación local para pruebas; ignora RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'Cuando está activado, este dispositivo desbloquea todas las funciones Pro de forma local. Solo para pruebas internas: no modifica tu suscripción real.';

  @override
  String get settingsUnitsTitle => 'Unidades de medida';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsClockWidgetTitle => 'Widget de reloj';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsProfileTitle => 'Perfil y sincronización';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get settingsLogoutConfirm => '¿Cerrar sesión en esta cuenta?';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountBody =>
      'La eliminación de cuenta la gestiona el soporte. Puedes cerrar sesión abajo.';

  @override
  String get settingsSectionAccount => 'Cuenta';

  @override
  String get accountManagementListTitle => 'Gestionar cuenta';

  @override
  String get accountManagementListSubtitle =>
      'Actualiza tu nombre, correo y contraseña';

  @override
  String get accountManagementTitle => 'Gestión de cuenta';

  @override
  String get accountSectionProfile => 'Perfil';

  @override
  String get accountSectionSignIn => 'Inicio de sesión';

  @override
  String get accountFieldDisplayName => 'Nombre para mostrar';

  @override
  String get accountFieldEmail => 'Correo electrónico';

  @override
  String get accountFieldCurrentPassword => 'Contraseña actual';

  @override
  String get accountFieldNewPassword => 'Nueva contraseña';

  @override
  String get accountSaveName => 'Guardar nombre';

  @override
  String get accountChangeEmail => 'Enviar verificación y cambiar correo';

  @override
  String get accountChangePassword => 'Cambiar contraseña';

  @override
  String get accountSignedOutMessage =>
      'Debes iniciar sesión para gestionar tu cuenta.';

  @override
  String get accountSignInCta => 'Iniciar sesión';

  @override
  String get accountNameSaved => 'Nombre actualizado';

  @override
  String accountEmailVerificationSent(String email) {
    return 'Enlace de verificación enviado a $email. Confírmalo para cambiar tu correo de acceso.';
  }

  @override
  String get accountPasswordChanged => 'Contraseña actualizada';

  @override
  String accountReauthRequired(String field) {
    return 'Por seguridad, vuelve a iniciar sesión para cambiar tu $field.';
  }

  @override
  String get accountFieldLabelEmail => 'correo';

  @override
  String get accountFieldLabelPassword => 'contraseña';

  @override
  String accountErrorGeneric(String field, String error) {
    return 'No se pudo actualizar $field: $error';
  }

  @override
  String get accountReauthAction => 'Iniciar sesión de nuevo';

  @override
  String get accountValidationEmailRequired => 'Introduce tu correo';

  @override
  String get accountValidationEmailInvalid => 'Introduce un correo válido';

  @override
  String get accountValidationNameRequired => 'Introduce tu nombre';

  @override
  String get accountValidationPasswordTooShort => 'Usa al menos 8 caracteres';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'Correo actual: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic Pro';

  @override
  String get proPaywallSubtitle =>
      'Desbloquea mapas sin conexión, herramientas avanzadas y colaboración.';

  @override
  String get proPaywallBenefits =>
      'Mapas sin conexión y descargas de regiones\nItinerario, presupuesto, bóveda y equipaje\nPlanificador grupal y sincronización en tiempo real';

  @override
  String get proPaywallBullets =>
      'Mapas sin conexión y descargas de regiones|Itinerario, presupuesto, bóveda y equipaje|Planificador grupal y sincronización en tiempo real';

  @override
  String get proPaywallUpgradeRevenueCat => 'Mejorar con RevenueCat';

  @override
  String get upgradeNow => 'Mejorar ahora';

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
  String get paywallDisabledBody =>
      'El paywall de RevenueCat está deshabilitado temporalmente para revisar la UI.';

  @override
  String get paywallDisabledTitle => 'Paywall deshabilitado';

  @override
  String get presentationDeleteBody =>
      '¿Seguro que quieres quitar este documento de la bóveda?';

  @override
  String get presentationDeleteTitle => '¿Eliminar documento?';

  @override
  String get presentationImageLoadFail => 'No se pudo cargar la imagen';

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
  String get proPaywallNotConfigured =>
      'Pro no está configurado en esta versión.';

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
  String get settingsMapboxAttributionTitle => 'Datos del mapa (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic usa mapas de Mapbox. © Mapbox, © OpenStreetMap y otros colaboradores. El logo y el control de atribución en el mapa están ocultos para un diseño más claro y menos toques accidentales; este aviso cumple los requisitos de Mapbox.';

  @override
  String get settingsMapboxAttributionMapboxLink =>
      'Mapbox — Acerca de los mapas';

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
  String get sizeCatBoysShoes => 'Calzado niño';

  @override
  String get sizeCatGirlsShoes => 'Calzado niña';

  @override
  String get sizeCatBoysTshirts => 'Camisetas / tops niño';

  @override
  String get sizeCatBoysPants => 'Pantalones niño';

  @override
  String get sizeCatGirlsTshirts => 'Camisetas / tops niña';

  @override
  String get sizeCatGirlsPants => 'Pantalones niña';

  @override
  String get sizeCatGirlsDressesKids => 'Vestidos niña';

  @override
  String get sizeColumnPrimaryEu => 'Principal: UE';

  @override
  String get sizeColumnPrimaryJp => 'Principal: JP';

  @override
  String get sizeColumnPrimaryMixed => 'Principal: mixto (UE→US→UK→JP)';

  @override
  String get sizeColumnPrimaryUk => 'Principal: UK';

  @override
  String get sizeColumnPrimaryUs => 'Principal: US';

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
  String get sizeEquivalentSizesHeader => 'TALLAS EQUIVALENTES';

  @override
  String get sizeHintBelts => 'p. ej. 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => 'p. ej. 38x32 o 38×32';

  @override
  String get sizeHintMensJeansInseam =>
      'p. ej. 32 (largo\") o 38x32 → usa largo 32';

  @override
  String get sizeHintMensJeansWaist =>
      'p. ej. 38 (cintura\") o 38x32 → usa cintura 38';

  @override
  String get sizeHintMensPants => 'p. ej. 30, 32, 34 (cintura\")';

  @override
  String get sizeHintMensShirts => 'p. ej. 15, 38, M';

  @override
  String get sizeHintMensShoes => 'p. ej. 6–14, 42, 27';

  @override
  String get sizeHintMensTshirts => 'p. ej. S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => 'p. ej. 8, 38, M, XL';

  @override
  String get sizeHintWomensDresses => 'p. ej. 8, 38, M';

  @override
  String get sizeHintWomensPants => 'p. ej. 6, 10, 38, M';

  @override
  String get sizeHintWomensShoes => 'p. ej. 5–12, 39, 25';

  @override
  String get sizeHintWomensTshirts => 'p. ej. XS, M, 38';

  @override
  String get sizeHintBoysShoes => 'p. ej. 11C, 3Y, 32, 21';

  @override
  String get sizeHintGirlsShoes => 'p. ej. 10C, 2Y, 33, 20';

  @override
  String get sizeHintBoysTshirts => 'p. ej. 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => 'p. ej. 6, 8, 10 (niño US)';

  @override
  String get sizeHintGirlsTshirts => 'p. ej. 6, 8, M, S';

  @override
  String get sizeHintGirlsPants => 'p. ej. 6, 8, 10 (niña US)';

  @override
  String get sizeHintGirlsDressesKids => 'p. ej. 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty =>
      'Introduce la talla de la etiqueta de tu prenda o zapato.';

  @override
  String get sizeNoMatchRow =>
      'No hay fila de tallas para esta categoría. Prueba números US, UK, UE, JP o letra (S, M, L) si aplica.';

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
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown de $total zonas';
  }

  @override
  String get timezoneSheetSearchHint =>
      'Buscar nombre IANA (p. ej. Europe, Tokyo)';

  @override
  String get timezoneSheetTitle => 'Seleccionar zona horaria';

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
  String get toolItinerarySubtitle => 'Vuelos, hoteles y planes por día';

  @override
  String get toolItineraryTitle => 'Itinerario';

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
  String get vaultTapToUpload => 'Toca para subir';

  @override
  String get vaultTapToView => 'Toca para ver';

  @override
  String get vaultVaultWord => 'bóveda';

  @override
  String get bucketListTitle => 'Lista de deseos';

  @override
  String get bucketListSubtitle =>
      'Lugares donde has estado, quieres ir y lo que viene.';

  @override
  String get bucketListToolSubtitle => 'Destinos soñados en mapa y en listas';

  @override
  String get bucketListViewModeList => 'Lista';

  @override
  String get bucketListViewModeMap => 'Mapa';

  @override
  String get bucketListCategoryBeen => 'Visitado';

  @override
  String get bucketListCategoryWant => 'Deseo';

  @override
  String get bucketListCategoryLive => 'Vivo';

  @override
  String get bucketListCategoryLived => 'Viví';

  @override
  String get bucketListCategoryUpcoming => 'Próximo';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'Categoría';

  @override
  String get bucketListDetailDates => 'Fechas';

  @override
  String get bucketListMapLegend => 'Toca un marcador para detalles';

  @override
  String get bucketListShareMapWatermarkLarge => 'Tripmetic';

  @override
  String get bucketListShareMapWatermarkUrl => 'tripmetic.app';

  @override
  String bucketListShareMapStatExplore(
    String name,
    String worldPercent,
    int populationPercent,
  ) {
    return '$name ha explorado el $worldPercent% del mundo. Ha viajado más que el $populationPercent% de la población mundial.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'Rafael';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'Ha viajado más que el $percent% de la población mundial';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'Países';

  @override
  String get bucketListShareMapCitiesLabel => 'Ciudades';

  @override
  String get bucketListEmptyCategory => 'Aún no hay lugares en esta categoría.';

  @override
  String get bucketListTravelStats => 'Estadísticas de viaje';

  @override
  String get bucketListStatWorld => 'Mundo explorado';

  @override
  String get bucketListStatUs => 'EE. UU. explorados';

  @override
  String get bucketListStatEurope => 'Europa explorada';

  @override
  String get bucketListStatAsia => 'Asia explorada';

  @override
  String get bucketListStatAfrica => 'África explorada';

  @override
  String get bucketListStatRegionalCaption => 'Regional';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count únicos · de $total';
  }

  @override
  String get bucketListAddDestination => 'Añadir destino';

  @override
  String get bucketListEditDestination => 'Editar destino';

  @override
  String get bucketListSave => 'Guardar';

  @override
  String get bucketListFieldCity => 'Ciudad';

  @override
  String get bucketListFieldCountry => 'País';

  @override
  String get bucketListFieldCategory => 'Categoría';

  @override
  String get bucketListFieldRegionHint => 'Estado / provincia (opcional)';

  @override
  String get bucketListFieldLatitude => 'Latitud';

  @override
  String get bucketListFieldLongitude => 'Longitud';

  @override
  String get bucketListFieldStart => 'Fecha de inicio';

  @override
  String get bucketListFieldEnd => 'Fecha de fin';

  @override
  String get bucketListFieldTripDates => 'Fechas del viaje';

  @override
  String get bucketListValidationRequired => 'Este campo es obligatorio.';

  @override
  String get bucketListValidationNumber => 'Introduce un número válido.';

  @override
  String get bucketListValidationDates =>
      'La fecha de fin debe ser igual o posterior a la de inicio.';

  @override
  String get bucketListGeocodeNotFound =>
      'No se encontró esta ubicación en el mapa. Revisa la ortografía.';

  @override
  String get bucketListShareSummarySubject => 'Mi lista Tripmetic';

  @override
  String get bucketListShareTooltip => 'Compartir lista y mapa';

  @override
  String bucketListShareFailed(String error) {
    return 'No se pudo compartir: $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'Abre la vista Mapa antes de capturar la imagen del mapa.';

  @override
  String get bucketListDeleteHint => 'Desliza para eliminar';

  @override
  String get bucketListTapEditHint => 'Toca para editar';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'Error de sincronización: $error';
  }

  @override
  String get bucketListRetry => 'Reintentar';

  @override
  String get bucketListBackupTooltip => 'Copia y registro';

  @override
  String get bucketListBackupTitle => 'Copia en la nube';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic funciona por completo sin cuenta. Añade una cuando quieras copia en la nube de tu lista y viajes en grupo compartidos.';

  @override
  String bucketListSignedInAs(String email) {
    return 'Sesión: $email';
  }

  @override
  String get bucketListBackupEmail => 'Correo';

  @override
  String get bucketListBackupPassword => 'Contraseña';

  @override
  String get bucketListBackupConfirmPassword => 'Confirmar contraseña';

  @override
  String get bucketListAuthTabSignUp => 'Registrarse';

  @override
  String get bucketListAuthPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get bucketListRegister => 'Crear cuenta y respaldar';

  @override
  String get bucketListSignIn => 'Iniciar sesión';

  @override
  String get bucketListSignOut => 'Cerrar sesión';

  @override
  String get bucketListBackupUploading => 'Subiendo a la nube…';

  @override
  String get bucketListAuthSuccessSignIn => '¡Sesión iniciada correctamente!';

  @override
  String get bucketListAuthSuccessSignUp => '¡Cuenta creada correctamente!';

  @override
  String get signUpSuccessMessage => 'Cuenta creada. ¡Bienvenido a Tripmetic!';

  @override
  String get signUpErrorEmailInUse =>
      'Este correo ya está registrado. Intenta iniciar sesión.';

  @override
  String get signUpErrorInvalidEmail => 'Introduce un correo válido.';

  @override
  String get signUpErrorWeakPassword =>
      'La contraseña es demasiado débil. Usa al menos 8 caracteres.';

  @override
  String signUpErrorGeneric(String message) {
    return 'No se pudo crear la cuenta: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'Iniciar sesión';

  @override
  String bucketListAuthFailed(String error) {
    return 'No se pudo autenticar: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'Aún no hay notas ni enlaces.';

  @override
  String get groupPlannerTitle => 'Planificador de grupo';

  @override
  String get groupPlannerToolTitle => 'Planificador de grupo';

  @override
  String get groupPlannerToolSubtitle =>
      'Planifica un viaje juntos en tiempo real';

  @override
  String get groupPlannerLandingPlanTitle => 'Planificar un viaje en grupo';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'Crea un viaje compartido con destino, fechas y presupuesto.';

  @override
  String get groupPlannerLandingJoinTitle => 'Unirse a un viaje en grupo';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'Introduce el código o enlace de la invitación.';

  @override
  String get groupPlannerCreateTripTitle => 'Nuevo viaje en grupo';

  @override
  String get groupPlannerSelectDates =>
      'Selecciona el rango de fechas del viaje.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'Por persona';

  @override
  String get groupPlannerBudgetGroupOption => 'Grupo';

  @override
  String get groupPlannerBudgetNoneOption => 'Ninguno';

  @override
  String get groupPlannerBudgetAmountLabel => 'Importe del presupuesto';

  @override
  String get groupPlannerOpenTitle => 'Abrir un viaje en grupo';

  @override
  String get groupPlannerOpenSubtitle => 'Pega el código de invitación.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'Código de viaje';

  @override
  String get groupPlannerOpenHint =>
      'Código corto, ID del viaje o enlace de invitación';

  @override
  String get groupPlannerOpenButton => 'Abrir viaje';

  @override
  String get groupPlannerDestination => 'Destino';

  @override
  String get groupPlannerDates => 'Fechas';

  @override
  String get groupPlannerGroupSize => 'Tamaño del grupo';

  @override
  String get groupPlannerBudget => 'Presupuesto';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'Por persona: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'Total del grupo: $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'Sin presupuesto';

  @override
  String get groupPlannerInviteMembers => 'Invitar miembros';

  @override
  String get groupPlannerManageMembers => 'Gestionar miembros';

  @override
  String get groupPlannerItinerary => 'Itinerario';

  @override
  String get groupPlannerItineraryEditorHint =>
      'Como administrador o coordinador del viaje, puedes añadir actividades y cambiar el calendario.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'Solo lectura: vota en las actividades propuestas con pulgar arriba o abajo. Solo los administradores y coordinadores del viaje pueden añadir o cambiar elementos.';

  @override
  String get groupPlannerNoActivities => 'Aún no hay actividades.';

  @override
  String get groupPlannerTripNotFound => 'No se pudo cargar este viaje.';

  @override
  String get groupPlannerSignInTitle => 'Inicia sesión';

  @override
  String get groupPlannerSignInBody =>
      'Inicia sesión en Lista → Copia en la nube para ver viajes compartidos.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'Guardar un viaje en grupo nuevo requiere una cuenta. Inicia sesión para continuar — el resto de Tripmetic funciona sin cuenta.';

  @override
  String get groupPlannerMembersTitle => 'Miembros';

  @override
  String get groupPlannerRoleAdmin => 'Admin';

  @override
  String get groupPlannerRoleCoPlanner => 'Coordinador del viaje';

  @override
  String get groupPlannerRoleViewOnly => 'Solo lectura';

  @override
  String get groupPlannerOwner => 'Propietario';

  @override
  String get groupPlannerRemoveMember => 'Eliminar';

  @override
  String get groupPlannerRemoveMemberTitle => '¿Eliminar miembro?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return '¿Quitar a $email de este viaje?';
  }

  @override
  String get groupPlannerCancel => 'Cancelar';

  @override
  String get groupPlannerNotes => 'Notas';

  @override
  String get groupPlannerOpenLink => 'Abrir enlace';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'No se pudo guardar el voto: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'No se pudo actualizar miembros: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'No se pudo compartir: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'No se pudo abrir el viaje: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'Tus viajes';

  @override
  String get groupPlannerMyTripsEmpty => 'Aún no hay viajes. Crea uno arriba.';

  @override
  String get groupPlannerExamplesTitle => 'Ejemplos de viajes';

  @override
  String get groupPlannerExamplesSubtitle =>
      'Tarjetas de muestra — crea un viaje arriba para añadir el tuyo.';

  @override
  String get groupPlannerExampleTapBody =>
      'Son solo ejemplos. Usa «Planificar un viaje en grupo» para crear un viaje real que puedas compartir.';

  @override
  String get groupPlannerExampleLisbonTitle => 'Retiro de equipo en Lisboa';

  @override
  String get groupPlannerExampleKyotoTitle => 'Tour de primavera en Kioto';

  @override
  String get groupPlannerAddActivity => 'Añadir actividad';

  @override
  String get groupPlannerActivityTitleLabel => 'Título de la actividad';

  @override
  String get groupPlannerActivityWhenLabel => 'Fecha y hora';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'Elige un día dentro del viaje y una hora. Quien pueda editar el itinerario puede cambiarlo después.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'Esa fecha está fuera del viaje. Elige un día entre el inicio y el fin del viaje.';

  @override
  String get groupPlannerActivityTitleRequired =>
      'Escribe un título para la actividad.';

  @override
  String get groupPlannerActivityDateUnset =>
      'Sin fecha — toca Editar para programar.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count personas';
  }

  @override
  String get groupPlannerEditActivity => 'Editar actividad';

  @override
  String get groupPlannerDeleteActivity => 'Eliminar';

  @override
  String get groupPlannerDeleteActivityTitle => '¿Eliminar actividad?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return '¿Quitar «$title» del itinerario? No se puede deshacer.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'No se pudo eliminar la actividad: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'No se pudo actualizar la actividad: $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'Editar viaje';

  @override
  String get groupPlannerEditTripAction => 'Editar viaje';

  @override
  String get groupPlannerDeleteTripTitle => '¿Eliminar viaje?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return '¿Eliminar para siempre el viaje «$destination» y su itinerario para todos? No se puede deshacer.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'Eliminar viaje';

  @override
  String get groupPlannerTripDeleted => 'Viaje eliminado.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'No se pudo eliminar el viaje: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'No se pudo actualizar el viaje: $error';
  }

  @override
  String get widgetInstructionTitle => 'Widget de doble reloj';

  @override
  String get widgetInstructionSubtitle =>
      'Consulta tu ciudad de origen y destino desde la pantalla de bloqueo o la pantalla de inicio.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosStep1 =>
      'Bloquea el teléfono y mantén pulsada la pantalla de bloqueo.';

  @override
  String get widgetInstructionIosStep2 =>
      'Toca \"Personalizar\" y elige \"Pantalla de bloqueo\".';

  @override
  String get widgetInstructionIosStep3 => 'Toca \"Añadir widgets\".';

  @override
  String get widgetInstructionIosStep4 =>
      'Desplázate, busca Tripmetic y añade el widget de doble reloj.';

  @override
  String get widgetInstructionAndroidStep1 =>
      'Ve a la pantalla de inicio y mantén pulsado un espacio vacío.';

  @override
  String get widgetInstructionAndroidStep2 => 'Toca \"Widgets\".';

  @override
  String get widgetInstructionAndroidStep3 => 'Desplázate hasta Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'Mantén pulsado el widget de doble reloj y arrástralo a la pantalla.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'Para ver ambos relojes en la pantalla de bloqueo: abre Ajustes y busca “pantalla de bloqueo” o “widgets”; añade Tripmetic si tu móvil permite widgets en la pantalla de bloqueo (no todos lo permiten).';

  @override
  String get widgetInstructionConfigureCta => 'Configurar ciudades del widget';

  @override
  String get dualClockScreenTitle => 'Widget de doble reloj';

  @override
  String get dualClockConfigTitle => 'Configurar ciudades';

  @override
  String get dualClockConfigSubtitle =>
      'Elige dos ciudades y zonas horarias. Se sincronizan con el widget de inicio (Android) y el de pantalla de bloqueo (iOS).';

  @override
  String get dualClockCity1Label => 'Primera ciudad';

  @override
  String get dualClockCity2Label => 'Segunda ciudad';

  @override
  String get dualClockSave => 'Guardar y actualizar widget';

  @override
  String get dualClockSaved => 'Widget actualizado.';

  @override
  String get dualClockSaveError =>
      'No se pudieron guardar los datos. Inténtalo de nuevo.';

  @override
  String get moreToolsDualClockBannerTitle => 'Widget de doble reloj';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'Dos zonas horarias en la pantalla de bloqueo o inicio — toca para configurar.';

  @override
  String get moreToolsDualClockBannerCta => 'Configurar';

  @override
  String get settingsDualClockWidgetTitle => 'Widget de doble reloj';

  @override
  String get settingsDualClockWidgetSubtitle =>
      'Añade el widget y elige tus ciudades';

  @override
  String get widgetNewFeatureBadge => 'Novedad';

  @override
  String get globalNavAccountCloudSyncTooltip => 'Cuenta y copia en la nube';

  @override
  String get exchangeRatesForceRefreshTooltip =>
      'Obtener tipos de cambio actualizados';

  @override
  String get exchangeRatesRefreshedOk => 'Tipos de cambio actualizados.';

  @override
  String get exchangeRatesRefreshFailed =>
      'No se pudieron actualizar los tipos de cambio.';

  @override
  String get bucketListStatUsTerritories => 'Territorios de EE. UU.';

  @override
  String get bucketListAuthErrUserNotFound => 'No hay cuenta con este correo.';

  @override
  String get bucketListAuthErrWrongPassword =>
      'Correo o contraseña incorrectos.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'Ya existe una cuenta con este correo.';

  @override
  String get bucketListAuthErrInvalidEmail => 'Correo no válido.';

  @override
  String get bucketListAuthErrWeakPassword =>
      'La contraseña es demasiado débil.';

  @override
  String get bucketListAuthErrUserDisabled => 'Esta cuenta está desactivada.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'Demasiados intentos. Prueba más tarde.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'El inicio de sesión por correo no está habilitado.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => 'Correo no válido.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get bucketListAuthValidationPasswordRequired =>
      'Introduce tu contraseña.';
}
