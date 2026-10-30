import 'package:flutter/widgets.dart';

import '../features/packing/domain/packing_category.dart';
import '../features/scheduler/application/availability.dart';
import '../features/scheduler/application/scheduler_logic.dart';
import '../features/sizes/domain/size_conversion_data.dart';
import '../features/sizes/domain/size_input_column.dart';
import '../features/tip/application/tip_calculator_state.dart';
import '../features/trip/domain/trip_budget.dart';
import '../features/units/domain/unit_category.dart';
import '../features/units/domain/unit_conversion.dart';
import '../core/navigation/nav_feature_ids.dart';
import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

extension TripmeticL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String tripBudgetCategoryLabel(AppLocalizations l, String key) {
  if (key == TripBudgetExpenseKeys.dailyFood) return l.budgetExpenseDailyFood;
  return switch (key) {
    'Flights' => l.budgetExpenseFlights,
    'Hotels' => l.budgetExpenseHotels,
    'Transportation' => l.budgetExpenseTransportation,
    'Shopping' => l.budgetExpenseShopping,
    'Eating Out' => l.budgetExpenseEatingOut,
    'Grocery' => l.budgetExpenseGrocery,
    'Entertainment' => l.budgetExpenseEntertainment,
    'Tourism' => l.budgetExpenseTourism,
    'Phone Service' => l.budgetExpensePhoneService,
    'Travel Insurance' => l.budgetExpenseTravelInsurance,
    'Misc' => l.budgetExpenseMisc,
    _ => key,
  };
}

String tipCountryLabel(AppLocalizations l, TipCountry c) => switch (c) {
      TipCountry.brazil => l.tipCountryBrazil,
      TipCountry.china => l.tipCountryChina,
      TipCountry.colombia => l.tipCountryColombia,
      TipCountry.dominicanRepublic => l.tipCountryDominicanRepublic,
      TipCountry.egypt => l.tipCountryEgypt,
      TipCountry.france => l.tipCountryFrance,
      TipCountry.germany => l.tipCountryGermany,
      TipCountry.hongKong => l.tipCountryHongKong,
      TipCountry.indonesia => l.tipCountryIndonesia,
      TipCountry.italy => l.tipCountryItaly,
      TipCountry.japan => l.tipCountryJapan,
      TipCountry.mexico => l.tipCountryMexico,
      TipCountry.morocco => l.tipCountryMorocco,
      TipCountry.portugal => l.tipCountryPortugal,
      TipCountry.singapore => l.tipCountrySingapore,
      TipCountry.spain => l.tipCountrySpain,
      TipCountry.thailand => l.tipCountryThailand,
      TipCountry.turkey => l.tipCountryTurkey,
      TipCountry.uae => l.tipCountryUae,
      TipCountry.unitedKingdom => l.tipCountryUnitedKingdom,
      TipCountry.usa => l.tipCountryUsa,
    };

/// Localized note when a country's customary tip is 0%.
String? tipCountryZeroReason(AppLocalizations l, TipCountry c) {
  if (!c.hasZeroTipDefault) return null;
  return switch (c) {
    TipCountry.china => l.tipZeroReasonChina,
    TipCountry.france => l.tipZeroReasonFrance,
    TipCountry.japan => l.tipZeroReasonJapan,
    TipCountry.singapore => l.tipZeroReasonSingapore,
    _ => l.tipZeroReasonGeneric,
  };
}

String unitCategoryTitle(AppLocalizations l, UnitCategory category) => switch (category) {
      UnitCategory.length => l.unitCategoryLength,
      UnitCategory.weight => l.unitCategoryWeight,
      UnitCategory.volume => l.unitCategoryVolume,
      UnitCategory.distance => l.unitCategoryDistance,
      UnitCategory.area => l.unitCategoryArea,
      UnitCategory.temperature => l.unitCategoryTemperature,
    };

/// Localized unit row label for [UnitIds] values.
String unitRowLabel(AppLocalizations l, String id) => switch (id) {
      UnitIds.ft => l.unitFeet,
      UnitIds.inch => l.unitInches,
      UnitIds.cm => l.unitCentimeters,
      UnitIds.m => l.unitMeters,
      UnitIds.lb => l.unitPounds,
      UnitIds.oz => l.unitOunces,
      UnitIds.kg => l.unitKilograms,
      UnitIds.g => l.unitGrams,
      UnitIds.gal => l.unitUsGallons,
      UnitIds.l => l.unitLiters,
      UnitIds.ml => l.unitMilliliters,
      UnitIds.flOz => l.unitUsFluidOunces,
      UnitIds.mi => l.unitMiles,
      UnitIds.km => l.unitKilometers,
      UnitIds.yd => l.unitYards,
      UnitIds.sqM => l.unitSquareMeters,
      UnitIds.sqCm => l.unitSquareCentimeters,
      UnitIds.sqFt => l.unitSquareFeet,
      UnitIds.sqYd => l.unitSquareYards,
      UnitIds.sqIn => l.unitSquareInches,
      UnitIds.sqKm => l.unitSquareKilometers,
      UnitIds.hectare => l.unitHectares,
      UnitIds.acre => l.unitAcres,
      UnitIds.fahrenheit => l.unitFahrenheit,
      UnitIds.celsius => l.unitCelsius,
      _ => id,
    };

String sizeCategoryDisplay(AppLocalizations l, SizeCategory c) => switch (c) {
      SizeCategory.mensShoes => l.sizeCatMensShoes,
      SizeCategory.womensShoes => l.sizeCatWomensShoes,
      SizeCategory.womensDresses => l.sizeCatWomensDresses,
      SizeCategory.mensShirts => l.sizeCatMensShirts,
      SizeCategory.mensPants => l.sizeCatMensPants,
      SizeCategory.womensPants => l.sizeCatWomensPants,
      SizeCategory.womensBlouses => l.sizeCatWomensBlouses,
      SizeCategory.mensTshirts => l.sizeCatMensTshirts,
      SizeCategory.womensTshirts => l.sizeCatWomensTshirts,
      SizeCategory.boysShoes => l.sizeCatBoysShoes,
      SizeCategory.girlsShoes => l.sizeCatGirlsShoes,
      SizeCategory.boysTshirts => l.sizeCatBoysTshirts,
      SizeCategory.boysPants => l.sizeCatBoysPants,
      SizeCategory.girlsTshirts => l.sizeCatGirlsTshirts,
      SizeCategory.girlsPants => l.sizeCatGirlsPants,
      SizeCategory.girlsDressesKids => l.sizeCatGirlsDressesKids,
      SizeCategory.mensJeansWaist => l.sizeCatMensJeansWaist,
      SizeCategory.mensJeansInseam => l.sizeCatMensJeansInseam,
      SizeCategory.mensJeansCombo => l.sizeCatMensJeansCombo,
      SizeCategory.belts => l.sizeCatBelts,
    };

String? sizeCategorySizingTip(AppLocalizations l, SizeCategory c) => switch (c) {
      SizeCategory.mensJeansWaist => l.sizeTipJeansWaist,
      SizeCategory.mensJeansInseam => l.sizeTipJeansInseam,
      SizeCategory.mensJeansCombo => l.sizeTipJeansCombo,
      _ => null,
    };

String sizeInputHint(AppLocalizations l, SizeCategory c) => switch (c) {
      SizeCategory.mensShoes => l.sizeHintMensShoes,
      SizeCategory.womensShoes => l.sizeHintWomensShoes,
      SizeCategory.womensDresses => l.sizeHintWomensDresses,
      SizeCategory.mensShirts => l.sizeHintMensShirts,
      SizeCategory.mensPants => l.sizeHintMensPants,
      SizeCategory.womensPants => l.sizeHintWomensPants,
      SizeCategory.womensBlouses => l.sizeHintWomensBlouses,
      SizeCategory.mensTshirts => l.sizeHintMensTshirts,
      SizeCategory.womensTshirts => l.sizeHintWomensTshirts,
      SizeCategory.boysShoes => l.sizeHintBoysShoes,
      SizeCategory.girlsShoes => l.sizeHintGirlsShoes,
      SizeCategory.boysTshirts => l.sizeHintBoysTshirts,
      SizeCategory.boysPants => l.sizeHintBoysPants,
      SizeCategory.girlsTshirts => l.sizeHintGirlsTshirts,
      SizeCategory.girlsPants => l.sizeHintGirlsPants,
      SizeCategory.girlsDressesKids => l.sizeHintGirlsDressesKids,
      SizeCategory.mensJeansWaist => l.sizeHintMensJeansWaist,
      SizeCategory.mensJeansInseam => l.sizeHintMensJeansInseam,
      SizeCategory.mensJeansCombo => l.sizeHintMensJeansCombo,
      SizeCategory.belts => l.sizeHintBelts,
    };

String sizeColumnLabel(AppLocalizations l, SizeInputColumn col) => switch (col) {
      SizeInputColumn.us => l.sizeColumnPrimaryUs,
      SizeInputColumn.uk => l.sizeColumnPrimaryUk,
      SizeInputColumn.eu => l.sizeColumnPrimaryEu,
      SizeInputColumn.jp => l.sizeColumnPrimaryJp,
      SizeInputColumn.mixed => l.sizeColumnPrimaryMixed,
    };

String vaultCategoryTitle(AppLocalizations l, String category) => switch (category) {
      'Visa' => l.vaultCategoryVisa,
      'Return Flight' => l.vaultCategoryReturnFlight,
      'Arrival Card' => l.vaultCategoryArrivalCard,
      'Passport Copy' => l.vaultCategoryPassportCopy,
      'Hotel Reservation' => l.vaultCategoryHotelReservation,
      'Other' => l.vaultCategoryOther,
      _ => category,
    };

String mapSavedPinCategory(AppLocalizations l, String category) =>
    switch (category) {
      'Hotel' => l.mapMarkHotel,
      'Food' => l.mapMarkFood,
      'Landmark' => l.mapMarkLandmark,
      'Other' => l.mapMarkOther,
      _ => category,
    };

String packingCategoryHeader(AppLocalizations l, String category) {
  if (category == PackingCategory.documents) return l.packingCatDocuments;
  if (category == PackingCategory.reservations) return l.packingCatReservations;
  if (category == PackingCategory.clothing) return l.packingCatClothing;
  if (category == PackingCategory.medications) return l.packingCatMedications;
  if (category == PackingCategory.misc) return l.packingCatMisc;
  return category.toUpperCase();
}

String? packingLocalizedStarterTitle(AppLocalizations l, String id) {
  if (id.endsWith('_passport')) return l.packingStarterPassport;
  if (id.endsWith('_tickets')) return l.packingStarterTickets;
  if (id.endsWith('_socks')) return l.packingStarterSocks;
  if (id.endsWith('_shirts')) return l.packingStarterShirts;
  if (id.endsWith('_toothbrush')) return l.packingStarterToothbrush;
  return null;
}

String schedulerAvailabilityLabel(AppLocalizations l, AvailabilityStatus s) =>
    switch (s) {
      AvailabilityStatus.working => l.schedulerAvailabilityGood,
      AvailabilityStatus.marginal => l.schedulerAvailabilityOk,
      AvailabilityStatus.sleeping => l.schedulerAvailabilityOffHours,
    };

String schedulerDayRelationLabel(AppLocalizations l, DayRelation r) => switch (r) {
      DayRelation.same => l.schedulerDaySame,
      DayRelation.next => l.schedulerDayNext,
      DayRelation.previous => l.schedulerDayPrevious,
    };

String navFeatureTitle(AppLocalizations l, String id) => switch (id) {
      NavFeatureIds.dashboard => l.navDashboard,
      NavFeatureIds.itinerary => l.navItinerary,
      NavFeatureIds.currency => l.navCurrency,
      NavFeatureIds.offlineMap => l.navOfflineMap,
      NavFeatureIds.bucketList => l.bucketListTitle,
      NavFeatureIds.groupPlanner => l.groupPlannerToolTitle,
      NavFeatureIds.budget => l.toolBudgetTitle,
      NavFeatureIds.vault => l.toolVaultTitle,
      NavFeatureIds.scheduler => l.toolSchedulerTitle,
      NavFeatureIds.packing => l.toolPackingTitle,
      NavFeatureIds.units => l.toolUnitsTitle,
      NavFeatureIds.crypto => l.toolCryptoTitle,
      NavFeatureIds.tipCalculator => l.toolTipTitle,
      NavFeatureIds.sizeConverter => l.toolSizeTitle,
      NavFeatureIds.mindMap => l.toolMindMapTitle,
      NavFeatureIds.dualClock => l.dualClockScreenTitle,
      NavFeatureIds.settings => l.toolSettingsInfo,
      _ => id,
    };

String navFeatureSubtitle(AppLocalizations l, String id) => switch (id) {
      NavFeatureIds.dashboard => l.navDashboardBody,
      NavFeatureIds.itinerary => l.toolItinerarySubtitle,
      NavFeatureIds.currency => l.moreToolsSubtitle,
      NavFeatureIds.offlineMap => l.mapDownloadCurrentRegion,
      NavFeatureIds.bucketList => l.bucketListToolSubtitle,
      NavFeatureIds.groupPlanner => l.groupPlannerToolSubtitle,
      NavFeatureIds.budget => l.toolBudgetSubtitle,
      NavFeatureIds.vault => l.toolVaultSubtitle,
      NavFeatureIds.scheduler => l.toolSchedulerSubtitle,
      NavFeatureIds.packing => l.toolPackingSubtitle,
      NavFeatureIds.units => l.toolUnitsSubtitle,
      NavFeatureIds.crypto => l.toolCryptoSubtitle,
      NavFeatureIds.tipCalculator => l.toolTipSubtitle,
      NavFeatureIds.sizeConverter => l.toolSizeSubtitle,
      NavFeatureIds.mindMap => l.toolMindMapSubtitle,
      NavFeatureIds.dualClock => l.moreToolsDualClockBannerSubtitle,
      NavFeatureIds.settings => l.toolSettingsAboutSubtitle,
      _ => '',
    };
