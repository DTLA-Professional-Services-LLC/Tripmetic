// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'Bitte geben Sie einen Titel ein';

  @override
  String get addItineraryFieldLocation => 'Standort';

  @override
  String get addItineraryFieldNotes => 'Notizen/Bestätigung';

  @override
  String get addItineraryFieldTitle => 'Titel';

  @override
  String get addItineraryHintLocation => 'Flughafen, Hoteladresse…';

  @override
  String get addItineraryHintNotes => 'Datensatz-Locator, Links…';

  @override
  String get addItineraryHintTitle => 'Flug nach Lissabon';

  @override
  String get addItinerarySave => 'Veranstaltung speichern';

  @override
  String get addItineraryTitle => 'Reiseplanereignis hinzufügen';

  @override
  String get addPackingAddToList => 'Zur Liste hinzufügen';

  @override
  String get addPackingEnterName => 'Bitte geben Sie einen Artikelnamen ein';

  @override
  String get addPackingFieldCategory => 'Kategorie';

  @override
  String get addPackingFieldItemName => 'Artikelname';

  @override
  String get addPackingHint => 'z.B. Netzteil';

  @override
  String get addPackingIcon => 'Symbol';

  @override
  String get addPackingQuantity => 'Menge';

  @override
  String get addPackingTitle => 'Verpackungsartikel hinzufügen';

  @override
  String get announcementsLatest => 'Neueste Updates';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => 'BASISWÄHRUNG';

  @override
  String get budgetCategoryDialogHint => 'z.B. Souvenirs';

  @override
  String get budgetCategoryNameExists => 'Name existiert bereits';

  @override
  String get budgetCategoryNameMax => 'Maximal 40 Zeichen';

  @override
  String get budgetDailyFood => 'Tägliches Essen';

  @override
  String get budgetDestinationSearchHint =>
      'Suchen Sie nach Land oder Währungscode';

  @override
  String get budgetDestinationTitle => 'Ziel hinzufügen';

  @override
  String get budgetDialogAdd => 'Hinzufügen';

  @override
  String get budgetDialogNewCategory => 'Neue Ausgabenkategorie';

  @override
  String budgetDialogRemoveBody(String name) {
    return '„$name“ und seinen Betrag entfernen?';
  }

  @override
  String get budgetDialogRemoveTitle => 'Kategorie entfernen';

  @override
  String get budgetDialogRename => 'Umbenennen';

  @override
  String get budgetDialogRenameCategory => 'Kategorie umbenennen';

  @override
  String get budgetEdit => 'Budget bearbeiten';

  @override
  String get budgetExpenseDailyFood => 'Tägliches Essen';

  @override
  String get budgetExpenseEatingOut => 'Auswärts essen';

  @override
  String get budgetExpenseEntertainment => 'Unterhaltung';

  @override
  String get budgetExpenseFlights => 'Flüge';

  @override
  String get budgetExpenseGrocery => 'Lebensmittelgeschäft';

  @override
  String get budgetExpenseHotels => 'Hotels';

  @override
  String get budgetExpenseMisc => 'Sonstiges';

  @override
  String get budgetExpensePhoneService => 'Telefonservice';

  @override
  String get budgetExpenseShopping => 'Einkaufen';

  @override
  String get budgetExpenseTourism => 'Tourismus';

  @override
  String get budgetExpenseTransportation => 'Transport';

  @override
  String get budgetExpenseTravelInsurance => 'Reiseversicherung';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3.000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => 'An Ihren Zielen';

  @override
  String get budgetNoCategories => 'Noch keine Ausgabenkategorien';

  @override
  String budgetOtherExpenses(String code) {
    return 'SONSTIGE AUFWENDUNGEN ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'Pro Tag (Schätzung)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / Tag';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'Verbleibend nach Kosten · $code';
  }

  @override
  String get budgetSave => 'Budget sparen';

  @override
  String get budgetSpendingPower => 'Kaufkraft';

  @override
  String get budgetSpentVsBudget => 'Ausgaben vs. Budget';

  @override
  String budgetTotalBudget(String code) {
    return 'GESAMTBUDGET ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return 'Gesamtbetrag für die Reise ($code)';
  }

  @override
  String get budgetTripDashboard => 'Armaturenbrett';

  @override
  String get budgetTripLengthDays => 'Reisedauer (Tage)';

  @override
  String get budgetTripTitle => 'Reisebudget';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get commonCancel => 'Stornieren';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonOk => 'OK';

  @override
  String get commonRemove => 'Entfernen';

  @override
  String get commonRename => 'Umbenennen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonKeyboardDone => 'Erledigt';

  @override
  String countryCountriesCount(String count) {
    return '$count Länder';
  }

  @override
  String get countryPickerTitle => 'Land auswählen';

  @override
  String get countrySheetSearchHint =>
      'Suchen Sie nach Ländernamen oder ISO-Code';

  @override
  String get countrySheetTitle => 'Basisland/-region';

  @override
  String get cryptoHeader => 'KRYPTO';

  @override
  String cryptoMockPerUnit(String price) {
    return 'Schein ~$price / Einheit';
  }

  @override
  String get cryptoPickerTitle => 'Wähle eine Münze';

  @override
  String get cryptoSheetTitle => 'Wählen Sie Kryptowährung aus';

  @override
  String get currencyPickerSearchHint => 'Suchticker oder Name';

  @override
  String get currencyPickerTitle => 'Wählen Sie eine Währung';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown von $total angezeigt';
  }

  @override
  String get currencySheetSearchHint => 'Suchcode, Name oder numerisches ISO';

  @override
  String get currencySheetTitle => 'Währung auswählen';

  @override
  String get exchangeBaseSuffix => '· Basis';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'Preise konnten nicht geladen werden\n$error';
  }

  @override
  String get exchangeHeader => 'AUSTAUSCH';

  @override
  String exchangeLastUpdated(String mins) {
    return 'Zuletzt aktualisiert vor $mins Min';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'Zuletzt aktualisiert vor $mins Min. (Offline)';
  }

  @override
  String get exchangeResetOne => 'Zurücksetzen auf 1 (USD Basis)';

  @override
  String get exchangeResetTooltip => 'Beträge zurücksetzen';

  @override
  String get exchangeResetZero => 'Klar auf 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'Tag $day: $date';
  }

  @override
  String get itineraryEmpty =>
      'Noch keine Veranstaltungen.\nTippen Sie auf +, um Flüge, Hotels und Pläne hinzuzufügen.';

  @override
  String get itineraryHeader => 'ROUTE';

  @override
  String itineraryHiveError(String error) {
    return 'Die gespeicherten Reisedaten konnten nicht geöffnet werden.\nSie können trotzdem versuchen, Ereignisse hinzuzufügen – diese bleiben möglicherweise nicht bestehen.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'Auf der Karte öffnen';

  @override
  String get mapAddToTrip => 'Zur Reise hinzufügen';

  @override
  String get mapClearRoute => 'Klare Route und Führung';

  @override
  String get mapClearTooltip => 'Klar';

  @override
  String get mapDisplayCurrentViewport => 'Aktuelles Ansichtsfenster';

  @override
  String get mapDisplaySavedSearch => 'Gespeicherte Suche';

  @override
  String get mapDisplayTripDestination => 'Reiseziel';

  @override
  String get mapDownloadAll => 'Alles herunterladen';

  @override
  String get mapDownloadCurrentRegion =>
      'Laden Sie die aktuelle Region zur Offline-Verwendung herunter';

  @override
  String get mapDownloadThisDestination => 'Laden Sie dieses Ziel herunter';

  @override
  String get mapDownloadedRegions => 'Heruntergeladene Regionen';

  @override
  String get mapDownloadingRegion => 'Region wird heruntergeladen...';

  @override
  String mapDownloadingTitle(String title) {
    return '$title wird heruntergeladen...';
  }

  @override
  String get mapFromItinerary => 'Aus Ihrer Reiseroute';

  @override
  String get mapItineraryEmptyHint =>
      'Fügen Sie hier Reiseroutenziele hinzu, um sie vorab herunterzuladen.';

  @override
  String get mapLoadingRegions => 'Offline-Regionen werden geladen…';

  @override
  String mapLocatingQuery(String query) {
    return '$query wird gesucht...';
  }

  @override
  String get mapMarkCategoryBody =>
      'Wählen Sie aus, wie dieser Offline-Pin beschriftet werden soll.';

  @override
  String get mapMarkCategoryTitle => 'Kategorie für diese Marke';

  @override
  String get mapMarkFood => 'Essen';

  @override
  String get mapMarkHotel => 'Hotel';

  @override
  String get mapMarkLandmark => 'Wahrzeichen';

  @override
  String get mapMarkOther => 'Andere';

  @override
  String mapNextInstruction(String current, String total) {
    return 'Nächste Anweisung ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'Kein Standort festgelegt';

  @override
  String get mapNoRegionsYet =>
      'Sie haben noch keine Regionen heruntergeladen.';

  @override
  String get mapOfflineIntro =>
      'Speichern Sie die aktuell sichtbare Region oder laden Sie Ihre Reiseziele vorab herunter, damit Sie auch außerhalb des Netzes navigieren können.';

  @override
  String get mapOfflineMapsTitle => 'Offline-Karten';

  @override
  String get mapRefreshTooltip => 'Aktualisieren';

  @override
  String get mapRemovePinTooltip => 'Stift entfernen';

  @override
  String get mapSaveOffline => 'Offline speichern';

  @override
  String get mapSavePinToMap => 'Pin auf Karte speichern';

  @override
  String get mapSavedPinsBody =>
      'Pins, die Sie aus der Suche gespeichert haben. Tippen Sie auf „Löschen“, um einen Eintrag aus der Karte zu entfernen.';

  @override
  String get mapSavedPinsTitle => 'Gespeicherte Kartenpins';

  @override
  String get mapSearchHint =>
      'Suchen Sie nach einer Stadt, einer Adresse oder einem Wahrzeichen ...';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title wurde zu Ihren Offline-Markierungen hinzugefügt.';
  }

  @override
  String get mapSnackArrived => 'Sie sind angekommen.';

  @override
  String mapSnackCouldNotFind(String query) {
    return '„$query“ konnte nicht gefunden werden.';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'Löschen fehlgeschlagen: $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return 'Offline-Download fehlgeschlagen: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return '„$title“ heruntergeladen.';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return 'Für „$title“ ist kein Standort festgelegt.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'Der Download der $count Reiseroutenregion(en) ist abgeschlossen.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'Offline-Regionen konnten nicht geladen werden: $error';
  }

  @override
  String get mapSnackLocationOff =>
      'Der Standortdienst ist deaktiviert. Aktivieren Sie es, um die Navigation zu starten.';

  @override
  String get mapSnackLocationPermission =>
      'Für die Abbiegehinweise ist eine Standortgenehmigung erforderlich.';

  @override
  String get mapSnackLocationDeniedForMap =>
      'Um die Karte auf Sie zu zentrieren, ist eine Standortgenehmigung erforderlich.';

  @override
  String get mapSnackLocateFail =>
      'Ihr Standort kann derzeit nicht ermittelt werden.';

  @override
  String get mapLocateMeTooltip => 'Gehen Sie zu meinem Standort';

  @override
  String get mapSnackMapNotReady =>
      'Die Karte ist noch nicht fertig. Bitte warten Sie einen Moment.';

  @override
  String get mapSnackNavStartFail =>
      'Die Navigation kann derzeit nicht gestartet werden.';

  @override
  String get mapSnackNavStopped => 'Die Navigation wurde gestoppt.';

  @override
  String get mapSnackNoItineraryLocations =>
      'Für keine Reiseroutenveranstaltungen gibt es einen Standort oder einen Kartenpunkt zum Herunterladen.';

  @override
  String get mapSnackNoManeuver =>
      'Dieser Schritt hat keinen genauen Manöverpunkt.';

  @override
  String get mapSnackNoRoute => 'Konnte keine Route finden; Ziel anzeigen.';

  @override
  String get mapSnackRegionDownloaded =>
      'Region erfolgreich heruntergeladen! Sie können jetzt offline navigieren.';

  @override
  String get mapSnackRemovedPin => 'Gespeicherte PIN entfernt.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'Offline-Region „$name“ entfernt.';
  }

  @override
  String get mapSnackRouteCleared => 'Route und Führung gelöscht.';

  @override
  String mapSnackRoutingFailed(String error) {
    return 'Routing fehlgeschlagen: $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return 'Suche fehlgeschlagen: $error';
  }

  @override
  String get mapStartNavigation => 'Starten Sie die Navigation';

  @override
  String get mapStartingNav => 'Navigation wird gestartet...';

  @override
  String get mapStopNavigation => 'Stoppen Sie die Navigation';

  @override
  String get mapTravelDriving => 'Fahren';

  @override
  String get mapTravelWalking => 'Gehen';

  @override
  String mapTurnByTurn(String mode) {
    return 'Turn-by-Turn ($mode)';
  }

  @override
  String get mindMapCaptureFail =>
      'Die Mindmap konnte nicht erfasst werden. Versuchen Sie es erneut.';

  @override
  String get mindMapClearBody =>
      'Dadurch werden alle Knoten entfernt und die Demo-Mindmap wiederhergestellt (zentriertes Beispiel).';

  @override
  String get mindMapClearTitle => 'Klare Leinwand?';

  @override
  String get mindMapClearTooltip => 'Löschen / Zurücksetzen';

  @override
  String mindMapCouldNotSave(String error) {
    return 'Konnte nicht gespeichert werden: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'Konnte nicht gespeichert werden: $type';
  }

  @override
  String get mindMapEmailShare => 'E-Mail / Teilen';

  @override
  String get mindMapEmptyNode => 'Leerer Knoten';

  @override
  String get mindMapHelpHint =>
      'Zum Zoomen kneifen · Leinwand ziehen · Karten ziehen · Auf eine Karte tippen, um sie zu bearbeiten · + fügt ein Kind hinzu';

  @override
  String get mindMapNodeAddLeftTooltip => 'Linkes Kind hinzufügen';

  @override
  String get mindMapNodeAddRightTooltip => 'Rechtes Kind hinzufügen';

  @override
  String get mindMapNodeDeleteTooltip => 'Knoten löschen';

  @override
  String get mindMapNodeEditTitle => 'Knoten bearbeiten';

  @override
  String get mindMapNodeHint => 'Geben Sie eine Kurzbezeichnung ein';

  @override
  String get mindMapPhotoAccess =>
      'Zum Speichern des Bildes ist Zugriff auf die Fotobibliothek erforderlich.';

  @override
  String get mindMapReset => 'Zurücksetzen';

  @override
  String get mindMapSavePhoto => 'Als Foto speichern';

  @override
  String get mindMapSavedPhotos => 'Unter Fotos gespeichert';

  @override
  String get mindMapShareCaptureFail =>
      'Die Mindmap konnte nicht zum Teilen erfasst werden.';

  @override
  String get mindMapShareCompleted => 'Teilen abgeschlossen';

  @override
  String mindMapShareFailed(String error) {
    return 'Freigabe fehlgeschlagen: $error';
  }

  @override
  String get mindMapShareReady =>
      'Bild bereit – wählen Sie eine App zum Teilen aus';

  @override
  String get mindMapShareSheetClosed => 'Freigabeblatt geschlossen';

  @override
  String get mindMapShareSubject => 'Tripmetic – Mindmap';

  @override
  String get mindMapShareText => 'Mindmap-Export aus Tripmetic';

  @override
  String get mindMapTapToEdit => 'Zum Bearbeiten tippen';

  @override
  String get moreToolsHeader => 'MEHR WERKZEUGE';

  @override
  String get moreToolsSubtitle => 'Reisezubehör';

  @override
  String get navCurrency => 'Währung';

  @override
  String get navItinerary => 'Route';

  @override
  String get navMoreTools => 'Weitere Werkzeuge';

  @override
  String get navOfflineMap => 'Offline-Karte';

  @override
  String get navDashboard => 'Armaturenbrett';

  @override
  String get navMoreMenu => 'Mehr';

  @override
  String get navEditNavigation => 'Navigation bearbeiten';

  @override
  String get navDoneEditing => 'Erledigt';

  @override
  String get navSelectSlotHint =>
      'Tippen Sie auf einen Steckplatz und dann auf ein Werkzeug, um es zuzuweisen.';

  @override
  String get navSavePins => 'Speichern';

  @override
  String get navPinnedSectionTitle => 'An die untere Leiste angeheftet';

  @override
  String get navAvailableSectionTitle => 'Verfügbare Funktionen';

  @override
  String get navEmptySlot =>
      'Leer – aus den unten verfügbaren Optionen hinzufügen';

  @override
  String get navPinFullHint =>
      'Alle vier Plätze sind belegt. Entfernen Sie eines, um ein weiteres hinzuzufügen.';

  @override
  String get navEditPinnedHint =>
      'Verwenden Sie −, um einen Platz freizugeben, +, um einen Platz zu füllen, oder ziehen Sie, um die Position neu anzuordnen. Speichern Sie, wenn alle vier gefüllt sind.';

  @override
  String get navAddToPinned => 'Zur unteren Leiste hinzufügen';

  @override
  String get navRemoveFromPinned => 'Von der unteren Leiste entfernen';

  @override
  String get navFeatureBadgeFree => 'Frei';

  @override
  String get navFeatureBadgePro => 'PRO';

  @override
  String get moreMenuSectionFree => 'Kostenlose Funktionen';

  @override
  String get moreMenuSectionPro => 'Tripmetic Pro';

  @override
  String get ourAppsMenuTitle => 'Unsere Apps';

  @override
  String get ourAppsMenuSubtitle => 'Weitere Software vom p1.do-Team';

  @override
  String get ourAppsScreenTitle => 'Unsere Apps';

  @override
  String get ourAppsIntro =>
      'Software vom p1.do-Team – tippen Sie auf eine Live-App, um deren Website zu öffnen. Stream CRM ist bald verfügbar.';

  @override
  String get ourAppsBadgeLive => 'Live';

  @override
  String get ourAppsBadgeSoon => 'Kommt bald';

  @override
  String get ourAppsBadgeThisApp => 'Diese App';

  @override
  String get ourAppsViewOnline => 'Alles auf p1.do ansehen';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => 'Web · Mobil';

  @override
  String get ourAppsPlatformWebTabletMobile => 'Web · Tablet · Mobil';

  @override
  String get ourAppsTravelRecapTagline => 'AI Reiserouten und Fotorückblicke';

  @override
  String get ourAppsTravelRecapSummary =>
      'Planen Sie Reisen mit mehreren Stopps auf einer interaktiven Karte, erstellen Sie Routen mit AI, fügen Sie Ziele hinzu und exportieren Sie ausgefeilte Reiserückblicke aus Ihren Fotos.';

  @override
  String get ourAppsP1doTagline => 'Link-in-Bio und Ersteller CRM';

  @override
  String get ourAppsP1doSummary =>
      'Link-in-Bio für YouTuber, die CRM Leads – plus Premium Selling und Terminbuchung – ohne zusätzliche Gewinnkürzung zusätzlich zur monatlichen Gebühr erfassen.';

  @override
  String get ourAppsDockTxtTagline =>
      'macOS Randfixierter Notizblock und exaktes Diff';

  @override
  String get ourAppsDockTxtSummary =>
      'Eine kostenlose native macOS-Floating-Schublade für Klartext-Notizblockarbeit, Leerraumbereinigung, JSON-Verschönerung und Unterschiede auf Zeichenebene.';

  @override
  String get ourAppsTripmeticTagline =>
      'Globaler Reise-Toolkit und Budgetplaner';

  @override
  String get ourAppsTripmeticSummary =>
      'Ein Dashboard für Bucket-Listen, Offline-Karten, Gruppenreisepläne, Budgets für mehrere Länder, Zeitzonen-Widgets, Packlisten und Konverter.';

  @override
  String get ourAppsPayxtTagline =>
      'Rechnungen per SMS in Sekundenschnelle bezahlen';

  @override
  String get ourAppsPayxtSummary =>
      'Verwandeln Sie eine Textnachricht in eine sichere bezahlte Rechnung mit Stripe- und PayPal-basierten Checkout-Links für mobile Berufstätige.';

  @override
  String get ourAppsPermitMobileTagline =>
      'Baugenehmigungs-Tracker für Sanierer';

  @override
  String get ourAppsPermitMobileSummary =>
      'Überwachen Sie den Status der kommunalen Baugenehmigungen von der Baustelle aus – Nummern, Adressen und Genehmigungsaktualisierungen von Stadtportalen.';

  @override
  String get ourAppsTrackkrTagline => 'Verwaltung von Wohnungsgrundstücken';

  @override
  String get ourAppsTrackkrSummary =>
      'Protokollieren Sie eingehende Pakete in Sekundenschnelle, benachrichtigen Sie Mieter per E-Mail (und optional SMS) und verwalten Sie unbegrenzte Einheiten mit einem für immer kostenlosen Basisplan.';

  @override
  String get ourAppsKeyForecastsTagline =>
      'Bruchteil-Controller für HVAC-Anführer';

  @override
  String get ourAppsKeyForecastsSummary =>
      'Executive Financial Intelligence für HVAC und Bauwesen – Auftragskalkulation, saisonale Cashflow-Prognose und skalierbare Berichterstattung.';

  @override
  String get ourAppsStreamCrmTagline =>
      'TikTok Live-Geschenkverfolgung und Spender CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'Verfolgen Sie TikTok Live-Spenden in Echtzeit, trennen Sie die Ausgaben der Schenkenden von Ihren Einnahmen und fördern Sie Top-Unterstützer mit Spenderprofilen.';

  @override
  String get proGlassTeaserTitle => 'Tripmetic Pro-Funktion';

  @override
  String get dashboardWorldExplorerSection => 'Weltforscher';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'Länder besucht';

  @override
  String get dashboardWorldExplorerPercentLabel => 'Von der erforschten Welt';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => 'Anzeigename';

  @override
  String get bucketListMapUnavailable =>
      'Die Karte ist nicht verfügbar, da kein Mapbox-Zugriffstoken konfiguriert wurde.';

  @override
  String get bucketListAuthValidationDisplayName => 'Geben Sie Ihren Namen ein';

  @override
  String get authSignUpScreenTitle => 'Erstellen Sie Ihr Tripmetic-Konto';

  @override
  String get authSignUpScreenSubtitle =>
      'Optional – nur wenn Sie Cloud-Backup wünschen. Sie können alle Tools auf diesem Gerät weiterhin nutzen, ohne sich anzumelden.';

  @override
  String get authSignInScreenTitle => 'Melden Sie sich bei Tripmetic an';

  @override
  String get authSignInScreenSubtitle =>
      'Optional – zum Synchronisieren Ihrer Bucket-Liste und Cloud-Gruppenreisen. Der Rest von Tripmetic funktioniert ohne Konto.';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authPasswordResetConfirmation =>
      'Wenn für diese E-Mail ein Konto vorhanden ist, erhalten Sie einen Link zum Zurücksetzen Ihres Passworts.';

  @override
  String get authUnexpectedError =>
      'Etwas ist schief gelaufen. Bitte versuchen Sie es erneut.';

  @override
  String get authBackupBulletBucketList =>
      'Bucket-List-Ziele werden in der Cloud gespeichert und zusammengeführt, wenn Sie sich anmelden.';

  @override
  String get authBackupBulletGroupTrips =>
      'Gruppenreisen, die Sie erstellen oder denen Sie beitreten, werden in Ihrem Konto gespeichert.';

  @override
  String get authBackupBulletMultiDevice =>
      'Melden Sie sich auf einem anderen Gerät an, um Ihre synchronisierten Daten wiederherzustellen.';

  @override
  String get authLinkAlreadyHaveAccount =>
      'Sie haben bereits ein Konto? anmelden';

  @override
  String get authLinkNeedAccount =>
      'Benötigen Sie ein Konto? Erstellen Sie eins';

  @override
  String get authFullSignUpCta =>
      'Verwenden Sie den vollständigen Anmeldebildschirm';

  @override
  String get authFullSignInCta =>
      'Verwenden Sie den vollständigen Anmeldebildschirm';

  @override
  String dashboardGreeting(String name) {
    return 'Hallo, $name';
  }

  @override
  String get dashboardGuestName => 'Reisender';

  @override
  String get dashboardWelcomeSubtitle =>
      'Planen Sie gemeinsam, bleiben Sie organisiert und nutzen Sie die Tools mit nur einem Fingertipp.';

  @override
  String get dashboardPlanGroupTrip => 'Planen Sie eine neue Gruppenreise';

  @override
  String get dashboardAddBucketList => 'Zur Bucket-Liste hinzufügen';

  @override
  String get dashboardActiveTripSection => 'Schnappschuss der aktiven Reise';

  @override
  String get dashboardNoUpcomingTripTitle => 'Keine bevorstehende Gruppenreise';

  @override
  String get dashboardNoUpcomingTripBody =>
      'Wenn Sie mit Freunden planen, wird hier die Zusammenfassung Ihrer nächsten Reise angezeigt.';

  @override
  String get dashboardQuickToolsSection => 'Schnelle Werkzeuge';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'Beginnt in $days Tagen';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'Endet in $days Tagen';
  }

  @override
  String get navDashboardBody =>
      'Ihr Reise-Hub – öffnen Sie Tools über die Leiste oder das Menü „Mehr“.';

  @override
  String get appSettings => 'App-Einstellungen';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic Pro';

  @override
  String get settingsSubscriptionActive => 'Aktives Abonnement';

  @override
  String get settingsSubscriptionLifetime => 'Lebenslanger Zugriff';

  @override
  String get settingsSubscriptionFree => 'Kostenloser Plan';

  @override
  String get settingsManageBilling => 'Abrechnung verwalten';

  @override
  String get settingsTestModeSectionTitle => 'Testmodus';

  @override
  String get settingsTestModeProTitle => 'Testen Sie als Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'Lokale Überschreibung zum Testen; ignoriert RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'Wenn diese Option aktiviert ist, schaltet dieses Gerät alle Pro-Funktionen lokal frei. Nur für interne Tests gedacht – Ihr tatsächliches Abonnement wird dadurch nicht geändert.';

  @override
  String get settingsUnitsTitle => 'Maßeinheiten';

  @override
  String get settingsLanguageTitle => 'Sprache';

  @override
  String get settingsThemeTitle => 'Thema';

  @override
  String get settingsClockWidgetTitle => 'Uhr-Widget';

  @override
  String get settingsCurrencyWidgetTitle => 'Währungs-Widget';

  @override
  String get settingsCurrencyWidgetSubtitle =>
      'Start- und Sperrbildschirm: 1, 20, 100 Ihrer Basiswährung';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Licht';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsLanguageEnglish => 'Englisch';

  @override
  String get settingsLanguageSpanish => 'Spanisch';

  @override
  String get settingsProfileTitle => 'Profil- und Cloud-Synchronisierung';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get settingsLogoutConfirm => 'Von diesem Konto abmelden?';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String get settingsDeleteAccountBody =>
      'Die Kontolöschung wird vom Support übernommen. Unten können Sie sich abmelden.';

  @override
  String get settingsSectionAccount => 'Konto';

  @override
  String get accountManagementListTitle => 'Konto verwalten';

  @override
  String get accountManagementListSubtitle =>
      'Aktualisieren Sie Ihren Namen, Ihre E-Mail-Adresse und Ihr Passwort';

  @override
  String get accountManagementTitle => 'Kontoverwaltung';

  @override
  String get accountSectionProfile => 'Profil';

  @override
  String get accountSectionSignIn => 'Anmelden';

  @override
  String get accountFieldDisplayName => 'Anzeigename';

  @override
  String get accountFieldEmail => 'E-Mail';

  @override
  String get accountFieldCurrentPassword => 'Aktuelles Passwort';

  @override
  String get accountFieldNewPassword => 'Neues Passwort';

  @override
  String get accountSaveName => 'Namen speichern';

  @override
  String get accountChangeEmail => 'Bestätigungs- und Änderungs-E-Mail senden';

  @override
  String get accountChangePassword => 'Kennwort ändern';

  @override
  String get accountSignedOutMessage =>
      'Sie müssen angemeldet sein, um Ihr Konto verwalten zu können.';

  @override
  String get accountSignInCta => 'anmelden';

  @override
  String get accountNameSaved => 'Name aktualisiert';

  @override
  String accountEmailVerificationSent(String email) {
    return 'Bestätigungslink an $email gesendet. Bestätigen Sie es, um Ihre Anmeldeadresse zu ändern.';
  }

  @override
  String get accountPasswordChanged => 'Passwort aktualisiert';

  @override
  String accountReauthRequired(String field) {
    return 'Melden Sie sich aus Sicherheitsgründen erneut an, um Ihren $field zu ändern.';
  }

  @override
  String get accountFieldLabelEmail => 'E-Mail';

  @override
  String get accountFieldLabelPassword => 'Passwort';

  @override
  String accountErrorGeneric(String field, String error) {
    return '$field konnte nicht aktualisiert werden: $error';
  }

  @override
  String get accountReauthAction => 'Melden Sie sich erneut an';

  @override
  String get accountValidationEmailRequired =>
      'Geben Sie Ihre E-Mail-Adresse ein';

  @override
  String get accountValidationEmailInvalid =>
      'Geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get accountValidationNameRequired => 'Geben Sie Ihren Namen ein';

  @override
  String get accountValidationPasswordTooShort =>
      'Verwenden Sie mindestens 8 Zeichen';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'Aktuelle E-Mail: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic Pro';

  @override
  String get proPaywallSubtitle =>
      'Schalten Sie Offline-Karten, Deep-Travel-Tools und Zusammenarbeit frei.';

  @override
  String get proPaywallBenefits =>
      'Offline-Karten und Regions-Downloads\nReiseroute, Budget, Tresor und Verpackung\nGruppenplaner und Echtzeitsynchronisierung';

  @override
  String get proPaywallBullets =>
      'Offline-Karten und Regions-Downloads|Reiseroute, Budget, Tresor und Verpackung|Gruppenplaner und Echtzeitsynchronisierung';

  @override
  String get proPaywallUpgradeRevenueCat => 'Upgrade über RevenueCat';

  @override
  String get upgradeNow => 'Jetzt upgraden';

  @override
  String get packingCatClothing => 'KLEIDUNG';

  @override
  String get packingCatDocuments => 'UNTERLAGEN';

  @override
  String get packingCatMedications => 'MEDIKAMENTE';

  @override
  String get packingCatMisc => 'VERSCHIEDENES';

  @override
  String get packingCatReservations => 'RESERVIERUNGEN';

  @override
  String get packingEmpty =>
      'Ihre Liste ist leer.\nTippen Sie auf +, um Elemente hinzuzufügen.';

  @override
  String get packingEmptyHidden =>
      'Es muss nichts mehr eingepackt werden – oder deaktivieren Sie „Erledigt ausblenden“, um erledigte Aufgaben anzuzeigen.';

  @override
  String get packingHeader => 'VERPACKUNG & LOGISTIK';

  @override
  String get packingHideCompleted => 'Ausblenden abgeschlossen';

  @override
  String get packingHideCompletedSubtitle =>
      'Abgeschlossene Elemente bleiben gespeichert; nur aus dieser Ansicht verborgen';

  @override
  String get packingStarterPassport => 'Reisepass';

  @override
  String get packingStarterShirts => 'Hemden';

  @override
  String get packingStarterSocks => 'Socken';

  @override
  String get packingStarterTickets => 'Flugtickets';

  @override
  String get packingStarterToothbrush => 'Zahnbürste';

  @override
  String get paywallDisabledBody =>
      'Die Paywall RevenueCat ist zur Überprüfung der Benutzeroberfläche vorübergehend deaktiviert.';

  @override
  String get paywallDisabledTitle => 'Paywall deaktiviert';

  @override
  String get presentationDeleteBody =>
      'Möchten Sie dieses Dokument wirklich aus dem Tresor entfernen?';

  @override
  String get presentationDeleteTitle => 'Dokument löschen?';

  @override
  String get presentationImageLoadFail => 'Bild konnte nicht geladen werden';

  @override
  String get proActive => 'Aktiv';

  @override
  String get proManageHintFree =>
      'Schalten Sie Pro-Funktionen mit einem monatlichen Abonnement frei.';

  @override
  String get proManageHintPro =>
      'Verwalten Sie Ihr Abonnement oder stellen Sie Einkäufe wieder her.';

  @override
  String get proManageSubscription => 'Abonnement verwalten';

  @override
  String get proName => 'Tripmetic Pro';

  @override
  String get proPaywallError =>
      'Paywall konnte nicht angezeigt werden. Überprüfen Sie Ihr RevenueCat-Angebot.';

  @override
  String get proPaywallNotConfigured =>
      'Abonnements sind in dieser Installation nicht verfügbar. Installieren Sie Tripmetic von Google Play, um ein Upgrade auf Pro durchzuführen.';

  @override
  String proRestoreFailed(String message) {
    return 'Wiederherstellung fehlgeschlagen: $message';
  }

  @override
  String get proTrialCta => 'Starten Sie Ihre 3-tägige kostenlose Testversion';

  @override
  String get proWelcome => 'Willkommen bei Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'Gut';

  @override
  String get schedulerAvailabilityOffHours => 'Außerhalb der Geschäftszeiten';

  @override
  String get schedulerAvailabilityOk => 'OK';

  @override
  String get schedulerBaseLocation => 'Basisstandort';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'Datum, Uhrzeit und Schieberegler gelten für die Basisuhr ($zone). Jede Stadtzeile zeigt denselben Zeitpunkt in dieser Zone.';
  }

  @override
  String get schedulerConvertedCities => 'Umgewandelte Städte';

  @override
  String get schedulerDayNext => '+1 Tag';

  @override
  String get schedulerDayPrevious => '-1 Tag';

  @override
  String get schedulerDaySame => 'Am selben Tag';

  @override
  String get schedulerMeetingTime => 'Besprechungszeit';

  @override
  String get schedulerSubtitle => 'Überschneidungen bei Besprechungen';

  @override
  String get schedulerTitle => 'Globaler Planer';

  @override
  String get settingsAndInfo => 'Einstellungen & Infos';

  @override
  String get settingsContact => 'Kontaktieren Sie uns';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'Link konnte nicht geöffnet werden';

  @override
  String get settingsHelpFaq => 'Hilfe und FAQ';

  @override
  String get settingsPrivacy => 'Datenschutzrichtlinie';

  @override
  String get settingsSupportLegal => 'Support & Recht';

  @override
  String get settingsTerms => 'Nutzungsbedingungen';

  @override
  String get settingsMapboxAttributionTitle => 'Kartendaten (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic verwendet Mapbox-Karten. © Mapbox, © OpenStreetMap und andere Datenlieferanten. Das Logo auf der Karte und die Zuordnungskontrolle sind in der App ausgeblendet, um ein klareres Layout zu gewährleisten und weniger versehentliches Tippen zu verhindern. Dieser Hinweis erfüllt die Anzeigeanforderungen von Mapbox.';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox – Über Karten';

  @override
  String get sizeCatBelts => 'Gürtel';

  @override
  String get sizeCatMensJeansCombo => 'Herrenjeans – B×L (US)';

  @override
  String get sizeCatMensJeansInseam => 'Herrenjeans – Schrittlänge (L)';

  @override
  String get sizeCatMensJeansWaist => 'Herrenjeans – Taille (W)';

  @override
  String get sizeCatMensPants => 'Herrenhosen';

  @override
  String get sizeCatMensShirts => 'Herrenhemden';

  @override
  String get sizeCatMensShoes => 'Herrenschuhe';

  @override
  String get sizeCatMensTshirts => 'Herren-T-Shirts';

  @override
  String get sizeCatWomensBlouses => 'Damenblusen';

  @override
  String get sizeCatWomensDresses => 'Damenkleider';

  @override
  String get sizeCatWomensPants => 'Damenhosen';

  @override
  String get sizeCatWomensShoes => 'Damenschuhe';

  @override
  String get sizeCatWomensTshirts => 'Damen-T-Shirts';

  @override
  String get sizeCatBoysShoes => 'Jungenschuhe (Kinder)';

  @override
  String get sizeCatGirlsShoes => 'Mädchenschuhe (Kinder)';

  @override
  String get sizeCatBoysTshirts => 'Oberteile / T-Shirts für Jungen';

  @override
  String get sizeCatBoysPants => 'Hosen für Jungen';

  @override
  String get sizeCatGirlsTshirts => 'Oberteile / T-Shirts für Mädchen';

  @override
  String get sizeCatGirlsPants => 'Mädchenhose';

  @override
  String get sizeCatGirlsDressesKids => 'Mädchenkleider (Kinder)';

  @override
  String get sizeColumnPrimaryEu => 'Primär: EU';

  @override
  String get sizeColumnPrimaryJp => 'Primär: JP';

  @override
  String get sizeColumnPrimaryMixed => 'Grundschule: gemischt (EU→US→UK→JP)';

  @override
  String get sizeColumnPrimaryUk => 'Grundschule: Großbritannien';

  @override
  String get sizeColumnPrimaryUs => 'Primär: USA';

  @override
  String get sizeConverterAppBarSubtitle => 'Kleidung und Schuhe';

  @override
  String get sizeConverterCategory => 'Kategorie';

  @override
  String get sizeConverterHeader => 'KLEIDUNG & SCHUHE';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · Zum Ändern tippen';
  }

  @override
  String get sizeConverterYourBaseSize => 'Ihre Grundgröße (auf dem Etikett)';

  @override
  String get sizeConverterYourCountry => 'Ihr Land/Ihre Region';

  @override
  String get sizeEquivalentSizesHeader => 'Äquivalente Größen';

  @override
  String get sizeHintBelts => 'z.B. 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => 'z.B. 38x32 oder 38×32';

  @override
  String get sizeHintMensJeansInseam =>
      'z.B. 32 (Schrittlänge) oder 38x32 → verwendet Schrittlänge 32';

  @override
  String get sizeHintMensJeansWaist =>
      'z.B. 38 (Taille\") oder 38x32 → verwendet Taille 38';

  @override
  String get sizeHintMensPants => 'z.B. 30, 32, 34 (Taille\")';

  @override
  String get sizeHintMensShirts => 'z.B. 15, 38, M';

  @override
  String get sizeHintMensShoes => 'z.B. 6–14, 42, 27';

  @override
  String get sizeHintMensTshirts => 'z.B. S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => 'z.B. 8, 38, M, XL';

  @override
  String get sizeHintWomensDresses => 'z.B. 8, 38, M';

  @override
  String get sizeHintWomensPants => 'z.B. 6, 10, 38, M';

  @override
  String get sizeHintWomensShoes => 'z.B. 5–12, 39, 25';

  @override
  String get sizeHintWomensTshirts => 'z.B. XS, M, 38';

  @override
  String get sizeHintBoysShoes => 'z.B. 11C, 3J, 32, 21';

  @override
  String get sizeHintGirlsShoes => 'z.B. 10C, 2Y, 33, 20';

  @override
  String get sizeHintBoysTshirts => 'z.B. 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => 'z.B. 6, 8, 10 (US-Kinder)';

  @override
  String get sizeHintGirlsTshirts => 'z.B. 6, 8, M, S';

  @override
  String get sizeHintGirlsPants => 'z.B. 6, 8, 10 (US-Kinder)';

  @override
  String get sizeHintGirlsDressesKids => 'z.B. 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty =>
      'Geben Sie die auf Ihrem Kleidungsstück oder Schuh aufgedruckte Größe ein.';

  @override
  String get sizeNoMatchRow =>
      'Für diese Kategorie gibt es keine Zeile mit passender Größe. Versuchen Sie es gegebenenfalls mit US-, UK-, EU-, JP-Nummern oder einem Buchstaben (S, M, L).';

  @override
  String get sizeTipJeansCombo =>
      'Beispiel US 38×32: Taille ≈ EU 48, JP-Taillenetikett oft ~96–97 cm; Schrittlänge 32\" ≈ ~81 cm. Marken unterscheiden sich – verwenden Sie dies als Ausgangspunkt.';

  @override
  String get sizeTipJeansInseam =>
      'Die Schrittlänge ist die Innenbeinlänge in Zoll (z. B. 32). Japan kann bei einer Schrittlänge von 32 Zoll etwa 81 cm anzeigen. Geben Sie 38×32 ein – wir verwenden 32 für die Schrittlänge.';

  @override
  String get sizeTipJeansWaist =>
      'Eine Zahl auf einem asiatischen Etikett ist oft die Taille: entweder Zentimeter (38\" ≈ 96–97 cm) oder US-Taille Zoll (38). Vergleichen Sie es mit einem Maßband. Sie können hier 38×32 eingeben – wir verwenden 38 für die Taille.';

  @override
  String get timezonePickerEmpty => 'Keine Übereinstimmungen';

  @override
  String get timezonePickerHint => 'IANA-Namen suchen (z. B. Europa, Tokio)';

  @override
  String get timezonePickerTitle => 'Wählen Sie eine Zeitzone';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown von $total Zonen';
  }

  @override
  String get timezoneSheetSearchHint =>
      'IANA-Namen suchen (z. B. Europa, Tokio)';

  @override
  String get timezoneSheetTitle => 'Zeitzone auswählen';

  @override
  String get tipAmount => 'Trinkgeldbetrag';

  @override
  String get tipAppBarSubtitle => 'Trinkgeld und Rechnung';

  @override
  String get tipBillHint => 'z.B. 1.250.000,00 \$';

  @override
  String get tipCountryBrazil => 'Brasilien';

  @override
  String get tipCountryChina => 'China';

  @override
  String get tipCountryColombia => 'Kolumbien';

  @override
  String get tipCountryDominicanRepublic => 'Dominikanische Republik';

  @override
  String get tipCountryEgypt => 'Ägypten';

  @override
  String get tipCountryFrance => 'Frankreich';

  @override
  String get tipCountryGermany => 'Deutschland';

  @override
  String get tipCountryHongKong => 'Hongkong';

  @override
  String get tipCountryIndonesia => 'Indonesien';

  @override
  String get tipCountryItaly => 'Italien';

  @override
  String get tipCountryJapan => 'Japan';

  @override
  String get tipCountryMexico => 'Mexiko';

  @override
  String get tipCountryMorocco => 'Marokko';

  @override
  String get tipCountryPortugal => 'Portugal';

  @override
  String get tipCountrySingapore => 'Singapur';

  @override
  String get tipCountrySpain => 'Spanien';

  @override
  String get tipCountryThailand => 'Thailand';

  @override
  String get tipCountryTurkey => 'Truthahn';

  @override
  String get tipCountryUae => 'Vereinigte Arabische Emirate (Dubai)';

  @override
  String get tipCountryUnitedKingdom => 'Vereinigtes Königreich';

  @override
  String get tipCountryUsa => 'Vereinigte Staaten';

  @override
  String get tipZeroReasonChina =>
      'Trinkgeld ist auf dem chinesischen Festland nicht üblich und kann vielerorts abgelehnt oder als ungewöhnlich angesehen werden.';

  @override
  String get tipZeroReasonFrance =>
      'In Restaurantrechnungen ist in der Regel eine Servicegebühr von 15 % enthalten (Service inklusive). Für außergewöhnlichen Service ist zusätzliches Trinkgeld optional.';

  @override
  String get tipZeroReasonJapan =>
      'Trinkgeld wird in Japan nicht praktiziert und kann zu Verwirrung oder Ärger führen.';

  @override
  String get tipZeroReasonSingapore =>
      'Trinkgeld wird nicht erwartet; Viele Veranstaltungsorte berechnen eine Servicegebühr von 10 % auf die Rechnung.';

  @override
  String get tipZeroReasonGeneric =>
      'Typisch ist hier ein Trinkgeld von 0 %. Sie können immer noch ein Trinkgeld für hervorragenden Service hinzufügen.';

  @override
  String get tipZeroReasonTitle => 'Warum 0 %?';

  @override
  String get tipCurrentCountry => 'Aktuelles Land';

  @override
  String get tipPeople => 'Menschen';

  @override
  String get tipPerPerson => 'Betrag pro Person';

  @override
  String get tipPercentHint => 'Tipp % eingeben (z. B. 15 oder 27,5)';

  @override
  String get tipPercentLabel => 'Tipp %';

  @override
  String get tipResults => 'ERGEBNISSE';

  @override
  String get tipSmartHeader => 'SMARTER TIPP';

  @override
  String get tipTotalBill => 'Gesamtrechnungsbetrag';

  @override
  String get tipTotalWithTip => 'Insgesamt mit Trinkgeld';

  @override
  String get toolBrainstorm => 'Brainstorming';

  @override
  String get toolBudget => 'Budget';

  @override
  String get toolBudgetSubtitle => 'Reisebudgetplanung und Kostenverfolgung';

  @override
  String get toolBudgetTitle => 'Budget';

  @override
  String get toolItinerarySubtitle => 'Flüge, Hotels und Pläne pro Tag';

  @override
  String get toolItineraryTitle => 'Route';

  @override
  String get toolCrypto => 'Krypto';

  @override
  String get toolCryptoSubtitle => 'USD-Werte bei beliebten Münzen';

  @override
  String get toolCryptoTitle => 'Krypto';

  @override
  String get toolDocumentVault => 'Dokumententresor';

  @override
  String get toolMindMapSubtitle =>
      'Ideen auf einer unendlichen Leinwand · offline';

  @override
  String get toolMindMapTitle => 'Brainstorming-Mindmap';

  @override
  String get toolPacking => 'Verpackung';

  @override
  String get toolPackingSubtitle => 'Clevere Pack-Checklisten nach Reise';

  @override
  String get toolPackingTitle => 'Verpackung';

  @override
  String get toolSchedulerSubtitle => 'Zwei Zeitzonen · Jetlag-Planung';

  @override
  String get toolSchedulerTitle => 'Uhrzeit und Datum';

  @override
  String get toolSettingsAboutSubtitle =>
      'Ankündigungen, Hilfe, Datenschutz und Nutzungsbedingungen';

  @override
  String get toolSettingsAboutTitle => 'Einstellungen & Info';

  @override
  String get toolSettingsInfo => 'Einstellungen & Infos';

  @override
  String get toolSizeSubtitle => 'USA · Großbritannien · EU · Japan (JP)';

  @override
  String get toolSizeTitle => 'Konverter für Konfektionsgrößen';

  @override
  String get toolTimeDate => 'Uhrzeit und Datum';

  @override
  String get toolTipSubtitle =>
      'Länderspezifische Trinkgeldnormen · Aufteilung auf bis zu 20 Personen';

  @override
  String get toolTipTitle => 'Intelligenter Trinkgeld- und Geldschein-Splitter';

  @override
  String get toolUnits => 'Einheiten';

  @override
  String get toolUnitsSubtitle => 'Länge, Gewicht, Temperatur, Volumen';

  @override
  String get toolUnitsTitle => 'Einheiten';

  @override
  String get toolVaultSubtitle =>
      'Offline-Speicherung wichtiger Reisedokumente';

  @override
  String get toolVaultTitle => 'Dokumententresor';

  @override
  String get unitAcres => 'Hektar';

  @override
  String get unitCategoryArea => 'Bereich';

  @override
  String get unitCategoryDistance => 'Distanz';

  @override
  String get unitCategoryLength => 'Länge';

  @override
  String get unitCategoryTemperature => 'Temperatur';

  @override
  String get unitCategoryVolume => 'Volumen';

  @override
  String get unitCategoryWeight => 'Gewicht';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get unitCentimeters => 'Zentimeter';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitFeet => 'Füße';

  @override
  String get unitGrams => 'Gramm';

  @override
  String get unitHectares => 'Hektar';

  @override
  String get unitInches => 'Zoll';

  @override
  String get unitKilograms => 'Kilogramm';

  @override
  String get unitKilometers => 'Kilometer';

  @override
  String get unitLiters => 'Liter';

  @override
  String get unitMeters => 'Meter';

  @override
  String get unitMiles => 'Meilen';

  @override
  String get unitMilliliters => 'Milliliter';

  @override
  String get unitOunces => 'Unzen';

  @override
  String get unitPounds => 'Pfund';

  @override
  String get unitSquareCentimeters => 'Quadratzentimeter';

  @override
  String get unitSquareFeet => 'Quadratfuß';

  @override
  String get unitSquareInches => 'Quadratzoll';

  @override
  String get unitSquareKilometers => 'Quadratkilometer';

  @override
  String get unitSquareMeters => 'Quadratmeter';

  @override
  String get unitSquareYards => 'Quadratmeter';

  @override
  String get unitUsFluidOunces => 'US-Flüssigkeitsunzen';

  @override
  String get unitUsGallons => 'US-Gallonen';

  @override
  String get unitYards => 'Yards';

  @override
  String get unitsHeader => 'EINHEITEN';

  @override
  String get vaultCategoryArrivalCard => 'Ankunftskarte';

  @override
  String get vaultCategoryHotelReservation => 'Hotelreservierung';

  @override
  String get vaultCategoryOther => 'Andere';

  @override
  String get vaultCategoryPassportCopy => 'Passkopie';

  @override
  String get vaultCategoryReturnFlight => 'Rückflug';

  @override
  String get vaultCategoryVisa => 'Visum';

  @override
  String get vaultDocumentTitle => 'Dokumentieren';

  @override
  String get vaultIntro =>
      'Speichern Sie wichtige Reisedokumente sicher für den Offline-Zugriff und die schnelle Vorlage bei der Einwanderung.';

  @override
  String vaultProcessFailed(String error) {
    return 'Dokument konnte nicht verarbeitet werden: $error';
  }

  @override
  String get vaultTapToUpload => 'Zum Hochladen antippen';

  @override
  String get vaultTapToView => 'Zum Ansehen antippen';

  @override
  String get vaultVaultWord => 'Gewölbe';

  @override
  String get bucketListTitle => 'Bucket-Liste';

  @override
  String get bucketListSubtitle =>
      'Orte, an denen Sie waren, die Sie besuchen möchten und was als nächstes kommt.';

  @override
  String get bucketListToolSubtitle =>
      'Traumziele auf einer Karte und in Listen';

  @override
  String get bucketListViewModeList => 'Liste';

  @override
  String get bucketListViewModeMap => 'Karte';

  @override
  String get bucketListViewModePopular => 'Beliebt';

  @override
  String get bucketListPopularHint =>
      'Been, Live und Lived aktualisieren Ihre Karte und Liste. „Want“ und „Upcoming“ sind nur Listen und erscheinen nie auf der Karte.';

  @override
  String get bucketListCategoryBeen => 'Gewesen';

  @override
  String get bucketListCategoryWant => 'Wollen';

  @override
  String get bucketListCategoryLive => 'Live';

  @override
  String get bucketListCategoryLived => 'Gelebt';

  @override
  String get bucketListCategoryUpcoming => 'Demnächst';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'Kategorie';

  @override
  String get bucketListDetailDates => 'Termine';

  @override
  String get bucketListMapLegend =>
      'Tippen Sie auf eine Markierung, um Einzelheiten anzuzeigen';

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
    return '$name hat $worldPercent % der Welt erkundet. Mehr als $populationPercent % der Weltbevölkerung sind gereist.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'Rafael';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'Mehr als $percent % der Weltbevölkerung sind gereist';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'Länder';

  @override
  String get bucketListShareMapCitiesLabel => 'Städte';

  @override
  String get bucketListEmptyCategory =>
      'Noch keine Plätze in dieser Kategorie.';

  @override
  String get bucketListTravelStats => 'Reisestatistiken';

  @override
  String get bucketListStatWorld => 'Welt erkundet';

  @override
  String get bucketListStatUs => 'USA erkundet';

  @override
  String get bucketListStatEurope => 'Europa erkundet';

  @override
  String get bucketListStatAsia => 'Asien erkundet';

  @override
  String get bucketListStatAfrica => 'Afrika erkundet';

  @override
  String get bucketListStatRegionalCaption => 'Regional';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count einzigartig · von $total';
  }

  @override
  String get bucketListAddDestination => 'Ziel hinzufügen';

  @override
  String get bucketListEditDestination => 'Ziel bearbeiten';

  @override
  String get bucketListSave => 'Speichern';

  @override
  String get bucketListFieldCity => 'Stadt';

  @override
  String get bucketListFieldCountry => 'Land';

  @override
  String get bucketListFieldCategory => 'Kategorie';

  @override
  String get bucketListFieldRegionHint => 'Bundesstaat/Provinz (optional)';

  @override
  String get bucketListFieldLatitude => 'Breite';

  @override
  String get bucketListFieldLongitude => 'Länge';

  @override
  String get bucketListFieldStart => 'Startdatum';

  @override
  String get bucketListFieldEnd => 'Enddatum';

  @override
  String get bucketListFieldTripDates => 'Reisedaten';

  @override
  String get bucketListValidationRequired => 'Dieses Feld ist erforderlich.';

  @override
  String get bucketListValidationNumber => 'Geben Sie eine gültige Nummer ein.';

  @override
  String get bucketListValidationDates =>
      'Das Enddatum muss am oder nach dem Startdatum liegen.';

  @override
  String get bucketListGeocodeNotFound =>
      'Dieser Ort konnte auf der Karte nicht gefunden werden. Bitte überprüfen Sie die Rechtschreibung.';

  @override
  String get bucketListShareSummarySubject => 'Meine Tripmetic Bucket List';

  @override
  String get bucketListShareTooltip => 'Liste und Karte teilen';

  @override
  String bucketListShareFailed(String error) {
    return 'Konnte nicht geteilt werden: $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'Öffnen Sie die Kartenansicht, bevor Sie das Kartenbild aufnehmen.';

  @override
  String get bucketListDeleteHint => 'Zum Entfernen wischen';

  @override
  String get bucketListTapEditHint => 'Zum Bearbeiten tippen';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'Cloud-Synchronisierung fehlgeschlagen: $error';
  }

  @override
  String get bucketListRetry => 'Wiederholen';

  @override
  String get bucketListBackupTooltip => 'Sichern und registrieren';

  @override
  String get bucketListBackupTitle => 'Cloud-Backup';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic funktioniert vollständig ohne Konto. Fügen Sie jederzeit eines hinzu, wenn Sie ein Cloud-Backup für Ihre Bucket List und gemeinsame Gruppenreisen wünschen.';

  @override
  String bucketListSignedInAs(String email) {
    return 'Angemeldet als $email';
  }

  @override
  String get bucketListBackupEmail => 'E-Mail';

  @override
  String get bucketListBackupPassword => 'Passwort';

  @override
  String get bucketListBackupConfirmPassword => 'Passwort bestätigen';

  @override
  String get bucketListAuthTabSignUp => 'Melden Sie sich an';

  @override
  String get bucketListAuthPasswordMismatch =>
      'Passwörter stimmen nicht überein.';

  @override
  String get bucketListRegister => 'Konto und Backup erstellen';

  @override
  String get bucketListSignIn => 'anmelden';

  @override
  String get bucketListSignOut => 'Abmelden';

  @override
  String get bucketListBackupUploading => 'Hochladen in die Cloud…';

  @override
  String get bucketListAuthSuccessSignIn => 'Erfolgreich eingeloggt!';

  @override
  String get bucketListAuthSuccessSignUp => 'Konto erfolgreich erstellt!';

  @override
  String get signUpSuccessMessage =>
      'Konto erstellt. Willkommen bei Tripmetic!';

  @override
  String get signUpErrorEmailInUse =>
      'Diese E-Mail ist bereits registriert. Versuchen Sie, sich anzumelden.';

  @override
  String get signUpErrorInvalidEmail =>
      'Geben Sie eine gültige E-Mail-Adresse ein.';

  @override
  String get signUpErrorWeakPassword =>
      'Das Passwort ist zu schwach. Verwenden Sie mindestens 8 Zeichen.';

  @override
  String signUpErrorGeneric(String message) {
    return 'Anmeldung nicht möglich: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'anmelden';

  @override
  String bucketListAuthFailed(String error) {
    return 'Authentifizierung konnte nicht durchgeführt werden: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'Noch keine Notizen oder Links.';

  @override
  String get groupPlannerTitle => 'Gruppenplaner';

  @override
  String get groupPlannerToolTitle => 'Gruppenplaner';

  @override
  String get groupPlannerToolSubtitle =>
      'Planen Sie gemeinsam eine Reise in Echtzeit';

  @override
  String get groupPlannerLandingPlanTitle => 'Planen Sie eine Gruppenreise';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'Erstellen Sie eine gemeinsame Reise mit Ziel, Daten und Budget.';

  @override
  String get groupPlannerLandingJoinTitle =>
      'Nehmen Sie an einer Gruppenreise teil';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'Geben Sie den Reisecode oder den Link aus Ihrer Einladung ein.';

  @override
  String get groupPlannerCreateTripTitle => 'Neue Gruppenreise';

  @override
  String get groupPlannerSelectDates =>
      'Wählen Sie einen Reisedatumsbereich aus.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'Pro Person';

  @override
  String get groupPlannerBudgetGroupOption => 'Gruppensumme';

  @override
  String get groupPlannerBudgetNoneOption => 'Keiner';

  @override
  String get groupPlannerBudgetAmountLabel => 'Budgetbetrag';

  @override
  String get groupPlannerOpenTitle => 'Eröffnen Sie eine Gruppenreise';

  @override
  String get groupPlannerOpenSubtitle =>
      'Fügen Sie den Reisecode aus Ihrer Einladung ein.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'Reisecode';

  @override
  String get groupPlannerOpenHint =>
      'Funktionscode, Reise-ID oder Einladungslink';

  @override
  String get groupPlannerOpenButton => 'Offene Reise';

  @override
  String get groupPlannerDestination => 'Ziel';

  @override
  String get groupPlannerDates => 'Termine';

  @override
  String get groupPlannerGroupSize => 'Gruppengröße';

  @override
  String get groupPlannerBudget => 'Budget';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'Pro Person: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'Gruppengesamt: $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'Kein Budget festgelegt';

  @override
  String get groupPlannerInviteMembers => 'Mitglieder einladen';

  @override
  String get groupPlannerManageMembers => 'Mitglieder verwalten';

  @override
  String get groupPlannerItinerary => 'Route';

  @override
  String get groupPlannerItineraryEditorHint =>
      'Als Reiseadministrator oder Reisekoordinator können Sie Aktivitäten hinzufügen und den Zeitplan ändern.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'Schreibgeschützt: Mit Daumen nach oben oder unten über vorgeschlagene Aktivitäten abstimmen. Nur Reiseadministratoren und Reisekoordinatoren können Elemente hinzufügen oder ändern.';

  @override
  String get groupPlannerNoActivities => 'Noch keine Aktivitäten.';

  @override
  String get groupPlannerTripNotFound =>
      'Diese Reise konnte nicht geladen werden.';

  @override
  String get groupPlannerSignInTitle => 'Anmeldung erforderlich';

  @override
  String get groupPlannerSignInBody =>
      'Melden Sie sich unter Bucket-Liste → Cloud-Backup an, um geteilte Reisen anzuzeigen.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'Für das Speichern einer neuen Gruppenreise ist ein Konto erforderlich. Melden Sie sich an, um fortzufahren – andere Tripmetic-Funktionen funktionieren auch ohne.';

  @override
  String get groupPlannerMembersTitle => 'Mitglieder';

  @override
  String get groupPlannerRoleAdmin => 'Admin';

  @override
  String get groupPlannerRoleCoPlanner => 'Reisekoordinator';

  @override
  String get groupPlannerRoleViewOnly => 'Nur zur Ansicht';

  @override
  String get groupPlannerOwner => 'Eigentümer';

  @override
  String get groupPlannerRemoveMember => 'Entfernen';

  @override
  String get groupPlannerRemoveMemberTitle => 'Mitglied entfernen?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return '$email von dieser Reise entfernen?';
  }

  @override
  String get groupPlannerCancel => 'Stornieren';

  @override
  String get groupPlannerNotes => 'Notizen';

  @override
  String get groupPlannerOpenLink => 'Link öffnen';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'Abstimmung konnte nicht gespeichert werden: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'Mitglieder konnten nicht aktualisiert werden: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'Freigabeblatt konnte nicht geöffnet werden: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'Reise konnte nicht geöffnet werden: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'Ihre Reisen';

  @override
  String get groupPlannerMyTripsEmpty =>
      'Noch keine Reisen. Erstellen Sie oben eines.';

  @override
  String get groupPlannerExamplesTitle => 'Beispielreisen';

  @override
  String get groupPlannerExamplesSubtitle =>
      'Beispielkarten – erstellen Sie oben eine Reise, um Ihre eigene hinzuzufügen.';

  @override
  String get groupPlannerExampleTapBody =>
      'Es handelt sich lediglich um Muster. Verwenden Sie „Gruppenreise planen“, um eine echte Reise zu erstellen, die Sie teilen können.';

  @override
  String get groupPlannerExampleLisbonTitle =>
      'Lissabon-Team außerhalb des Stadions';

  @override
  String get groupPlannerExampleKyotoTitle => 'Kyoto-Frühlingstour';

  @override
  String get groupPlannerAddActivity => 'Aktivität hinzufügen';

  @override
  String get groupPlannerActivityTitleLabel => 'Aktivitätstitel';

  @override
  String get groupPlannerActivityWhenLabel => 'Datum und Uhrzeit';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'Wählen Sie einen Tag und dann eine Uhrzeit für Ihre Reise. Jeder, der die Reiseroute bearbeiten kann, kann dies später ändern.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'Dieses Datum liegt außerhalb dieser Reise. Wählen Sie einen Tag zwischen Reisebeginn und -ende.';

  @override
  String get groupPlannerActivityTitleRequired =>
      'Geben Sie einen Aktivitätstitel ein.';

  @override
  String get groupPlannerActivityDateUnset =>
      'Datum nicht festgelegt – tippen Sie auf „Bearbeiten“, um einen Termin festzulegen.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count Leute';
  }

  @override
  String get groupPlannerEditActivity => 'Aktivität bearbeiten';

  @override
  String get groupPlannerDeleteActivity => 'Löschen';

  @override
  String get groupPlannerDeleteActivityTitle => 'Aktivität löschen?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return '„$title“ aus dem Reiseplan entfernen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'Aktivität konnte nicht gelöscht werden: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'Aktivität konnte nicht aktualisiert werden: $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'Reise bearbeiten';

  @override
  String get groupPlannerEditTripAction => 'Reise bearbeiten';

  @override
  String get groupPlannerDeleteTripTitle => 'Reise löschen?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return 'Die Reise „$destination“ und ihren Reiseplan dauerhaft für alle entfernen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'Reise löschen';

  @override
  String get groupPlannerTripDeleted => 'Reise entfernt.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'Reise konnte nicht gelöscht werden: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'Reise konnte nicht aktualisiert werden: $error';
  }

  @override
  String get widgetInstructionTitle => 'Dual-Clock-Widget';

  @override
  String get widgetInstructionSubtitle =>
      'Verfolgen Sie die Zeitzonen Ihres Heimat- und Zielorts direkt von Ihrem Sperrbildschirm oder Startbildschirm aus.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'Bildschirm sperren';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'Drücken Sie lange auf den Sperrbildschirm und tippen Sie auf „Anpassen“.';

  @override
  String get widgetInstructionIosLockScreenStep2 =>
      'Wählen Sie die Vorschau „Sperrbildschirm“.';

  @override
  String get widgetInstructionIosLockScreenStep3 =>
      'Tippen Sie auf den Widget-Bereich direkt unter der Uhrzeit.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      'Scrollen Sie nach unten, wählen Sie Tripmetic aus und tippen Sie, um das Widget hinzuzufügen.';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'Startbildschirm';

  @override
  String get widgetInstructionIosHomeScreenStep1 =>
      'Drücken Sie lange auf eine leere Stelle auf Ihrem Startbildschirm.';

  @override
  String get widgetInstructionIosHomeScreenStep2 =>
      'Tippen Sie oben links auf das +-Symbol.';

  @override
  String get widgetInstructionIosHomeScreenStep3 =>
      'Suchen Sie nach „Tripmetic“.';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      'Wählen Sie Ihre bevorzugte Widget-Größe und tippen Sie auf „Widget hinzufügen“.';

  @override
  String get widgetInstructionAndroidStep1 =>
      'Gehen Sie zu Ihrem Startbildschirm und drücken Sie lange auf einen leeren Bereich.';

  @override
  String get widgetInstructionAndroidStep2 => 'Tippen Sie auf „Widgets“.';

  @override
  String get widgetInstructionAndroidStep3 =>
      'Scrollen Sie nach unten zu Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'Tippen und halten Sie das Dual Clock-Widget und ziehen Sie es dann auf Ihren Bildschirm.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'Um beide Uhren auf dem Sperrbildschirm anzuzeigen: Öffnen Sie Einstellungen → suchen Sie nach „Sperrbildschirm“ oder „Widgets“ und fügen Sie dort Tripmetic hinzu, wenn Ihr Telefon Sperrbildschirm-Widgets bietet (nicht alle Geräte).';

  @override
  String get widgetInstructionConfigureCta => 'Widget-Städte konfigurieren';

  @override
  String get currencyWidgetInstructionTitle => 'Währungsumrechner-Widget';

  @override
  String get currencyWidgetInstructionSubtitle =>
      'Hängen Sie Ihre Basis- und Zielwährungen an Ihren Android-Startbildschirm an. Die Preise werden immer dann synchronisiert, wenn Sie den Konverter in Tripmetic verwenden.';

  @override
  String get currencyWidgetInstructionAndroidTitle =>
      'Zum Startbildschirm hinzufügen';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      'Öffnen Sie das Währungstool einmal und legen Sie Ihre ersten beiden Währungen fest (Basis und Ziel).';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      'Gehen Sie zu Ihrem Startbildschirm und drücken Sie lange auf einen leeren Bereich.';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      'Tippen Sie auf „Widgets“, scrollen Sie zu Tripmetic und wählen Sie „Währungsumrechner“.';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      'Ziehen Sie das Widget auf Ihren Startbildschirm oder tippen Sie auf „Hinzufügen“, wenn Ihr Launcher dies unterstützt.';

  @override
  String get currencyWidgetInstructionUsageTitle => 'Verwendung des Widgets';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      'Tippen Sie auf „Ändern“ (oder auf den Widget-Körper), um die Währungsauswahl in Tripmetic zu öffnen.';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      'Tippen Sie auf ↻ Aktualisieren, um die Tarife im Widget im Hintergrund zu aktualisieren (die App wird nicht geöffnet).';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      'Beträge werden automatisch aktualisiert, wenn Sie Währungen oder Werte in der App bearbeiten.';

  @override
  String get currencyWidgetInstructionPinCta =>
      'Widget zum Startbildschirm hinzufügen';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta =>
      'Widget-Währungen ändern';

  @override
  String get currencyWidgetInstructionIosHint =>
      'Das Währungs-Startbildschirm-Widget ist unter Android verfügbar. Verwenden Sie auf iPhone das In-App-Währungstool.';

  @override
  String get currencyWidgetPinUnsupported =>
      'Ihr Launcher unterstützt das Hinzufügen dieses Widgets aus der App nicht. Drücken Sie lange auf Ihren Startbildschirm und wählen Sie stattdessen Widgets.';

  @override
  String get currencyWidgetPinFailed =>
      'Die Widget-Auswahl konnte nicht geöffnet werden. Fügen Sie das Widget manuell von Ihrem Startbildschirm aus hinzu.';

  @override
  String get dualClockScreenTitle => 'Dual-Clock-Widget';

  @override
  String get dualClockConfigTitle => 'Städte konfigurieren';

  @override
  String get dualClockConfigSubtitle =>
      'Wählen Sie zwei Städte und Zeitzonen. Ihre Auswahl wird mit dem Tripmetic Startbildschirm-Widget (Android) und dem Sperrbildschirm-Widget (iOS) synchronisiert.';

  @override
  String get dualClockCity1Label => 'Erste Stadt';

  @override
  String get dualClockCity2Label => 'Zweite Stadt';

  @override
  String get dualClockSave => 'Widget speichern und aktualisieren';

  @override
  String get dualClockSaved => 'Widget aktualisiert.';

  @override
  String get dualClockSaveError =>
      'Widget-Daten konnten nicht gespeichert werden. Bitte versuchen Sie es erneut.';

  @override
  String get dualClockAppearanceTitle => 'Widget-Erscheinungsbild';

  @override
  String get dualClockAppearanceHint =>
      'Passen Sie Textgröße, Farben und Hintergrund des Startbildschirms an. Der Sperrbildschirm verwendet die Schriftgröße (und Farben, sofern das System dies zulässt).';

  @override
  String get dualClockFontScaleLabel => 'Textgröße';

  @override
  String get dualClockColorCity => 'Städtenamen';

  @override
  String get dualClockColorTime => 'Mal';

  @override
  String get dualClockColorDate => 'Termine';

  @override
  String get dualClockColorBackground => 'Heimhintergrund';

  @override
  String get dualClockShadowLabel => 'Textschatten';

  @override
  String get dualClockShadowSubtitle =>
      'Fügt Kontrast auf belebten oder Fototapeten hinzu.';

  @override
  String get moreToolsDualClockBannerTitle => 'Dual Clock-Widget';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'Sehen Sie sich zwei Zeitzonen auf Ihrem Sperrbildschirm oder Startbildschirm an – tippen Sie zum Einrichten darauf.';

  @override
  String get moreToolsDualClockBannerCta => 'Aufstellen';

  @override
  String get settingsDualClockWidgetTitle => 'Dual Clock-Widget';

  @override
  String get settingsDualClockWidgetSubtitle =>
      'Fügen Sie das Widget hinzu und wählen Sie Ihre Städte aus';

  @override
  String get widgetNewFeatureBadge => 'Neu';

  @override
  String get globalNavAccountCloudSyncTooltip => 'Konto- und Cloud-Backup';

  @override
  String get exchangeRatesForceRefreshTooltip =>
      'Aktuelle Wechselkurse abrufen';

  @override
  String get exchangeRatesRefreshedOk => 'Wechselkurse aktualisiert.';

  @override
  String get exchangeRatesRefreshFailed =>
      'Die Wechselkurse konnten nicht aktualisiert werden.';

  @override
  String get bucketListStatUsTerritories => 'US-Territorien';

  @override
  String get bucketListAuthErrUserNotFound =>
      'Für diese E-Mail wurde kein Konto gefunden.';

  @override
  String get bucketListAuthErrWrongPassword =>
      'Falsche E-Mail-Adresse oder falsches Passwort.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'Für diese E-Mail existiert bereits ein Konto.';

  @override
  String get bucketListAuthErrInvalidEmail => 'Ungültige E-Mail-Adresse.';

  @override
  String get bucketListAuthErrWeakPassword => 'Das Passwort ist zu schwach.';

  @override
  String get bucketListAuthErrUserDisabled => 'Dieses Konto wurde deaktiviert.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'Zu viele Versuche. Versuchen Sie es später noch einmal.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'Die E-Mail-/Passwort-Anmeldung ist nicht aktiviert.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail =>
      'Ungültige E-Mail-Adresse.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get bucketListAuthValidationPasswordRequired =>
      'Geben Sie Ihr Passwort ein.';

  @override
  String get currencyWidgetAppearanceTitle => 'Aussehen';

  @override
  String get currencyWidgetAppearanceHint =>
      'Passen Sie die Schriftgröße, die Textfarben und den Hintergrund des Startbildschirms an. Home-Widgets behalten eine feste Größe, sodass große Schriftarten automatisch angepasst werden und alle Zeilen sichtbar bleiben. Der Sperrbildschirm verwendet die Schriftgröße (und Farben, sofern das System dies zulässt).';

  @override
  String get currencyWidgetFontScaleLabel => 'Schriftgröße';

  @override
  String get currencyWidgetColorPrimary => 'Primärtext (Beträge/Basis)';

  @override
  String get currencyWidgetColorAccent =>
      'Akzenttext (Paar-/Leiterbeschriftungen)';

  @override
  String get currencyWidgetColorCaption => 'Beschriftungstext (Preiszeile)';

  @override
  String get currencyWidgetColorBackground => 'Heimhintergrund';

  @override
  String get currencyWidgetSaveAppearance => 'Aussehen speichern';

  @override
  String get currencyWidgetAppearanceSaved =>
      'Erscheinungsbild des Währungs-Widgets gespeichert';

  @override
  String get currencyWidgetAppearanceSaveFailed =>
      'Das Widget-Erscheinungsbild konnte nicht gespeichert werden';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
