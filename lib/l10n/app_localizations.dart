import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @addItineraryEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get addItineraryEnterTitle;

  /// No description provided for @addItineraryFieldLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get addItineraryFieldLocation;

  /// No description provided for @addItineraryFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes / confirmation'**
  String get addItineraryFieldNotes;

  /// No description provided for @addItineraryFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get addItineraryFieldTitle;

  /// No description provided for @addItineraryHintLocation.
  ///
  /// In en, this message translates to:
  /// **'Airport, hotel address…'**
  String get addItineraryHintLocation;

  /// No description provided for @addItineraryHintNotes.
  ///
  /// In en, this message translates to:
  /// **'Record locator, links…'**
  String get addItineraryHintNotes;

  /// No description provided for @addItineraryHintTitle.
  ///
  /// In en, this message translates to:
  /// **'Flight to Lisbon'**
  String get addItineraryHintTitle;

  /// No description provided for @addItinerarySave.
  ///
  /// In en, this message translates to:
  /// **'Save event'**
  String get addItinerarySave;

  /// No description provided for @addItineraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add itinerary event'**
  String get addItineraryTitle;

  /// No description provided for @addPackingAddToList.
  ///
  /// In en, this message translates to:
  /// **'Add to list'**
  String get addPackingAddToList;

  /// No description provided for @addPackingEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter an item name'**
  String get addPackingEnterName;

  /// No description provided for @addPackingHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Power adapter'**
  String get addPackingHint;

  /// No description provided for @addPackingIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get addPackingIcon;

  /// No description provided for @addPackingQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get addPackingQuantity;

  /// No description provided for @addPackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Add packing item'**
  String get addPackingTitle;

  /// No description provided for @announcementsLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest updates'**
  String get announcementsLatest;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'TRIPMETIC.app'**
  String get appTitle;

  /// No description provided for @budgetBaseCurrency.
  ///
  /// In en, this message translates to:
  /// **'BASE CURRENCY'**
  String get budgetBaseCurrency;

  /// No description provided for @budgetCategoryDialogHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Souvenirs'**
  String get budgetCategoryDialogHint;

  /// No description provided for @budgetCategoryNameExists.
  ///
  /// In en, this message translates to:
  /// **'Name already exists'**
  String get budgetCategoryNameExists;

  /// No description provided for @budgetCategoryNameMax.
  ///
  /// In en, this message translates to:
  /// **'Max 40 characters'**
  String get budgetCategoryNameMax;

  /// No description provided for @budgetDailyFood.
  ///
  /// In en, this message translates to:
  /// **'Daily food'**
  String get budgetDailyFood;

  /// No description provided for @budgetDialogAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get budgetDialogAdd;

  /// No description provided for @budgetDialogNewCategory.
  ///
  /// In en, this message translates to:
  /// **'New expense category'**
  String get budgetDialogNewCategory;

  /// No description provided for @budgetDialogRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" and its amount?'**
  String budgetDialogRemoveBody(String name);

  /// No description provided for @budgetDialogRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove category'**
  String get budgetDialogRemoveTitle;

  /// No description provided for @budgetDialogRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get budgetDialogRename;

  /// No description provided for @budgetDialogRenameCategory.
  ///
  /// In en, this message translates to:
  /// **'Rename category'**
  String get budgetDialogRenameCategory;

  /// No description provided for @budgetEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit budget'**
  String get budgetEdit;

  /// No description provided for @budgetExpenseDailyFood.
  ///
  /// In en, this message translates to:
  /// **'Daily Food'**
  String get budgetExpenseDailyFood;

  /// No description provided for @budgetExpenseEatingOut.
  ///
  /// In en, this message translates to:
  /// **'Eating Out'**
  String get budgetExpenseEatingOut;

  /// No description provided for @budgetExpenseEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get budgetExpenseEntertainment;

  /// No description provided for @budgetExpenseFlights.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get budgetExpenseFlights;

  /// No description provided for @budgetExpenseGrocery.
  ///
  /// In en, this message translates to:
  /// **'Grocery'**
  String get budgetExpenseGrocery;

  /// No description provided for @budgetExpenseHotels.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get budgetExpenseHotels;

  /// No description provided for @budgetExpenseMisc.
  ///
  /// In en, this message translates to:
  /// **'Misc'**
  String get budgetExpenseMisc;

  /// No description provided for @budgetExpensePhoneService.
  ///
  /// In en, this message translates to:
  /// **'Phone Service'**
  String get budgetExpensePhoneService;

  /// No description provided for @budgetExpenseShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get budgetExpenseShopping;

  /// No description provided for @budgetExpenseTourism.
  ///
  /// In en, this message translates to:
  /// **'Tourism'**
  String get budgetExpenseTourism;

  /// No description provided for @budgetExpenseTransportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get budgetExpenseTransportation;

  /// No description provided for @budgetExpenseTravelInsurance.
  ///
  /// In en, this message translates to:
  /// **'Travel Insurance'**
  String get budgetExpenseTravelInsurance;

  /// No description provided for @budgetInDestinations.
  ///
  /// In en, this message translates to:
  /// **'In your destinations'**
  String get budgetInDestinations;

  /// No description provided for @budgetNoCategories.
  ///
  /// In en, this message translates to:
  /// **'No expense categories yet'**
  String get budgetNoCategories;

  /// No description provided for @budgetOtherExpenses.
  ///
  /// In en, this message translates to:
  /// **'OTHER EXPENSES ({code})'**
  String budgetOtherExpenses(String code);

  /// No description provided for @budgetPerDayEstimate.
  ///
  /// In en, this message translates to:
  /// **'Per day (estimate)'**
  String get budgetPerDayEstimate;

  /// No description provided for @budgetPerDayValue.
  ///
  /// In en, this message translates to:
  /// **'≈ {amount} / day'**
  String budgetPerDayValue(String amount);

  /// No description provided for @budgetRemainingAfter.
  ///
  /// In en, this message translates to:
  /// **'Remaining after expenses · {code}'**
  String budgetRemainingAfter(String code);

  /// No description provided for @budgetSave.
  ///
  /// In en, this message translates to:
  /// **'Save budget'**
  String get budgetSave;

  /// No description provided for @budgetSpendingPower.
  ///
  /// In en, this message translates to:
  /// **'Spending power'**
  String get budgetSpendingPower;

  /// No description provided for @budgetSpentVsBudget.
  ///
  /// In en, this message translates to:
  /// **'Spent vs budget'**
  String get budgetSpentVsBudget;

  /// No description provided for @budgetTotalBudget.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BUDGET ({code})'**
  String budgetTotalBudget(String code);

  /// No description provided for @budgetTotalForTrip.
  ///
  /// In en, this message translates to:
  /// **'Total for trip ({code})'**
  String budgetTotalForTrip(Object code);

  /// No description provided for @budgetTripDashboard.
  ///
  /// In en, this message translates to:
  /// **'dashboard'**
  String get budgetTripDashboard;

  /// No description provided for @budgetTripLengthDays.
  ///
  /// In en, this message translates to:
  /// **'Trip length (days)'**
  String get budgetTripLengthDays;

  /// No description provided for @budgetTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip budget'**
  String get budgetTripTitle;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get commonRename;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @countryPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get countryPickerTitle;

  /// No description provided for @cryptoHeader.
  ///
  /// In en, this message translates to:
  /// **'CRYPTO'**
  String get cryptoHeader;

  /// No description provided for @cryptoPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a coin'**
  String get cryptoPickerTitle;

  /// No description provided for @currencyPickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ticker or name'**
  String get currencyPickerSearchHint;

  /// No description provided for @currencyPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a currency'**
  String get currencyPickerTitle;

  /// No description provided for @exchangeBaseSuffix.
  ///
  /// In en, this message translates to:
  /// **' · Base'**
  String get exchangeBaseSuffix;

  /// No description provided for @exchangeCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load rates\n{error}'**
  String exchangeCouldNotLoad(String error);

  /// No description provided for @exchangeHeader.
  ///
  /// In en, this message translates to:
  /// **'EXCHANGE'**
  String get exchangeHeader;

  /// No description provided for @exchangeLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated {mins} min ago'**
  String exchangeLastUpdated(String mins);

  /// No description provided for @exchangeLastUpdatedOffline.
  ///
  /// In en, this message translates to:
  /// **'Last updated {mins} min ago (Offline)'**
  String exchangeLastUpdatedOffline(String mins);

  /// No description provided for @exchangeResetOne.
  ///
  /// In en, this message translates to:
  /// **'Reset to 1 (USD base)'**
  String get exchangeResetOne;

  /// No description provided for @exchangeResetTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset amounts'**
  String get exchangeResetTooltip;

  /// No description provided for @exchangeResetZero.
  ///
  /// In en, this message translates to:
  /// **'Clear to 0'**
  String get exchangeResetZero;

  /// No description provided for @itineraryDayPrefix.
  ///
  /// In en, this message translates to:
  /// **'Day {day}: {date}'**
  String itineraryDayPrefix(String day, String date);

  /// No description provided for @itineraryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No events yet.\nTap + to add flights, hotels, and plans.'**
  String get itineraryEmpty;

  /// No description provided for @itineraryHeader.
  ///
  /// In en, this message translates to:
  /// **'ITINERARY'**
  String get itineraryHeader;

  /// No description provided for @itineraryHiveError.
  ///
  /// In en, this message translates to:
  /// **'Could not open saved itinerary data.\nYou can still try adding events — they may not persist.\n({error})'**
  String itineraryHiveError(String error);

  /// No description provided for @itineraryOpenOnMap.
  ///
  /// In en, this message translates to:
  /// **'Open on map'**
  String get itineraryOpenOnMap;

  /// No description provided for @mapAddToTrip.
  ///
  /// In en, this message translates to:
  /// **'Add to trip'**
  String get mapAddToTrip;

  /// No description provided for @mapClearRoute.
  ///
  /// In en, this message translates to:
  /// **'Clear route & guidance'**
  String get mapClearRoute;

  /// No description provided for @mapClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get mapClearTooltip;

  /// No description provided for @mapDisplayCurrentViewport.
  ///
  /// In en, this message translates to:
  /// **'Current viewport'**
  String get mapDisplayCurrentViewport;

  /// No description provided for @mapDisplaySavedSearch.
  ///
  /// In en, this message translates to:
  /// **'Saved search'**
  String get mapDisplaySavedSearch;

  /// No description provided for @mapDisplayTripDestination.
  ///
  /// In en, this message translates to:
  /// **'Trip destination'**
  String get mapDisplayTripDestination;

  /// No description provided for @mapDownloadAll.
  ///
  /// In en, this message translates to:
  /// **'Download all'**
  String get mapDownloadAll;

  /// No description provided for @mapDownloadCurrentRegion.
  ///
  /// In en, this message translates to:
  /// **'Download Current Region for Offline Use'**
  String get mapDownloadCurrentRegion;

  /// No description provided for @mapDownloadThisDestination.
  ///
  /// In en, this message translates to:
  /// **'Download this destination'**
  String get mapDownloadThisDestination;

  /// No description provided for @mapDownloadedRegions.
  ///
  /// In en, this message translates to:
  /// **'Downloaded regions'**
  String get mapDownloadedRegions;

  /// No description provided for @mapDownloadingRegion.
  ///
  /// In en, this message translates to:
  /// **'Downloading region...'**
  String get mapDownloadingRegion;

  /// No description provided for @mapDownloadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Downloading {title}...'**
  String mapDownloadingTitle(String title);

  /// No description provided for @mapFromItinerary.
  ///
  /// In en, this message translates to:
  /// **'From your itinerary'**
  String get mapFromItinerary;

  /// No description provided for @mapItineraryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add itinerary destinations to pre-download them here.'**
  String get mapItineraryEmptyHint;

  /// No description provided for @mapLoadingRegions.
  ///
  /// In en, this message translates to:
  /// **'Loading offline regions…'**
  String get mapLoadingRegions;

  /// No description provided for @mapLocatingQuery.
  ///
  /// In en, this message translates to:
  /// **'Locating {query}...'**
  String mapLocatingQuery(String query);

  /// No description provided for @mapMarkCategoryBody.
  ///
  /// In en, this message translates to:
  /// **'Choose how to label this offline pin.'**
  String get mapMarkCategoryBody;

  /// No description provided for @mapMarkCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Category for this mark'**
  String get mapMarkCategoryTitle;

  /// No description provided for @mapMarkFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get mapMarkFood;

  /// No description provided for @mapMarkHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get mapMarkHotel;

  /// No description provided for @mapMarkLandmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get mapMarkLandmark;

  /// No description provided for @mapMarkOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get mapMarkOther;

  /// No description provided for @mapNextInstruction.
  ///
  /// In en, this message translates to:
  /// **'Next instruction ({current}/{total})'**
  String mapNextInstruction(String current, String total);

  /// No description provided for @mapNoLocationSet.
  ///
  /// In en, this message translates to:
  /// **'No location set'**
  String get mapNoLocationSet;

  /// No description provided for @mapNoRegionsYet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t downloaded any regions yet.'**
  String get mapNoRegionsYet;

  /// No description provided for @mapOfflineIntro.
  ///
  /// In en, this message translates to:
  /// **'Save the currently visible region, or pre-download your trip destinations so you can navigate when you\'re off-grid.'**
  String get mapOfflineIntro;

  /// No description provided for @mapOfflineMapsTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline maps'**
  String get mapOfflineMapsTitle;

  /// No description provided for @mapRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get mapRefreshTooltip;

  /// No description provided for @mapRemovePinTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove pin'**
  String get mapRemovePinTooltip;

  /// No description provided for @mapSaveOffline.
  ///
  /// In en, this message translates to:
  /// **'Save offline'**
  String get mapSaveOffline;

  /// No description provided for @mapSavePinToMap.
  ///
  /// In en, this message translates to:
  /// **'Save pin to map'**
  String get mapSavePinToMap;

  /// No description provided for @mapSavedPinsBody.
  ///
  /// In en, this message translates to:
  /// **'Pins you saved from search. Tap delete to remove one from the map.'**
  String get mapSavedPinsBody;

  /// No description provided for @mapSavedPinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved map pins'**
  String get mapSavedPinsTitle;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search a city, address, or landmark…'**
  String get mapSearchHint;

  /// No description provided for @mapSnackAddedOfflineMark.
  ///
  /// In en, this message translates to:
  /// **'{title} added to your offline marks.'**
  String mapSnackAddedOfflineMark(String title);

  /// No description provided for @mapSnackArrived.
  ///
  /// In en, this message translates to:
  /// **'You have arrived.'**
  String get mapSnackArrived;

  /// No description provided for @mapSnackCouldNotFind.
  ///
  /// In en, this message translates to:
  /// **'Could not find \"{query}\".'**
  String mapSnackCouldNotFind(String query);

  /// No description provided for @mapSnackDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String mapSnackDeleteFailed(String error);

  /// No description provided for @mapSnackDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Offline download failed: {error}'**
  String mapSnackDownloadFailed(Object error);

  /// No description provided for @mapSnackDownloadedEvent.
  ///
  /// In en, this message translates to:
  /// **'Downloaded \"{title}\".'**
  String mapSnackDownloadedEvent(String title);

  /// No description provided for @mapSnackEventNoLocation.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" has no location set.'**
  String mapSnackEventNoLocation(String title);

  /// No description provided for @mapSnackFinishedBatch.
  ///
  /// In en, this message translates to:
  /// **'Finished downloading {count} itinerary region(s).'**
  String mapSnackFinishedBatch(String count);

  /// No description provided for @mapSnackLoadRegionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load offline regions: {error}'**
  String mapSnackLoadRegionsFailed(String error);

  /// No description provided for @mapSnackLocationOff.
  ///
  /// In en, this message translates to:
  /// **'Location service is off. Enable it to start navigation.'**
  String get mapSnackLocationOff;

  /// No description provided for @mapSnackLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required for turn-by-turn.'**
  String get mapSnackLocationPermission;

  /// No description provided for @mapSnackMapNotReady.
  ///
  /// In en, this message translates to:
  /// **'Map is not ready yet. Please wait a moment.'**
  String get mapSnackMapNotReady;

  /// No description provided for @mapSnackNavStartFail.
  ///
  /// In en, this message translates to:
  /// **'Unable to start navigation right now.'**
  String get mapSnackNavStartFail;

  /// No description provided for @mapSnackNavStopped.
  ///
  /// In en, this message translates to:
  /// **'Navigation stopped.'**
  String get mapSnackNavStopped;

  /// No description provided for @mapSnackNoItineraryLocations.
  ///
  /// In en, this message translates to:
  /// **'No itinerary events have a location or map point to download.'**
  String get mapSnackNoItineraryLocations;

  /// No description provided for @mapSnackNoManeuver.
  ///
  /// In en, this message translates to:
  /// **'This step has no precise maneuver point.'**
  String get mapSnackNoManeuver;

  /// No description provided for @mapSnackNoRoute.
  ///
  /// In en, this message translates to:
  /// **'Could not find a route; showing destination.'**
  String get mapSnackNoRoute;

  /// No description provided for @mapSnackRegionDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Region downloaded successfully! You can now navigate offline.'**
  String get mapSnackRegionDownloaded;

  /// No description provided for @mapSnackRemovedPin.
  ///
  /// In en, this message translates to:
  /// **'Removed saved pin.'**
  String get mapSnackRemovedPin;

  /// No description provided for @mapSnackRemovedRegion.
  ///
  /// In en, this message translates to:
  /// **'Removed offline region \"{name}\".'**
  String mapSnackRemovedRegion(String name);

  /// No description provided for @mapSnackRouteCleared.
  ///
  /// In en, this message translates to:
  /// **'Route and guidance cleared.'**
  String get mapSnackRouteCleared;

  /// No description provided for @mapSnackSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed: {error}'**
  String mapSnackSearchFailed(String error);

  /// No description provided for @mapStartNavigation.
  ///
  /// In en, this message translates to:
  /// **'Start Navigation'**
  String get mapStartNavigation;

  /// No description provided for @mapStartingNav.
  ///
  /// In en, this message translates to:
  /// **'Starting navigation...'**
  String get mapStartingNav;

  /// No description provided for @mapStopNavigation.
  ///
  /// In en, this message translates to:
  /// **'Stop Navigation'**
  String get mapStopNavigation;

  /// No description provided for @mapTravelDriving.
  ///
  /// In en, this message translates to:
  /// **'Driving'**
  String get mapTravelDriving;

  /// No description provided for @mapTravelWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get mapTravelWalking;

  /// No description provided for @mapTurnByTurn.
  ///
  /// In en, this message translates to:
  /// **'Turn-by-turn ({mode})'**
  String mapTurnByTurn(String mode);

  /// No description provided for @mindMapCaptureFail.
  ///
  /// In en, this message translates to:
  /// **'Could not capture the mind map. Try again.'**
  String get mindMapCaptureFail;

  /// No description provided for @mindMapClearBody.
  ///
  /// In en, this message translates to:
  /// **'This removes all nodes and restores the demo mind map (centered example).'**
  String get mindMapClearBody;

  /// No description provided for @mindMapClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear canvas?'**
  String get mindMapClearTitle;

  /// No description provided for @mindMapClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear / Reset'**
  String get mindMapClearTooltip;

  /// No description provided for @mindMapCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {error}'**
  String mindMapCouldNotSave(String error);

  /// No description provided for @mindMapCouldNotSaveType.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {type}'**
  String mindMapCouldNotSaveType(String type);

  /// No description provided for @mindMapEmailShare.
  ///
  /// In en, this message translates to:
  /// **'Email / Share'**
  String get mindMapEmailShare;

  /// No description provided for @mindMapHelpHint.
  ///
  /// In en, this message translates to:
  /// **'Pinch to zoom · drag canvas · drag cards · tap a card to edit · + adds a child'**
  String get mindMapHelpHint;

  /// No description provided for @mindMapNodeAddLeftTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add left child'**
  String get mindMapNodeAddLeftTooltip;

  /// No description provided for @mindMapNodeAddRightTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add right child'**
  String get mindMapNodeAddRightTooltip;

  /// No description provided for @mindMapNodeDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete node'**
  String get mindMapNodeDeleteTooltip;

  /// No description provided for @mindMapNodeEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit node'**
  String get mindMapNodeEditTitle;

  /// No description provided for @mindMapNodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a short label'**
  String get mindMapNodeHint;

  /// No description provided for @mindMapPhotoAccess.
  ///
  /// In en, this message translates to:
  /// **'Photo library access is required to save the image.'**
  String get mindMapPhotoAccess;

  /// No description provided for @mindMapReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get mindMapReset;

  /// No description provided for @mindMapSavePhoto.
  ///
  /// In en, this message translates to:
  /// **'Save as photo'**
  String get mindMapSavePhoto;

  /// No description provided for @mindMapSavedPhotos.
  ///
  /// In en, this message translates to:
  /// **'Saved to Photos'**
  String get mindMapSavedPhotos;

  /// No description provided for @mindMapShareCaptureFail.
  ///
  /// In en, this message translates to:
  /// **'Could not capture the mind map for sharing.'**
  String get mindMapShareCaptureFail;

  /// No description provided for @mindMapShareCompleted.
  ///
  /// In en, this message translates to:
  /// **'Share completed'**
  String get mindMapShareCompleted;

  /// No description provided for @mindMapShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Share failed: {error}'**
  String mindMapShareFailed(String error);

  /// No description provided for @mindMapShareReady.
  ///
  /// In en, this message translates to:
  /// **'Image ready — pick an app to share'**
  String get mindMapShareReady;

  /// No description provided for @mindMapShareSheetClosed.
  ///
  /// In en, this message translates to:
  /// **'Share sheet closed'**
  String get mindMapShareSheetClosed;

  /// No description provided for @moreToolsHeader.
  ///
  /// In en, this message translates to:
  /// **'MORE TOOLS'**
  String get moreToolsHeader;

  /// No description provided for @moreToolsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Travel utilities'**
  String get moreToolsSubtitle;

  /// No description provided for @navCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get navCurrency;

  /// No description provided for @navItinerary.
  ///
  /// In en, this message translates to:
  /// **'Itinerary'**
  String get navItinerary;

  /// No description provided for @navMoreTools.
  ///
  /// In en, this message translates to:
  /// **'More tools'**
  String get navMoreTools;

  /// No description provided for @navOfflineMap.
  ///
  /// In en, this message translates to:
  /// **'Offline Map'**
  String get navOfflineMap;

  /// No description provided for @packingCatClothing.
  ///
  /// In en, this message translates to:
  /// **'CLOTHING'**
  String get packingCatClothing;

  /// No description provided for @packingCatDocuments.
  ///
  /// In en, this message translates to:
  /// **'DOCUMENTS'**
  String get packingCatDocuments;

  /// No description provided for @packingCatMedications.
  ///
  /// In en, this message translates to:
  /// **'MEDICATIONS'**
  String get packingCatMedications;

  /// No description provided for @packingCatMisc.
  ///
  /// In en, this message translates to:
  /// **'MISC'**
  String get packingCatMisc;

  /// No description provided for @packingCatReservations.
  ///
  /// In en, this message translates to:
  /// **'RESERVATIONS'**
  String get packingCatReservations;

  /// No description provided for @packingEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your list is empty.\nTap + to add items.'**
  String get packingEmpty;

  /// No description provided for @packingEmptyHidden.
  ///
  /// In en, this message translates to:
  /// **'Nothing left to pack — or turn off \"Hide completed\" to see done items.'**
  String get packingEmptyHidden;

  /// No description provided for @packingHeader.
  ///
  /// In en, this message translates to:
  /// **'PACKING & LOGISTICS'**
  String get packingHeader;

  /// No description provided for @packingHideCompleted.
  ///
  /// In en, this message translates to:
  /// **'Hide completed'**
  String get packingHideCompleted;

  /// No description provided for @packingHideCompletedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Completed items stay saved; only hidden from this view'**
  String get packingHideCompletedSubtitle;

  /// No description provided for @packingStarterPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get packingStarterPassport;

  /// No description provided for @packingStarterShirts.
  ///
  /// In en, this message translates to:
  /// **'Shirts'**
  String get packingStarterShirts;

  /// No description provided for @packingStarterSocks.
  ///
  /// In en, this message translates to:
  /// **'Socks'**
  String get packingStarterSocks;

  /// No description provided for @packingStarterTickets.
  ///
  /// In en, this message translates to:
  /// **'Flight tickets'**
  String get packingStarterTickets;

  /// No description provided for @packingStarterToothbrush.
  ///
  /// In en, this message translates to:
  /// **'Toothbrush'**
  String get packingStarterToothbrush;

  /// No description provided for @presentationDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this document from the vault?'**
  String get presentationDeleteBody;

  /// No description provided for @presentationDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Document?'**
  String get presentationDeleteTitle;

  /// No description provided for @proActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get proActive;

  /// No description provided for @proManageHintFree.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro features with a monthly subscription.'**
  String get proManageHintFree;

  /// No description provided for @proManageHintPro.
  ///
  /// In en, this message translates to:
  /// **'Manage your subscription or restore purchases.'**
  String get proManageHintPro;

  /// No description provided for @proManageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get proManageSubscription;

  /// No description provided for @proName.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic Pro'**
  String get proName;

  /// No description provided for @proPaywallError.
  ///
  /// In en, this message translates to:
  /// **'Paywall could not be shown. Check your RevenueCat offering.'**
  String get proPaywallError;

  /// No description provided for @proRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {message}'**
  String proRestoreFailed(String message);

  /// No description provided for @proTrialCta.
  ///
  /// In en, this message translates to:
  /// **'Start Your 3-Day Free Trial'**
  String get proTrialCta;

  /// No description provided for @proWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Tripmetic Pro'**
  String get proWelcome;

  /// No description provided for @schedulerAvailabilityGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get schedulerAvailabilityGood;

  /// No description provided for @schedulerAvailabilityOffHours.
  ///
  /// In en, this message translates to:
  /// **'Off-hours'**
  String get schedulerAvailabilityOffHours;

  /// No description provided for @schedulerAvailabilityOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get schedulerAvailabilityOk;

  /// No description provided for @schedulerBaseLocation.
  ///
  /// In en, this message translates to:
  /// **'Base location'**
  String get schedulerBaseLocation;

  /// No description provided for @schedulerBaseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Date, time, and slider apply to the base clock ({zone}). Each city row shows the same instant in that zone.'**
  String schedulerBaseTooltip(String zone);

  /// No description provided for @schedulerConvertedCities.
  ///
  /// In en, this message translates to:
  /// **'Converted cities'**
  String get schedulerConvertedCities;

  /// No description provided for @schedulerDayNext.
  ///
  /// In en, this message translates to:
  /// **'+1 Day'**
  String get schedulerDayNext;

  /// No description provided for @schedulerDayPrevious.
  ///
  /// In en, this message translates to:
  /// **'-1 Day'**
  String get schedulerDayPrevious;

  /// No description provided for @schedulerDaySame.
  ///
  /// In en, this message translates to:
  /// **'Same Day'**
  String get schedulerDaySame;

  /// No description provided for @schedulerMeetingTime.
  ///
  /// In en, this message translates to:
  /// **'Meeting time'**
  String get schedulerMeetingTime;

  /// No description provided for @schedulerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Meeting overlap'**
  String get schedulerSubtitle;

  /// No description provided for @schedulerTitle.
  ///
  /// In en, this message translates to:
  /// **'Global scheduler'**
  String get schedulerTitle;

  /// No description provided for @settingsAndInfo.
  ///
  /// In en, this message translates to:
  /// **'Settings & info'**
  String get settingsAndInfo;

  /// No description provided for @settingsContact.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get settingsContact;

  /// No description provided for @settingsCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 TRIPMETIC.app'**
  String get settingsCopyright;

  /// No description provided for @settingsCouldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get settingsCouldNotOpenLink;

  /// No description provided for @settingsHelpFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get settingsHelpFaq;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsSupportLegal.
  ///
  /// In en, this message translates to:
  /// **'Support & legal'**
  String get settingsSupportLegal;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTerms;

  /// No description provided for @sizeCatBelts.
  ///
  /// In en, this message translates to:
  /// **'Belts'**
  String get sizeCatBelts;

  /// No description provided for @sizeCatMensJeansCombo.
  ///
  /// In en, this message translates to:
  /// **'Men\'s jeans — W×L (US)'**
  String get sizeCatMensJeansCombo;

  /// No description provided for @sizeCatMensJeansInseam.
  ///
  /// In en, this message translates to:
  /// **'Men\'s jeans — inseam (L)'**
  String get sizeCatMensJeansInseam;

  /// No description provided for @sizeCatMensJeansWaist.
  ///
  /// In en, this message translates to:
  /// **'Men\'s jeans — waist (W)'**
  String get sizeCatMensJeansWaist;

  /// No description provided for @sizeCatMensPants.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Pants'**
  String get sizeCatMensPants;

  /// No description provided for @sizeCatMensShirts.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Shirts'**
  String get sizeCatMensShirts;

  /// No description provided for @sizeCatMensShoes.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Shoes'**
  String get sizeCatMensShoes;

  /// No description provided for @sizeCatMensTshirts.
  ///
  /// In en, this message translates to:
  /// **'Men\'s T-shirts'**
  String get sizeCatMensTshirts;

  /// No description provided for @sizeCatWomensBlouses.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Blouses'**
  String get sizeCatWomensBlouses;

  /// No description provided for @sizeCatWomensDresses.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Dresses'**
  String get sizeCatWomensDresses;

  /// No description provided for @sizeCatWomensPants.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Pants'**
  String get sizeCatWomensPants;

  /// No description provided for @sizeCatWomensShoes.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Shoes'**
  String get sizeCatWomensShoes;

  /// No description provided for @sizeCatWomensTshirts.
  ///
  /// In en, this message translates to:
  /// **'Women\'s T-shirts'**
  String get sizeCatWomensTshirts;

  /// No description provided for @sizeConverterAppBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clothing & shoes'**
  String get sizeConverterAppBarSubtitle;

  /// No description provided for @sizeConverterCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get sizeConverterCategory;

  /// No description provided for @sizeConverterHeader.
  ///
  /// In en, this message translates to:
  /// **'CLOTHING & SHOES'**
  String get sizeConverterHeader;

  /// No description provided for @sizeConverterTapToChange.
  ///
  /// In en, this message translates to:
  /// **'{code} · tap to change'**
  String sizeConverterTapToChange(String code);

  /// No description provided for @sizeConverterYourBaseSize.
  ///
  /// In en, this message translates to:
  /// **'Your base size (on the tag)'**
  String get sizeConverterYourBaseSize;

  /// No description provided for @sizeConverterYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Your country / region'**
  String get sizeConverterYourCountry;

  /// No description provided for @sizeTipJeansCombo.
  ///
  /// In en, this message translates to:
  /// **'Example US 38×32: waist ≈ EU 48, JP waist tag often ~96–97 cm; inseam 32\" ≈ ~81 cm. Brands differ — use this as a starting point.'**
  String get sizeTipJeansCombo;

  /// No description provided for @sizeTipJeansInseam.
  ///
  /// In en, this message translates to:
  /// **'Inseam is the inside-leg length in inches (e.g. 32). Japan may show ~81 cm for a 32\" inseam. Type 38×32 — we use 32 for inseam.'**
  String get sizeTipJeansInseam;

  /// No description provided for @sizeTipJeansWaist.
  ///
  /// In en, this message translates to:
  /// **'One number on an Asian tag is often waist: either centimeters (38\" ≈ 96–97 cm) or US waist inches (38). Compare to a tape measure. You can type 38×32 here — we use 38 for waist.'**
  String get sizeTipJeansWaist;

  /// No description provided for @timezonePickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get timezonePickerEmpty;

  /// No description provided for @timezonePickerHint.
  ///
  /// In en, this message translates to:
  /// **'Search IANA name (e.g. Europe, Tokyo)'**
  String get timezonePickerHint;

  /// No description provided for @timezonePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a timezone'**
  String get timezonePickerTitle;

  /// No description provided for @tipAmount.
  ///
  /// In en, this message translates to:
  /// **'Tip amount'**
  String get tipAmount;

  /// No description provided for @tipAppBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tip & bill'**
  String get tipAppBarSubtitle;

  /// No description provided for @tipBillHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. \$1,250,000.00'**
  String get tipBillHint;

  /// No description provided for @tipCountryBrazil.
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get tipCountryBrazil;

  /// No description provided for @tipCountryChina.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get tipCountryChina;

  /// No description provided for @tipCountryColombia.
  ///
  /// In en, this message translates to:
  /// **'Colombia'**
  String get tipCountryColombia;

  /// No description provided for @tipCountryDominicanRepublic.
  ///
  /// In en, this message translates to:
  /// **'Dominican Republic'**
  String get tipCountryDominicanRepublic;

  /// No description provided for @tipCountryEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get tipCountryEgypt;

  /// No description provided for @tipCountryMexico.
  ///
  /// In en, this message translates to:
  /// **'Mexico'**
  String get tipCountryMexico;

  /// No description provided for @tipCountrySpain.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get tipCountrySpain;

  /// No description provided for @tipCountryThailand.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get tipCountryThailand;

  /// No description provided for @tipCountryUsa.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get tipCountryUsa;

  /// No description provided for @tipCurrentCountry.
  ///
  /// In en, this message translates to:
  /// **'Current country'**
  String get tipCurrentCountry;

  /// No description provided for @tipPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get tipPeople;

  /// No description provided for @tipPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Amount per person'**
  String get tipPerPerson;

  /// No description provided for @tipPercentHint.
  ///
  /// In en, this message translates to:
  /// **'Type tip % (e.g. 15 or 27.5)'**
  String get tipPercentHint;

  /// No description provided for @tipPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Tip %'**
  String get tipPercentLabel;

  /// No description provided for @tipResults.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get tipResults;

  /// No description provided for @tipSmartHeader.
  ///
  /// In en, this message translates to:
  /// **'SMART TIP'**
  String get tipSmartHeader;

  /// No description provided for @tipTotalBill.
  ///
  /// In en, this message translates to:
  /// **'Total bill amount'**
  String get tipTotalBill;

  /// No description provided for @tipTotalWithTip.
  ///
  /// In en, this message translates to:
  /// **'Total with tip'**
  String get tipTotalWithTip;

  /// No description provided for @toolBrainstorm.
  ///
  /// In en, this message translates to:
  /// **'Brainstorm'**
  String get toolBrainstorm;

  /// No description provided for @toolBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get toolBudget;

  /// No description provided for @toolBudgetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Trip budget planning and expense tracking'**
  String get toolBudgetSubtitle;

  /// No description provided for @toolBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get toolBudgetTitle;

  /// No description provided for @toolCrypto.
  ///
  /// In en, this message translates to:
  /// **'Crypto'**
  String get toolCrypto;

  /// No description provided for @toolCryptoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'USD values across popular coins'**
  String get toolCryptoSubtitle;

  /// No description provided for @toolCryptoTitle.
  ///
  /// In en, this message translates to:
  /// **'Crypto'**
  String get toolCryptoTitle;

  /// No description provided for @toolDocumentVault.
  ///
  /// In en, this message translates to:
  /// **'Document Vault'**
  String get toolDocumentVault;

  /// No description provided for @toolMindMapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ideas on an infinite canvas · offline'**
  String get toolMindMapSubtitle;

  /// No description provided for @toolMindMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Brainstorming mind map'**
  String get toolMindMapTitle;

  /// No description provided for @toolPacking.
  ///
  /// In en, this message translates to:
  /// **'Packing'**
  String get toolPacking;

  /// No description provided for @toolPackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart packing checklists by trip'**
  String get toolPackingSubtitle;

  /// No description provided for @toolPackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Packing'**
  String get toolPackingTitle;

  /// No description provided for @toolSchedulerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dual time zones · jet lag planning'**
  String get toolSchedulerSubtitle;

  /// No description provided for @toolSchedulerTitle.
  ///
  /// In en, this message translates to:
  /// **'Time & date'**
  String get toolSchedulerTitle;

  /// No description provided for @toolSettingsAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Announcements, help, privacy & terms'**
  String get toolSettingsAboutSubtitle;

  /// No description provided for @toolSettingsAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & about'**
  String get toolSettingsAboutTitle;

  /// No description provided for @toolSettingsInfo.
  ///
  /// In en, this message translates to:
  /// **'Settings & info'**
  String get toolSettingsInfo;

  /// No description provided for @toolSizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'US · UK · EU · Japan (JP)'**
  String get toolSizeSubtitle;

  /// No description provided for @toolSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Clothing Size Converter'**
  String get toolSizeTitle;

  /// No description provided for @toolTimeDate.
  ///
  /// In en, this message translates to:
  /// **'Time & date'**
  String get toolTimeDate;

  /// No description provided for @toolTipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Country tip norms · split up to 20 people'**
  String get toolTipSubtitle;

  /// No description provided for @toolTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Tip & Bill Splitter'**
  String get toolTipTitle;

  /// No description provided for @toolUnits.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get toolUnits;

  /// No description provided for @toolUnitsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Length, weight, temperature, volume'**
  String get toolUnitsSubtitle;

  /// No description provided for @toolUnitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get toolUnitsTitle;

  /// No description provided for @toolVaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Offline storage for vital travel documents'**
  String get toolVaultSubtitle;

  /// No description provided for @toolVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Document Vault'**
  String get toolVaultTitle;

  /// No description provided for @unitAcres.
  ///
  /// In en, this message translates to:
  /// **'Acres'**
  String get unitAcres;

  /// No description provided for @unitCategoryArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get unitCategoryArea;

  /// No description provided for @unitCategoryDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get unitCategoryDistance;

  /// No description provided for @unitCategoryLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get unitCategoryLength;

  /// No description provided for @unitCategoryTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get unitCategoryTemperature;

  /// No description provided for @unitCategoryVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get unitCategoryVolume;

  /// No description provided for @unitCategoryWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get unitCategoryWeight;

  /// No description provided for @unitCelsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius'**
  String get unitCelsius;

  /// No description provided for @unitCentimeters.
  ///
  /// In en, this message translates to:
  /// **'Centimeters'**
  String get unitCentimeters;

  /// No description provided for @unitFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit'**
  String get unitFahrenheit;

  /// No description provided for @unitFeet.
  ///
  /// In en, this message translates to:
  /// **'Feet'**
  String get unitFeet;

  /// No description provided for @unitGrams.
  ///
  /// In en, this message translates to:
  /// **'Grams'**
  String get unitGrams;

  /// No description provided for @unitHectares.
  ///
  /// In en, this message translates to:
  /// **'Hectares'**
  String get unitHectares;

  /// No description provided for @unitInches.
  ///
  /// In en, this message translates to:
  /// **'Inches'**
  String get unitInches;

  /// No description provided for @unitKilograms.
  ///
  /// In en, this message translates to:
  /// **'Kilograms'**
  String get unitKilograms;

  /// No description provided for @unitKilometers.
  ///
  /// In en, this message translates to:
  /// **'Kilometers'**
  String get unitKilometers;

  /// No description provided for @unitLiters.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get unitLiters;

  /// No description provided for @unitMeters.
  ///
  /// In en, this message translates to:
  /// **'Meters'**
  String get unitMeters;

  /// No description provided for @unitMiles.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get unitMiles;

  /// No description provided for @unitMilliliters.
  ///
  /// In en, this message translates to:
  /// **'Milliliters'**
  String get unitMilliliters;

  /// No description provided for @unitOunces.
  ///
  /// In en, this message translates to:
  /// **'Ounces'**
  String get unitOunces;

  /// No description provided for @unitPounds.
  ///
  /// In en, this message translates to:
  /// **'Pounds'**
  String get unitPounds;

  /// No description provided for @unitSquareCentimeters.
  ///
  /// In en, this message translates to:
  /// **'Square centimeters'**
  String get unitSquareCentimeters;

  /// No description provided for @unitSquareFeet.
  ///
  /// In en, this message translates to:
  /// **'Square feet'**
  String get unitSquareFeet;

  /// No description provided for @unitSquareInches.
  ///
  /// In en, this message translates to:
  /// **'Square inches'**
  String get unitSquareInches;

  /// No description provided for @unitSquareKilometers.
  ///
  /// In en, this message translates to:
  /// **'Square kilometers'**
  String get unitSquareKilometers;

  /// No description provided for @unitSquareMeters.
  ///
  /// In en, this message translates to:
  /// **'Square meters'**
  String get unitSquareMeters;

  /// No description provided for @unitSquareYards.
  ///
  /// In en, this message translates to:
  /// **'Square yards'**
  String get unitSquareYards;

  /// No description provided for @unitUsFluidOunces.
  ///
  /// In en, this message translates to:
  /// **'US Fluid Ounces'**
  String get unitUsFluidOunces;

  /// No description provided for @unitUsGallons.
  ///
  /// In en, this message translates to:
  /// **'US Gallons'**
  String get unitUsGallons;

  /// No description provided for @unitYards.
  ///
  /// In en, this message translates to:
  /// **'Yards'**
  String get unitYards;

  /// No description provided for @unitsHeader.
  ///
  /// In en, this message translates to:
  /// **'UNITS'**
  String get unitsHeader;

  /// No description provided for @vaultCategoryArrivalCard.
  ///
  /// In en, this message translates to:
  /// **'Arrival Card'**
  String get vaultCategoryArrivalCard;

  /// No description provided for @vaultCategoryHotelReservation.
  ///
  /// In en, this message translates to:
  /// **'Hotel Reservation'**
  String get vaultCategoryHotelReservation;

  /// No description provided for @vaultCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get vaultCategoryOther;

  /// No description provided for @vaultCategoryPassportCopy.
  ///
  /// In en, this message translates to:
  /// **'Passport Copy'**
  String get vaultCategoryPassportCopy;

  /// No description provided for @vaultCategoryReturnFlight.
  ///
  /// In en, this message translates to:
  /// **'Return Flight'**
  String get vaultCategoryReturnFlight;

  /// No description provided for @vaultCategoryVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get vaultCategoryVisa;

  /// No description provided for @vaultDocumentTitle.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get vaultDocumentTitle;

  /// No description provided for @vaultIntro.
  ///
  /// In en, this message translates to:
  /// **'Securely store vital travel documents for offline access and quick presentation at immigration.'**
  String get vaultIntro;

  /// No description provided for @vaultProcessFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to process document: {error}'**
  String vaultProcessFailed(String error);

  /// No description provided for @vaultVaultWord.
  ///
  /// In en, this message translates to:
  /// **'vault'**
  String get vaultVaultWord;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
