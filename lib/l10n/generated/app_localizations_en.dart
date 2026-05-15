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
  String get addPackingFieldCategory => 'Category';

  @override
  String get addPackingFieldItemName => 'Item name';

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
  String get appTitle => 'Tripmetic.app';

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
  String get budgetDestinationSearchHint => 'Search country or currency code';

  @override
  String get budgetDestinationTitle => 'Add destination';

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
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3,000';

  @override
  String get budgetHintZero => '0';

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
  String get commonKeyboardDone => 'Done';

  @override
  String countryCountriesCount(String count) {
    return '$count countries';
  }

  @override
  String get countryPickerTitle => 'Select country';

  @override
  String get countrySheetSearchHint => 'Search country name or ISO code';

  @override
  String get countrySheetTitle => 'Base country / region';

  @override
  String get cryptoHeader => 'CRYPTO';

  @override
  String cryptoMockPerUnit(String price) {
    return 'Mock ~$price / unit';
  }

  @override
  String get cryptoPickerTitle => 'Pick a coin';

  @override
  String get cryptoSheetTitle => 'Select cryptocurrency';

  @override
  String get currencyPickerSearchHint => 'Search ticker or name';

  @override
  String get currencyPickerTitle => 'Pick a currency';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown of $total shown';
  }

  @override
  String get currencySheetSearchHint => 'Search code, name, or numeric ISO';

  @override
  String get currencySheetTitle => 'Select currency';

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
  String mapSnackDownloadFailed(String error) {
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
  String get mapSnackLocationDeniedForMap =>
      'Location permission is required to center the map on you.';

  @override
  String get mapSnackLocateFail => 'Unable to get your location right now.';

  @override
  String get mapLocateMeTooltip => 'Go to my location';

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
  String mapSnackRoutingFailed(String error) {
    return 'Routing failed: $error';
  }

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
  String get mindMapEmptyNode => 'Empty Node';

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
  String get mindMapShareSubject => 'Tripmetic — Mind map';

  @override
  String get mindMapShareText => 'Mind map export from Tripmetic';

  @override
  String get mindMapTapToEdit => 'Tap to edit';

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
  String get navDashboard => 'Dashboard';

  @override
  String get navMoreMenu => 'More';

  @override
  String get navEditNavigation => 'Edit navigation';

  @override
  String get navDoneEditing => 'Done';

  @override
  String get navSelectSlotHint => 'Tap a slot, then tap a tool to assign it.';

  @override
  String get navSavePins => 'Save';

  @override
  String get navPinnedSectionTitle => 'Pinned to bottom bar';

  @override
  String get navAvailableSectionTitle => 'Available features';

  @override
  String get navEmptySlot => 'Empty — add from available below';

  @override
  String get navPinFullHint =>
      'All four slots are full. Remove one to add another.';

  @override
  String get navEditPinnedHint =>
      'Use − to free a slot, + to fill a slot, or drag to reorder. Save when all four are filled.';

  @override
  String get navAddToPinned => 'Add to bottom bar';

  @override
  String get navRemoveFromPinned => 'Remove from bottom bar';

  @override
  String get navFeatureBadgeFree => 'Free';

  @override
  String get navFeatureBadgePro => 'PRO';

  @override
  String get moreMenuSectionFree => 'Free features';

  @override
  String get moreMenuSectionPro => 'Tripmetic Pro';

  @override
  String get proGlassTeaserTitle => 'Tripmetic Pro Feature';

  @override
  String get dashboardWorldExplorerSection => 'World Explorer';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'Countries visited';

  @override
  String get dashboardWorldExplorerPercentLabel => 'Of the world explored';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => 'Display name';

  @override
  String get bucketListAuthValidationDisplayName => 'Enter your name';

  @override
  String get authSignUpScreenTitle => 'Create your Tripmetic account';

  @override
  String get authSignUpScreenSubtitle =>
      'Optional — only if you want cloud backup. You can keep using all tools on this device without signing up.';

  @override
  String get authSignInScreenTitle => 'Sign in to Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      'Optional — for syncing your bucket list and cloud group trips. The rest of Tripmetic works without an account.';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authPasswordResetConfirmation =>
      'If an account exists for that email, you will receive a link to reset your password.';

  @override
  String get authUnexpectedError => 'Something went wrong. Please try again.';

  @override
  String get authBackupBulletBucketList =>
      'Bucket list destinations are saved to the cloud and merged when you sign in.';

  @override
  String get authBackupBulletGroupTrips =>
      'Group trips you create or join are stored under your account.';

  @override
  String get authBackupBulletMultiDevice =>
      'Sign in on another device to restore your synced data.';

  @override
  String get authLinkAlreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get authLinkNeedAccount => 'Need an account? Create one';

  @override
  String get authFullSignUpCta => 'Use full sign-up screen';

  @override
  String get authFullSignInCta => 'Use full sign-in screen';

  @override
  String dashboardGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get dashboardGuestName => 'Traveler';

  @override
  String get dashboardWelcomeSubtitle =>
      'Plan together, stay organized, and jump into tools in one tap.';

  @override
  String get dashboardPlanGroupTrip => 'Plan a new group trip';

  @override
  String get dashboardAddBucketList => 'Add to bucket list';

  @override
  String get dashboardActiveTripSection => 'Active trip snapshot';

  @override
  String get dashboardNoUpcomingTripTitle => 'No upcoming group trip';

  @override
  String get dashboardNoUpcomingTripBody =>
      'When you plan with friends, your next trip summary appears here.';

  @override
  String get dashboardQuickToolsSection => 'Quick tools';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'Starts in $days days';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'Ends in $days days';
  }

  @override
  String get navDashboardBody =>
      'Your trip hub — open tools from the bar or the More menu.';

  @override
  String get appSettings => 'App settings';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic Pro';

  @override
  String get settingsSubscriptionActive => 'Active subscription';

  @override
  String get settingsSubscriptionFree => 'Free plan';

  @override
  String get settingsManageBilling => 'Manage billing';

  @override
  String get settingsTestModeSectionTitle => 'Test mode';

  @override
  String get settingsTestModeProTitle => 'Test as Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'Local override for testing; ignores RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'When enabled, this device unlocks all Pro features locally. Intended for internal testing only — it does not change your real subscription.';

  @override
  String get settingsUnitsTitle => 'Units of measurement';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get settingsClockWidgetTitle => 'Clock widget';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Spanish';

  @override
  String get settingsProfileTitle => 'Profile & cloud sync';

  @override
  String get settingsLogout => 'Log out';

  @override
  String get settingsLogoutConfirm => 'Log out of this account?';

  @override
  String get settingsDeleteAccount => 'Delete account';

  @override
  String get settingsDeleteAccountBody =>
      'Account deletion is handled by support. You can log out below.';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get accountManagementListTitle => 'Manage account';

  @override
  String get accountManagementListSubtitle =>
      'Update your name, email, and password';

  @override
  String get accountManagementTitle => 'Account management';

  @override
  String get accountSectionProfile => 'Profile';

  @override
  String get accountSectionSignIn => 'Sign-in';

  @override
  String get accountFieldDisplayName => 'Display name';

  @override
  String get accountFieldEmail => 'Email';

  @override
  String get accountFieldCurrentPassword => 'Current password';

  @override
  String get accountFieldNewPassword => 'New password';

  @override
  String get accountSaveName => 'Save name';

  @override
  String get accountChangeEmail => 'Send verification & change email';

  @override
  String get accountChangePassword => 'Change password';

  @override
  String get accountSignedOutMessage =>
      'You must be signed in to manage your account.';

  @override
  String get accountSignInCta => 'Sign in';

  @override
  String get accountNameSaved => 'Name updated';

  @override
  String accountEmailVerificationSent(String email) {
    return 'Verification link sent to $email. Confirm it to switch your sign-in address.';
  }

  @override
  String get accountPasswordChanged => 'Password updated';

  @override
  String accountReauthRequired(String field) {
    return 'For security, sign in again to change your $field.';
  }

  @override
  String get accountFieldLabelEmail => 'email';

  @override
  String get accountFieldLabelPassword => 'password';

  @override
  String accountErrorGeneric(String field, String error) {
    return 'Could not update $field: $error';
  }

  @override
  String get accountReauthAction => 'Sign in again';

  @override
  String get accountValidationEmailRequired => 'Enter your email';

  @override
  String get accountValidationEmailInvalid => 'Enter a valid email';

  @override
  String get accountValidationNameRequired => 'Enter your name';

  @override
  String get accountValidationPasswordTooShort => 'Use at least 8 characters';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'Current email: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic Pro';

  @override
  String get proPaywallSubtitle =>
      'Unlock offline maps, deep travel tools, and collaboration.';

  @override
  String get proPaywallBenefits =>
      'Offline maps & region downloads\nItinerary, budget, vault & packing\nGroup planner & real-time sync';

  @override
  String get proPaywallBullets =>
      'Offline maps & region downloads|Itinerary, budget, vault & packing|Group planner & real-time sync';

  @override
  String get proPaywallUpgradeRevenueCat => 'Upgrade via RevenueCat';

  @override
  String get upgradeNow => 'Upgrade now';

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
  String get paywallDisabledBody =>
      'RevenueCat paywall is temporarily disabled for UI review.';

  @override
  String get paywallDisabledTitle => 'Paywall disabled';

  @override
  String get presentationDeleteBody =>
      'Are you sure you want to remove this document from the vault?';

  @override
  String get presentationDeleteTitle => 'Delete Document?';

  @override
  String get presentationImageLoadFail => 'Failed to load image';

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
  String get proPaywallNotConfigured => 'Pro is not configured in this build.';

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
  String get settingsCopyright => '© 2026 Tripmetic.app';

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
  String get settingsMapboxAttributionTitle => 'Map data (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic uses Mapbox maps. © Mapbox, © OpenStreetMap, and other data contributors. The on-map logo and attribution control are hidden in the app for a clearer layout and fewer accidental taps; this notice satisfies Mapbox display requirements.';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — About maps';

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
  String get sizeCatBoysShoes => 'Boys\' shoes (kids)';

  @override
  String get sizeCatGirlsShoes => 'Girls\' shoes (kids)';

  @override
  String get sizeCatBoysTshirts => 'Boys\' tops / T-shirts';

  @override
  String get sizeCatBoysPants => 'Boys\' pants';

  @override
  String get sizeCatGirlsTshirts => 'Girls\' tops / T-shirts';

  @override
  String get sizeCatGirlsPants => 'Girls\' pants';

  @override
  String get sizeCatGirlsDressesKids => 'Girls\' dresses (kids)';

  @override
  String get sizeColumnPrimaryEu => 'Primary: EU';

  @override
  String get sizeColumnPrimaryJp => 'Primary: JP';

  @override
  String get sizeColumnPrimaryMixed => 'Primary: mixed (EU→US→UK→JP)';

  @override
  String get sizeColumnPrimaryUk => 'Primary: UK';

  @override
  String get sizeColumnPrimaryUs => 'Primary: US';

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
  String get sizeEquivalentSizesHeader => 'EQUIVALENT SIZES';

  @override
  String get sizeHintBelts => 'e.g. 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => 'e.g. 38x32 or 38×32';

  @override
  String get sizeHintMensJeansInseam =>
      'e.g. 32 (inseam\") or 38x32 → uses inseam 32';

  @override
  String get sizeHintMensJeansWaist =>
      'e.g. 38 (waist\") or 38x32 → uses waist 38';

  @override
  String get sizeHintMensPants => 'e.g. 30, 32, 34 (waist\")';

  @override
  String get sizeHintMensShirts => 'e.g. 15, 38, M';

  @override
  String get sizeHintMensShoes => 'e.g. 6–14, 42, 27';

  @override
  String get sizeHintMensTshirts => 'e.g. S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => 'e.g. 8, 38, M, XL';

  @override
  String get sizeHintWomensDresses => 'e.g. 8, 38, M';

  @override
  String get sizeHintWomensPants => 'e.g. 6, 10, 38, M';

  @override
  String get sizeHintWomensShoes => 'e.g. 5–12, 39, 25';

  @override
  String get sizeHintWomensTshirts => 'e.g. XS, M, 38';

  @override
  String get sizeHintBoysShoes => 'e.g. 11C, 3Y, 32, 21';

  @override
  String get sizeHintGirlsShoes => 'e.g. 10C, 2Y, 33, 20';

  @override
  String get sizeHintBoysTshirts => 'e.g. 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => 'e.g. 6, 8, 10 (US kids)';

  @override
  String get sizeHintGirlsTshirts => 'e.g. 6, 8, M, S';

  @override
  String get sizeHintGirlsPants => 'e.g. 6, 8, 10 (US kids)';

  @override
  String get sizeHintGirlsDressesKids => 'e.g. 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty =>
      'Enter the size printed on your garment or shoe.';

  @override
  String get sizeNoMatchRow =>
      'No matching size row for this category. Try US, UK, EU, JP numbers, or a letter (S, M, L) where applicable.';

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
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown of $total zones';
  }

  @override
  String get timezoneSheetSearchHint => 'Search IANA name (e.g. Europe, Tokyo)';

  @override
  String get timezoneSheetTitle => 'Select timezone';

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
  String get tipCountryFrance => 'France';

  @override
  String get tipCountryGermany => 'Germany';

  @override
  String get tipCountryHongKong => 'Hong Kong';

  @override
  String get tipCountryIndonesia => 'Indonesia';

  @override
  String get tipCountryItaly => 'Italy';

  @override
  String get tipCountryJapan => 'Japan';

  @override
  String get tipCountryMexico => 'Mexico';

  @override
  String get tipCountryMorocco => 'Morocco';

  @override
  String get tipCountryPortugal => 'Portugal';

  @override
  String get tipCountrySingapore => 'Singapore';

  @override
  String get tipCountrySpain => 'Spain';

  @override
  String get tipCountryThailand => 'Thailand';

  @override
  String get tipCountryTurkey => 'Turkey';

  @override
  String get tipCountryUae => 'United Arab Emirates (Dubai)';

  @override
  String get tipCountryUnitedKingdom => 'United Kingdom';

  @override
  String get tipCountryUsa => 'United States';

  @override
  String get tipZeroReasonChina =>
      'Tipping is not customary in mainland China and can be declined or seen as odd in many places.';

  @override
  String get tipZeroReasonFrance =>
      'Restaurant bills usually include a 15% service charge (service compris). Extra tipping is optional for exceptional service.';

  @override
  String get tipZeroReasonGeneric =>
      'A 0% tip is typical here. You can still add a tip for outstanding service.';

  @override
  String get tipZeroReasonJapan =>
      'Tipping is not practiced in Japan and can cause confusion or offense.';

  @override
  String get tipZeroReasonSingapore =>
      'Tipping is not expected; many venues add a 10% service charge to the bill.';

  @override
  String get tipZeroReasonTitle => 'Why 0%?';

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
  String get toolItinerarySubtitle => 'Flights, hotels, and plans by day';

  @override
  String get toolItineraryTitle => 'Itinerary';

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
  String get vaultTapToUpload => 'Tap to upload';

  @override
  String get vaultTapToView => 'Tap to view';

  @override
  String get vaultVaultWord => 'vault';

  @override
  String get bucketListTitle => 'Bucket list';

  @override
  String get bucketListSubtitle =>
      'Places you’ve been, want to go, and what’s next.';

  @override
  String get bucketListToolSubtitle =>
      'Dream destinations on a map and in lists';

  @override
  String get bucketListViewModeList => 'List';

  @override
  String get bucketListViewModeMap => 'Map';

  @override
  String get bucketListViewModePopular => 'Popular';

  @override
  String get bucketListPopularHint =>
      'Been, Live, and Lived update your map and list. Want and Upcoming are list-only and never appear on the map.';

  @override
  String get bucketListCategoryBeen => 'Been';

  @override
  String get bucketListCategoryWant => 'Want';

  @override
  String get bucketListCategoryLive => 'Live';

  @override
  String get bucketListCategoryLived => 'Lived';

  @override
  String get bucketListCategoryUpcoming => 'Upcoming';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'Category';

  @override
  String get bucketListDetailDates => 'Dates';

  @override
  String get bucketListMapLegend => 'Tap a marker for details';

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
    return '$name explored $worldPercent% of the world. Traveled more than $populationPercent% of the world\'s population.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'Rafael';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'Traveled more than $percent% of the world\'s population';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'Countries';

  @override
  String get bucketListShareMapCitiesLabel => 'Cities';

  @override
  String get bucketListEmptyCategory => 'No places in this category yet.';

  @override
  String get bucketListTravelStats => 'Travel stats';

  @override
  String get bucketListStatWorld => 'World explored';

  @override
  String get bucketListStatUs => 'U.S. explored';

  @override
  String get bucketListStatEurope => 'Europe explored';

  @override
  String get bucketListStatAsia => 'Asia explored';

  @override
  String get bucketListStatAfrica => 'Africa explored';

  @override
  String get bucketListStatRegionalCaption => 'Regional';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count unique · of $total';
  }

  @override
  String get bucketListAddDestination => 'Add destination';

  @override
  String get bucketListEditDestination => 'Edit destination';

  @override
  String get bucketListSave => 'Save';

  @override
  String get bucketListFieldCity => 'City';

  @override
  String get bucketListFieldCountry => 'Country';

  @override
  String get bucketListFieldCategory => 'Category';

  @override
  String get bucketListFieldRegionHint => 'State / province (optional)';

  @override
  String get bucketListFieldLatitude => 'Latitude';

  @override
  String get bucketListFieldLongitude => 'Longitude';

  @override
  String get bucketListFieldStart => 'Start date';

  @override
  String get bucketListFieldEnd => 'End date';

  @override
  String get bucketListFieldTripDates => 'Trip dates';

  @override
  String get bucketListValidationRequired => 'This field is required.';

  @override
  String get bucketListValidationNumber => 'Enter a valid number.';

  @override
  String get bucketListValidationDates =>
      'End date must be on or after start date.';

  @override
  String get bucketListGeocodeNotFound =>
      'Could not find this location on the map. Please check the spelling.';

  @override
  String get bucketListShareSummarySubject => 'My Tripmetic bucket list';

  @override
  String get bucketListShareTooltip => 'Share list and map';

  @override
  String bucketListShareFailed(String error) {
    return 'Could not share: $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'Open Map view before capturing the map image.';

  @override
  String get bucketListDeleteHint => 'Swipe to remove';

  @override
  String get bucketListTapEditHint => 'Tap to edit';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'Cloud sync failed: $error';
  }

  @override
  String get bucketListRetry => 'Retry';

  @override
  String get bucketListBackupTooltip => 'Backup & register';

  @override
  String get bucketListBackupTitle => 'Cloud backup';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic works fully without an account. Add one anytime if you want cloud backup for your bucket list and shared group trips.';

  @override
  String bucketListSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get bucketListBackupEmail => 'Email';

  @override
  String get bucketListBackupPassword => 'Password';

  @override
  String get bucketListBackupConfirmPassword => 'Confirm password';

  @override
  String get bucketListAuthTabSignUp => 'Sign up';

  @override
  String get bucketListAuthPasswordMismatch => 'Passwords do not match.';

  @override
  String get bucketListRegister => 'Create account & backup';

  @override
  String get bucketListSignIn => 'Sign in';

  @override
  String get bucketListSignOut => 'Sign out';

  @override
  String get bucketListBackupUploading => 'Uploading to cloud…';

  @override
  String get bucketListAuthSuccessSignIn => 'Successfully logged in!';

  @override
  String get bucketListAuthSuccessSignUp => 'Account successfully created!';

  @override
  String get signUpSuccessMessage => 'Account created. Welcome to Tripmetic!';

  @override
  String get signUpErrorEmailInUse =>
      'This email is already registered. Try signing in.';

  @override
  String get signUpErrorInvalidEmail => 'Enter a valid email.';

  @override
  String get signUpErrorWeakPassword =>
      'Password is too weak. Use at least 8 characters.';

  @override
  String signUpErrorGeneric(String message) {
    return 'Could not sign up: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'Sign in';

  @override
  String bucketListAuthFailed(String error) {
    return 'Could not authenticate: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'No notes or links yet.';

  @override
  String get groupPlannerTitle => 'Group planner';

  @override
  String get groupPlannerToolTitle => 'Group planner';

  @override
  String get groupPlannerToolSubtitle => 'Plan a trip together in real time';

  @override
  String get groupPlannerLandingPlanTitle => 'Plan a group trip';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'Create a shared trip with destination, dates, and budget.';

  @override
  String get groupPlannerLandingJoinTitle => 'Join a group trip';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'Enter the trip code or link from your invitation.';

  @override
  String get groupPlannerCreateTripTitle => 'New group trip';

  @override
  String get groupPlannerSelectDates => 'Select a trip date range.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'Per person';

  @override
  String get groupPlannerBudgetGroupOption => 'Group total';

  @override
  String get groupPlannerBudgetNoneOption => 'None';

  @override
  String get groupPlannerBudgetAmountLabel => 'Budget amount';

  @override
  String get groupPlannerOpenTitle => 'Open a group trip';

  @override
  String get groupPlannerOpenSubtitle =>
      'Paste the trip code from your invitation.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'Trip code';

  @override
  String get groupPlannerOpenHint => 'Short code, trip ID, or invitation link';

  @override
  String get groupPlannerOpenButton => 'Open trip';

  @override
  String get groupPlannerDestination => 'Destination';

  @override
  String get groupPlannerDates => 'Dates';

  @override
  String get groupPlannerGroupSize => 'Group size';

  @override
  String get groupPlannerBudget => 'Budget';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'Per person: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'Group total: $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'No budget set';

  @override
  String get groupPlannerInviteMembers => 'Invite members';

  @override
  String get groupPlannerManageMembers => 'Manage members';

  @override
  String get groupPlannerItinerary => 'Itinerary';

  @override
  String get groupPlannerItineraryEditorHint =>
      'As a trip admin or trip coordinator, you can add activities and change the schedule.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'Read-only: vote on suggested activities with thumbs up or down. Only trip admins and trip coordinators can add or change items.';

  @override
  String get groupPlannerNoActivities => 'No activities yet.';

  @override
  String get groupPlannerTripNotFound => 'This trip could not be loaded.';

  @override
  String get groupPlannerSignInTitle => 'Sign in required';

  @override
  String get groupPlannerSignInBody =>
      'Sign in under Bucket list → Cloud backup to view shared trips.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'Saving a new group trip requires an account. Sign in to continue — other Tripmetic features work without one.';

  @override
  String get groupPlannerMembersTitle => 'Members';

  @override
  String get groupPlannerRoleAdmin => 'Admin';

  @override
  String get groupPlannerRoleCoPlanner => 'Trip coordinator';

  @override
  String get groupPlannerRoleViewOnly => 'View-only';

  @override
  String get groupPlannerOwner => 'Owner';

  @override
  String get groupPlannerRemoveMember => 'Remove';

  @override
  String get groupPlannerRemoveMemberTitle => 'Remove member?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return 'Remove $email from this trip?';
  }

  @override
  String get groupPlannerCancel => 'Cancel';

  @override
  String get groupPlannerNotes => 'Notes';

  @override
  String get groupPlannerOpenLink => 'Open link';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'Could not save vote: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'Could not update members: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'Could not open share sheet: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'Could not open trip: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'Your trips';

  @override
  String get groupPlannerMyTripsEmpty => 'No trips yet. Create one above.';

  @override
  String get groupPlannerExamplesTitle => 'Example trips';

  @override
  String get groupPlannerExamplesSubtitle =>
      'Sample cards — create a trip above to add your own.';

  @override
  String get groupPlannerExampleTapBody =>
      'These are samples only. Use “Plan a group trip” to create a real trip you can share.';

  @override
  String get groupPlannerExampleLisbonTitle => 'Lisbon team offsite';

  @override
  String get groupPlannerExampleKyotoTitle => 'Kyoto spring tour';

  @override
  String get groupPlannerAddActivity => 'Add activity';

  @override
  String get groupPlannerActivityTitleLabel => 'Activity title';

  @override
  String get groupPlannerActivityWhenLabel => 'Date & time';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'Pick a day on your trip, then a time. Anyone who can edit the itinerary can change this later.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'That date is outside this trip. Choose a day between the trip start and end.';

  @override
  String get groupPlannerActivityTitleRequired => 'Enter an activity title.';

  @override
  String get groupPlannerActivityDateUnset =>
      'Date not set — tap Edit to schedule.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count people';
  }

  @override
  String get groupPlannerEditActivity => 'Edit activity';

  @override
  String get groupPlannerDeleteActivity => 'Delete';

  @override
  String get groupPlannerDeleteActivityTitle => 'Delete activity?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return 'Remove \"$title\" from the itinerary? This cannot be undone.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'Could not delete activity: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'Could not update activity: $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'Edit trip';

  @override
  String get groupPlannerEditTripAction => 'Edit trip';

  @override
  String get groupPlannerDeleteTripTitle => 'Delete trip?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return 'Permanently remove the trip \"$destination\" and its itinerary for everyone? This cannot be undone.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'Delete trip';

  @override
  String get groupPlannerTripDeleted => 'Trip removed.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'Could not delete trip: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'Could not update trip: $error';
  }

  @override
  String get widgetInstructionTitle => 'Dual Clock Widget';

  @override
  String get widgetInstructionSubtitle =>
      'Track your home and destination timezones directly from your Lock Screen or Home Screen.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'Lock Screen';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'Long-press your Lock Screen and tap \'Customize\'.';

  @override
  String get widgetInstructionIosLockScreenStep2 =>
      'Select the \'Lock Screen\' preview.';

  @override
  String get widgetInstructionIosLockScreenStep3 =>
      'Tap the widget area directly below the time.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      'Scroll down, select Tripmetic, and tap to add the widget.';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'Home Screen';

  @override
  String get widgetInstructionIosHomeScreenStep1 =>
      'Long-press an empty space on your Home Screen.';

  @override
  String get widgetInstructionIosHomeScreenStep2 =>
      'Tap the + icon in the top-left corner.';

  @override
  String get widgetInstructionIosHomeScreenStep3 => 'Search for \'Tripmetic\'.';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      'Select your preferred widget size and tap \'Add Widget\'.';

  @override
  String get widgetInstructionAndroidStep1 =>
      'Go to your Home Screen and long-press an empty area.';

  @override
  String get widgetInstructionAndroidStep2 => 'Tap \"Widgets\".';

  @override
  String get widgetInstructionAndroidStep3 => 'Scroll down to Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'Tap and hold the Dual Clock widget, then drag it onto your screen.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'To see both clocks on the lock screen: open Settings → search for “lock screen” or “widgets”, and add Tripmetic there if your phone offers lock-screen widgets (not all devices do).';

  @override
  String get widgetInstructionConfigureCta => 'Configure Widget Cities';

  @override
  String get dualClockScreenTitle => 'Dual Clock Widget';

  @override
  String get dualClockConfigTitle => 'Configure cities';

  @override
  String get dualClockConfigSubtitle =>
      'Choose two cities and timezones. Your selections sync to the Tripmetic home screen widget (Android) and lock screen widget (iOS).';

  @override
  String get dualClockCity1Label => 'First city';

  @override
  String get dualClockCity2Label => 'Second city';

  @override
  String get dualClockSave => 'Save & update widget';

  @override
  String get dualClockSaved => 'Widget updated.';

  @override
  String get dualClockSaveError =>
      'Could not save widget data. Please try again.';

  @override
  String get dualClockAppearanceTitle => 'Lock screen widget (iOS)';

  @override
  String get dualClockAppearanceHint =>
      'Larger text and shadows help on photo wallpapers. Android home widget uses system colors.';

  @override
  String get dualClockFontScaleLabel => 'Text size';

  @override
  String get dualClockColorCity => 'City names';

  @override
  String get dualClockColorTime => 'Times';

  @override
  String get dualClockColorDate => 'Dates';

  @override
  String get dualClockShadowLabel => 'Text shadow';

  @override
  String get dualClockShadowSubtitle =>
      'Adds contrast on busy or photo wallpapers.';

  @override
  String get moreToolsDualClockBannerTitle => 'Dual Clock widget';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'See two timezones on your Lock Screen or Home Screen — tap to set up.';

  @override
  String get moreToolsDualClockBannerCta => 'Set up';

  @override
  String get settingsDualClockWidgetTitle => 'Dual Clock widget';

  @override
  String get settingsDualClockWidgetSubtitle =>
      'Add the widget and choose your cities';

  @override
  String get widgetNewFeatureBadge => 'New';

  @override
  String get globalNavAccountCloudSyncTooltip => 'Account & cloud backup';

  @override
  String get exchangeRatesForceRefreshTooltip => 'Fetch latest exchange rates';

  @override
  String get exchangeRatesRefreshedOk => 'Exchange rates updated.';

  @override
  String get exchangeRatesRefreshFailed => 'Could not refresh exchange rates.';

  @override
  String get bucketListStatUsTerritories => 'U.S. territories';

  @override
  String get bucketListAuthErrUserNotFound =>
      'No account found for this email.';

  @override
  String get bucketListAuthErrWrongPassword => 'Incorrect email or password.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'An account already exists for this email.';

  @override
  String get bucketListAuthErrInvalidEmail => 'Invalid email address.';

  @override
  String get bucketListAuthErrWeakPassword => 'Password is too weak.';

  @override
  String get bucketListAuthErrUserDisabled => 'This account has been disabled.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'Too many attempts. Try again later.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'Email/password sign-in is not enabled.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => 'Invalid email address.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'Password must be at least 6 characters.';

  @override
  String get bucketListAuthValidationPasswordRequired => 'Enter your password.';
}
