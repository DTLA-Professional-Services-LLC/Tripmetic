// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'الرجاء إدخال عنوان';

  @override
  String get addItineraryFieldLocation => 'موقع';

  @override
  String get addItineraryFieldNotes => 'ملاحظات / تأكيد';

  @override
  String get addItineraryFieldTitle => 'عنوان';

  @override
  String get addItineraryHintLocation => 'المطار، عنوان الفندق…';

  @override
  String get addItineraryHintNotes => 'سجل محدد، وصلات...';

  @override
  String get addItineraryHintTitle => 'رحلة إلى لشبونة';

  @override
  String get addItinerarySave => 'حفظ الحدث';

  @override
  String get addItineraryTitle => 'أضف حدث خط سير الرحلة';

  @override
  String get addPackingAddToList => 'أضف إلى القائمة';

  @override
  String get addPackingEnterName => 'الرجاء إدخال اسم العنصر';

  @override
  String get addPackingFieldCategory => 'فئة';

  @override
  String get addPackingFieldItemName => 'اسم العنصر';

  @override
  String get addPackingHint => 'على سبيل المثال محول الطاقة';

  @override
  String get addPackingIcon => 'رمز';

  @override
  String get addPackingQuantity => 'كمية';

  @override
  String get addPackingTitle => 'إضافة عنصر التعبئة';

  @override
  String get announcementsLatest => 'آخر التحديثات';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => 'العملة الأساسية';

  @override
  String get budgetCategoryDialogHint => 'على سبيل المثال الهدايا التذكارية';

  @override
  String get budgetCategoryNameExists => 'الاسم موجود بالفعل';

  @override
  String get budgetCategoryNameMax => 'الحد الأقصى 40 حرفًا';

  @override
  String get budgetDailyFood => 'الطعام اليومي';

  @override
  String get budgetDestinationSearchHint => 'البحث عن رمز البلد أو العملة';

  @override
  String get budgetDestinationTitle => 'أضف الوجهة';

  @override
  String get budgetDialogAdd => 'يضيف';

  @override
  String get budgetDialogNewCategory => 'فئة النفقات الجديدة';

  @override
  String budgetDialogRemoveBody(String name) {
    return 'هل تريد إزالة \"$name\" ومبلغه؟';
  }

  @override
  String get budgetDialogRemoveTitle => 'إزالة الفئة';

  @override
  String get budgetDialogRename => 'إعادة تسمية';

  @override
  String get budgetDialogRenameCategory => 'إعادة تسمية الفئة';

  @override
  String get budgetEdit => 'تحرير الميزانية';

  @override
  String get budgetExpenseDailyFood => 'الغذاء اليومي';

  @override
  String get budgetExpenseEatingOut => 'تناول الطعام بالخارج';

  @override
  String get budgetExpenseEntertainment => 'ترفيه';

  @override
  String get budgetExpenseFlights => 'الرحلات الجوية';

  @override
  String get budgetExpenseGrocery => 'خضروات';

  @override
  String get budgetExpenseHotels => 'الفنادق';

  @override
  String get budgetExpenseMisc => 'متنوعات';

  @override
  String get budgetExpensePhoneService => 'خدمة الهاتف';

  @override
  String get budgetExpenseShopping => 'التسوق';

  @override
  String get budgetExpenseTourism => 'السياحة';

  @override
  String get budgetExpenseTransportation => 'مواصلات';

  @override
  String get budgetExpenseTravelInsurance => 'تأمين السفر';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => 'في وجهاتك';

  @override
  String get budgetNoCategories => 'لا توجد فئات النفقات حتى الآن';

  @override
  String budgetOtherExpenses(String code) {
    return 'مصاريف أخرى ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'في اليوم (تقديري)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / يوم';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'المتبقي بعد النفقات · $code';
  }

  @override
  String get budgetSave => 'حفظ الميزانية';

  @override
  String get budgetSpendingPower => 'قوة الإنفاق';

  @override
  String get budgetSpentVsBudget => 'الإنفاق مقابل الميزانية';

  @override
  String budgetTotalBudget(String code) {
    return 'إجمالي الميزانية ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return 'إجمالي الرحلة ($code)';
  }

  @override
  String get budgetTripDashboard => 'لوحة القيادة';

  @override
  String get budgetTripLengthDays => 'مدة الرحلة (أيام)';

  @override
  String get budgetTripTitle => 'ميزانية الرحلة';

  @override
  String get commonAdd => 'يضيف';

  @override
  String get commonCancel => 'يلغي';

  @override
  String get commonDelete => 'يمسح';

  @override
  String get commonOk => 'نعم';

  @override
  String get commonRemove => 'يزيل';

  @override
  String get commonRename => 'إعادة تسمية';

  @override
  String get commonSave => 'يحفظ';

  @override
  String get commonKeyboardDone => 'منتهي';

  @override
  String countryCountriesCount(String count) {
    return '$count البلدان';
  }

  @override
  String get countryPickerTitle => 'اختر البلد';

  @override
  String get countrySheetSearchHint => 'ابحث عن اسم البلد أو رمز ISO';

  @override
  String get countrySheetTitle => 'البلد/المنطقة الأساسية';

  @override
  String get cryptoHeader => 'تشفير';

  @override
  String cryptoMockPerUnit(String price) {
    return 'وهمية ~$price / وحدة';
  }

  @override
  String get cryptoPickerTitle => 'اختر عملة معدنية';

  @override
  String get cryptoSheetTitle => 'حدد العملة المشفرة';

  @override
  String get currencyPickerSearchHint => 'بحث في شريط أو اسم';

  @override
  String get currencyPickerTitle => 'اختر عملة';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown من $total معروض';
  }

  @override
  String get currencySheetSearchHint => 'رمز البحث أو الاسم أو الرقم ISO';

  @override
  String get currencySheetTitle => 'اختر العملة';

  @override
  String get exchangeBaseSuffix => '· قاعدة';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'تعذر تحميل الأسعار\n$error';
  }

  @override
  String get exchangeHeader => 'تبادل';

  @override
  String exchangeLastUpdated(String mins) {
    return 'تم آخر تحديث منذ $mins دقيقة';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'تم آخر تحديث منذ $mins دقيقة (غير متصل)';
  }

  @override
  String get exchangeResetOne => 'إعادة التعيين إلى 1 (قاعدة USD)';

  @override
  String get exchangeResetTooltip => 'إعادة تعيين المبالغ';

  @override
  String get exchangeResetZero => 'واضح إلى 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'اليوم $day: $date';
  }

  @override
  String get itineraryEmpty =>
      'لا توجد أحداث حتى الآن.\nاضغط على + لإضافة رحلات الطيران والفنادق والخطط.';

  @override
  String get itineraryHeader => 'خط سير الرحلة';

  @override
  String itineraryHiveError(String error) {
    return 'تعذر فتح بيانات خط سير الرحلة المحفوظة.\nلا يزال بإمكانك محاولة إضافة الأحداث - فقد لا تستمر.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'فتح على الخريطة';

  @override
  String get mapAddToTrip => 'أضف إلى الرحلة';

  @override
  String get mapClearRoute => 'مسح الطريق والتوجيه';

  @override
  String get mapClearTooltip => 'واضح';

  @override
  String get mapDisplayCurrentViewport => 'إطار العرض الحالي';

  @override
  String get mapDisplaySavedSearch => 'البحث المحفوظ';

  @override
  String get mapDisplayTripDestination => 'وجهة الرحلة';

  @override
  String get mapDownloadAll => 'تحميل الكل';

  @override
  String get mapDownloadCurrentRegion =>
      'قم بتنزيل المنطقة الحالية للاستخدام دون اتصال بالإنترنت';

  @override
  String get mapDownloadThisDestination => 'قم بتنزيل هذه الوجهة';

  @override
  String get mapDownloadedRegions => 'المناطق التي تم تنزيلها';

  @override
  String get mapDownloadingRegion => 'جارٍ تنزيل المنطقة...';

  @override
  String mapDownloadingTitle(String title) {
    return 'جاري التحميل $title...';
  }

  @override
  String get mapFromItinerary => 'من خط سير الرحلة الخاص بك';

  @override
  String get mapItineraryEmptyHint =>
      'أضف وجهات خط سير الرحلة لتنزيلها مسبقًا هنا.';

  @override
  String get mapLoadingRegions => 'جارٍ تحميل المناطق غير المتصلة…';

  @override
  String mapLocatingQuery(String query) {
    return 'تحديد موقع $query...';
  }

  @override
  String get mapMarkCategoryBody =>
      'اختر كيفية تسمية هذا الدبوس غير المتصل بالإنترنت.';

  @override
  String get mapMarkCategoryTitle => 'الفئة لهذه العلامة';

  @override
  String get mapMarkFood => 'طعام';

  @override
  String get mapMarkHotel => 'الفندق';

  @override
  String get mapMarkLandmark => 'معلم';

  @override
  String get mapMarkOther => 'آخر';

  @override
  String mapNextInstruction(String current, String total) {
    return 'التعليمات التالية ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'لم يتم تحديد الموقع';

  @override
  String get mapNoRegionsYet => 'لم تقم بتنزيل أي مناطق بعد.';

  @override
  String get mapOfflineIntro =>
      'احفظ المنطقة المرئية حاليًا، أو قم بتنزيل وجهات رحلتك مسبقًا حتى تتمكن من التنقل عندما تكون خارج الشبكة.';

  @override
  String get mapOfflineMapsTitle => 'خرائط دون اتصال';

  @override
  String get mapRefreshTooltip => 'ينعش';

  @override
  String get mapRemovePinTooltip => 'إزالة الدبوس';

  @override
  String get mapSaveOffline => 'حفظ دون اتصال';

  @override
  String get mapSavePinToMap => 'حفظ الدبوس على الخريطة';

  @override
  String get mapSavedPinsBody =>
      'الدبابيس التي قمت بحفظها من البحث. اضغط على \"حذف\" لإزالة واحدة من الخريطة.';

  @override
  String get mapSavedPinsTitle => 'دبابيس الخريطة المحفوظة';

  @override
  String get mapSearchHint => 'ابحث عن مدينة أو عنوان أو معلم...';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return 'تمت إضافة $title إلى علامات عدم الاتصال بالإنترنت.';
  }

  @override
  String get mapSnackArrived => 'لقد وصلت.';

  @override
  String mapSnackCouldNotFind(String query) {
    return 'تعذر العثور على \"$query\".';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'فشل الحذف: $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return 'فشل التنزيل دون اتصال: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return 'تم تنزيل \"$title\".';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\" لم يتم تحديد موقع له.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'تم الانتهاء من تنزيل منطقة (مناطق) خط سير الرحلة $count.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'تعذر تحميل المناطق غير المتصلة بالإنترنت: $error';
  }

  @override
  String get mapSnackLocationOff =>
      'خدمة تحديد الموقع متوقفة. قم بتمكينه لبدء التنقل.';

  @override
  String get mapSnackLocationPermission => 'مطلوب إذن الموقع منعطف بمنعطف.';

  @override
  String get mapSnackLocationDeniedForMap =>
      'مطلوب إذن الموقع لتوسيط الخريطة عليك.';

  @override
  String get mapSnackLocateFail => 'غير قادر على الحصول على موقعك الآن.';

  @override
  String get mapLocateMeTooltip => 'اذهب إلى موقعي';

  @override
  String get mapSnackMapNotReady =>
      'الخريطة ليست جاهزة بعد. من فضلك انتظر لحظة.';

  @override
  String get mapSnackNavStartFail => 'غير قادر على بدء التنقل الآن.';

  @override
  String get mapSnackNavStopped => 'توقفت الملاحة.';

  @override
  String get mapSnackNoItineraryLocations =>
      'لا يوجد لأحداث خط سير الرحلة موقع أو نقطة خريطة لتنزيلها.';

  @override
  String get mapSnackNoManeuver => 'هذه الخطوة ليس لها نقطة مناورة دقيقة.';

  @override
  String get mapSnackNoRoute => 'تعذر العثور على الطريق؛ تظهر الوجهة.';

  @override
  String get mapSnackRegionDownloaded =>
      'تم تنزيل المنطقة بنجاح! يمكنك الآن التنقل دون اتصال بالإنترنت.';

  @override
  String get mapSnackRemovedPin => 'تمت إزالة الدبوس المحفوظ.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'تمت إزالة المنطقة غير المتصلة بالإنترنت \"$name\".';
  }

  @override
  String get mapSnackRouteCleared => 'تم محو المسار والإرشاد.';

  @override
  String mapSnackRoutingFailed(String error) {
    return 'فشل التوجيه: $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return 'فشل البحث: $error';
  }

  @override
  String get mapStartNavigation => 'ابدأ التنقل';

  @override
  String get mapStartingNav => 'جارٍ بدء التنقل...';

  @override
  String get mapStopNavigation => 'إيقاف الملاحة';

  @override
  String get mapTravelDriving => 'القيادة';

  @override
  String get mapTravelWalking => 'المشي';

  @override
  String mapTurnByTurn(String mode) {
    return 'خطوة بخطوة ($mode)';
  }

  @override
  String get mindMapCaptureFail =>
      'لا يمكن التقاط الخريطة الذهنية. حاول ثانية.';

  @override
  String get mindMapClearBody =>
      'يؤدي هذا إلى إزالة جميع العقد واستعادة الخريطة الذهنية التجريبية (المثال المركزي).';

  @override
  String get mindMapClearTitle => 'قماش واضح؟';

  @override
  String get mindMapClearTooltip => 'مسح / إعادة تعيين';

  @override
  String mindMapCouldNotSave(String error) {
    return 'لا يمكن حفظ: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'لا يمكن حفظ: $type';
  }

  @override
  String get mindMapEmailShare => 'البريد الإلكتروني / حصة';

  @override
  String get mindMapEmptyNode => 'عقدة فارغة';

  @override
  String get mindMapHelpHint =>
      'قرصة للتكبير · اسحب اللوحة القماشية · اسحب البطاقات · اضغط على البطاقة لتحريرها · + إضافة طفل';

  @override
  String get mindMapNodeAddLeftTooltip => 'إضافة الطفل الأيسر';

  @override
  String get mindMapNodeAddRightTooltip => 'أضف الطفل المناسب';

  @override
  String get mindMapNodeDeleteTooltip => 'حذف العقدة';

  @override
  String get mindMapNodeEditTitle => 'تحرير العقدة';

  @override
  String get mindMapNodeHint => 'أدخل تسمية قصيرة';

  @override
  String get mindMapPhotoAccess => 'مطلوب الوصول إلى مكتبة الصور لحفظ الصورة.';

  @override
  String get mindMapReset => 'إعادة ضبط';

  @override
  String get mindMapSavePhoto => 'حفظ كصورة';

  @override
  String get mindMapSavedPhotos => 'تم الحفظ في الصور';

  @override
  String get mindMapShareCaptureFail =>
      'لا يمكن التقاط الخريطة الذهنية للمشاركة.';

  @override
  String get mindMapShareCompleted => 'اكتملت المشاركة';

  @override
  String mindMapShareFailed(String error) {
    return 'فشلت المشاركة: $error';
  }

  @override
  String get mindMapShareReady => 'الصورة جاهزة — اختر تطبيقًا لمشاركته';

  @override
  String get mindMapShareSheetClosed => 'ورقة المشاركة مغلقة';

  @override
  String get mindMapShareSubject => 'Tripmetic — الخريطة الذهنية';

  @override
  String get mindMapShareText => 'تصدير الخريطة الذهنية من Tripmetic';

  @override
  String get mindMapTapToEdit => 'انقر للتحرير';

  @override
  String get moreToolsHeader => 'المزيد من الأدوات';

  @override
  String get moreToolsSubtitle => 'مرافق السفر';

  @override
  String get navCurrency => 'عملة';

  @override
  String get navItinerary => 'خط سير الرحلة';

  @override
  String get navMoreTools => 'المزيد من الأدوات';

  @override
  String get navOfflineMap => 'خريطة غير متصل';

  @override
  String get navDashboard => 'لوحة القيادة';

  @override
  String get navMoreMenu => 'أكثر';

  @override
  String get navEditNavigation => 'تحرير الملاحة';

  @override
  String get navDoneEditing => 'منتهي';

  @override
  String get navSelectSlotHint =>
      'اضغط على إحدى الفتحات، ثم اضغط على أداة لتعيينها.';

  @override
  String get navSavePins => 'يحفظ';

  @override
  String get navPinnedSectionTitle => 'مثبت في الشريط السفلي';

  @override
  String get navAvailableSectionTitle => 'الميزات المتاحة';

  @override
  String get navEmptySlot => 'فارغ - أضف مما هو متاح أدناه';

  @override
  String get navPinFullHint =>
      'جميع الفتحات الأربع ممتلئة. قم بإزالة واحد لإضافة آخر.';

  @override
  String get navEditPinnedHint =>
      'استخدم - لتحرير إحدى الفتحات، أو + لملء إحدى الفتحات، أو اسحب لإعادة الترتيب. احفظ عندما تمتلئ الأربعة.';

  @override
  String get navAddToPinned => 'أضف إلى الشريط السفلي';

  @override
  String get navRemoveFromPinned => 'إزالة من الشريط السفلي';

  @override
  String get navFeatureBadgeFree => 'حر';

  @override
  String get navFeatureBadgePro => 'للمحترفين';

  @override
  String get moreMenuSectionFree => 'ميزات مجانية';

  @override
  String get moreMenuSectionPro => 'Tripmetic برو';

  @override
  String get ourAppsMenuTitle => 'تطبيقاتنا';

  @override
  String get ourAppsMenuSubtitle => 'المزيد من البرامج من فريق p1.do';

  @override
  String get ourAppsScreenTitle => 'تطبيقاتنا';

  @override
  String get ourAppsIntro =>
      'برنامج من فريق p1.do — انقر فوق تطبيق مباشر لفتح موقعه. ستريم CRM قريبا.';

  @override
  String get ourAppsBadgeLive => 'متاح';

  @override
  String get ourAppsBadgeSoon => 'قريباً';

  @override
  String get ourAppsBadgeThisApp => 'هذا التطبيق';

  @override
  String get ourAppsViewOnline => 'عرض الكل على p1.do';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => 'الويب · الجوال';

  @override
  String get ourAppsPlatformWebTabletMobile =>
      'الويب · الكمبيوتر اللوحي · الهاتف المحمول';

  @override
  String get ourAppsTravelRecapTagline => 'AI طرق السفر وملخصات الصور';

  @override
  String get ourAppsTravelRecapSummary =>
      'خطط لرحلات متعددة التوقفات على خريطة تفاعلية، وقم بإنشاء مسارات باستخدام AI، وأضف الوجهات، وقم بتصدير ملخصات السفر المصقولة من صورك.';

  @override
  String get ourAppsP1doTagline => 'الرابط في السيرة الذاتية والمنشئ CRM';

  @override
  String get ourAppsP1doSummary =>
      'رابط في السيرة الذاتية لمنشئي المحتوى الذين يجذبون CRM عملاء محتملين - بالإضافة إلى Premium Selling وحجز المواعيد - دون خصم إضافي من أرباحك بالإضافة إلى الرسوم الشهرية.';

  @override
  String get ourAppsDockTxtTagline =>
      'macOS لوحة مسودة مثبتة على الحافة وفرق دقيق';

  @override
  String get ourAppsDockTxtSummary =>
      'درج عائم أصلي مجاني macOS للعمل على مسودة النص العادي، وتعقيم المسافات البيضاء، وتجميل JSON، والاختلافات على مستوى الأحرف.';

  @override
  String get ourAppsTripmeticTagline =>
      'مجموعة أدوات السفر العالمية ومخطط الميزانية';

  @override
  String get ourAppsTripmeticSummary =>
      'لوحة تحكم واحدة لقوائم المجموعات، والخرائط غير المتصلة بالإنترنت، وخطوط سير الرحلات الجماعية، وميزانيات البلدان المتعددة، وعناصر واجهة مستخدم المنطقة الزمنية، وقوائم التعبئة، والمحولات.';

  @override
  String get ourAppsPayxtTagline => 'الفواتير النصية للدفع في ثوان';

  @override
  String get ourAppsPayxtSummary =>
      'يمكنك تحويل رسالة نصية إلى فاتورة مدفوعة آمنة باستخدام روابط الدفع التي تدعم Stripe وPayPal لمحترفي الهاتف المحمول.';

  @override
  String get ourAppsPermitMobileTagline => 'تعقب تصريح البناء للمعيدين';

  @override
  String get ourAppsPermitMobileSummary =>
      'راقب حالة تصريح البناء التابع للبلدية من موقع العمل — الأرقام والعناوين وتحديثات الموافقة من بوابات المدينة.';

  @override
  String get ourAppsTrackkrTagline => 'إدارة قطع الشقق';

  @override
  String get ourAppsTrackkrSummary =>
      'قم بتسجيل الحزم الواردة في ثوانٍ، وقم بإخطار المستأجرين عبر البريد الإلكتروني (وSMS الاختياري)، وقم بإدارة وحدات غير محدودة في خطة أساسية مجانية إلى الأبد.';

  @override
  String get ourAppsKeyForecastsTagline => 'وحدة التحكم الجزئية لقادة HVAC';

  @override
  String get ourAppsKeyForecastsSummary =>
      'المعلومات المالية التنفيذية لـ HVAC والبناء - تكلفة الوظائف، والتنبؤ بالتدفق النقدي الموسمي، وإعداد التقارير الجاهزة للقياس.';

  @override
  String get ourAppsStreamCrmTagline =>
      'TikTok التتبع المباشر للهدايا والمتبرعين CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'تتبع الهدايا المباشرة TikTok في الوقت الفعلي، وافصل إنفاق المانحين عن أرباحك، وقم برعاية كبار الداعمين من خلال الملفات الشخصية للمانحين.';

  @override
  String get proGlassTeaserTitle => 'Tripmetic الميزة الاحترافية';

  @override
  String get dashboardWorldExplorerSection => 'مستكشف العالم';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'البلدان التي تمت زيارتها';

  @override
  String get dashboardWorldExplorerPercentLabel => 'من العالم استكشاف';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => 'اسم العرض';

  @override
  String get bucketListMapUnavailable =>
      'الخريطة غير متاحة لأنه لم يتم إعداد رمز وصول Mapbox.';

  @override
  String get bucketListAuthValidationDisplayName => 'أدخل اسمك';

  @override
  String get authSignUpScreenTitle => 'قم بإنشاء حساب Tripmetic الخاص بك';

  @override
  String get authSignUpScreenSubtitle =>
      'اختياري - فقط إذا كنت تريد النسخ الاحتياطي السحابي. يمكنك الاستمرار في استخدام جميع الأدوات الموجودة على هذا الجهاز دون الاشتراك.';

  @override
  String get authSignInScreenTitle => 'تسجيل الدخول إلى Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      'اختياري — لمزامنة قائمة المجموعة الخاصة بك ورحلات المجموعة السحابية. بقية Tripmetic تعمل بدون حساب.';

  @override
  String get authForgotPassword => 'هل نسيت كلمة السر؟';

  @override
  String get authPasswordResetConfirmation =>
      'إذا كان هناك حساب لهذا البريد الإلكتروني، فسوف تتلقى رابطًا لإعادة تعيين كلمة المرور الخاصة بك.';

  @override
  String get authUnexpectedError => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get authBackupBulletBucketList =>
      'يتم حفظ وجهات قائمة المجموعة في السحابة ويتم دمجها عند تسجيل الدخول.';

  @override
  String get authBackupBulletGroupTrips =>
      'يتم تخزين الرحلات الجماعية التي تقوم بإنشائها أو الانضمام إليها ضمن حسابك.';

  @override
  String get authBackupBulletMultiDevice =>
      'قم بتسجيل الدخول على جهاز آخر لاستعادة بياناتك المتزامنة.';

  @override
  String get authLinkAlreadyHaveAccount => 'هل لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get authLinkNeedAccount => 'هل تحتاج إلى حساب؟ قم بإنشاء واحدة';

  @override
  String get authFullSignUpCta => 'استخدم شاشة التسجيل الكاملة';

  @override
  String get authFullSignInCta => 'استخدم شاشة تسجيل الدخول الكاملة';

  @override
  String dashboardGreeting(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get dashboardGuestName => 'مسافر';

  @override
  String get dashboardWelcomeSubtitle =>
      'خططوا معًا، وحافظوا على تنظيمكم، واستخدموا الأدوات بنقرة واحدة.';

  @override
  String get dashboardPlanGroupTrip => 'خطط لرحلة جماعية جديدة';

  @override
  String get dashboardAddBucketList => 'إضافة إلى قائمة دلو';

  @override
  String get dashboardActiveTripSection => 'لقطة الرحلة النشطة';

  @override
  String get dashboardNoUpcomingTripTitle => 'لا توجد رحلة جماعية قادمة';

  @override
  String get dashboardNoUpcomingTripBody =>
      'عندما تخطط مع الأصدقاء، يظهر ملخص رحلتك القادمة هنا.';

  @override
  String get dashboardQuickToolsSection => 'أدوات سريعة';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'يبدأ خلال $days من الأيام';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'ينتهي خلال $days من الأيام';
  }

  @override
  String get navDashboardBody =>
      'مركز رحلتك — افتح الأدوات من الشريط أو قائمة المزيد.';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic برو';

  @override
  String get settingsSubscriptionActive => 'الاشتراك النشط';

  @override
  String get settingsSubscriptionLifetime => 'الوصول مدى الحياة';

  @override
  String get settingsSubscriptionFree => 'خطة مجانية';

  @override
  String get settingsManageBilling => 'إدارة الفواتير';

  @override
  String get settingsTestModeSectionTitle => 'وضع الاختبار';

  @override
  String get settingsTestModeProTitle => 'اختبر كـ Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'التجاوز المحلي للاختبار؛ يتجاهل RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'عند التمكين، يفتح هذا الجهاز جميع ميزات Pro محليًا. مخصص للاختبار الداخلي فقط، ولا يغير اشتراكك الحقيقي.';

  @override
  String get settingsUnitsTitle => 'وحدات القياس';

  @override
  String get settingsLanguageTitle => 'لغة';

  @override
  String get settingsThemeTitle => 'سمة';

  @override
  String get settingsClockWidgetTitle => 'القطعة على مدار الساعة';

  @override
  String get settingsCurrencyWidgetTitle => 'القطعة العملة';

  @override
  String get settingsCurrencyWidgetSubtitle =>
      'الشاشة الرئيسية وشاشة القفل: 1، 20، 100 من عملتك الأساسية';

  @override
  String get settingsThemeSystem => 'نظام';

  @override
  String get settingsThemeLight => 'ضوء';

  @override
  String get settingsThemeDark => 'مظلم';

  @override
  String get settingsLanguageSystem => 'الافتراضي للنظام';

  @override
  String get settingsLanguageEnglish => 'إنجليزي';

  @override
  String get settingsLanguageSpanish => 'الأسبانية';

  @override
  String get settingsProfileTitle => 'الملف الشخصي والمزامنة السحابية';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsLogoutConfirm => 'تسجيل الخروج من هذا الحساب؟';

  @override
  String get settingsDeleteAccount => 'حذف الحساب';

  @override
  String get settingsDeleteAccountBody =>
      'تتم معالجة حذف الحساب عن طريق الدعم. يمكنك تسجيل الخروج أدناه.';

  @override
  String get settingsSectionAccount => 'حساب';

  @override
  String get accountManagementListTitle => 'إدارة الحساب';

  @override
  String get accountManagementListSubtitle =>
      'قم بتحديث اسمك والبريد الإلكتروني وكلمة المرور';

  @override
  String get accountManagementTitle => 'إدارة الحساب';

  @override
  String get accountSectionProfile => 'حساب تعريفي';

  @override
  String get accountSectionSignIn => 'تسجيل الدخول';

  @override
  String get accountFieldDisplayName => 'اسم العرض';

  @override
  String get accountFieldEmail => 'بريد إلكتروني';

  @override
  String get accountFieldCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get accountFieldNewPassword => 'كلمة المرور الجديدة';

  @override
  String get accountSaveName => 'حفظ الاسم';

  @override
  String get accountChangeEmail => 'إرسال التحقق وتغيير البريد الإلكتروني';

  @override
  String get accountChangePassword => 'تغيير كلمة المرور';

  @override
  String get accountSignedOutMessage => 'يجب عليك تسجيل الدخول لإدارة حسابك.';

  @override
  String get accountSignInCta => 'تسجيل الدخول';

  @override
  String get accountNameSaved => 'تم تحديث الاسم';

  @override
  String accountEmailVerificationSent(String email) {
    return 'تم إرسال رابط التحقق إلى $email. قم بتأكيده لتبديل عنوان تسجيل الدخول الخاص بك.';
  }

  @override
  String get accountPasswordChanged => 'تم تحديث كلمة المرور';

  @override
  String accountReauthRequired(String field) {
    return 'لدواعي الأمان، قم بتسجيل الدخول مرة أخرى لتغيير $field الخاص بك.';
  }

  @override
  String get accountFieldLabelEmail => 'بريد إلكتروني';

  @override
  String get accountFieldLabelPassword => 'كلمة المرور';

  @override
  String accountErrorGeneric(String field, String error) {
    return 'تعذر تحديث $field: $error';
  }

  @override
  String get accountReauthAction => 'قم بتسجيل الدخول مرة أخرى';

  @override
  String get accountValidationEmailRequired => 'أدخل بريدك الإلكتروني';

  @override
  String get accountValidationEmailInvalid => 'أدخل بريدًا إلكترونيًا صالحًا';

  @override
  String get accountValidationNameRequired => 'أدخل اسمك';

  @override
  String get accountValidationPasswordTooShort => 'استخدم 8 أحرف على الأقل';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'البريد الإلكتروني الحالي: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic برو';

  @override
  String get proPaywallSubtitle =>
      'افتح الخرائط غير المتصلة بالإنترنت وأدوات السفر العميقة والتعاون.';

  @override
  String get proPaywallBenefits =>
      'خرائط دون اتصال وتنزيلات المنطقة\nخط سير الرحلة والميزانية والقبو والتعبئة\nمخطط المجموعة والمزامنة في الوقت الحقيقي';

  @override
  String get proPaywallBullets =>
      'خرائط دون اتصال وتنزيلات المنطقة|خط سير الرحلة والميزانية والقبو والتعبئة|مخطط المجموعة والمزامنة في الوقت الحقيقي';

  @override
  String get proPaywallUpgradeRevenueCat => 'الترقية عبر RevenueCat';

  @override
  String get upgradeNow => 'قم بالترقية الآن';

  @override
  String get packingCatClothing => 'ملابس';

  @override
  String get packingCatDocuments => 'وثائق';

  @override
  String get packingCatMedications => 'الأدوية';

  @override
  String get packingCatMisc => 'متفرقات';

  @override
  String get packingCatReservations => 'الحجوزات';

  @override
  String get packingEmpty => 'قائمتك فارغة.\nاضغط على + لإضافة عناصر.';

  @override
  String get packingEmptyHidden =>
      'لم يتبق شيء لحزمه - أو قم بإيقاف تشغيل \"إخفاء المكتمل\" لرؤية العناصر المكتملة.';

  @override
  String get packingHeader => 'التعبئة والخدمات اللوجستية';

  @override
  String get packingHideCompleted => 'تم إخفاء';

  @override
  String get packingHideCompletedSubtitle =>
      'تظل العناصر المكتملة محفوظة؛ مخفية فقط من هذا الرأي';

  @override
  String get packingStarterPassport => 'جواز سفر';

  @override
  String get packingStarterShirts => 'قمصان';

  @override
  String get packingStarterSocks => 'الجوارب';

  @override
  String get packingStarterTickets => 'تذاكر الطيران';

  @override
  String get packingStarterToothbrush => 'فرشاة الأسنان';

  @override
  String get paywallDisabledBody =>
      'تم تعطيل نظام حظر الاشتراك غير المدفوع مؤقتًا لمراجعة واجهة المستخدم RevenueCat.';

  @override
  String get paywallDisabledTitle => 'تم تعطيل نظام حظر الاشتراك غير المدفوع';

  @override
  String get presentationDeleteBody =>
      'هل أنت متأكد أنك تريد إزالة هذا المستند من المخزن؟';

  @override
  String get presentationDeleteTitle => 'هل تريد حذف المستند؟';

  @override
  String get presentationImageLoadFail => 'فشل تحميل الصورة';

  @override
  String get proActive => 'نشيط';

  @override
  String get proManageHintFree => 'افتح ميزات Pro من خلال اشتراك شهري.';

  @override
  String get proManageHintPro => 'إدارة اشتراكك أو استعادة المشتريات.';

  @override
  String get proManageSubscription => 'إدارة الاشتراك';

  @override
  String get proName => 'Tripmetic برو';

  @override
  String get proPaywallError =>
      'لا يمكن إظهار نظام Paywall. تحقق من عرض RevenueCat الخاص بك.';

  @override
  String get proPaywallNotConfigured =>
      'الاشتراكات غير متوفرة في هذا التثبيت. قم بتثبيت Tripmetic من Google Play للترقية إلى Pro.';

  @override
  String proRestoreFailed(String message) {
    return 'فشلت الاستعادة: $message';
  }

  @override
  String get proTrialCta => 'ابدأ تجربتك المجانية لمدة 3 أيام';

  @override
  String get proWelcome => 'مرحبًا بك في Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'جيد';

  @override
  String get schedulerAvailabilityOffHours => 'خارج ساعات العمل';

  @override
  String get schedulerAvailabilityOk => 'نعم';

  @override
  String get schedulerBaseLocation => 'الموقع الأساسي';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'ينطبق التاريخ والوقت وشريط التمرير على الساعة الأساسية ($zone). يُظهر كل صف مدينة نفس اللحظة في تلك المنطقة.';
  }

  @override
  String get schedulerConvertedCities => 'المدن المحولة';

  @override
  String get schedulerDayNext => '+1 يوم';

  @override
  String get schedulerDayPrevious => '-1 يوم';

  @override
  String get schedulerDaySame => 'نفس اليوم';

  @override
  String get schedulerMeetingTime => 'وقت الاجتماع';

  @override
  String get schedulerSubtitle => 'تداخل الاجتماع';

  @override
  String get schedulerTitle => 'جدولة العالمية';

  @override
  String get settingsAndInfo => 'الإعدادات والمعلومات';

  @override
  String get settingsContact => 'اتصل بنا';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'لا يمكن فتح الرابط';

  @override
  String get settingsHelpFaq => 'المساعدة والأسئلة الشائعة';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsSupportLegal => 'الدعم والقانوني';

  @override
  String get settingsTerms => 'شروط الاستخدام';

  @override
  String get settingsMapboxAttributionTitle => 'بيانات الخريطة (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic يستخدم خرائط Mapbox. © Mapbox، © OpenStreetMap، وغيرهم من المساهمين في البيانات. يتم إخفاء الشعار الموجود على الخريطة والتحكم في الإسناد في التطبيق للحصول على تخطيط أكثر وضوحًا وعدد أقل من النقرات غير المقصودة؛ يلبي هذا الإشعار متطلبات عرض Mapbox.';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — حول الخرائط';

  @override
  String get sizeCatBelts => 'أحزمة';

  @override
  String get sizeCatMensJeansCombo => 'جينز للرجال - W×L (الولايات المتحدة)';

  @override
  String get sizeCatMensJeansInseam => 'جينز رجالي — درزة داخلية (L)';

  @override
  String get sizeCatMensJeansWaist => 'الجينز الرجالي – الخصر (W)';

  @override
  String get sizeCatMensPants => 'السراويل الرجالية';

  @override
  String get sizeCatMensShirts => 'قمصان رجالية';

  @override
  String get sizeCatMensShoes => 'أحذية رجالية';

  @override
  String get sizeCatMensTshirts => 'قمصان رجالية';

  @override
  String get sizeCatWomensBlouses => 'البلوزات النسائية';

  @override
  String get sizeCatWomensDresses => 'فساتين نسائية';

  @override
  String get sizeCatWomensPants => 'السراويل النسائية';

  @override
  String get sizeCatWomensShoes => 'أحذية نسائية';

  @override
  String get sizeCatWomensTshirts => 'قمصان نسائية';

  @override
  String get sizeCatBoysShoes => 'أحذية الأولاد (أطفال)';

  @override
  String get sizeCatGirlsShoes => 'أحذية البنات (الاطفال)';

  @override
  String get sizeCatBoysTshirts => 'قمصان/قمصان للأولاد';

  @override
  String get sizeCatBoysPants => 'سراويل الأولاد';

  @override
  String get sizeCatGirlsTshirts => 'بلايز / تيشيرتات بناتي';

  @override
  String get sizeCatGirlsPants => 'سروال البنات';

  @override
  String get sizeCatGirlsDressesKids => 'فساتين بنات (اطفال)';

  @override
  String get sizeColumnPrimaryEu => 'الابتدائية: الاتحاد الأوروبي';

  @override
  String get sizeColumnPrimaryJp => 'الابتدائية: جي بي';

  @override
  String get sizeColumnPrimaryMixed =>
      'الأساسي: مختلط (الاتحاد الأوروبي → الولايات المتحدة → المملكة المتحدة → اليابان)';

  @override
  String get sizeColumnPrimaryUk => 'الابتدائية: المملكة المتحدة';

  @override
  String get sizeColumnPrimaryUs => 'الابتدائية: الولايات المتحدة';

  @override
  String get sizeConverterAppBarSubtitle => 'الملابس والأحذية';

  @override
  String get sizeConverterCategory => 'فئة';

  @override
  String get sizeConverterHeader => 'الملابس والأحذية';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · اضغط للتغيير';
  }

  @override
  String get sizeConverterYourBaseSize =>
      'الحجم الأساسي الخاص بك (على العلامة)';

  @override
  String get sizeConverterYourCountry => 'بلدك / منطقتك';

  @override
  String get sizeEquivalentSizesHeader => 'أحجام متساوية';

  @override
  String get sizeHintBelts => 'على سبيل المثال 32، 34، 85، 90';

  @override
  String get sizeHintMensJeansCombo => 'على سبيل المثال 38x32 أو 38x32';

  @override
  String get sizeHintMensJeansInseam =>
      'على سبيل المثال 32 (درزة داخلية\") أو 38x32 → يستخدم درزة داخلية 32';

  @override
  String get sizeHintMensJeansWaist =>
      'على سبيل المثال 38 (الخصر\") أو 38x32 → يستخدم الخصر 38';

  @override
  String get sizeHintMensPants => 'على سبيل المثال 30، 32، 34 (الخصر\")';

  @override
  String get sizeHintMensShirts => 'على سبيل المثال 15, 38, م';

  @override
  String get sizeHintMensShoes => 'على سبيل المثال 6-14، 42، 27';

  @override
  String get sizeHintMensTshirts => 'على سبيل المثال س، م، ل، 48';

  @override
  String get sizeHintWomensBlouses => 'على سبيل المثال 8، 38، م، XL';

  @override
  String get sizeHintWomensDresses => 'على سبيل المثال 8, 38, م';

  @override
  String get sizeHintWomensPants => 'على سبيل المثال 6، 10، 38، م';

  @override
  String get sizeHintWomensShoes => 'على سبيل المثال 5-12، 39، 25';

  @override
  String get sizeHintWomensTshirts => 'على سبيل المثال XS، م، 38';

  @override
  String get sizeHintBoysShoes => 'على سبيل المثال 11ج، 3ص، 32، 21';

  @override
  String get sizeHintGirlsShoes => 'على سبيل المثال 10ج، 2ص، 33، 20';

  @override
  String get sizeHintBoysTshirts => 'على سبيل المثال 6، 8، م، XS';

  @override
  String get sizeHintBoysPants =>
      'على سبيل المثال 6، 8، 10 (أطفال الولايات المتحدة)';

  @override
  String get sizeHintGirlsTshirts => 'على سبيل المثال 6، 8، م، س';

  @override
  String get sizeHintGirlsPants =>
      'على سبيل المثال 6، 8، 10 (أطفال الولايات المتحدة)';

  @override
  String get sizeHintGirlsDressesKids => 'على سبيل المثال 4، 6، 8، 104';

  @override
  String get sizeNoMatchEmpty => 'أدخل الحجم المطبوع على ملابسك أو حذائك.';

  @override
  String get sizeNoMatchRow =>
      'لا يوجد صف حجم مطابق لهذه الفئة. جرّب أرقام الولايات المتحدة أو المملكة المتحدة أو الاتحاد الأوروبي أو JP أو الحرف (S، M، L) حيثما أمكن ذلك.';

  @override
  String get sizeTipJeansCombo =>
      'مثال الولايات المتحدة 38×32: الخصر ≈ الاتحاد الأوروبي 48، علامة الخصر JP غالبًا ~96-97 سم؛ درزة داخلية 32\" ≈ ~81 سم. تختلف العلامات التجارية - استخدم هذا كنقطة بداية.';

  @override
  String get sizeTipJeansInseam =>
      'التماس الداخلي هو طول الساق من الداخل بالبوصة (على سبيل المثال 32). قد تظهر اليابان حوالي 81 سم للدرزة الداخلية مقاس 32 بوصة. النوع 38×32 — نستخدم 32 للدرزة الداخلية.';

  @override
  String get sizeTipJeansWaist =>
      'غالبًا ما يكون الرقم الموجود على العلامة الآسيوية هو الخصر: إما سنتيمتر (38\" ≈ 96-97 سم) أو بوصة الخصر الأمريكية (38). قارنه بشريط القياس. يمكنك كتابة 38×32 هنا - نستخدم 38 للخصر.';

  @override
  String get timezonePickerEmpty => 'لا توجد مباريات';

  @override
  String get timezonePickerHint =>
      'البحث عن اسم IANA (على سبيل المثال، أوروبا وطوكيو)';

  @override
  String get timezonePickerTitle => 'اختر منطقة زمنية';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown من مناطق $total';
  }

  @override
  String get timezoneSheetSearchHint =>
      'البحث عن اسم IANA (على سبيل المثال، أوروبا وطوكيو)';

  @override
  String get timezoneSheetTitle => 'حدد المنطقة الزمنية';

  @override
  String get tipAmount => 'مبلغ النصيحة';

  @override
  String get tipAppBarSubtitle => 'نصيحة وفاتورة';

  @override
  String get tipBillHint => 'على سبيل المثال 1,250,000.00 دولار';

  @override
  String get tipCountryBrazil => 'البرازيل';

  @override
  String get tipCountryChina => 'الصين';

  @override
  String get tipCountryColombia => 'كولومبيا';

  @override
  String get tipCountryDominicanRepublic => 'جمهورية الدومينيكان';

  @override
  String get tipCountryEgypt => 'مصر';

  @override
  String get tipCountryFrance => 'فرنسا';

  @override
  String get tipCountryGermany => 'ألمانيا';

  @override
  String get tipCountryHongKong => 'هونج كونج';

  @override
  String get tipCountryIndonesia => 'أندونيسيا';

  @override
  String get tipCountryItaly => 'إيطاليا';

  @override
  String get tipCountryJapan => 'اليابان';

  @override
  String get tipCountryMexico => 'المكسيك';

  @override
  String get tipCountryMorocco => 'المغرب';

  @override
  String get tipCountryPortugal => 'البرتغال';

  @override
  String get tipCountrySingapore => 'سنغافورة';

  @override
  String get tipCountrySpain => 'إسبانيا';

  @override
  String get tipCountryThailand => 'تايلاند';

  @override
  String get tipCountryTurkey => 'ديك رومى';

  @override
  String get tipCountryUae => 'الإمارات العربية المتحدة (دبي)';

  @override
  String get tipCountryUnitedKingdom => 'المملكة المتحدة';

  @override
  String get tipCountryUsa => 'الولايات المتحدة';

  @override
  String get tipZeroReasonChina =>
      'البقشيش ليس أمرًا معتادًا في الصين القارية ويمكن رفضه أو اعتباره أمرًا غريبًا في العديد من الأماكن.';

  @override
  String get tipZeroReasonFrance =>
      'تتضمن فواتير المطاعم عادةً رسوم خدمة بنسبة 15% (رسوم الخدمة). البقشيش الإضافي اختياري للخدمة الاستثنائية.';

  @override
  String get tipZeroReasonJapan =>
      'البقشيش لا يُمارس في اليابان ويمكن أن يسبب ارتباكًا أو إساءة.';

  @override
  String get tipZeroReasonSingapore =>
      'البقشيش غير متوقع؛ تضيف العديد من الأماكن رسوم خدمة بنسبة 10٪ إلى الفاتورة.';

  @override
  String get tipZeroReasonGeneric =>
      'نصيحة 0٪ نموذجية هنا. لا يزال بإمكانك إضافة إكرامية للخدمة المتميزة.';

  @override
  String get tipZeroReasonTitle => 'لماذا 0%؟';

  @override
  String get tipCurrentCountry => 'البلد الحالي';

  @override
  String get tipPeople => 'الناس';

  @override
  String get tipPerPerson => 'المبلغ للشخص الواحد';

  @override
  String get tipPercentHint => 'اكتب الإكرامية % (على سبيل المثال 15 أو 27.5)';

  @override
  String get tipPercentLabel => 'نصيحة ٪';

  @override
  String get tipResults => 'نتائج';

  @override
  String get tipSmartHeader => 'نصيحة ذكية';

  @override
  String get tipTotalBill => 'إجمالي مبلغ الفاتورة';

  @override
  String get tipTotalWithTip => 'المجموع مع معلومات سرية';

  @override
  String get toolBrainstorm => 'العصف الذهني';

  @override
  String get toolBudget => 'ميزانية';

  @override
  String get toolBudgetSubtitle => 'تخطيط ميزانية الرحلة وتتبع النفقات';

  @override
  String get toolBudgetTitle => 'ميزانية';

  @override
  String get toolItinerarySubtitle => 'الرحلات الجوية والفنادق والخطط يوميا';

  @override
  String get toolItineraryTitle => 'خط سير الرحلة';

  @override
  String get toolCrypto => 'تشفير';

  @override
  String get toolCryptoSubtitle => 'قيم USD عبر العملات الشائعة';

  @override
  String get toolCryptoTitle => 'تشفير';

  @override
  String get toolDocumentVault => 'قبو الوثيقة';

  @override
  String get toolMindMapSubtitle =>
      'أفكار على لوحة قماشية لا حصر لها · غير متصل بالإنترنت';

  @override
  String get toolMindMapTitle => 'خريطة العصف الذهني';

  @override
  String get toolPacking => 'التعبئة';

  @override
  String get toolPackingSubtitle => 'قوائم التعبئة الذكية حسب الرحلة';

  @override
  String get toolPackingTitle => 'التعبئة';

  @override
  String get toolSchedulerSubtitle =>
      'المناطق الزمنية المزدوجة · التخطيط لاضطراب الرحلات الجوية الطويلة';

  @override
  String get toolSchedulerTitle => 'الوقت والتاريخ';

  @override
  String get toolSettingsAboutSubtitle =>
      'الإعلانات والمساعدة والخصوصية والشروط';

  @override
  String get toolSettingsAboutTitle => 'الإعدادات وحول';

  @override
  String get toolSettingsInfo => 'الإعدادات والمعلومات';

  @override
  String get toolSizeSubtitle =>
      'الولايات المتحدة · المملكة المتحدة · الاتحاد الأوروبي · اليابان (اليابان)';

  @override
  String get toolSizeTitle => 'تحويل حجم الملابس';

  @override
  String get toolTimeDate => 'الوقت والتاريخ';

  @override
  String get toolTipSubtitle =>
      'معايير معلومات الدولة · تقسيم ما يصل إلى 20 شخصًا';

  @override
  String get toolTipTitle => 'نصيحة ذكية وفاصل الفاتورة';

  @override
  String get toolUnits => 'الوحدات';

  @override
  String get toolUnitsSubtitle => 'الطول، الوزن، درجة الحرارة، الحجم';

  @override
  String get toolUnitsTitle => 'الوحدات';

  @override
  String get toolVaultSubtitle => 'تخزين غير متصل لوثائق السفر الحيوية';

  @override
  String get toolVaultTitle => 'قبو الوثيقة';

  @override
  String get unitAcres => 'فدان';

  @override
  String get unitCategoryArea => 'منطقة';

  @override
  String get unitCategoryDistance => 'مسافة';

  @override
  String get unitCategoryLength => 'طول';

  @override
  String get unitCategoryTemperature => 'درجة حرارة';

  @override
  String get unitCategoryVolume => 'مقدار';

  @override
  String get unitCategoryWeight => 'وزن';

  @override
  String get unitCelsius => 'مئوية';

  @override
  String get unitCentimeters => 'سنتيمترات';

  @override
  String get unitFahrenheit => 'فهرنهايت';

  @override
  String get unitFeet => 'قدم';

  @override
  String get unitGrams => 'غرام';

  @override
  String get unitHectares => 'هكتار';

  @override
  String get unitInches => 'بوصة';

  @override
  String get unitKilograms => 'كيلوغرامات';

  @override
  String get unitKilometers => 'كيلومترات';

  @override
  String get unitLiters => 'لتر';

  @override
  String get unitMeters => 'متر';

  @override
  String get unitMiles => 'مايلز';

  @override
  String get unitMilliliters => 'ملليلتر';

  @override
  String get unitOunces => 'أوقية';

  @override
  String get unitPounds => 'جنيه';

  @override
  String get unitSquareCentimeters => 'سنتيمترات مربعة';

  @override
  String get unitSquareFeet => 'قدم مربع';

  @override
  String get unitSquareInches => 'بوصة مربعة';

  @override
  String get unitSquareKilometers => 'كيلومتر مربع';

  @override
  String get unitSquareMeters => 'متر مربع';

  @override
  String get unitSquareYards => 'ياردة مربعة';

  @override
  String get unitUsFluidOunces => 'أوقية السوائل الأمريكية';

  @override
  String get unitUsGallons => 'جالون أمريكي';

  @override
  String get unitYards => 'ياردة';

  @override
  String get unitsHeader => 'الوحدات';

  @override
  String get vaultCategoryArrivalCard => 'بطاقة الوصول';

  @override
  String get vaultCategoryHotelReservation => 'حجز الفندق';

  @override
  String get vaultCategoryOther => 'آخر';

  @override
  String get vaultCategoryPassportCopy => 'نسخة من جواز السفر';

  @override
  String get vaultCategoryReturnFlight => 'رحلة العودة';

  @override
  String get vaultCategoryVisa => 'فيزا';

  @override
  String get vaultDocumentTitle => 'وثيقة';

  @override
  String get vaultIntro =>
      'قم بتخزين مستندات السفر الحيوية بشكل آمن للوصول إليها دون اتصال بالإنترنت وتقديم عرض سريع عند الهجرة.';

  @override
  String vaultProcessFailed(String error) {
    return 'فشلت معالجة المستند: $error';
  }

  @override
  String get vaultTapToUpload => 'انقر للتحميل';

  @override
  String get vaultTapToView => 'انقر للعرض';

  @override
  String get vaultVaultWord => 'قبو';

  @override
  String get bucketListTitle => 'قائمة دلو';

  @override
  String get bucketListSubtitle =>
      'الأماكن التي زرتها، والتي تريد الذهاب إليها، وما هي الخطوة التالية.';

  @override
  String get bucketListToolSubtitle => 'وجهات الحلم على الخريطة وفي القوائم';

  @override
  String get bucketListViewModeList => 'قائمة';

  @override
  String get bucketListViewModeMap => 'رسم خريطة';

  @override
  String get bucketListViewModePopular => 'شائع';

  @override
  String get bucketListPopularHint =>
      'تم، عش، وعش، قم بتحديث خريطتك وقائمتك. المطلوب والقادم موجودان في القائمة فقط ولا يظهران أبدًا على الخريطة.';

  @override
  String get bucketListCategoryBeen => 'كان';

  @override
  String get bucketListCategoryWant => 'يريد';

  @override
  String get bucketListCategoryLive => 'يعيش';

  @override
  String get bucketListCategoryLived => 'عاش';

  @override
  String get bucketListCategoryUpcoming => 'القادمة';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start - $end';
  }

  @override
  String get bucketListDetailCategory => 'فئة';

  @override
  String get bucketListDetailDates => 'بلح';

  @override
  String get bucketListMapLegend => 'اضغط على علامة للحصول على التفاصيل';

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
    return '$name استكشف $worldPercent% من العالم. سافر أكثر من $populationPercent% من سكان العالم.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'رافائيل';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'سافر أكثر من $percent% من سكان العالم';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'بلدان';

  @override
  String get bucketListShareMapCitiesLabel => 'المدن';

  @override
  String get bucketListEmptyCategory => 'لا يوجد أماكن في هذه الفئة حتى الآن.';

  @override
  String get bucketListTravelStats => 'إحصائيات السفر';

  @override
  String get bucketListStatWorld => 'استكشاف العالم';

  @override
  String get bucketListStatUs => 'استكشفت الولايات المتحدة';

  @override
  String get bucketListStatEurope => 'استكشفت أوروبا';

  @override
  String get bucketListStatAsia => 'استكشاف آسيا';

  @override
  String get bucketListStatAfrica => 'تم استكشاف أفريقيا';

  @override
  String get bucketListStatRegionalCaption => 'إقليمي';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count فريد · من $total';
  }

  @override
  String get bucketListAddDestination => 'أضف الوجهة';

  @override
  String get bucketListEditDestination => 'تحرير الوجهة';

  @override
  String get bucketListSave => 'يحفظ';

  @override
  String get bucketListFieldCity => 'مدينة';

  @override
  String get bucketListFieldCountry => 'دولة';

  @override
  String get bucketListFieldCategory => 'فئة';

  @override
  String get bucketListFieldRegionHint => 'الولاية/المقاطعة (اختياري)';

  @override
  String get bucketListFieldLatitude => 'خط العرض';

  @override
  String get bucketListFieldLongitude => 'خط الطول';

  @override
  String get bucketListFieldStart => 'تاريخ البدء';

  @override
  String get bucketListFieldEnd => 'تاريخ الانتهاء';

  @override
  String get bucketListFieldTripDates => 'مواعيد الرحلة';

  @override
  String get bucketListValidationRequired => 'هذه الخانة مطلوبه.';

  @override
  String get bucketListValidationNumber => 'أدخل رقمًا صالحًا.';

  @override
  String get bucketListValidationDates =>
      'يجب أن يكون تاريخ الانتهاء في نفس تاريخ البدء أو بعده.';

  @override
  String get bucketListGeocodeNotFound =>
      'تعذر العثور على هذا الموقع على الخريطة. يرجى التحقق من التهجئة.';

  @override
  String get bucketListShareSummarySubject => 'قائمتي Tripmetic';

  @override
  String get bucketListShareTooltip => 'مشاركة القائمة والخريطة';

  @override
  String bucketListShareFailed(String error) {
    return 'لا يمكن المشاركة: $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'افتح عرض الخريطة قبل التقاط صورة الخريطة.';

  @override
  String get bucketListDeleteHint => 'انتقد لإزالة';

  @override
  String get bucketListTapEditHint => 'انقر للتحرير';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'فشلت المزامنة السحابية: $error';
  }

  @override
  String get bucketListRetry => 'أعد المحاولة';

  @override
  String get bucketListBackupTooltip => 'النسخ الاحتياطي والتسجيل';

  @override
  String get bucketListBackupTitle => 'النسخ الاحتياطي السحابي';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic يعمل بشكل كامل بدون حساب. أضف واحدة في أي وقت إذا كنت تريد النسخ الاحتياطي السحابي لقائمة المجموعات الخاصة بك والرحلات الجماعية المشتركة.';

  @override
  String bucketListSignedInAs(String email) {
    return 'تم تسجيل الدخول باسم $email';
  }

  @override
  String get bucketListBackupEmail => 'بريد إلكتروني';

  @override
  String get bucketListBackupPassword => 'كلمة المرور';

  @override
  String get bucketListBackupConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get bucketListAuthTabSignUp => 'اشتراك';

  @override
  String get bucketListAuthPasswordMismatch => 'كلمات المرور غير متطابقة.';

  @override
  String get bucketListRegister => 'إنشاء حساب والنسخ الاحتياطي';

  @override
  String get bucketListSignIn => 'تسجيل الدخول';

  @override
  String get bucketListSignOut => 'تسجيل الخروج';

  @override
  String get bucketListBackupUploading => 'جارٍ التحميل إلى السحابة…';

  @override
  String get bucketListAuthSuccessSignIn => 'تم تسجيل الدخول بنجاح!';

  @override
  String get bucketListAuthSuccessSignUp => 'تم إنشاء الحساب بنجاح!';

  @override
  String get signUpSuccessMessage => 'تم إنشاء الحساب. مرحبًا بك في Tripmetic!';

  @override
  String get signUpErrorEmailInUse =>
      'عنوان البريد الإلكترونى هذا مسجل بالفعل. حاول تسجيل الدخول.';

  @override
  String get signUpErrorInvalidEmail => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get signUpErrorWeakPassword =>
      'كلمة المرور ضعيفة جدًا. استخدم 8 أحرف على الأقل.';

  @override
  String signUpErrorGeneric(String message) {
    return 'تعذر التسجيل: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'تسجيل الدخول';

  @override
  String bucketListAuthFailed(String error) {
    return 'تعذرت المصادقة: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'لا توجد ملاحظات أو روابط حتى الآن.';

  @override
  String get groupPlannerTitle => 'مخطط المجموعة';

  @override
  String get groupPlannerToolTitle => 'مخطط المجموعة';

  @override
  String get groupPlannerToolSubtitle => 'خطط لرحلة معًا في الوقت الفعلي';

  @override
  String get groupPlannerLandingPlanTitle => 'خطط لرحلة جماعية';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'قم بإنشاء رحلة مشتركة مع الوجهة والتواريخ والميزانية.';

  @override
  String get groupPlannerLandingJoinTitle => 'انضم إلى رحلة جماعية';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'أدخل رمز الرحلة أو الرابط من دعوتك.';

  @override
  String get groupPlannerCreateTripTitle => 'رحلة جماعية جديدة';

  @override
  String get groupPlannerSelectDates => 'حدد النطاق الزمني للرحلة.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'لكل شخص';

  @override
  String get groupPlannerBudgetGroupOption => 'مجموع المجموعة';

  @override
  String get groupPlannerBudgetNoneOption => 'لا أحد';

  @override
  String get groupPlannerBudgetAmountLabel => 'مبلغ الميزانية';

  @override
  String get groupPlannerOpenTitle => 'افتح رحلة جماعية';

  @override
  String get groupPlannerOpenSubtitle => 'الصق رمز الرحلة من دعوتك.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'رمز الرحلة';

  @override
  String get groupPlannerOpenHint =>
      'الرمز القصير أو معرف الرحلة أو رابط الدعوة';

  @override
  String get groupPlannerOpenButton => 'رحلة مفتوحة';

  @override
  String get groupPlannerDestination => 'وجهة';

  @override
  String get groupPlannerDates => 'بلح';

  @override
  String get groupPlannerGroupSize => 'حجم المجموعة';

  @override
  String get groupPlannerBudget => 'ميزانية';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'للشخص الواحد: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'إجمالي المجموعة: $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'لم يتم تحديد الميزانية';

  @override
  String get groupPlannerInviteMembers => 'دعوة الأعضاء';

  @override
  String get groupPlannerManageMembers => 'إدارة الأعضاء';

  @override
  String get groupPlannerItinerary => 'خط سير الرحلة';

  @override
  String get groupPlannerItineraryEditorHint =>
      'باعتبارك مسؤول الرحلة أو منسق الرحلة، يمكنك إضافة أنشطة وتغيير الجدول الزمني.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'للقراءة فقط: التصويت على الأنشطة المقترحة بإبهام لأعلى أو لأسفل. يمكن لمسؤولي الرحلة ومنسقي الرحلة فقط إضافة العناصر أو تغييرها.';

  @override
  String get groupPlannerNoActivities => 'لا توجد أنشطة حتى الآن.';

  @override
  String get groupPlannerTripNotFound => 'لا يمكن تحميل هذه الرحلة.';

  @override
  String get groupPlannerSignInTitle => 'تسجيل الدخول مطلوب';

  @override
  String get groupPlannerSignInBody =>
      'قم بتسجيل الدخول ضمن قائمة الجرافات → النسخ الاحتياطي السحابي لعرض الرحلات المشتركة.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'يتطلب حفظ رحلة جماعية جديدة إنشاء حساب. قم بتسجيل الدخول للمتابعة — تعمل ميزات Tripmetic الأخرى بدون ميزة واحدة.';

  @override
  String get groupPlannerMembersTitle => 'أعضاء';

  @override
  String get groupPlannerRoleAdmin => 'مسؤل';

  @override
  String get groupPlannerRoleCoPlanner => 'منسق الرحلة';

  @override
  String get groupPlannerRoleViewOnly => 'للعرض فقط';

  @override
  String get groupPlannerOwner => 'مالك';

  @override
  String get groupPlannerRemoveMember => 'يزيل';

  @override
  String get groupPlannerRemoveMemberTitle => 'إزالة العضو؟';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return 'هل تريد إزالة $email من هذه الرحلة؟';
  }

  @override
  String get groupPlannerCancel => 'يلغي';

  @override
  String get groupPlannerNotes => 'ملحوظات';

  @override
  String get groupPlannerOpenLink => 'فتح الرابط';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'تعذر حفظ التصويت: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'لا يمكن تحديث الأعضاء: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'تعذر فتح ورقة المشاركة: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'لا يمكن فتح الرحلة: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'رحلاتك';

  @override
  String get groupPlannerMyTripsEmpty => 'لا توجد رحلات بعد. إنشاء واحد أعلاه.';

  @override
  String get groupPlannerExamplesTitle => 'الرحلات سبيل المثال';

  @override
  String get groupPlannerExamplesSubtitle =>
      'نماذج من البطاقات - قم بإنشاء رحلة أعلاه لإضافة رحلتك الخاصة.';

  @override
  String get groupPlannerExampleTapBody =>
      'هذه عينات فقط. استخدم \"التخطيط لرحلة جماعية\" لإنشاء رحلة حقيقية يمكنك مشاركتها.';

  @override
  String get groupPlannerExampleLisbonTitle => 'فريق لشبونة خارج الملعب';

  @override
  String get groupPlannerExampleKyotoTitle => 'جولة الربيع في كيوتو';

  @override
  String get groupPlannerAddActivity => 'أضف نشاطًا';

  @override
  String get groupPlannerActivityTitleLabel => 'عنوان النشاط';

  @override
  String get groupPlannerActivityWhenLabel => 'التاريخ والوقت';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'اختر يومًا لرحلتك، ثم وقتًا. يمكن لأي شخص يمكنه تعديل خط سير الرحلة تغيير ذلك لاحقًا.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'هذا التاريخ خارج هذه الرحلة. اختر يومًا بين بداية الرحلة وانتهائها.';

  @override
  String get groupPlannerActivityTitleRequired => 'أدخل عنوان النشاط.';

  @override
  String get groupPlannerActivityDateUnset =>
      'لم يتم ضبط التاريخ - انقر فوق \"تحرير\" للجدولة.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count الناس';
  }

  @override
  String get groupPlannerEditActivity => 'تحرير النشاط';

  @override
  String get groupPlannerDeleteActivity => 'يمسح';

  @override
  String get groupPlannerDeleteActivityTitle => 'هل تريد حذف النشاط؟';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return 'هل تريد إزالة \"$title\" من خط سير الرحلة؟ لا يمكن التراجع عن هذا.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'تعذر حذف النشاط: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'تعذر تحديث النشاط: $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'تحرير الرحلة';

  @override
  String get groupPlannerEditTripAction => 'تحرير الرحلة';

  @override
  String get groupPlannerDeleteTripTitle => 'هل تريد حذف الرحلة؟';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return 'هل تريد إزالة الرحلة \"$destination\" وخط سيرها للجميع نهائيًا؟ لا يمكن التراجع عن هذا.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'حذف الرحلة';

  @override
  String get groupPlannerTripDeleted => 'تمت إزالة الرحلة.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'تعذر حذف الرحلة: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'تعذر تحديث الرحلة: $error';
  }

  @override
  String get widgetInstructionTitle => 'القطعة على مدار الساعة المزدوجة';

  @override
  String get widgetInstructionSubtitle =>
      'تتبع المناطق الزمنية الرئيسية والوجهة مباشرة من شاشة القفل أو الشاشة الرئيسية.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'قفل الشاشة';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'اضغط لفترة طويلة على شاشة القفل ثم اضغط على \"تخصيص\".';

  @override
  String get widgetInstructionIosLockScreenStep2 =>
      'حدد معاينة \"شاشة القفل\".';

  @override
  String get widgetInstructionIosLockScreenStep3 =>
      'اضغط على منطقة القطعة مباشرة أسفل الوقت.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      'قم بالتمرير لأسفل، وحدد Tripmetic، ثم انقر لإضافة الأداة.';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'الشاشة الرئيسية';

  @override
  String get widgetInstructionIosHomeScreenStep1 =>
      'اضغط لفترة طويلة على مساحة فارغة على شاشتك الرئيسية.';

  @override
  String get widgetInstructionIosHomeScreenStep2 =>
      'اضغط على أيقونة + في الزاوية العلوية اليسرى.';

  @override
  String get widgetInstructionIosHomeScreenStep3 => 'ابحث عن \"Tripmetic\".';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      'حدد حجم الأداة المفضلة لديك وانقر فوق \"إضافة القطعة\".';

  @override
  String get widgetInstructionAndroidStep1 =>
      'انتقل إلى شاشتك الرئيسية واضغط لفترة طويلة على منطقة فارغة.';

  @override
  String get widgetInstructionAndroidStep2 => 'اضغط على \"الحاجيات\".';

  @override
  String get widgetInstructionAndroidStep3 =>
      'قم بالتمرير لأسفل إلى Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'اضغط مطولاً على أداة الساعة المزدوجة، ثم اسحبها إلى شاشتك.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'لرؤية الساعتين على شاشة القفل: افتح الإعدادات ← ابحث عن \"شاشة القفل\" أو \"الأدوات\"، وأضف Tripmetic هناك إذا كان هاتفك يوفر أدوات لشاشة القفل (ليس كل الأجهزة تفعل ذلك).';

  @override
  String get widgetInstructionConfigureCta => 'تكوين مدن القطعة';

  @override
  String get currencyWidgetInstructionTitle => 'القطعة تحويل العملات';

  @override
  String get currencyWidgetInstructionSubtitle =>
      'قم بتثبيت العملات الأساسية والعملات المستهدفة على شاشتك الرئيسية Android. تتم مزامنة الأسعار كلما استخدمت المحول في Tripmetic.';

  @override
  String get currencyWidgetInstructionAndroidTitle => 'أضف إلى الشاشة الرئيسية';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      'افتح أداة العملة مرة واحدة وقم بتعيين أول عملتين (الأساسية والهدف).';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      'انتقل إلى شاشتك الرئيسية واضغط لفترة طويلة على منطقة فارغة.';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      'اضغط على \"الأدوات\"، وقم بالتمرير إلى Tripmetic، واختر \"محول العملات\".';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      'اسحب الأداة إلى شاشتك الرئيسية، أو انقر فوق \"إضافة\" إذا كان المشغل الخاص بك يدعمها.';

  @override
  String get currencyWidgetInstructionUsageTitle => 'باستخدام القطعة';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      'اضغط على تغيير (أو نص الأداة) لفتح تحديد العملة في Tripmetic.';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      'انقر فوق ↻ تحديث لتحديث الأسعار على الأداة في الخلفية (لا يفتح التطبيق).';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      'يتم تحديث المبالغ تلقائيًا عند قيامك بتحرير العملات أو القيم في التطبيق.';

  @override
  String get currencyWidgetInstructionPinCta =>
      'إضافة القطعة إلى الشاشة الرئيسية';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta => 'تغيير عملات القطعة';

  @override
  String get currencyWidgetInstructionIosHint =>
      'أداة الشاشة الرئيسية للعملة متاحة على Android. على iPhone، استخدم أداة العملة داخل التطبيق.';

  @override
  String get currencyWidgetPinUnsupported =>
      'لا يدعم المشغل الخاص بك إضافة هذه الأداة من التطبيق. اضغط لفترة طويلة على شاشتك الرئيسية واختر Widgets بدلاً من ذلك.';

  @override
  String get currencyWidgetPinFailed =>
      'تعذر فتح منتقي الأدوات. أضف الأداة يدويًا من شاشتك الرئيسية.';

  @override
  String get dualClockScreenTitle => 'القطعة على مدار الساعة المزدوجة';

  @override
  String get dualClockConfigTitle => 'تكوين المدن';

  @override
  String get dualClockConfigSubtitle =>
      'اختر مدينتين ومنطقتين زمنيتين. تتم مزامنة اختياراتك مع أداة الشاشة الرئيسية Tripmetic (Android) وأداة شاشة القفل (iOS).';

  @override
  String get dualClockCity1Label => 'المدينة الأولى';

  @override
  String get dualClockCity2Label => 'المدينة الثانية';

  @override
  String get dualClockSave => 'حفظ وتحديث القطعة';

  @override
  String get dualClockSaved => 'تم تحديث القطعة.';

  @override
  String get dualClockSaveError =>
      'لا يمكن حفظ بيانات القطعة. يرجى المحاولة مرة أخرى.';

  @override
  String get dualClockAppearanceTitle => 'مظهر القطعة';

  @override
  String get dualClockAppearanceHint =>
      'تخصيص حجم النص والألوان وخلفية الشاشة الرئيسية. تستخدم شاشة القفل حجم الخط (والألوان التي يسمح بها النظام).';

  @override
  String get dualClockFontScaleLabel => 'حجم النص';

  @override
  String get dualClockColorCity => 'أسماء المدن';

  @override
  String get dualClockColorTime => 'مرات';

  @override
  String get dualClockColorDate => 'بلح';

  @override
  String get dualClockColorBackground => 'خلفية المنزل';

  @override
  String get dualClockShadowLabel => 'ظل النص';

  @override
  String get dualClockShadowSubtitle =>
      'يضيف تباينًا على خلفيات الصور المزدحمة أو المزدحمة.';

  @override
  String get moreToolsDualClockBannerTitle => 'القطعة على مدار الساعة المزدوجة';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'شاهد منطقتين زمنيتين على شاشة القفل أو الشاشة الرئيسية - انقر للإعداد.';

  @override
  String get moreToolsDualClockBannerCta => 'يثبت';

  @override
  String get settingsDualClockWidgetTitle => 'القطعة على مدار الساعة المزدوجة';

  @override
  String get settingsDualClockWidgetSubtitle => 'أضف القطعة واختر مدنك';

  @override
  String get widgetNewFeatureBadge => 'جديد';

  @override
  String get globalNavAccountCloudSyncTooltip =>
      'الحساب والنسخ الاحتياطي السحابي';

  @override
  String get exchangeRatesForceRefreshTooltip => 'جلب أحدث أسعار الصرف';

  @override
  String get exchangeRatesRefreshedOk => 'تم تحديث أسعار الصرف.';

  @override
  String get exchangeRatesRefreshFailed => 'تعذر تحديث أسعار الصرف.';

  @override
  String get bucketListStatUsTerritories => 'الأراضي الأمريكية';

  @override
  String get bucketListAuthErrUserNotFound =>
      'لم يتم العثور على حساب لهذا البريد الإلكتروني.';

  @override
  String get bucketListAuthErrWrongPassword =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'يوجد حساب بالفعل لهذا البريد الإلكتروني.';

  @override
  String get bucketListAuthErrInvalidEmail =>
      'عنوان البريد الإلكتروني غير صالح.';

  @override
  String get bucketListAuthErrWeakPassword => 'كلمة المرور ضعيفة جدًا.';

  @override
  String get bucketListAuthErrUserDisabled => 'لقد تم تعطيل هذا الحساب.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'محاولات كثيرة جدًا. حاول مرة أخرى لاحقًا.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'لم يتم تمكين تسجيل الدخول بالبريد الإلكتروني/كلمة المرور.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail =>
      'عنوان البريد الإلكتروني غير صالح.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';

  @override
  String get bucketListAuthValidationPasswordRequired =>
      'أدخل كلمة المرور الخاصة بك.';

  @override
  String get currencyWidgetAppearanceTitle => 'مظهر';

  @override
  String get currencyWidgetAppearanceHint =>
      'تخصيص حجم الخط وألوان النص وخلفية الشاشة الرئيسية. تحافظ الأدوات الرئيسية على حجم ثابت، بحيث يتم احتواء الخطوط الكبيرة تلقائيًا بحيث تظل جميع الصفوف مرئية. تستخدم شاشة القفل حجم الخط (والألوان التي يسمح بها النظام).';

  @override
  String get currencyWidgetFontScaleLabel => 'حجم الخط';

  @override
  String get currencyWidgetColorPrimary => 'النص الأساسي (المبالغ / القاعدة)';

  @override
  String get currencyWidgetColorAccent => 'نص مميز (تسميات الزوج/السلم)';

  @override
  String get currencyWidgetColorCaption => 'نص التسمية التوضيحية (خط السعر)';

  @override
  String get currencyWidgetColorBackground => 'خلفية المنزل';

  @override
  String get currencyWidgetSaveAppearance => 'حفظ المظهر';

  @override
  String get currencyWidgetAppearanceSaved => 'تم حفظ مظهر أداة العملة';

  @override
  String get currencyWidgetAppearanceSaveFailed => 'لا يمكن حفظ مظهر القطعة';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
