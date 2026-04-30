// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'Please enter a title';

  @override
  String get addItineraryFieldLocation => 'Location';

  @override
  String get addItineraryFieldNotes => 'Notes / confirmation';

  @override
  String get addItineraryFieldTitle => 'Title';

  @override
  String get addItineraryHintLocation => 'Airport, hotel address…';

  @override
  String get addItineraryHintNotes => 'Record locator, links…';

  @override
  String get addItineraryHintTitle => 'Flight to Lisbon';

  @override
  String get addItinerarySave => 'Save event';

  @override
  String get addItineraryTitle => 'Add itinerary event';

  @override
  String get addPackingAddToList => 'Add to list';

  @override
  String get addPackingEnterName => 'Please enter an item name';

  @override
  String get addPackingHint => 'e.g. Power adapter';

  @override
  String get addPackingIcon => 'Icon';

  @override
  String get addPackingQuantity => 'Quantity';

  @override
  String get addPackingTitle => 'Add packing item';

  @override
  String get announcementsLatest => 'Latest updates';

  @override
  String get appTitle => 'TRIPMETIC.app';

  @override
  String get budgetBaseCurrency => 'BASE CURRENCY';

  @override
  String get budgetCategoryDialogHint => 'e.g. Souvenirs';

  @override
  String get budgetCategoryNameExists => 'Name already exists';

  @override
  String get budgetCategoryNameMax => 'Max 40 characters';

  @override
  String get budgetDailyFood => 'Daily food';

  @override
  String get budgetDialogAdd => 'Add';

  @override
  String get budgetDialogNewCategory => 'New expense category';

  @override
  String budgetDialogRemoveBody(String name) {
    return 'Remove \"$name\" and its amount?';
  }

  @override
  String get budgetDialogRemoveTitle => 'Remove category';

  @override
  String get budgetDialogRename => 'Rename';

  @override
  String get budgetDialogRenameCategory => 'Rename category';

  @override
  String get budgetEdit => 'Edit budget';

  @override
  String get budgetExpenseDailyFood => 'Daily Food';

  @override
  String get budgetExpenseEatingOut => 'Eating Out';

  @override
  String get budgetExpenseEntertainment => 'Entertainment';

  @override
  String get budgetExpenseFlights => 'Flights';

  @override
  String get budgetExpenseGrocery => 'Grocery';

  @override
  String get budgetExpenseHotels => 'Hotels';

  @override
  String get budgetExpenseMisc => 'Misc';

  @override
  String get budgetExpensePhoneService => 'Phone Service';

  @override
  String get budgetExpenseShopping => 'Shopping';

  @override
  String get budgetExpenseTourism => 'Tourism';

  @override
  String get budgetExpenseTransportation => 'Transportation';

  @override
  String get budgetExpenseTravelInsurance => 'Travel Insurance';

  @override
  String get budgetInDestinations => 'In your destinations';

  @override
  String get budgetNoCategories => 'No expense categories yet';

  @override
  String budgetOtherExpenses(String code) {
    return 'OTHER EXPENSES ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'Per day (estimate)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / day';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'Remaining after expenses · $code';
  }

  @override
  String get budgetSave => 'Save budget';

  @override
  String get budgetSpendingPower => 'Spending power';

  @override
  String get budgetSpentVsBudget => 'Spent vs budget';

  @override
  String budgetTotalBudget(String code) {
    return 'TOTAL BUDGET ($code)';
  }

  @override
  String budgetTotalForTrip(Object code) {
    return 'Total for trip ($code)';
  }

  @override
  String get budgetTripDashboard => 'dashboard';

  @override
  String get budgetTripLengthDays => 'Trip length (days)';

  @override
  String get budgetTripTitle => 'Trip budget';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonOk => 'OK';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonRename => 'Rename';

  @override
  String get commonSave => 'Save';

  @override
  String get countryPickerTitle => 'Select country';

  @override
  String get cryptoHeader => 'CRYPTO';

  @override
  String get cryptoPickerTitle => 'Pick a coin';

  @override
  String get currencyPickerSearchHint => 'Search ticker or name';

  @override
  String get currencyPickerTitle => 'Pick a currency';

  @override
  String get exchangeBaseSuffix => ' · Base';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'Could not load rates\n$error';
  }

  @override
  String get exchangeHeader => 'EXCHANGE';

  @override
  String exchangeLastUpdated(String mins) {
    return 'Last updated $mins min ago';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'Last updated $mins min ago (Offline)';
  }

  @override
  String get exchangeResetOne => 'Reset to 1 (USD base)';

  @override
  String get exchangeResetTooltip => 'Reset amounts';

  @override
  String get exchangeResetZero => 'Clear to 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'Day $day: $date';
  }

  @override
  String get itineraryEmpty =>
      'No events yet.\nTap + to add flights, hotels, and plans.';

  @override
  String get itineraryHeader => 'ITINERARY';

  @override
  String itineraryHiveError(String error) {
    return 'Could not open saved itinerary data.\nYou can still try adding events — they may not persist.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'Open on map';

  @override
  String get mapAddToTrip => 'Add to trip';

  @override
  String get mapClearRoute => 'Clear route & guidance';

  @override
  String get mapClearTooltip => 'Clear';

  @override
  String get mapDisplayCurrentViewport => 'Current viewport';

  @override
  String get mapDisplaySavedSearch => 'Saved search';

  @override
  String get mapDisplayTripDestination => 'Trip destination';

  @override
  String get mapDownloadAll => 'Download all';

  @override
  String get mapDownloadCurrentRegion =>
      'Download Current Region for Offline Use';

  @override
  String get mapDownloadThisDestination => 'Download this destination';

  @override
  String get mapDownloadedRegions => 'Downloaded regions';

  @override
  String get mapDownloadingRegion => 'Downloading region...';

  @override
  String mapDownloadingTitle(String title) {
    return 'Downloading $title...';
  }

  @override
  String get mapFromItinerary => 'From your itinerary';

  @override
  String get mapItineraryEmptyHint =>
      'Add itinerary destinations to pre-download them here.';

  @override
  String get mapLoadingRegions => 'Loading offline regions…';

  @override
  String mapLocatingQuery(String query) {
    return 'Locating $query...';
  }

  @override
  String get mapMarkCategoryBody => 'Choose how to label this offline pin.';

  @override
  String get mapMarkCategoryTitle => 'Category for this mark';

  @override
  String get mapMarkFood => 'Food';

  @override
  String get mapMarkHotel => 'Hotel';

  @override
  String get mapMarkLandmark => 'Landmark';

  @override
  String get mapMarkOther => 'Other';

  @override
  String mapNextInstruction(String current, String total) {
    return 'Next instruction ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'No location set';

  @override
  String get mapNoRegionsYet => 'You haven\'t downloaded any regions yet.';

  @override
  String get mapOfflineIntro =>
      'Save the currently visible region, or pre-download your trip destinations so you can navigate when you\'re off-grid.';

  @override
  String get mapOfflineMapsTitle => 'Offline maps';

  @override
  String get mapRefreshTooltip => 'Refresh';

  @override
  String get mapRemovePinTooltip => 'Remove pin';

  @override
  String get mapSaveOffline => 'Save offline';

  @override
  String get mapSavePinToMap => 'Save pin to map';

  @override
  String get mapSavedPinsBody =>
      'Pins you saved from search. Tap delete to remove one from the map.';

  @override
  String get mapSavedPinsTitle => 'Saved map pins';

  @override
  String get mapSearchHint => 'Search a city, address, or landmark…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title added to your offline marks.';
  }

  @override
  String get mapSnackArrived => 'You have arrived.';

  @override
  String mapSnackCouldNotFind(String query) {
    return 'Could not find \"$query\".';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String mapSnackDownloadFailed(Object error) {
    return 'Offline download failed: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return 'Downloaded \"$title\".';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\" has no location set.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'Finished downloading $count itinerary region(s).';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'Could not load offline regions: $error';
  }

  @override
  String get mapSnackLocationOff =>
      'Location service is off. Enable it to start navigation.';

  @override
  String get mapSnackLocationPermission =>
      'Location permission is required for turn-by-turn.';

  @override
  String get mapSnackMapNotReady =>
      'Map is not ready yet. Please wait a moment.';

  @override
  String get mapSnackNavStartFail => 'Unable to start navigation right now.';

  @override
  String get mapSnackNavStopped => 'Navigation stopped.';

  @override
  String get mapSnackNoItineraryLocations =>
      'No itinerary events have a location or map point to download.';

  @override
  String get mapSnackNoManeuver => 'This step has no precise maneuver point.';

  @override
  String get mapSnackNoRoute => 'Could not find a route; showing destination.';

  @override
  String get mapSnackRegionDownloaded =>
      'Region downloaded successfully! You can now navigate offline.';

  @override
  String get mapSnackRemovedPin => 'Removed saved pin.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'Removed offline region \"$name\".';
  }

  @override
  String get mapSnackRouteCleared => 'Route and guidance cleared.';

  @override
  String mapSnackSearchFailed(String error) {
    return 'Search failed: $error';
  }

  @override
  String get mapStartNavigation => 'Start Navigation';

  @override
  String get mapStartingNav => 'Starting navigation...';

  @override
  String get mapStopNavigation => 'Stop Navigation';

  @override
  String get mapTravelDriving => 'Driving';

  @override
  String get mapTravelWalking => 'Walking';

  @override
  String mapTurnByTurn(String mode) {
    return 'Turn-by-turn ($mode)';
  }

  @override
  String get mindMapCaptureFail => 'Could not capture the mind map. Try again.';

  @override
  String get mindMapClearBody =>
      'This removes all nodes and restores the demo mind map (centered example).';

  @override
  String get mindMapClearTitle => 'Clear canvas?';

  @override
  String get mindMapClearTooltip => 'Clear / Reset';

  @override
  String mindMapCouldNotSave(String error) {
    return 'Could not save: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'Could not save: $type';
  }

  @override
  String get mindMapEmailShare => 'Email / Share';

  @override
  String get mindMapHelpHint =>
      'Pinch to zoom · drag canvas · drag cards · tap a card to edit · + adds a child';

  @override
  String get mindMapNodeAddLeftTooltip => 'Add left child';

  @override
  String get mindMapNodeAddRightTooltip => 'Add right child';

  @override
  String get mindMapNodeDeleteTooltip => 'Delete node';

  @override
  String get mindMapNodeEditTitle => 'Edit node';

  @override
  String get mindMapNodeHint => 'Enter a short label';

  @override
  String get mindMapPhotoAccess =>
      'Photo library access is required to save the image.';

  @override
  String get mindMapReset => 'Reset';

  @override
  String get mindMapSavePhoto => 'Save as photo';

  @override
  String get mindMapSavedPhotos => 'Saved to Photos';

  @override
  String get mindMapShareCaptureFail =>
      'Could not capture the mind map for sharing.';

  @override
  String get mindMapShareCompleted => 'Share completed';

  @override
  String mindMapShareFailed(String error) {
    return 'Share failed: $error';
  }

  @override
  String get mindMapShareReady => 'Image ready — pick an app to share';

  @override
  String get mindMapShareSheetClosed => 'Share sheet closed';

  @override
  String get moreToolsHeader => 'MORE TOOLS';

  @override
  String get moreToolsSubtitle => 'Travel utilities';

  @override
  String get navCurrency => 'Currency';

  @override
  String get navItinerary => 'Itinerary';

  @override
  String get navMoreTools => 'More tools';

  @override
  String get navOfflineMap => 'Offline Map';

  @override
  String get packingCatClothing => 'CLOTHING';

  @override
  String get packingCatDocuments => 'DOCUMENTS';

  @override
  String get packingCatMedications => 'MEDICATIONS';

  @override
  String get packingCatMisc => 'MISC';

  @override
  String get packingCatReservations => 'RESERVATIONS';

  @override
  String get packingEmpty => 'Your list is empty.\nTap + to add items.';

  @override
  String get packingEmptyHidden =>
      'Nothing left to pack — or turn off \"Hide completed\" to see done items.';

  @override
  String get packingHeader => 'PACKING & LOGISTICS';

  @override
  String get packingHideCompleted => 'Hide completed';

  @override
  String get packingHideCompletedSubtitle =>
      'Completed items stay saved; only hidden from this view';

  @override
  String get packingStarterPassport => 'Passport';

  @override
  String get packingStarterShirts => 'Shirts';

  @override
  String get packingStarterSocks => 'Socks';

  @override
  String get packingStarterTickets => 'Flight tickets';

  @override
  String get packingStarterToothbrush => 'Toothbrush';

  @override
  String get presentationDeleteBody =>
      'Are you sure you want to remove this document from the vault?';

  @override
  String get presentationDeleteTitle => 'Delete Document?';

  @override
  String get proActive => 'Active';

  @override
  String get proManageHintFree =>
      'Unlock Pro features with a monthly subscription.';

  @override
  String get proManageHintPro =>
      'Manage your subscription or restore purchases.';

  @override
  String get proManageSubscription => 'Manage subscription';

  @override
  String get proName => 'Tripmetic Pro';

  @override
  String get proPaywallError =>
      'Paywall could not be shown. Check your RevenueCat offering.';

  @override
  String proRestoreFailed(String message) {
    return 'Restore failed: $message';
  }

  @override
  String get proTrialCta => 'Start Your 3-Day Free Trial';

  @override
  String get proWelcome => 'Welcome to Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'Good';

  @override
  String get schedulerAvailabilityOffHours => 'Off-hours';

  @override
  String get schedulerAvailabilityOk => 'OK';

  @override
  String get schedulerBaseLocation => 'Base location';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'Date, time, and slider apply to the base clock ($zone). Each city row shows the same instant in that zone.';
  }

  @override
  String get schedulerConvertedCities => 'Converted cities';

  @override
  String get schedulerDayNext => '+1 Day';

  @override
  String get schedulerDayPrevious => '-1 Day';

  @override
  String get schedulerDaySame => 'Same Day';

  @override
  String get schedulerMeetingTime => 'Meeting time';

  @override
  String get schedulerSubtitle => 'Meeting overlap';

  @override
  String get schedulerTitle => 'Global scheduler';

  @override
  String get settingsAndInfo => 'Settings & info';

  @override
  String get settingsContact => 'Contact us';

  @override
  String get settingsCopyright => '© 2026 TRIPMETIC.app';

  @override
  String get settingsCouldNotOpenLink => 'Could not open link';

  @override
  String get settingsHelpFaq => 'Help & FAQ';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsSupportLegal => 'Support & legal';

  @override
  String get settingsTerms => 'Terms of use';

  @override
  String get sizeCatBelts => 'Belts';

  @override
  String get sizeCatMensJeansCombo => 'Men\'s jeans — W×L (US)';

  @override
  String get sizeCatMensJeansInseam => 'Men\'s jeans — inseam (L)';

  @override
  String get sizeCatMensJeansWaist => 'Men\'s jeans — waist (W)';

  @override
  String get sizeCatMensPants => 'Men\'s Pants';

  @override
  String get sizeCatMensShirts => 'Men\'s Shirts';

  @override
  String get sizeCatMensShoes => 'Men\'s Shoes';

  @override
  String get sizeCatMensTshirts => 'Men\'s T-shirts';

  @override
  String get sizeCatWomensBlouses => 'Women\'s Blouses';

  @override
  String get sizeCatWomensDresses => 'Women\'s Dresses';

  @override
  String get sizeCatWomensPants => 'Women\'s Pants';

  @override
  String get sizeCatWomensShoes => 'Women\'s Shoes';

  @override
  String get sizeCatWomensTshirts => 'Women\'s T-shirts';

  @override
  String get sizeConverterAppBarSubtitle => 'Clothing & shoes';

  @override
  String get sizeConverterCategory => 'Category';

  @override
  String get sizeConverterHeader => 'CLOTHING & SHOES';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · tap to change';
  }

  @override
  String get sizeConverterYourBaseSize => 'Your base size (on the tag)';

  @override
  String get sizeConverterYourCountry => 'Your country / region';

  @override
  String get sizeTipJeansCombo =>
      'Example US 38×32: waist ≈ EU 48, JP waist tag often ~96–97 cm; inseam 32\" ≈ ~81 cm. Brands differ — use this as a starting point.';

  @override
  String get sizeTipJeansInseam =>
      'Inseam is the inside-leg length in inches (e.g. 32). Japan may show ~81 cm for a 32\" inseam. Type 38×32 — we use 32 for inseam.';

  @override
  String get sizeTipJeansWaist =>
      'One number on an Asian tag is often waist: either centimeters (38\" ≈ 96–97 cm) or US waist inches (38). Compare to a tape measure. You can type 38×32 here — we use 38 for waist.';

  @override
  String get timezonePickerEmpty => 'No matches';

  @override
  String get timezonePickerHint => 'Search IANA name (e.g. Europe, Tokyo)';

  @override
  String get timezonePickerTitle => 'Pick a timezone';

  @override
  String get tipAmount => 'Tip amount';

  @override
  String get tipAppBarSubtitle => 'Tip & bill';

  @override
  String get tipBillHint => 'e.g. \$1,250,000.00';

  @override
  String get tipCountryBrazil => 'Brazil';

  @override
  String get tipCountryChina => 'China';

  @override
  String get tipCountryColombia => 'Colombia';

  @override
  String get tipCountryDominicanRepublic => 'Dominican Republic';

  @override
  String get tipCountryEgypt => 'Egypt';

  @override
  String get tipCountryMexico => 'Mexico';

  @override
  String get tipCountrySpain => 'Spain';

  @override
  String get tipCountryThailand => 'Thailand';

  @override
  String get tipCountryUsa => 'United States';

  @override
  String get tipCurrentCountry => 'Current country';

  @override
  String get tipPeople => 'People';

  @override
  String get tipPerPerson => 'Amount per person';

  @override
  String get tipPercentHint => 'Type tip % (e.g. 15 or 27.5)';

  @override
  String get tipPercentLabel => 'Tip %';

  @override
  String get tipResults => 'RESULTS';

  @override
  String get tipSmartHeader => 'SMART TIP';

  @override
  String get tipTotalBill => 'Total bill amount';

  @override
  String get tipTotalWithTip => 'Total with tip';

  @override
  String get toolBrainstorm => 'Brainstorm';

  @override
  String get toolBudget => 'Budget';

  @override
  String get toolBudgetSubtitle => 'Trip budget planning and expense tracking';

  @override
  String get toolBudgetTitle => 'Budget';

  @override
  String get toolCrypto => 'Crypto';

  @override
  String get toolCryptoSubtitle => 'USD values across popular coins';

  @override
  String get toolCryptoTitle => 'Crypto';

  @override
  String get toolDocumentVault => 'Document Vault';

  @override
  String get toolMindMapSubtitle => 'Ideas on an infinite canvas · offline';

  @override
  String get toolMindMapTitle => 'Brainstorming mind map';

  @override
  String get toolPacking => 'Packing';

  @override
  String get toolPackingSubtitle => 'Smart packing checklists by trip';

  @override
  String get toolPackingTitle => 'Packing';

  @override
  String get toolSchedulerSubtitle => 'Dual time zones · jet lag planning';

  @override
  String get toolSchedulerTitle => 'Time & date';

  @override
  String get toolSettingsAboutSubtitle =>
      'Announcements, help, privacy & terms';

  @override
  String get toolSettingsAboutTitle => 'Settings & about';

  @override
  String get toolSettingsInfo => 'Settings & info';

  @override
  String get toolSizeSubtitle => 'US · UK · EU · Japan (JP)';

  @override
  String get toolSizeTitle => 'Clothing Size Converter';

  @override
  String get toolTimeDate => 'Time & date';

  @override
  String get toolTipSubtitle => 'Country tip norms · split up to 20 people';

  @override
  String get toolTipTitle => 'Smart Tip & Bill Splitter';

  @override
  String get toolUnits => 'Units';

  @override
  String get toolUnitsSubtitle => 'Length, weight, temperature, volume';

  @override
  String get toolUnitsTitle => 'Units';

  @override
  String get toolVaultSubtitle => 'Offline storage for vital travel documents';

  @override
  String get toolVaultTitle => 'Document Vault';

  @override
  String get unitAcres => 'Acres';

  @override
  String get unitCategoryArea => 'Area';

  @override
  String get unitCategoryDistance => 'Distance';

  @override
  String get unitCategoryLength => 'Length';

  @override
  String get unitCategoryTemperature => 'Temperature';

  @override
  String get unitCategoryVolume => 'Volume';

  @override
  String get unitCategoryWeight => 'Weight';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get unitCentimeters => 'Centimeters';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitFeet => 'Feet';

  @override
  String get unitGrams => 'Grams';

  @override
  String get unitHectares => 'Hectares';

  @override
  String get unitInches => 'Inches';

  @override
  String get unitKilograms => 'Kilograms';

  @override
  String get unitKilometers => 'Kilometers';

  @override
  String get unitLiters => 'Liters';

  @override
  String get unitMeters => 'Meters';

  @override
  String get unitMiles => 'Miles';

  @override
  String get unitMilliliters => 'Milliliters';

  @override
  String get unitOunces => 'Ounces';

  @override
  String get unitPounds => 'Pounds';

  @override
  String get unitSquareCentimeters => 'Square centimeters';

  @override
  String get unitSquareFeet => 'Square feet';

  @override
  String get unitSquareInches => 'Square inches';

  @override
  String get unitSquareKilometers => 'Square kilometers';

  @override
  String get unitSquareMeters => 'Square meters';

  @override
  String get unitSquareYards => 'Square yards';

  @override
  String get unitUsFluidOunces => 'US Fluid Ounces';

  @override
  String get unitUsGallons => 'US Gallons';

  @override
  String get unitYards => 'Yards';

  @override
  String get unitsHeader => 'UNITS';

  @override
  String get vaultCategoryArrivalCard => 'Arrival Card';

  @override
  String get vaultCategoryHotelReservation => 'Hotel Reservation';

  @override
  String get vaultCategoryOther => 'Other';

  @override
  String get vaultCategoryPassportCopy => 'Passport Copy';

  @override
  String get vaultCategoryReturnFlight => 'Return Flight';

  @override
  String get vaultCategoryVisa => 'Visa';

  @override
  String get vaultDocumentTitle => 'Document';

  @override
  String get vaultIntro =>
      'Securely store vital travel documents for offline access and quick presentation at immigration.';

  @override
  String vaultProcessFailed(String error) {
    return 'Failed to process document: $error';
  }

  @override
  String get vaultVaultWord => 'vault';
}
