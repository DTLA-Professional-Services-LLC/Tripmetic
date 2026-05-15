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
/// import 'generated/app_localizations.dart';
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

  /// No description provided for @addPackingFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get addPackingFieldCategory;

  /// No description provided for @addPackingFieldItemName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get addPackingFieldItemName;

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
  /// **'Tripmetic.app'**
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

  /// No description provided for @budgetDestinationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country or currency code'**
  String get budgetDestinationSearchHint;

  /// No description provided for @budgetDestinationTitle.
  ///
  /// In en, this message translates to:
  /// **'Add destination'**
  String get budgetDestinationTitle;

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

  /// No description provided for @budgetHintDays.
  ///
  /// In en, this message translates to:
  /// **'7'**
  String get budgetHintDays;

  /// No description provided for @budgetHintTotal.
  ///
  /// In en, this message translates to:
  /// **'3,000'**
  String get budgetHintTotal;

  /// No description provided for @budgetHintZero.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get budgetHintZero;

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

  /// No description provided for @commonKeyboardDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonKeyboardDone;

  /// No description provided for @countryCountriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} countries'**
  String countryCountriesCount(String count);

  /// No description provided for @countryPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get countryPickerTitle;

  /// No description provided for @countrySheetSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search country name or ISO code'**
  String get countrySheetSearchHint;

  /// No description provided for @countrySheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Base country / region'**
  String get countrySheetTitle;

  /// No description provided for @cryptoHeader.
  ///
  /// In en, this message translates to:
  /// **'CRYPTO'**
  String get cryptoHeader;

  /// No description provided for @cryptoMockPerUnit.
  ///
  /// In en, this message translates to:
  /// **'Mock ~{price} / unit'**
  String cryptoMockPerUnit(String price);

  /// No description provided for @cryptoPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a coin'**
  String get cryptoPickerTitle;

  /// No description provided for @cryptoSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select cryptocurrency'**
  String get cryptoSheetTitle;

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

  /// No description provided for @currencySheetCountShown.
  ///
  /// In en, this message translates to:
  /// **'{shown} of {total} shown'**
  String currencySheetCountShown(String shown, String total);

  /// No description provided for @currencySheetSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search code, name, or numeric ISO'**
  String get currencySheetSearchHint;

  /// No description provided for @currencySheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select currency'**
  String get currencySheetTitle;

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
  String mapSnackDownloadFailed(String error);

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

  /// No description provided for @mapSnackLocationDeniedForMap.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to center the map on you.'**
  String get mapSnackLocationDeniedForMap;

  /// No description provided for @mapSnackLocateFail.
  ///
  /// In en, this message translates to:
  /// **'Unable to get your location right now.'**
  String get mapSnackLocateFail;

  /// No description provided for @mapLocateMeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Go to my location'**
  String get mapLocateMeTooltip;

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

  /// No description provided for @mapSnackRoutingFailed.
  ///
  /// In en, this message translates to:
  /// **'Routing failed: {error}'**
  String mapSnackRoutingFailed(String error);

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

  /// No description provided for @mindMapEmptyNode.
  ///
  /// In en, this message translates to:
  /// **'Empty Node'**
  String get mindMapEmptyNode;

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

  /// No description provided for @mindMapShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic — Mind map'**
  String get mindMapShareSubject;

  /// No description provided for @mindMapShareText.
  ///
  /// In en, this message translates to:
  /// **'Mind map export from Tripmetic'**
  String get mindMapShareText;

  /// No description provided for @mindMapTapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit'**
  String get mindMapTapToEdit;

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

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navMoreMenu.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMoreMenu;

  /// No description provided for @navEditNavigation.
  ///
  /// In en, this message translates to:
  /// **'Edit navigation'**
  String get navEditNavigation;

  /// No description provided for @navDoneEditing.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get navDoneEditing;

  /// No description provided for @navSelectSlotHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a slot, then tap a tool to assign it.'**
  String get navSelectSlotHint;

  /// No description provided for @navSavePins.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get navSavePins;

  /// No description provided for @navPinnedSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Pinned to bottom bar'**
  String get navPinnedSectionTitle;

  /// No description provided for @navAvailableSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Available features'**
  String get navAvailableSectionTitle;

  /// No description provided for @navEmptySlot.
  ///
  /// In en, this message translates to:
  /// **'Empty — add from available below'**
  String get navEmptySlot;

  /// No description provided for @navPinFullHint.
  ///
  /// In en, this message translates to:
  /// **'All four slots are full. Remove one to add another.'**
  String get navPinFullHint;

  /// No description provided for @navEditPinnedHint.
  ///
  /// In en, this message translates to:
  /// **'Use − to free a slot, + to fill a slot, or drag to reorder. Save when all four are filled.'**
  String get navEditPinnedHint;

  /// No description provided for @navAddToPinned.
  ///
  /// In en, this message translates to:
  /// **'Add to bottom bar'**
  String get navAddToPinned;

  /// No description provided for @navRemoveFromPinned.
  ///
  /// In en, this message translates to:
  /// **'Remove from bottom bar'**
  String get navRemoveFromPinned;

  /// No description provided for @navFeatureBadgeFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get navFeatureBadgeFree;

  /// No description provided for @navFeatureBadgePro.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get navFeatureBadgePro;

  /// No description provided for @moreMenuSectionFree.
  ///
  /// In en, this message translates to:
  /// **'Free features'**
  String get moreMenuSectionFree;

  /// No description provided for @moreMenuSectionPro.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic Pro'**
  String get moreMenuSectionPro;

  /// No description provided for @proGlassTeaserTitle.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic Pro Feature'**
  String get proGlassTeaserTitle;

  /// No description provided for @dashboardWorldExplorerSection.
  ///
  /// In en, this message translates to:
  /// **'World Explorer'**
  String get dashboardWorldExplorerSection;

  /// No description provided for @dashboardWorldExplorerCountriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Countries visited'**
  String get dashboardWorldExplorerCountriesLabel;

  /// No description provided for @dashboardWorldExplorerPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Of the world explored'**
  String get dashboardWorldExplorerPercentLabel;

  /// No description provided for @dashboardWorldExplorerPercentValue.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String dashboardWorldExplorerPercentValue(String percent);

  /// No description provided for @bucketListDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get bucketListDisplayNameLabel;

  /// No description provided for @bucketListAuthValidationDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get bucketListAuthValidationDisplayName;

  /// No description provided for @authSignUpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your Tripmetic account'**
  String get authSignUpScreenTitle;

  /// No description provided for @authSignUpScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional — only if you want cloud backup. You can keep using all tools on this device without signing up.'**
  String get authSignUpScreenSubtitle;

  /// No description provided for @authSignInScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Tripmetic'**
  String get authSignInScreenTitle;

  /// No description provided for @authSignInScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional — for syncing your bucket list and cloud group trips. The rest of Tripmetic works without an account.'**
  String get authSignInScreenSubtitle;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authPasswordResetConfirmation.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for that email, you will receive a link to reset your password.'**
  String get authPasswordResetConfirmation;

  /// No description provided for @authUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authUnexpectedError;

  /// No description provided for @authBackupBulletBucketList.
  ///
  /// In en, this message translates to:
  /// **'Bucket list destinations are saved to the cloud and merged when you sign in.'**
  String get authBackupBulletBucketList;

  /// No description provided for @authBackupBulletGroupTrips.
  ///
  /// In en, this message translates to:
  /// **'Group trips you create or join are stored under your account.'**
  String get authBackupBulletGroupTrips;

  /// No description provided for @authBackupBulletMultiDevice.
  ///
  /// In en, this message translates to:
  /// **'Sign in on another device to restore your synced data.'**
  String get authBackupBulletMultiDevice;

  /// No description provided for @authLinkAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authLinkAlreadyHaveAccount;

  /// No description provided for @authLinkNeedAccount.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Create one'**
  String get authLinkNeedAccount;

  /// No description provided for @authFullSignUpCta.
  ///
  /// In en, this message translates to:
  /// **'Use full sign-up screen'**
  String get authFullSignUpCta;

  /// No description provided for @authFullSignInCta.
  ///
  /// In en, this message translates to:
  /// **'Use full sign-in screen'**
  String get authFullSignInCta;

  /// No description provided for @dashboardGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String dashboardGreeting(String name);

  /// No description provided for @dashboardGuestName.
  ///
  /// In en, this message translates to:
  /// **'Traveler'**
  String get dashboardGuestName;

  /// No description provided for @dashboardWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan together, stay organized, and jump into tools in one tap.'**
  String get dashboardWelcomeSubtitle;

  /// No description provided for @dashboardPlanGroupTrip.
  ///
  /// In en, this message translates to:
  /// **'Plan a new group trip'**
  String get dashboardPlanGroupTrip;

  /// No description provided for @dashboardAddBucketList.
  ///
  /// In en, this message translates to:
  /// **'Add to bucket list'**
  String get dashboardAddBucketList;

  /// No description provided for @dashboardActiveTripSection.
  ///
  /// In en, this message translates to:
  /// **'Active trip snapshot'**
  String get dashboardActiveTripSection;

  /// No description provided for @dashboardNoUpcomingTripTitle.
  ///
  /// In en, this message translates to:
  /// **'No upcoming group trip'**
  String get dashboardNoUpcomingTripTitle;

  /// No description provided for @dashboardNoUpcomingTripBody.
  ///
  /// In en, this message translates to:
  /// **'When you plan with friends, your next trip summary appears here.'**
  String get dashboardNoUpcomingTripBody;

  /// No description provided for @dashboardQuickToolsSection.
  ///
  /// In en, this message translates to:
  /// **'Quick tools'**
  String get dashboardQuickToolsSection;

  /// No description provided for @dashboardCountdownStartsIn.
  ///
  /// In en, this message translates to:
  /// **'Starts in {days} days'**
  String dashboardCountdownStartsIn(String days);

  /// No description provided for @dashboardCountdownEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Ends in {days} days'**
  String dashboardCountdownEndsIn(String days);

  /// No description provided for @navDashboardBody.
  ///
  /// In en, this message translates to:
  /// **'Your trip hub — open tools from the bar or the More menu.'**
  String get navDashboardBody;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get appSettings;

  /// No description provided for @settingsSectionTripmeticPro.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic Pro'**
  String get settingsSectionTripmeticPro;

  /// No description provided for @settingsSubscriptionActive.
  ///
  /// In en, this message translates to:
  /// **'Active subscription'**
  String get settingsSubscriptionActive;

  /// No description provided for @settingsSubscriptionFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get settingsSubscriptionFree;

  /// No description provided for @settingsManageBilling.
  ///
  /// In en, this message translates to:
  /// **'Manage billing'**
  String get settingsManageBilling;

  /// No description provided for @settingsTestModeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Test mode'**
  String get settingsTestModeSectionTitle;

  /// No description provided for @settingsTestModeProTitle.
  ///
  /// In en, this message translates to:
  /// **'Test as Tripmetic Pro'**
  String get settingsTestModeProTitle;

  /// No description provided for @settingsTestModeProSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Local override for testing; ignores RevenueCat.'**
  String get settingsTestModeProSubtitle;

  /// No description provided for @settingsTestModeProCaption.
  ///
  /// In en, this message translates to:
  /// **'When enabled, this device unlocks all Pro features locally. Intended for internal testing only — it does not change your real subscription.'**
  String get settingsTestModeProCaption;

  /// No description provided for @settingsUnitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Units of measurement'**
  String get settingsUnitsTitle;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeTitle;

  /// No description provided for @settingsClockWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Clock widget'**
  String get settingsClockWidgetTitle;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile & cloud sync'**
  String get settingsProfileTitle;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Log out of this account?'**
  String get settingsLogoutConfirm;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is handled by support. You can log out below.'**
  String get settingsDeleteAccountBody;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsSectionAccount;

  /// No description provided for @accountManagementListTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage account'**
  String get accountManagementListTitle;

  /// No description provided for @accountManagementListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your name, email, and password'**
  String get accountManagementListSubtitle;

  /// No description provided for @accountManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Account management'**
  String get accountManagementTitle;

  /// No description provided for @accountSectionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get accountSectionProfile;

  /// No description provided for @accountSectionSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign-in'**
  String get accountSectionSignIn;

  /// No description provided for @accountFieldDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get accountFieldDisplayName;

  /// No description provided for @accountFieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountFieldEmail;

  /// No description provided for @accountFieldCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get accountFieldCurrentPassword;

  /// No description provided for @accountFieldNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get accountFieldNewPassword;

  /// No description provided for @accountSaveName.
  ///
  /// In en, this message translates to:
  /// **'Save name'**
  String get accountSaveName;

  /// No description provided for @accountChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Send verification & change email'**
  String get accountChangeEmail;

  /// No description provided for @accountChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get accountChangePassword;

  /// No description provided for @accountSignedOutMessage.
  ///
  /// In en, this message translates to:
  /// **'You must be signed in to manage your account.'**
  String get accountSignedOutMessage;

  /// No description provided for @accountSignInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get accountSignInCta;

  /// No description provided for @accountNameSaved.
  ///
  /// In en, this message translates to:
  /// **'Name updated'**
  String get accountNameSaved;

  /// No description provided for @accountEmailVerificationSent.
  ///
  /// In en, this message translates to:
  /// **'Verification link sent to {email}. Confirm it to switch your sign-in address.'**
  String accountEmailVerificationSent(String email);

  /// No description provided for @accountPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get accountPasswordChanged;

  /// No description provided for @accountReauthRequired.
  ///
  /// In en, this message translates to:
  /// **'For security, sign in again to change your {field}.'**
  String accountReauthRequired(String field);

  /// No description provided for @accountFieldLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get accountFieldLabelEmail;

  /// No description provided for @accountFieldLabelPassword.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get accountFieldLabelPassword;

  /// No description provided for @accountErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Could not update {field}: {error}'**
  String accountErrorGeneric(String field, String error);

  /// No description provided for @accountReauthAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in again'**
  String get accountReauthAction;

  /// No description provided for @accountValidationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get accountValidationEmailRequired;

  /// No description provided for @accountValidationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get accountValidationEmailInvalid;

  /// No description provided for @accountValidationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get accountValidationNameRequired;

  /// No description provided for @accountValidationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get accountValidationPasswordTooShort;

  /// No description provided for @accountCurrentEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Current email: {email}'**
  String accountCurrentEmailLabel(String email);

  /// No description provided for @proPaywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic Pro'**
  String get proPaywallTitle;

  /// No description provided for @proPaywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock offline maps, deep travel tools, and collaboration.'**
  String get proPaywallSubtitle;

  /// No description provided for @proPaywallBenefits.
  ///
  /// In en, this message translates to:
  /// **'Offline maps & region downloads\nItinerary, budget, vault & packing\nGroup planner & real-time sync'**
  String get proPaywallBenefits;

  /// No description provided for @proPaywallBullets.
  ///
  /// In en, this message translates to:
  /// **'Offline maps & region downloads|Itinerary, budget, vault & packing|Group planner & real-time sync'**
  String get proPaywallBullets;

  /// No description provided for @proPaywallUpgradeRevenueCat.
  ///
  /// In en, this message translates to:
  /// **'Upgrade via RevenueCat'**
  String get proPaywallUpgradeRevenueCat;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade now'**
  String get upgradeNow;

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

  /// No description provided for @paywallDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat paywall is temporarily disabled for UI review.'**
  String get paywallDisabledBody;

  /// No description provided for @paywallDisabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Paywall disabled'**
  String get paywallDisabledTitle;

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

  /// No description provided for @presentationImageLoadFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get presentationImageLoadFail;

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

  /// No description provided for @proPaywallNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Pro is not configured in this build.'**
  String get proPaywallNotConfigured;

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
  /// **'© 2026 Tripmetic.app'**
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

  /// No description provided for @settingsMapboxAttributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Map data (Mapbox)'**
  String get settingsMapboxAttributionTitle;

  /// No description provided for @settingsMapboxAttributionBody.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic uses Mapbox maps. © Mapbox, © OpenStreetMap, and other data contributors. The on-map logo and attribution control are hidden in the app for a clearer layout and fewer accidental taps; this notice satisfies Mapbox display requirements.'**
  String get settingsMapboxAttributionBody;

  /// No description provided for @settingsMapboxAttributionMapboxLink.
  ///
  /// In en, this message translates to:
  /// **'Mapbox — About maps'**
  String get settingsMapboxAttributionMapboxLink;

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

  /// No description provided for @sizeCatBoysShoes.
  ///
  /// In en, this message translates to:
  /// **'Boys\' shoes (kids)'**
  String get sizeCatBoysShoes;

  /// No description provided for @sizeCatGirlsShoes.
  ///
  /// In en, this message translates to:
  /// **'Girls\' shoes (kids)'**
  String get sizeCatGirlsShoes;

  /// No description provided for @sizeCatBoysTshirts.
  ///
  /// In en, this message translates to:
  /// **'Boys\' tops / T-shirts'**
  String get sizeCatBoysTshirts;

  /// No description provided for @sizeCatBoysPants.
  ///
  /// In en, this message translates to:
  /// **'Boys\' pants'**
  String get sizeCatBoysPants;

  /// No description provided for @sizeCatGirlsTshirts.
  ///
  /// In en, this message translates to:
  /// **'Girls\' tops / T-shirts'**
  String get sizeCatGirlsTshirts;

  /// No description provided for @sizeCatGirlsPants.
  ///
  /// In en, this message translates to:
  /// **'Girls\' pants'**
  String get sizeCatGirlsPants;

  /// No description provided for @sizeCatGirlsDressesKids.
  ///
  /// In en, this message translates to:
  /// **'Girls\' dresses (kids)'**
  String get sizeCatGirlsDressesKids;

  /// No description provided for @sizeColumnPrimaryEu.
  ///
  /// In en, this message translates to:
  /// **'Primary: EU'**
  String get sizeColumnPrimaryEu;

  /// No description provided for @sizeColumnPrimaryJp.
  ///
  /// In en, this message translates to:
  /// **'Primary: JP'**
  String get sizeColumnPrimaryJp;

  /// No description provided for @sizeColumnPrimaryMixed.
  ///
  /// In en, this message translates to:
  /// **'Primary: mixed (EU→US→UK→JP)'**
  String get sizeColumnPrimaryMixed;

  /// No description provided for @sizeColumnPrimaryUk.
  ///
  /// In en, this message translates to:
  /// **'Primary: UK'**
  String get sizeColumnPrimaryUk;

  /// No description provided for @sizeColumnPrimaryUs.
  ///
  /// In en, this message translates to:
  /// **'Primary: US'**
  String get sizeColumnPrimaryUs;

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

  /// No description provided for @sizeEquivalentSizesHeader.
  ///
  /// In en, this message translates to:
  /// **'EQUIVALENT SIZES'**
  String get sizeEquivalentSizesHeader;

  /// No description provided for @sizeHintBelts.
  ///
  /// In en, this message translates to:
  /// **'e.g. 32, 34, 85, 90'**
  String get sizeHintBelts;

  /// No description provided for @sizeHintMensJeansCombo.
  ///
  /// In en, this message translates to:
  /// **'e.g. 38x32 or 38×32'**
  String get sizeHintMensJeansCombo;

  /// No description provided for @sizeHintMensJeansInseam.
  ///
  /// In en, this message translates to:
  /// **'e.g. 32 (inseam\") or 38x32 → uses inseam 32'**
  String get sizeHintMensJeansInseam;

  /// No description provided for @sizeHintMensJeansWaist.
  ///
  /// In en, this message translates to:
  /// **'e.g. 38 (waist\") or 38x32 → uses waist 38'**
  String get sizeHintMensJeansWaist;

  /// No description provided for @sizeHintMensPants.
  ///
  /// In en, this message translates to:
  /// **'e.g. 30, 32, 34 (waist\")'**
  String get sizeHintMensPants;

  /// No description provided for @sizeHintMensShirts.
  ///
  /// In en, this message translates to:
  /// **'e.g. 15, 38, M'**
  String get sizeHintMensShirts;

  /// No description provided for @sizeHintMensShoes.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6–14, 42, 27'**
  String get sizeHintMensShoes;

  /// No description provided for @sizeHintMensTshirts.
  ///
  /// In en, this message translates to:
  /// **'e.g. S, M, L, 48'**
  String get sizeHintMensTshirts;

  /// No description provided for @sizeHintWomensBlouses.
  ///
  /// In en, this message translates to:
  /// **'e.g. 8, 38, M, XL'**
  String get sizeHintWomensBlouses;

  /// No description provided for @sizeHintWomensDresses.
  ///
  /// In en, this message translates to:
  /// **'e.g. 8, 38, M'**
  String get sizeHintWomensDresses;

  /// No description provided for @sizeHintWomensPants.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6, 10, 38, M'**
  String get sizeHintWomensPants;

  /// No description provided for @sizeHintWomensShoes.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5–12, 39, 25'**
  String get sizeHintWomensShoes;

  /// No description provided for @sizeHintWomensTshirts.
  ///
  /// In en, this message translates to:
  /// **'e.g. XS, M, 38'**
  String get sizeHintWomensTshirts;

  /// No description provided for @sizeHintBoysShoes.
  ///
  /// In en, this message translates to:
  /// **'e.g. 11C, 3Y, 32, 21'**
  String get sizeHintBoysShoes;

  /// No description provided for @sizeHintGirlsShoes.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10C, 2Y, 33, 20'**
  String get sizeHintGirlsShoes;

  /// No description provided for @sizeHintBoysTshirts.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6, 8, M, XS'**
  String get sizeHintBoysTshirts;

  /// No description provided for @sizeHintBoysPants.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6, 8, 10 (US kids)'**
  String get sizeHintBoysPants;

  /// No description provided for @sizeHintGirlsTshirts.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6, 8, M, S'**
  String get sizeHintGirlsTshirts;

  /// No description provided for @sizeHintGirlsPants.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6, 8, 10 (US kids)'**
  String get sizeHintGirlsPants;

  /// No description provided for @sizeHintGirlsDressesKids.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4, 6, 8, 104'**
  String get sizeHintGirlsDressesKids;

  /// No description provided for @sizeNoMatchEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter the size printed on your garment or shoe.'**
  String get sizeNoMatchEmpty;

  /// No description provided for @sizeNoMatchRow.
  ///
  /// In en, this message translates to:
  /// **'No matching size row for this category. Try US, UK, EU, JP numbers, or a letter (S, M, L) where applicable.'**
  String get sizeNoMatchRow;

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

  /// No description provided for @timezoneSheetCountZones.
  ///
  /// In en, this message translates to:
  /// **'{shown} of {total} zones'**
  String timezoneSheetCountZones(String shown, String total);

  /// No description provided for @timezoneSheetSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search IANA name (e.g. Europe, Tokyo)'**
  String get timezoneSheetSearchHint;

  /// No description provided for @timezoneSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select timezone'**
  String get timezoneSheetTitle;

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

  /// No description provided for @tipCountryFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get tipCountryFrance;

  /// No description provided for @tipCountryGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get tipCountryGermany;

  /// No description provided for @tipCountryHongKong.
  ///
  /// In en, this message translates to:
  /// **'Hong Kong'**
  String get tipCountryHongKong;

  /// No description provided for @tipCountryIndonesia.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get tipCountryIndonesia;

  /// No description provided for @tipCountryItaly.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get tipCountryItaly;

  /// No description provided for @tipCountryJapan.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get tipCountryJapan;

  /// No description provided for @tipCountryMexico.
  ///
  /// In en, this message translates to:
  /// **'Mexico'**
  String get tipCountryMexico;

  /// No description provided for @tipCountryMorocco.
  ///
  /// In en, this message translates to:
  /// **'Morocco'**
  String get tipCountryMorocco;

  /// No description provided for @tipCountryPortugal.
  ///
  /// In en, this message translates to:
  /// **'Portugal'**
  String get tipCountryPortugal;

  /// No description provided for @tipCountrySingapore.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get tipCountrySingapore;

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

  /// No description provided for @tipCountryTurkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get tipCountryTurkey;

  /// No description provided for @tipCountryUae.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates (Dubai)'**
  String get tipCountryUae;

  /// No description provided for @tipCountryUnitedKingdom.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get tipCountryUnitedKingdom;

  /// No description provided for @tipCountryUsa.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get tipCountryUsa;

  /// No description provided for @tipZeroReasonChina.
  ///
  /// In en, this message translates to:
  /// **'Tipping is not customary in mainland China and can be declined or seen as odd in many places.'**
  String get tipZeroReasonChina;

  /// No description provided for @tipZeroReasonFrance.
  ///
  /// In en, this message translates to:
  /// **'Restaurant bills usually include a 15% service charge (service compris). Extra tipping is optional for exceptional service.'**
  String get tipZeroReasonFrance;

  /// No description provided for @tipZeroReasonGeneric.
  ///
  /// In en, this message translates to:
  /// **'A 0% tip is typical here. You can still add a tip for outstanding service.'**
  String get tipZeroReasonGeneric;

  /// No description provided for @tipZeroReasonJapan.
  ///
  /// In en, this message translates to:
  /// **'Tipping is not practiced in Japan and can cause confusion or offense.'**
  String get tipZeroReasonJapan;

  /// No description provided for @tipZeroReasonSingapore.
  ///
  /// In en, this message translates to:
  /// **'Tipping is not expected; many venues add a 10% service charge to the bill.'**
  String get tipZeroReasonSingapore;

  /// No description provided for @tipZeroReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Why 0%?'**
  String get tipZeroReasonTitle;

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

  /// No description provided for @toolItinerarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Flights, hotels, and plans by day'**
  String get toolItinerarySubtitle;

  /// No description provided for @toolItineraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Itinerary'**
  String get toolItineraryTitle;

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

  /// No description provided for @vaultTapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload'**
  String get vaultTapToUpload;

  /// No description provided for @vaultTapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view'**
  String get vaultTapToView;

  /// No description provided for @vaultVaultWord.
  ///
  /// In en, this message translates to:
  /// **'vault'**
  String get vaultVaultWord;

  /// No description provided for @bucketListTitle.
  ///
  /// In en, this message translates to:
  /// **'Bucket list'**
  String get bucketListTitle;

  /// No description provided for @bucketListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Places you’ve been, want to go, and what’s next.'**
  String get bucketListSubtitle;

  /// No description provided for @bucketListToolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dream destinations on a map and in lists'**
  String get bucketListToolSubtitle;

  /// No description provided for @bucketListViewModeList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get bucketListViewModeList;

  /// No description provided for @bucketListViewModeMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get bucketListViewModeMap;

  /// No description provided for @bucketListViewModePopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get bucketListViewModePopular;

  /// No description provided for @bucketListPopularHint.
  ///
  /// In en, this message translates to:
  /// **'Been, Live, and Lived update your map and list. Want and Upcoming are list-only and never appear on the map.'**
  String get bucketListPopularHint;

  /// No description provided for @bucketListCategoryBeen.
  ///
  /// In en, this message translates to:
  /// **'Been'**
  String get bucketListCategoryBeen;

  /// No description provided for @bucketListCategoryWant.
  ///
  /// In en, this message translates to:
  /// **'Want'**
  String get bucketListCategoryWant;

  /// No description provided for @bucketListCategoryLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get bucketListCategoryLive;

  /// No description provided for @bucketListCategoryLived.
  ///
  /// In en, this message translates to:
  /// **'Lived'**
  String get bucketListCategoryLived;

  /// No description provided for @bucketListCategoryUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get bucketListCategoryUpcoming;

  /// No description provided for @bucketListDatesRange.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String bucketListDatesRange(String start, String end);

  /// No description provided for @bucketListDetailCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get bucketListDetailCategory;

  /// No description provided for @bucketListDetailDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get bucketListDetailDates;

  /// No description provided for @bucketListMapLegend.
  ///
  /// In en, this message translates to:
  /// **'Tap a marker for details'**
  String get bucketListMapLegend;

  /// No description provided for @bucketListShareMapWatermarkLarge.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic'**
  String get bucketListShareMapWatermarkLarge;

  /// No description provided for @bucketListShareMapWatermarkUrl.
  ///
  /// In en, this message translates to:
  /// **'tripmetic.app'**
  String get bucketListShareMapWatermarkUrl;

  /// No description provided for @bucketListShareMapStatExplore.
  ///
  /// In en, this message translates to:
  /// **'{name} explored {worldPercent}% of the world. Traveled more than {populationPercent}% of the world\'s population.'**
  String bucketListShareMapStatExplore(
    String name,
    String worldPercent,
    int populationPercent,
  );

  /// No description provided for @bucketListShareMapTravelerFallback.
  ///
  /// In en, this message translates to:
  /// **'Rafael'**
  String get bucketListShareMapTravelerFallback;

  /// No description provided for @bucketListShareMapStatPopulation.
  ///
  /// In en, this message translates to:
  /// **'Traveled more than {percent}% of the world\'s population'**
  String bucketListShareMapStatPopulation(int percent);

  /// No description provided for @bucketListShareMapCountriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get bucketListShareMapCountriesLabel;

  /// No description provided for @bucketListShareMapCitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Cities'**
  String get bucketListShareMapCitiesLabel;

  /// No description provided for @bucketListEmptyCategory.
  ///
  /// In en, this message translates to:
  /// **'No places in this category yet.'**
  String get bucketListEmptyCategory;

  /// No description provided for @bucketListTravelStats.
  ///
  /// In en, this message translates to:
  /// **'Travel stats'**
  String get bucketListTravelStats;

  /// No description provided for @bucketListStatWorld.
  ///
  /// In en, this message translates to:
  /// **'World explored'**
  String get bucketListStatWorld;

  /// No description provided for @bucketListStatUs.
  ///
  /// In en, this message translates to:
  /// **'U.S. explored'**
  String get bucketListStatUs;

  /// No description provided for @bucketListStatEurope.
  ///
  /// In en, this message translates to:
  /// **'Europe explored'**
  String get bucketListStatEurope;

  /// No description provided for @bucketListStatAsia.
  ///
  /// In en, this message translates to:
  /// **'Asia explored'**
  String get bucketListStatAsia;

  /// No description provided for @bucketListStatAfrica.
  ///
  /// In en, this message translates to:
  /// **'Africa explored'**
  String get bucketListStatAfrica;

  /// No description provided for @bucketListStatRegionalCaption.
  ///
  /// In en, this message translates to:
  /// **'Regional'**
  String get bucketListStatRegionalCaption;

  /// No description provided for @bucketListStatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} unique · of {total}'**
  String bucketListStatSubtitle(int count, int total);

  /// No description provided for @bucketListAddDestination.
  ///
  /// In en, this message translates to:
  /// **'Add destination'**
  String get bucketListAddDestination;

  /// No description provided for @bucketListEditDestination.
  ///
  /// In en, this message translates to:
  /// **'Edit destination'**
  String get bucketListEditDestination;

  /// No description provided for @bucketListSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get bucketListSave;

  /// No description provided for @bucketListFieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get bucketListFieldCity;

  /// No description provided for @bucketListFieldCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get bucketListFieldCountry;

  /// No description provided for @bucketListFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get bucketListFieldCategory;

  /// No description provided for @bucketListFieldRegionHint.
  ///
  /// In en, this message translates to:
  /// **'State / province (optional)'**
  String get bucketListFieldRegionHint;

  /// No description provided for @bucketListFieldLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get bucketListFieldLatitude;

  /// No description provided for @bucketListFieldLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get bucketListFieldLongitude;

  /// No description provided for @bucketListFieldStart.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get bucketListFieldStart;

  /// No description provided for @bucketListFieldEnd.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get bucketListFieldEnd;

  /// No description provided for @bucketListFieldTripDates.
  ///
  /// In en, this message translates to:
  /// **'Trip dates'**
  String get bucketListFieldTripDates;

  /// No description provided for @bucketListValidationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get bucketListValidationRequired;

  /// No description provided for @bucketListValidationNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number.'**
  String get bucketListValidationNumber;

  /// No description provided for @bucketListValidationDates.
  ///
  /// In en, this message translates to:
  /// **'End date must be on or after start date.'**
  String get bucketListValidationDates;

  /// No description provided for @bucketListGeocodeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find this location on the map. Please check the spelling.'**
  String get bucketListGeocodeNotFound;

  /// No description provided for @bucketListShareSummarySubject.
  ///
  /// In en, this message translates to:
  /// **'My Tripmetic bucket list'**
  String get bucketListShareSummarySubject;

  /// No description provided for @bucketListShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share list and map'**
  String get bucketListShareTooltip;

  /// No description provided for @bucketListShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not share: {error}'**
  String bucketListShareFailed(String error);

  /// No description provided for @bucketListShareNeedMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map view before capturing the map image.'**
  String get bucketListShareNeedMap;

  /// No description provided for @bucketListDeleteHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe to remove'**
  String get bucketListDeleteHint;

  /// No description provided for @bucketListTapEditHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit'**
  String get bucketListTapEditHint;

  /// No description provided for @bucketListCloudSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync failed: {error}'**
  String bucketListCloudSyncFailed(String error);

  /// No description provided for @bucketListRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get bucketListRetry;

  /// No description provided for @bucketListBackupTooltip.
  ///
  /// In en, this message translates to:
  /// **'Backup & register'**
  String get bucketListBackupTooltip;

  /// No description provided for @bucketListBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup'**
  String get bucketListBackupTitle;

  /// No description provided for @bucketListBackupGuestIntro.
  ///
  /// In en, this message translates to:
  /// **'Tripmetic works fully without an account. Add one anytime if you want cloud backup for your bucket list and shared group trips.'**
  String get bucketListBackupGuestIntro;

  /// No description provided for @bucketListSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String bucketListSignedInAs(String email);

  /// No description provided for @bucketListBackupEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get bucketListBackupEmail;

  /// No description provided for @bucketListBackupPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get bucketListBackupPassword;

  /// No description provided for @bucketListBackupConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get bucketListBackupConfirmPassword;

  /// No description provided for @bucketListAuthTabSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get bucketListAuthTabSignUp;

  /// No description provided for @bucketListAuthPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get bucketListAuthPasswordMismatch;

  /// No description provided for @bucketListRegister.
  ///
  /// In en, this message translates to:
  /// **'Create account & backup'**
  String get bucketListRegister;

  /// No description provided for @bucketListSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get bucketListSignIn;

  /// No description provided for @bucketListSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get bucketListSignOut;

  /// No description provided for @bucketListBackupUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading to cloud…'**
  String get bucketListBackupUploading;

  /// No description provided for @bucketListAuthSuccessSignIn.
  ///
  /// In en, this message translates to:
  /// **'Successfully logged in!'**
  String get bucketListAuthSuccessSignIn;

  /// No description provided for @bucketListAuthSuccessSignUp.
  ///
  /// In en, this message translates to:
  /// **'Account successfully created!'**
  String get bucketListAuthSuccessSignUp;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Account created. Welcome to Tripmetic!'**
  String get signUpSuccessMessage;

  /// No description provided for @signUpErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Try signing in.'**
  String get signUpErrorEmailInUse;

  /// No description provided for @signUpErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get signUpErrorInvalidEmail;

  /// No description provided for @signUpErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 8 characters.'**
  String get signUpErrorWeakPassword;

  /// No description provided for @signUpErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Could not sign up: {message}'**
  String signUpErrorGeneric(String message);

  /// No description provided for @signUpErrorEmailInUseAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signUpErrorEmailInUseAction;

  /// No description provided for @bucketListAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not authenticate: {error}'**
  String bucketListAuthFailed(String error);

  /// No description provided for @groupPlannerNoExtraDetails.
  ///
  /// In en, this message translates to:
  /// **'No notes or links yet.'**
  String get groupPlannerNoExtraDetails;

  /// No description provided for @groupPlannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Group planner'**
  String get groupPlannerTitle;

  /// No description provided for @groupPlannerToolTitle.
  ///
  /// In en, this message translates to:
  /// **'Group planner'**
  String get groupPlannerToolTitle;

  /// No description provided for @groupPlannerToolSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan a trip together in real time'**
  String get groupPlannerToolSubtitle;

  /// No description provided for @groupPlannerLandingPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan a group trip'**
  String get groupPlannerLandingPlanTitle;

  /// No description provided for @groupPlannerLandingPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a shared trip with destination, dates, and budget.'**
  String get groupPlannerLandingPlanSubtitle;

  /// No description provided for @groupPlannerLandingJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join a group trip'**
  String get groupPlannerLandingJoinTitle;

  /// No description provided for @groupPlannerLandingJoinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the trip code or link from your invitation.'**
  String get groupPlannerLandingJoinSubtitle;

  /// No description provided for @groupPlannerCreateTripTitle.
  ///
  /// In en, this message translates to:
  /// **'New group trip'**
  String get groupPlannerCreateTripTitle;

  /// No description provided for @groupPlannerSelectDates.
  ///
  /// In en, this message translates to:
  /// **'Select a trip date range.'**
  String get groupPlannerSelectDates;

  /// No description provided for @groupPlannerBudgetPerPersonOption.
  ///
  /// In en, this message translates to:
  /// **'Per person'**
  String get groupPlannerBudgetPerPersonOption;

  /// No description provided for @groupPlannerBudgetGroupOption.
  ///
  /// In en, this message translates to:
  /// **'Group total'**
  String get groupPlannerBudgetGroupOption;

  /// No description provided for @groupPlannerBudgetNoneOption.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get groupPlannerBudgetNoneOption;

  /// No description provided for @groupPlannerBudgetAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget amount'**
  String get groupPlannerBudgetAmountLabel;

  /// No description provided for @groupPlannerOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Open a group trip'**
  String get groupPlannerOpenTitle;

  /// No description provided for @groupPlannerOpenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paste the trip code from your invitation.'**
  String get groupPlannerOpenSubtitle;

  /// No description provided for @groupPlannerOpenTripCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Trip code'**
  String get groupPlannerOpenTripCodeLabel;

  /// No description provided for @groupPlannerOpenHint.
  ///
  /// In en, this message translates to:
  /// **'Short code, trip ID, or invitation link'**
  String get groupPlannerOpenHint;

  /// No description provided for @groupPlannerOpenButton.
  ///
  /// In en, this message translates to:
  /// **'Open trip'**
  String get groupPlannerOpenButton;

  /// No description provided for @groupPlannerDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get groupPlannerDestination;

  /// No description provided for @groupPlannerDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get groupPlannerDates;

  /// No description provided for @groupPlannerGroupSize.
  ///
  /// In en, this message translates to:
  /// **'Group size'**
  String get groupPlannerGroupSize;

  /// No description provided for @groupPlannerBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get groupPlannerBudget;

  /// No description provided for @groupPlannerBudgetPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Per person: {amount}'**
  String groupPlannerBudgetPerPerson(String amount);

  /// No description provided for @groupPlannerBudgetGroup.
  ///
  /// In en, this message translates to:
  /// **'Group total: {amount}'**
  String groupPlannerBudgetGroup(String amount);

  /// No description provided for @groupPlannerBudgetNone.
  ///
  /// In en, this message translates to:
  /// **'No budget set'**
  String get groupPlannerBudgetNone;

  /// No description provided for @groupPlannerInviteMembers.
  ///
  /// In en, this message translates to:
  /// **'Invite members'**
  String get groupPlannerInviteMembers;

  /// No description provided for @groupPlannerManageMembers.
  ///
  /// In en, this message translates to:
  /// **'Manage members'**
  String get groupPlannerManageMembers;

  /// No description provided for @groupPlannerItinerary.
  ///
  /// In en, this message translates to:
  /// **'Itinerary'**
  String get groupPlannerItinerary;

  /// No description provided for @groupPlannerItineraryEditorHint.
  ///
  /// In en, this message translates to:
  /// **'As a trip admin or trip coordinator, you can add activities and change the schedule.'**
  String get groupPlannerItineraryEditorHint;

  /// No description provided for @groupPlannerItineraryViewerHint.
  ///
  /// In en, this message translates to:
  /// **'Read-only: vote on suggested activities with thumbs up or down. Only trip admins and trip coordinators can add or change items.'**
  String get groupPlannerItineraryViewerHint;

  /// No description provided for @groupPlannerNoActivities.
  ///
  /// In en, this message translates to:
  /// **'No activities yet.'**
  String get groupPlannerNoActivities;

  /// No description provided for @groupPlannerTripNotFound.
  ///
  /// In en, this message translates to:
  /// **'This trip could not be loaded.'**
  String get groupPlannerTripNotFound;

  /// No description provided for @groupPlannerSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in required'**
  String get groupPlannerSignInTitle;

  /// No description provided for @groupPlannerSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in under Bucket list → Cloud backup to view shared trips.'**
  String get groupPlannerSignInBody;

  /// No description provided for @groupPlannerCreateTripSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Saving a new group trip requires an account. Sign in to continue — other Tripmetic features work without one.'**
  String get groupPlannerCreateTripSignInRequired;

  /// No description provided for @groupPlannerMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get groupPlannerMembersTitle;

  /// No description provided for @groupPlannerRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get groupPlannerRoleAdmin;

  /// No description provided for @groupPlannerRoleCoPlanner.
  ///
  /// In en, this message translates to:
  /// **'Trip coordinator'**
  String get groupPlannerRoleCoPlanner;

  /// No description provided for @groupPlannerRoleViewOnly.
  ///
  /// In en, this message translates to:
  /// **'View-only'**
  String get groupPlannerRoleViewOnly;

  /// No description provided for @groupPlannerOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get groupPlannerOwner;

  /// No description provided for @groupPlannerRemoveMember.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get groupPlannerRemoveMember;

  /// No description provided for @groupPlannerRemoveMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove member?'**
  String get groupPlannerRemoveMemberTitle;

  /// No description provided for @groupPlannerRemoveMemberBody.
  ///
  /// In en, this message translates to:
  /// **'Remove {email} from this trip?'**
  String groupPlannerRemoveMemberBody(String email);

  /// No description provided for @groupPlannerCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupPlannerCancel;

  /// No description provided for @groupPlannerNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get groupPlannerNotes;

  /// No description provided for @groupPlannerOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get groupPlannerOpenLink;

  /// No description provided for @groupPlannerNetVotes.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String groupPlannerNetVotes(String count);

  /// No description provided for @groupPlannerVoteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save vote: {error}'**
  String groupPlannerVoteError(String error);

  /// No description provided for @groupPlannerManageError.
  ///
  /// In en, this message translates to:
  /// **'Could not update members: {error}'**
  String groupPlannerManageError(String error);

  /// No description provided for @groupPlannerInviteError.
  ///
  /// In en, this message translates to:
  /// **'Could not open share sheet: {error}'**
  String groupPlannerInviteError(String error);

  /// No description provided for @groupPlannerUnknownTripCode.
  ///
  /// In en, this message translates to:
  /// **'Could not open trip: {error}'**
  String groupPlannerUnknownTripCode(String error);

  /// No description provided for @groupPlannerMyTripsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Your trips'**
  String get groupPlannerMyTripsSectionTitle;

  /// No description provided for @groupPlannerMyTripsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trips yet. Create one above.'**
  String get groupPlannerMyTripsEmpty;

  /// No description provided for @groupPlannerExamplesTitle.
  ///
  /// In en, this message translates to:
  /// **'Example trips'**
  String get groupPlannerExamplesTitle;

  /// No description provided for @groupPlannerExamplesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sample cards — create a trip above to add your own.'**
  String get groupPlannerExamplesSubtitle;

  /// No description provided for @groupPlannerExampleTapBody.
  ///
  /// In en, this message translates to:
  /// **'These are samples only. Use “Plan a group trip” to create a real trip you can share.'**
  String get groupPlannerExampleTapBody;

  /// No description provided for @groupPlannerExampleLisbonTitle.
  ///
  /// In en, this message translates to:
  /// **'Lisbon team offsite'**
  String get groupPlannerExampleLisbonTitle;

  /// No description provided for @groupPlannerExampleKyotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Kyoto spring tour'**
  String get groupPlannerExampleKyotoTitle;

  /// No description provided for @groupPlannerAddActivity.
  ///
  /// In en, this message translates to:
  /// **'Add activity'**
  String get groupPlannerAddActivity;

  /// No description provided for @groupPlannerActivityTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity title'**
  String get groupPlannerActivityTitleLabel;

  /// No description provided for @groupPlannerActivityWhenLabel.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get groupPlannerActivityWhenLabel;

  /// No description provided for @groupPlannerActivityTripDateRangeHelp.
  ///
  /// In en, this message translates to:
  /// **'Pick a day on your trip, then a time. Anyone who can edit the itinerary can change this later.'**
  String get groupPlannerActivityTripDateRangeHelp;

  /// No description provided for @groupPlannerActivityDateOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'That date is outside this trip. Choose a day between the trip start and end.'**
  String get groupPlannerActivityDateOutOfRange;

  /// No description provided for @groupPlannerActivityTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an activity title.'**
  String get groupPlannerActivityTitleRequired;

  /// No description provided for @groupPlannerActivityDateUnset.
  ///
  /// In en, this message translates to:
  /// **'Date not set — tap Edit to schedule.'**
  String get groupPlannerActivityDateUnset;

  /// No description provided for @groupPlannerPeopleCount.
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String groupPlannerPeopleCount(String count);

  /// No description provided for @groupPlannerEditActivity.
  ///
  /// In en, this message translates to:
  /// **'Edit activity'**
  String get groupPlannerEditActivity;

  /// No description provided for @groupPlannerDeleteActivity.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get groupPlannerDeleteActivity;

  /// No description provided for @groupPlannerDeleteActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete activity?'**
  String get groupPlannerDeleteActivityTitle;

  /// No description provided for @groupPlannerDeleteActivityBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\" from the itinerary? This cannot be undone.'**
  String groupPlannerDeleteActivityBody(String title);

  /// No description provided for @groupPlannerActivityDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete activity: {error}'**
  String groupPlannerActivityDeleteError(String error);

  /// No description provided for @groupPlannerActivityEditError.
  ///
  /// In en, this message translates to:
  /// **'Could not update activity: {error}'**
  String groupPlannerActivityEditError(String error);

  /// No description provided for @groupPlannerEditTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get groupPlannerEditTripTitle;

  /// No description provided for @groupPlannerEditTripAction.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get groupPlannerEditTripAction;

  /// No description provided for @groupPlannerDeleteTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete trip?'**
  String get groupPlannerDeleteTripTitle;

  /// No description provided for @groupPlannerDeleteTripBody.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove the trip \"{destination}\" and its itinerary for everyone? This cannot be undone.'**
  String groupPlannerDeleteTripBody(String destination);

  /// No description provided for @groupPlannerDeleteTripAction.
  ///
  /// In en, this message translates to:
  /// **'Delete trip'**
  String get groupPlannerDeleteTripAction;

  /// No description provided for @groupPlannerTripDeleted.
  ///
  /// In en, this message translates to:
  /// **'Trip removed.'**
  String get groupPlannerTripDeleted;

  /// No description provided for @groupPlannerTripDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete trip: {error}'**
  String groupPlannerTripDeleteError(String error);

  /// No description provided for @groupPlannerTripUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Could not update trip: {error}'**
  String groupPlannerTripUpdateError(String error);

  /// No description provided for @widgetInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Dual Clock Widget'**
  String get widgetInstructionTitle;

  /// No description provided for @widgetInstructionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your home and destination timezones directly from your Lock Screen or Home Screen.'**
  String get widgetInstructionSubtitle;

  /// No description provided for @widgetInstructionTabIos.
  ///
  /// In en, this message translates to:
  /// **'iOS'**
  String get widgetInstructionTabIos;

  /// No description provided for @widgetInstructionTabAndroid.
  ///
  /// In en, this message translates to:
  /// **'Android'**
  String get widgetInstructionTabAndroid;

  /// No description provided for @widgetInstructionIosLockScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock Screen'**
  String get widgetInstructionIosLockScreenTitle;

  /// No description provided for @widgetInstructionIosLockScreenStep1.
  ///
  /// In en, this message translates to:
  /// **'Long-press your Lock Screen and tap \'Customize\'.'**
  String get widgetInstructionIosLockScreenStep1;

  /// No description provided for @widgetInstructionIosLockScreenStep2.
  ///
  /// In en, this message translates to:
  /// **'Select the \'Lock Screen\' preview.'**
  String get widgetInstructionIosLockScreenStep2;

  /// No description provided for @widgetInstructionIosLockScreenStep3.
  ///
  /// In en, this message translates to:
  /// **'Tap the widget area directly below the time.'**
  String get widgetInstructionIosLockScreenStep3;

  /// No description provided for @widgetInstructionIosLockScreenStep4.
  ///
  /// In en, this message translates to:
  /// **'Scroll down, select Tripmetic, and tap to add the widget.'**
  String get widgetInstructionIosLockScreenStep4;

  /// No description provided for @widgetInstructionIosHomeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Screen'**
  String get widgetInstructionIosHomeScreenTitle;

  /// No description provided for @widgetInstructionIosHomeScreenStep1.
  ///
  /// In en, this message translates to:
  /// **'Long-press an empty space on your Home Screen.'**
  String get widgetInstructionIosHomeScreenStep1;

  /// No description provided for @widgetInstructionIosHomeScreenStep2.
  ///
  /// In en, this message translates to:
  /// **'Tap the + icon in the top-left corner.'**
  String get widgetInstructionIosHomeScreenStep2;

  /// No description provided for @widgetInstructionIosHomeScreenStep3.
  ///
  /// In en, this message translates to:
  /// **'Search for \'Tripmetic\'.'**
  String get widgetInstructionIosHomeScreenStep3;

  /// No description provided for @widgetInstructionIosHomeScreenStep4.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred widget size and tap \'Add Widget\'.'**
  String get widgetInstructionIosHomeScreenStep4;

  /// No description provided for @widgetInstructionAndroidStep1.
  ///
  /// In en, this message translates to:
  /// **'Go to your Home Screen and long-press an empty area.'**
  String get widgetInstructionAndroidStep1;

  /// No description provided for @widgetInstructionAndroidStep2.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Widgets\".'**
  String get widgetInstructionAndroidStep2;

  /// No description provided for @widgetInstructionAndroidStep3.
  ///
  /// In en, this message translates to:
  /// **'Scroll down to Tripmetic.'**
  String get widgetInstructionAndroidStep3;

  /// No description provided for @widgetInstructionAndroidStep4.
  ///
  /// In en, this message translates to:
  /// **'Tap and hold the Dual Clock widget, then drag it onto your screen.'**
  String get widgetInstructionAndroidStep4;

  /// No description provided for @widgetInstructionAndroidLockScreenHint.
  ///
  /// In en, this message translates to:
  /// **'To see both clocks on the lock screen: open Settings → search for “lock screen” or “widgets”, and add Tripmetic there if your phone offers lock-screen widgets (not all devices do).'**
  String get widgetInstructionAndroidLockScreenHint;

  /// No description provided for @widgetInstructionConfigureCta.
  ///
  /// In en, this message translates to:
  /// **'Configure Widget Cities'**
  String get widgetInstructionConfigureCta;

  /// No description provided for @dualClockScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Dual Clock Widget'**
  String get dualClockScreenTitle;

  /// No description provided for @dualClockConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Configure cities'**
  String get dualClockConfigTitle;

  /// No description provided for @dualClockConfigSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose two cities and timezones. Your selections sync to the Tripmetic home screen widget (Android) and lock screen widget (iOS).'**
  String get dualClockConfigSubtitle;

  /// No description provided for @dualClockCity1Label.
  ///
  /// In en, this message translates to:
  /// **'First city'**
  String get dualClockCity1Label;

  /// No description provided for @dualClockCity2Label.
  ///
  /// In en, this message translates to:
  /// **'Second city'**
  String get dualClockCity2Label;

  /// No description provided for @dualClockSave.
  ///
  /// In en, this message translates to:
  /// **'Save & update widget'**
  String get dualClockSave;

  /// No description provided for @dualClockSaved.
  ///
  /// In en, this message translates to:
  /// **'Widget updated.'**
  String get dualClockSaved;

  /// No description provided for @dualClockSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save widget data. Please try again.'**
  String get dualClockSaveError;

  /// No description provided for @dualClockAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock screen widget (iOS)'**
  String get dualClockAppearanceTitle;

  /// No description provided for @dualClockAppearanceHint.
  ///
  /// In en, this message translates to:
  /// **'Larger text and shadows help on photo wallpapers. Android home widget uses system colors.'**
  String get dualClockAppearanceHint;

  /// No description provided for @dualClockFontScaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get dualClockFontScaleLabel;

  /// No description provided for @dualClockColorCity.
  ///
  /// In en, this message translates to:
  /// **'City names'**
  String get dualClockColorCity;

  /// No description provided for @dualClockColorTime.
  ///
  /// In en, this message translates to:
  /// **'Times'**
  String get dualClockColorTime;

  /// No description provided for @dualClockColorDate.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dualClockColorDate;

  /// No description provided for @dualClockShadowLabel.
  ///
  /// In en, this message translates to:
  /// **'Text shadow'**
  String get dualClockShadowLabel;

  /// No description provided for @dualClockShadowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Adds contrast on busy or photo wallpapers.'**
  String get dualClockShadowSubtitle;

  /// No description provided for @moreToolsDualClockBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Dual Clock widget'**
  String get moreToolsDualClockBannerTitle;

  /// No description provided for @moreToolsDualClockBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See two timezones on your Lock Screen or Home Screen — tap to set up.'**
  String get moreToolsDualClockBannerSubtitle;

  /// No description provided for @moreToolsDualClockBannerCta.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get moreToolsDualClockBannerCta;

  /// No description provided for @settingsDualClockWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Dual Clock widget'**
  String get settingsDualClockWidgetTitle;

  /// No description provided for @settingsDualClockWidgetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add the widget and choose your cities'**
  String get settingsDualClockWidgetSubtitle;

  /// No description provided for @widgetNewFeatureBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get widgetNewFeatureBadge;

  /// No description provided for @globalNavAccountCloudSyncTooltip.
  ///
  /// In en, this message translates to:
  /// **'Account & cloud backup'**
  String get globalNavAccountCloudSyncTooltip;

  /// No description provided for @exchangeRatesForceRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Fetch latest exchange rates'**
  String get exchangeRatesForceRefreshTooltip;

  /// No description provided for @exchangeRatesRefreshedOk.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates updated.'**
  String get exchangeRatesRefreshedOk;

  /// No description provided for @exchangeRatesRefreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not refresh exchange rates.'**
  String get exchangeRatesRefreshFailed;

  /// No description provided for @bucketListStatUsTerritories.
  ///
  /// In en, this message translates to:
  /// **'U.S. territories'**
  String get bucketListStatUsTerritories;

  /// No description provided for @bucketListAuthErrUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found for this email.'**
  String get bucketListAuthErrUserNotFound;

  /// No description provided for @bucketListAuthErrWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get bucketListAuthErrWrongPassword;

  /// No description provided for @bucketListAuthErrEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists for this email.'**
  String get bucketListAuthErrEmailInUse;

  /// No description provided for @bucketListAuthErrInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get bucketListAuthErrInvalidEmail;

  /// No description provided for @bucketListAuthErrWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get bucketListAuthErrWeakPassword;

  /// No description provided for @bucketListAuthErrUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get bucketListAuthErrUserDisabled;

  /// No description provided for @bucketListAuthErrTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get bucketListAuthErrTooManyRequests;

  /// No description provided for @bucketListAuthErrOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Email/password sign-in is not enabled.'**
  String get bucketListAuthErrOperationNotAllowed;

  /// No description provided for @bucketListAuthErrDetail.
  ///
  /// In en, this message translates to:
  /// **'{detail}'**
  String bucketListAuthErrDetail(String detail);

  /// No description provided for @bucketListAuthValidationInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get bucketListAuthValidationInvalidEmail;

  /// No description provided for @bucketListAuthValidationPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get bucketListAuthValidationPasswordShort;

  /// No description provided for @bucketListAuthValidationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get bucketListAuthValidationPasswordRequired;
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
