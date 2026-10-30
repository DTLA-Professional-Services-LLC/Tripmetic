// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get addItineraryEnterTitle => '제목을 입력하세요';

  @override
  String get addItineraryFieldLocation => '위치';

  @override
  String get addItineraryFieldNotes => '주의사항/확인';

  @override
  String get addItineraryFieldTitle => '제목';

  @override
  String get addItineraryHintLocation => '공항, 호텔 주소…';

  @override
  String get addItineraryHintNotes => '기록 찾기, 링크…';

  @override
  String get addItineraryHintTitle => '리스본행 비행기';

  @override
  String get addItinerarySave => '이벤트 저장';

  @override
  String get addItineraryTitle => '여행일정 추가';

  @override
  String get addPackingAddToList => '목록에 추가';

  @override
  String get addPackingEnterName => '항목 이름을 입력하세요.';

  @override
  String get addPackingFieldCategory => '범주';

  @override
  String get addPackingFieldItemName => '품목 이름';

  @override
  String get addPackingHint => '예를 들어 전원 어댑터';

  @override
  String get addPackingIcon => '상';

  @override
  String get addPackingQuantity => '수량';

  @override
  String get addPackingTitle => '포장 품목 추가';

  @override
  String get announcementsLatest => '최신 업데이트';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => '기본 통화';

  @override
  String get budgetCategoryDialogHint => '예를 들어 기념품';

  @override
  String get budgetCategoryNameExists => '이름이 이미 존재합니다.';

  @override
  String get budgetCategoryNameMax => '최대 40자';

  @override
  String get budgetDailyFood => '매일의 음식';

  @override
  String get budgetDestinationSearchHint => '국가 또는 통화 코드 검색';

  @override
  String get budgetDestinationTitle => '목적지 추가';

  @override
  String get budgetDialogAdd => '추가하다';

  @override
  String get budgetDialogNewCategory => '새로운 비용 카테고리';

  @override
  String budgetDialogRemoveBody(String name) {
    return '\'$name\' 및 해당 금액을 삭제하시겠습니까?';
  }

  @override
  String get budgetDialogRemoveTitle => '카테고리 삭제';

  @override
  String get budgetDialogRename => '이름 바꾸기';

  @override
  String get budgetDialogRenameCategory => '카테고리 이름 바꾸기';

  @override
  String get budgetEdit => '예산 수정';

  @override
  String get budgetExpenseDailyFood => '매일의 음식';

  @override
  String get budgetExpenseEatingOut => '외식';

  @override
  String get budgetExpenseEntertainment => '오락';

  @override
  String get budgetExpenseFlights => '항공편';

  @override
  String get budgetExpenseGrocery => '식료품점';

  @override
  String get budgetExpenseHotels => '호텔';

  @override
  String get budgetExpenseMisc => '기타';

  @override
  String get budgetExpensePhoneService => '전화 서비스';

  @override
  String get budgetExpenseShopping => '쇼핑';

  @override
  String get budgetExpenseTourism => '관광 여행';

  @override
  String get budgetExpenseTransportation => '운송';

  @override
  String get budgetExpenseTravelInsurance => '여행 보험';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3,000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => '목적지에서';

  @override
  String get budgetNoCategories => '아직 비용 카테고리가 없습니다.';

  @override
  String budgetOtherExpenses(String code) {
    return '기타 비용($code)';
  }

  @override
  String get budgetPerDayEstimate => '하루당(추정)';

  @override
  String budgetPerDayValue(String amount) {
    return '≒ $amount/일';
  }

  @override
  String budgetRemainingAfter(String code) {
    return '지출 후 남은 금액 · $code';
  }

  @override
  String get budgetSave => '예산 절약';

  @override
  String get budgetSpendingPower => '소비력';

  @override
  String get budgetSpentVsBudget => '지출과 예산';

  @override
  String budgetTotalBudget(String code) {
    return '총 예산($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return '여행 총액($code)';
  }

  @override
  String get budgetTripDashboard => '계기반';

  @override
  String get budgetTripLengthDays => '여행 기간(일)';

  @override
  String get budgetTripTitle => '여행 예산';

  @override
  String get commonAdd => '추가하다';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonOk => '좋아요';

  @override
  String get commonRemove => '제거하다';

  @override
  String get commonRename => '이름 바꾸기';

  @override
  String get commonSave => '구하다';

  @override
  String get commonKeyboardDone => '완료';

  @override
  String countryCountriesCount(String count) {
    return '$count 국가';
  }

  @override
  String get countryPickerTitle => '국가 선택';

  @override
  String get countrySheetSearchHint => '국가 이름 또는 ISO 코드 검색';

  @override
  String get countrySheetTitle => '기본 국가/지역';

  @override
  String get cryptoHeader => '암호화폐';

  @override
  String cryptoMockPerUnit(String price) {
    return '모의 ~$price/단위';
  }

  @override
  String get cryptoPickerTitle => '동전을 골라보세요';

  @override
  String get cryptoSheetTitle => '암호화폐 선택';

  @override
  String get currencyPickerSearchHint => '종목 또는 이름 검색';

  @override
  String get currencyPickerTitle => '통화를 선택하세요';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$total 중 $shown 표시됨';
  }

  @override
  String get currencySheetSearchHint => '검색 코드, 이름 또는 숫자 ISO';

  @override
  String get currencySheetTitle => '통화 선택';

  @override
  String get exchangeBaseSuffix => '· 베이스';

  @override
  String exchangeCouldNotLoad(String error) {
    return '요금을 로드할 수 없습니다.\n$error';
  }

  @override
  String get exchangeHeader => '교환';

  @override
  String exchangeLastUpdated(String mins) {
    return '마지막 업데이트: $mins분 전';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return '마지막 업데이트: $mins분 전(오프라인)';
  }

  @override
  String get exchangeResetOne => '1로 재설정(USD 기본)';

  @override
  String get exchangeResetTooltip => '금액 재설정';

  @override
  String get exchangeResetZero => '0으로 클리어';

  @override
  String itineraryDayPrefix(String day, String date) {
    return '$day일: $date';
  }

  @override
  String get itineraryEmpty => '아직 이벤트가 없습니다.\n항공편, 호텔, 계획을 추가하려면 +를 탭하세요.';

  @override
  String get itineraryHeader => '여행일정';

  @override
  String itineraryHiveError(String error) {
    return '저장된 여행일정 데이터를 열 수 없습니다.\n여전히 이벤트를 추가해 볼 수 있습니다. 이벤트가 지속되지 않을 수도 있습니다.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => '지도에서 열기';

  @override
  String get mapAddToTrip => '여행에 추가';

  @override
  String get mapClearRoute => '명확한 경로 및 안내';

  @override
  String get mapClearTooltip => '분명한';

  @override
  String get mapDisplayCurrentViewport => '현재 뷰포트';

  @override
  String get mapDisplaySavedSearch => '저장된 검색';

  @override
  String get mapDisplayTripDestination => '여행 목적지';

  @override
  String get mapDownloadAll => '모두 다운로드';

  @override
  String get mapDownloadCurrentRegion => '오프라인 사용을 위해 현재 지역 다운로드';

  @override
  String get mapDownloadThisDestination => '이 목적지를 다운로드하세요';

  @override
  String get mapDownloadedRegions => '다운로드된 지역';

  @override
  String get mapDownloadingRegion => '지역 다운로드 중...';

  @override
  String mapDownloadingTitle(String title) {
    return '$title 다운로드 중...';
  }

  @override
  String get mapFromItinerary => '여행 일정에서';

  @override
  String get mapItineraryEmptyHint => '여행 일정 목적지를 추가하여 여기에서 미리 다운로드하세요.';

  @override
  String get mapLoadingRegions => '오프라인 지역 로드 중…';

  @override
  String mapLocatingQuery(String query) {
    return '$query 찾는 중...';
  }

  @override
  String get mapMarkCategoryBody => '이 오프라인 핀에 라벨을 지정하는 방법을 선택하세요.';

  @override
  String get mapMarkCategoryTitle => '이 마크의 카테고리';

  @override
  String get mapMarkFood => '음식';

  @override
  String get mapMarkHotel => '호텔';

  @override
  String get mapMarkLandmark => '경계표';

  @override
  String get mapMarkOther => '다른';

  @override
  String mapNextInstruction(String current, String total) {
    return '다음 명령($current/$total)';
  }

  @override
  String get mapNoLocationSet => '설정된 위치 없음';

  @override
  String get mapNoRegionsYet => '아직 다운로드한 지역이 없습니다.';

  @override
  String get mapOfflineIntro =>
      '현재 표시되는 지역을 저장하거나 여행 목적지를 미리 다운로드하여 외부에서도 탐색할 수 있습니다.';

  @override
  String get mapOfflineMapsTitle => '오프라인 지도';

  @override
  String get mapRefreshTooltip => '새로 고치다';

  @override
  String get mapRemovePinTooltip => '핀 제거';

  @override
  String get mapSaveOffline => '오프라인으로 저장';

  @override
  String get mapSavePinToMap => '지도에 핀 저장';

  @override
  String get mapSavedPinsBody => '검색에서 저장한 핀입니다. 지도에서 하나를 제거하려면 삭제를 탭하세요.';

  @override
  String get mapSavedPinsTitle => '저장된 지도 핀';

  @override
  String get mapSearchHint => '도시, 주소, 랜드마크를 검색하세요…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title이(가) 오프라인 표시에 추가되었습니다.';
  }

  @override
  String get mapSnackArrived => '당신은 도착했습니다.';

  @override
  String mapSnackCouldNotFind(String query) {
    return '\"$query\"을(를) 찾을 수 없습니다.';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return '삭제 실패: $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return '오프라인 다운로드 실패: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return '\'$title\'을(를) 다운로드했습니다.';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\"에는 설정된 위치가 없습니다.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return '$count 여행 일정 지역 다운로드가 완료되었습니다.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return '오프라인 지역을 로드할 수 없습니다: $error';
  }

  @override
  String get mapSnackLocationOff => '위치 서비스가 꺼져 있습니다. 탐색을 시작하려면 활성화하세요.';

  @override
  String get mapSnackLocationPermission => '턴바이턴을 위해서는 위치 권한이 필요합니다.';

  @override
  String get mapSnackLocationDeniedForMap => '지도 중앙에 위치를 지정하려면 위치 권한이 필요합니다.';

  @override
  String get mapSnackLocateFail => '지금은 위치를 확인할 수 없습니다.';

  @override
  String get mapLocateMeTooltip => '내 위치로 이동';

  @override
  String get mapSnackMapNotReady => '지도가 아직 준비되지 않았습니다. 잠시만 기다려주세요.';

  @override
  String get mapSnackNavStartFail => '지금은 내비게이션을 시작할 수 없습니다.';

  @override
  String get mapSnackNavStopped => '내비게이션이 중지되었습니다.';

  @override
  String get mapSnackNoItineraryLocations =>
      '여행 일정 이벤트에는 다운로드할 위치나 지도 지점이 없습니다.';

  @override
  String get mapSnackNoManeuver => '이 단계에는 정확한 기동 지점이 없습니다.';

  @override
  String get mapSnackNoRoute => '경로를 찾을 수 없습니다. 목적지를 보여줍니다.';

  @override
  String get mapSnackRegionDownloaded =>
      '지역이 성공적으로 다운로드되었습니다! 이제 오프라인으로 탐색할 수 있습니다.';

  @override
  String get mapSnackRemovedPin => '저장된 핀을 제거했습니다.';

  @override
  String mapSnackRemovedRegion(String name) {
    return '오프라인 지역 \'$name\'을(를) 삭제했습니다.';
  }

  @override
  String get mapSnackRouteCleared => '경로 및 안내가 삭제되었습니다.';

  @override
  String mapSnackRoutingFailed(String error) {
    return '라우팅 실패: $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return '검색 실패: $error';
  }

  @override
  String get mapStartNavigation => '내비게이션 시작';

  @override
  String get mapStartingNav => '내비게이션 시작 중...';

  @override
  String get mapStopNavigation => '탐색 중지';

  @override
  String get mapTravelDriving => '운전';

  @override
  String get mapTravelWalking => '걷는';

  @override
  String mapTurnByTurn(String mode) {
    return '턴바이턴($mode)';
  }

  @override
  String get mindMapCaptureFail => '마인드맵을 캡쳐하지 못했습니다. 다시 시도해 보세요.';

  @override
  String get mindMapClearBody => '이렇게 하면 모든 노드가 제거되고 데모 마인드 맵(가운데 예)이 복원됩니다.';

  @override
  String get mindMapClearTitle => '캔버스를 지우시겠습니까?';

  @override
  String get mindMapClearTooltip => '지우기 / 재설정';

  @override
  String mindMapCouldNotSave(String error) {
    return '저장할 수 없습니다: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return '저장할 수 없습니다: $type';
  }

  @override
  String get mindMapEmailShare => '이메일 / 공유';

  @override
  String get mindMapEmptyNode => '빈 노드';

  @override
  String get mindMapHelpHint =>
      '핀치하여 확대/축소 · 캔버스 드래그 · 카드 드래그 · 카드를 탭하여 편집 · + 어린이 추가';

  @override
  String get mindMapNodeAddLeftTooltip => '왼쪽 자식 추가';

  @override
  String get mindMapNodeAddRightTooltip => '오른쪽 자식 추가';

  @override
  String get mindMapNodeDeleteTooltip => '노드 삭제';

  @override
  String get mindMapNodeEditTitle => '노드 편집';

  @override
  String get mindMapNodeHint => '짧은 라벨을 입력하세요.';

  @override
  String get mindMapPhotoAccess => '이미지를 저장하려면 사진 라이브러리 접근 권한이 필요합니다.';

  @override
  String get mindMapReset => '다시 놓기';

  @override
  String get mindMapSavePhoto => '사진으로 저장';

  @override
  String get mindMapSavedPhotos => '포토에 저장됨';

  @override
  String get mindMapShareCaptureFail => '공유할 마인드맵을 캡쳐하지 못했습니다.';

  @override
  String get mindMapShareCompleted => '공유 완료';

  @override
  String mindMapShareFailed(String error) {
    return '공유 실패: $error';
  }

  @override
  String get mindMapShareReady => '이미지 준비됨 - 공유할 앱을 선택하세요';

  @override
  String get mindMapShareSheetClosed => '공유 시트가 닫혔습니다.';

  @override
  String get mindMapShareSubject => 'Tripmetic — 마인드맵';

  @override
  String get mindMapShareText => 'Tripmetic에서 마인드맵 내보내기';

  @override
  String get mindMapTapToEdit => '수정하려면 탭하세요.';

  @override
  String get moreToolsHeader => '더 많은 도구';

  @override
  String get moreToolsSubtitle => '여행 유틸리티';

  @override
  String get navCurrency => '통화';

  @override
  String get navItinerary => '여행일정';

  @override
  String get navMoreTools => '더 많은 도구';

  @override
  String get navOfflineMap => '오프라인 지도';

  @override
  String get navDashboard => '계기반';

  @override
  String get navMoreMenu => '더';

  @override
  String get navEditNavigation => '탐색 수정';

  @override
  String get navDoneEditing => '완료';

  @override
  String get navSelectSlotHint => '슬롯을 탭한 다음 도구를 탭하여 할당하세요.';

  @override
  String get navSavePins => '구하다';

  @override
  String get navPinnedSectionTitle => '하단바에 고정됨';

  @override
  String get navAvailableSectionTitle => '사용 가능한 기능';

  @override
  String get navEmptySlot => '비어 있음 - 아래에서 추가 가능';

  @override
  String get navPinFullHint => '슬롯 4개가 모두 꽉 찼습니다. 다른 하나를 추가하려면 하나를 제거하세요.';

  @override
  String get navEditPinnedHint =>
      '슬롯을 비우려면 −를 사용하고, 슬롯을 채우려면 +를 사용하고, 순서를 변경하려면 드래그하세요. 4개가 모두 채워지면 저장하세요.';

  @override
  String get navAddToPinned => '하단바에 추가';

  @override
  String get navRemoveFromPinned => '하단바에서 제거';

  @override
  String get navFeatureBadgeFree => '무료';

  @override
  String get navFeatureBadgePro => '찬성';

  @override
  String get moreMenuSectionFree => '무료 기능';

  @override
  String get moreMenuSectionPro => 'Tripmetic 프로';

  @override
  String get ourAppsMenuTitle => '우리의 앱';

  @override
  String get ourAppsMenuSubtitle => 'p1.do 팀의 추가 소프트웨어';

  @override
  String get ourAppsScreenTitle => '우리의 앱';

  @override
  String get ourAppsIntro =>
      'p1.do 팀의 소프트웨어 - 라이브 앱을 탭하여 해당 사이트를 엽니다. 스트림 CRM이 곧 출시될 예정입니다.';

  @override
  String get ourAppsBadgeLive => '출시됨';

  @override
  String get ourAppsBadgeSoon => '곧 출시 예정';

  @override
  String get ourAppsBadgeThisApp => '이 앱';

  @override
  String get ourAppsViewOnline => 'p1.do에서 모두 보기';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => '웹 · 모바일';

  @override
  String get ourAppsPlatformWebTabletMobile => '웹 · 태블릿 · 모바일';

  @override
  String get ourAppsTravelRecapTagline => 'AI 여행 경로 및 사진 요약';

  @override
  String get ourAppsTravelRecapSummary =>
      '대화형 지도에서 다지점 여행을 계획하고, AI을 사용하여 경로를 생성하고, 목적지를 추가하고, 사진에서 세련된 여행 요약을 내보냅니다.';

  @override
  String get ourAppsP1doTagline => '약력 및 제작자 CRM';

  @override
  String get ourAppsP1doSummary =>
      '월 수수료 외에 추가 수익을 삭감하지 않고도 CRM 리드와 Premium Selling 및 약속 예약을 확보하는 제작자를 위한 약력 링크입니다.';

  @override
  String get ourAppsDockTxtTagline => 'macOS 가장자리 고정 스크래치패드 및 정확한 차이';

  @override
  String get ourAppsDockTxtSummary =>
      '일반 텍스트 스크래치 패드 작업, 공백 삭제, JSON 꾸미기 및 문자 수준 차이를 위한 무료 기본 macOS 플로팅 서랍입니다.';

  @override
  String get ourAppsTripmeticTagline => '글로벌 여행 툴킷 및 예산 플래너';

  @override
  String get ourAppsTripmeticSummary =>
      '버킷 목록, 오프라인 지도, 그룹 여행 일정, 다국적 예산, 시간대 위젯, 포장 목록 및 변환기를 위한 단일 대시보드입니다.';

  @override
  String get ourAppsPayxtTagline => '몇 초 만에 텍스트-결제 송장';

  @override
  String get ourAppsPayxtSummary =>
      '모바일 전문가를 위한 Stripe 및 PayPal 기반 체크아웃 링크를 사용하여 문자 메시지를 안전한 유료 송장으로 바꿔보세요.';

  @override
  String get ourAppsPermitMobileTagline => '리모델링 업체를 위한 건축 허가 추적기';

  @override
  String get ourAppsPermitMobileSummary =>
      '작업 현장에서 도시 건축 허가 상태(시 포털의 번호, 주소 및 승인 업데이트)를 모니터링합니다.';

  @override
  String get ourAppsTrackkrTagline => '아파트 필지관리';

  @override
  String get ourAppsTrackkrSummary =>
      '들어오는 패키지를 몇 초 만에 기록하고, 이메일(선택 사항 SMS)로 테넌트에게 알리고, 영구 무료 기본 계획에 따라 무제한 단위를 관리하세요.';

  @override
  String get ourAppsKeyForecastsTagline => 'HVAC 지시선에 대한 분수 제어기';

  @override
  String get ourAppsKeyForecastsSummary =>
      'HVAC 및 건설에 대한 실무 재무 인텔리전스 - 작업 원가 계산, 계절별 현금 흐름 예측 및 확장 가능한 보고.';

  @override
  String get ourAppsStreamCrmTagline => 'TikTok 실시간 선물 추적 및 기부자 CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'TikTok 라이브 선물을 실시간으로 추적하고, 수입에서 선물 지출을 분리하고, 기부자 프로필을 통해 최고의 후원자를 육성하세요.';

  @override
  String get proGlassTeaserTitle => 'Tripmetic 프로 기능';

  @override
  String get dashboardWorldExplorerSection => '월드 익스플로러';

  @override
  String get dashboardWorldExplorerCountriesLabel => '방문한 국가';

  @override
  String get dashboardWorldExplorerPercentLabel => '탐험된 세계의';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => '표시 이름';

  @override
  String get bucketListMapUnavailable =>
      'Mapbox 액세스 토큰이 구성되지 않아 지도를 표시할 수 없습니다.';

  @override
  String get bucketListAuthValidationDisplayName => '이름을 입력하세요';

  @override
  String get authSignUpScreenTitle => 'Tripmetic 계정을 만드세요';

  @override
  String get authSignUpScreenSubtitle =>
      '선택 사항 - 클라우드 백업을 원하는 경우에만 해당됩니다. 가입하지 않고도 이 기기의 모든 도구를 계속 사용할 수 있습니다.';

  @override
  String get authSignInScreenTitle => 'Tripmetic에 로그인';

  @override
  String get authSignInScreenSubtitle =>
      '선택 사항 - 버킷 목록과 클라우드 그룹 여행을 동기화합니다. 나머지 Tripmetic은 계정 없이 작동합니다.';

  @override
  String get authForgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get authPasswordResetConfirmation =>
      '해당 이메일에 대한 계정이 존재하는 경우 비밀번호를 재설정할 수 있는 링크를 받게 됩니다.';

  @override
  String get authUnexpectedError => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get authBackupBulletBucketList => '버킷리스트 목적지는 클라우드에 저장되어 로그인 시 병합됩니다.';

  @override
  String get authBackupBulletGroupTrips =>
      '귀하가 생성하거나 참여하는 그룹 여행은 귀하의 계정에 저장됩니다.';

  @override
  String get authBackupBulletMultiDevice => '동기화된 데이터를 복원하려면 다른 기기에 로그인하세요.';

  @override
  String get authLinkAlreadyHaveAccount => '이미 계정이 있나요? 로그인';

  @override
  String get authLinkNeedAccount => '계정이 필요하십니까? 하나 만들기';

  @override
  String get authFullSignUpCta => '전체 가입 화면 사용';

  @override
  String get authFullSignInCta => '전체 로그인 화면 사용';

  @override
  String dashboardGreeting(String name) {
    return '안녕하세요, $name';
  }

  @override
  String get dashboardGuestName => '여행자';

  @override
  String get dashboardWelcomeSubtitle =>
      '탭 한 번으로 함께 계획하고 체계적으로 정리하고 도구를 사용할 수 있습니다.';

  @override
  String get dashboardPlanGroupTrip => '새로운 단체 여행을 계획해보세요';

  @override
  String get dashboardAddBucketList => '버킷리스트에 추가';

  @override
  String get dashboardActiveTripSection => '활성 여행 스냅샷';

  @override
  String get dashboardNoUpcomingTripTitle => '예정된 단체 여행이 없습니다.';

  @override
  String get dashboardNoUpcomingTripBody =>
      '친구와 함께 계획을 세울 때 다음 여행 요약이 여기에 표시됩니다.';

  @override
  String get dashboardQuickToolsSection => '빠른 도구';

  @override
  String dashboardCountdownStartsIn(String days) {
    return '$days일 후에 시작됩니다.';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return '$days일 후에 종료됩니다.';
  }

  @override
  String get navDashboardBody => '여행 허브 — 바 또는 추가 메뉴에서 도구를 엽니다.';

  @override
  String get appSettings => '앱 설정';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic 프로';

  @override
  String get settingsSubscriptionActive => '활성 구독';

  @override
  String get settingsSubscriptionLifetime => '평생 이용 가능';

  @override
  String get settingsSubscriptionFree => '무료 플랜';

  @override
  String get settingsManageBilling => '청구 관리';

  @override
  String get settingsTestModeSectionTitle => '테스트 모드';

  @override
  String get settingsTestModeProTitle => 'Tripmetic Pro로 테스트';

  @override
  String get settingsTestModeProSubtitle => '테스트를 위한 로컬 재정의 RevenueCat을 무시합니다.';

  @override
  String get settingsTestModeProCaption =>
      '활성화되면 이 장치는 모든 Pro 기능을 로컬로 잠금 해제합니다. 내부 테스트용으로만 사용되며 실제 구독에는 영향을 주지 않습니다.';

  @override
  String get settingsUnitsTitle => '측정 단위';

  @override
  String get settingsLanguageTitle => '언어';

  @override
  String get settingsThemeTitle => '주제';

  @override
  String get settingsClockWidgetTitle => '시계 위젯';

  @override
  String get settingsCurrencyWidgetTitle => '통화 위젯';

  @override
  String get settingsCurrencyWidgetSubtitle => '홈 및 잠금 화면: 기본 통화의 1, 20, 100';

  @override
  String get settingsThemeSystem => '체계';

  @override
  String get settingsThemeLight => '빛';

  @override
  String get settingsThemeDark => '어두운';

  @override
  String get settingsLanguageSystem => '시스템 기본값';

  @override
  String get settingsLanguageEnglish => '영어';

  @override
  String get settingsLanguageSpanish => '스페인 사람';

  @override
  String get settingsProfileTitle => '프로필 및 클라우드 동기화';

  @override
  String get settingsLogout => '로그아웃';

  @override
  String get settingsLogoutConfirm => '이 계정에서 로그아웃하시겠습니까?';

  @override
  String get settingsDeleteAccount => '계정 삭제';

  @override
  String get settingsDeleteAccountBody =>
      '계정 삭제는 지원팀에서 처리합니다. 아래에서 로그아웃할 수 있습니다.';

  @override
  String get settingsSectionAccount => '계정';

  @override
  String get accountManagementListTitle => '계정 관리';

  @override
  String get accountManagementListSubtitle => '이름, 이메일, 비밀번호 업데이트';

  @override
  String get accountManagementTitle => '계정 관리';

  @override
  String get accountSectionProfile => '윤곽';

  @override
  String get accountSectionSignIn => '로그인';

  @override
  String get accountFieldDisplayName => '표시 이름';

  @override
  String get accountFieldEmail => '이메일';

  @override
  String get accountFieldCurrentPassword => '현재 비밀번호';

  @override
  String get accountFieldNewPassword => '새 비밀번호';

  @override
  String get accountSaveName => '이름 저장';

  @override
  String get accountChangeEmail => '확인 보내기 및 이메일 변경';

  @override
  String get accountChangePassword => '비밀번호 변경';

  @override
  String get accountSignedOutMessage => '계정을 관리하려면 로그인해야 합니다.';

  @override
  String get accountSignInCta => '로그인';

  @override
  String get accountNameSaved => '이름이 업데이트되었습니다.';

  @override
  String accountEmailVerificationSent(String email) {
    return '$email(으)로 확인 링크가 전송되었습니다. 로그인 주소를 변경하려면 확인하세요.';
  }

  @override
  String get accountPasswordChanged => '비밀번호가 업데이트되었습니다.';

  @override
  String accountReauthRequired(String field) {
    return '보안을 위해 다시 로그인하여 $field을(를) 변경하세요.';
  }

  @override
  String get accountFieldLabelEmail => '이메일';

  @override
  String get accountFieldLabelPassword => '비밀번호';

  @override
  String accountErrorGeneric(String field, String error) {
    return '$field을(를) 업데이트할 수 없습니다: $error';
  }

  @override
  String get accountReauthAction => '다시 로그인';

  @override
  String get accountValidationEmailRequired => '이메일을 입력하세요';

  @override
  String get accountValidationEmailInvalid => '유효한 이메일을 입력하세요';

  @override
  String get accountValidationNameRequired => '이름을 입력하세요';

  @override
  String get accountValidationPasswordTooShort => '8자 이상 사용하세요.';

  @override
  String accountCurrentEmailLabel(String email) {
    return '현재 이메일: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic 프로';

  @override
  String get proPaywallSubtitle => '오프라인 지도, 심도 있는 여행 도구 및 공동작업을 잠금 해제하세요.';

  @override
  String get proPaywallBenefits =>
      '오프라인 지도 및 지역 다운로드\n일정, 예산, 보관 및 포장\n그룹 플래너 및 실시간 동기화';

  @override
  String get proPaywallBullets =>
      '오프라인 지도 및 지역 다운로드|일정, 예산, 보관 및 포장|그룹 플래너 및 실시간 동기화';

  @override
  String get proPaywallUpgradeRevenueCat => 'RevenueCat을(를) 통해 업그레이드';

  @override
  String get upgradeNow => '지금 업그레이드';

  @override
  String get packingCatClothing => '의류';

  @override
  String get packingCatDocuments => '서류';

  @override
  String get packingCatMedications => '약물';

  @override
  String get packingCatMisc => '기타';

  @override
  String get packingCatReservations => '전세';

  @override
  String get packingEmpty => '귀하의 목록이 비어 있습니다.\n항목을 추가하려면 +를 탭하세요.';

  @override
  String get packingEmptyHidden =>
      '짐을 꾸릴 것이 더 이상 없습니다. 또는 완료된 항목을 보려면 \"완료된 항목 숨기기\"를 끄십시오.';

  @override
  String get packingHeader => '포장 및 물류';

  @override
  String get packingHideCompleted => '숨기기 완료';

  @override
  String get packingHideCompletedSubtitle => '완료된 항목은 계속 저장됩니다. 이 보기에서만 숨겨집니다.';

  @override
  String get packingStarterPassport => '여권';

  @override
  String get packingStarterShirts => '셔츠';

  @override
  String get packingStarterSocks => '양말';

  @override
  String get packingStarterTickets => '항공권';

  @override
  String get packingStarterToothbrush => '칫솔';

  @override
  String get paywallDisabledBody =>
      'RevenueCat UI 검토를 위해 페이월이 일시적으로 비활성화되었습니다.';

  @override
  String get paywallDisabledTitle => '페이월이 비활성화되었습니다.';

  @override
  String get presentationDeleteBody => '정말로 이 문서를 Vault에서 제거하시겠습니까?';

  @override
  String get presentationDeleteTitle => '문서를 삭제하시겠습니까?';

  @override
  String get presentationImageLoadFail => '이미지를 로드하지 못했습니다.';

  @override
  String get proActive => '활동적인';

  @override
  String get proManageHintFree => '월간 구독으로 Pro 기능을 잠금 해제하세요.';

  @override
  String get proManageHintPro => '구독을 관리하거나 구매를 복원하세요.';

  @override
  String get proManageSubscription => '구독 관리';

  @override
  String get proName => 'Tripmetic 프로';

  @override
  String get proPaywallError => '페이월을 표시할 수 없습니다. RevenueCat 제품을 확인하세요.';

  @override
  String get proPaywallNotConfigured =>
      '이 설치에서는 구독을 사용할 수 없습니다. Pro로 업그레이드하려면 Google Play에서 Tripmetic을 설치하세요.';

  @override
  String proRestoreFailed(String message) {
    return '복원 실패: $message';
  }

  @override
  String get proTrialCta => '3일 무료 평가판을 시작하세요';

  @override
  String get proWelcome => 'Tripmetic Pro에 오신 것을 환영합니다.';

  @override
  String get schedulerAvailabilityGood => '좋은';

  @override
  String get schedulerAvailabilityOffHours => '근무 외 시간';

  @override
  String get schedulerAvailabilityOk => '좋아요';

  @override
  String get schedulerBaseLocation => '기본 위치';

  @override
  String schedulerBaseTooltip(String zone) {
    return '날짜, 시간 및 슬라이더는 기본 시계($zone)에 적용됩니다. 각 도시 행은 해당 구역에서 동일한 순간을 표시합니다.';
  }

  @override
  String get schedulerConvertedCities => '변환된 도시';

  @override
  String get schedulerDayNext => '+1일';

  @override
  String get schedulerDayPrevious => '-1일';

  @override
  String get schedulerDaySame => '같은 날';

  @override
  String get schedulerMeetingTime => '집합 시간';

  @override
  String get schedulerSubtitle => '회의 중복';

  @override
  String get schedulerTitle => '글로벌 스케줄러';

  @override
  String get settingsAndInfo => '설정 및 정보';

  @override
  String get settingsContact => '문의하기';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => '링크를 열 수 없습니다.';

  @override
  String get settingsHelpFaq => '도움말 및 FAQ';

  @override
  String get settingsPrivacy => '개인 정보 보호 정책';

  @override
  String get settingsSupportLegal => '지원 및 법률';

  @override
  String get settingsTerms => '이용약관';

  @override
  String get settingsMapboxAttributionTitle => '지도 데이터(Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic은 Mapbox 맵을 사용합니다. © Mapbox, © OpenStreetMap 및 기타 데이터 기여자. 더 명확한 레이아웃과 실수로 인한 탭을 줄이기 위해 지도 상의 로고와 속성 컨트롤이 앱에 숨겨져 있습니다. 이 공지는 Mapbox 표시 요구 사항을 충족합니다.';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — 지도 정보';

  @override
  String get sizeCatBelts => '벨트';

  @override
  String get sizeCatMensJeansCombo => '남성용 청바지 - W×L(미국)';

  @override
  String get sizeCatMensJeansInseam => '남성용 청바지 - 밑아래(L)';

  @override
  String get sizeCatMensJeansWaist => '남성용 청바지 - 허리(W)';

  @override
  String get sizeCatMensPants => '남성 바지';

  @override
  String get sizeCatMensShirts => '남성 셔츠';

  @override
  String get sizeCatMensShoes => '남성 신발';

  @override
  String get sizeCatMensTshirts => '남성 티셔츠';

  @override
  String get sizeCatWomensBlouses => '여성용 블라우스';

  @override
  String get sizeCatWomensDresses => '여성 드레스';

  @override
  String get sizeCatWomensPants => '여성용 바지';

  @override
  String get sizeCatWomensShoes => '여성 신발';

  @override
  String get sizeCatWomensTshirts => '여성용 티셔츠';

  @override
  String get sizeCatBoysShoes => '남아 신발(키즈)';

  @override
  String get sizeCatGirlsShoes => '여아 신발 (아동용)';

  @override
  String get sizeCatBoysTshirts => '남아 상의/티셔츠';

  @override
  String get sizeCatBoysPants => '남아용 바지';

  @override
  String get sizeCatGirlsTshirts => '여아상의 / 티셔츠';

  @override
  String get sizeCatGirlsPants => '여아 바지';

  @override
  String get sizeCatGirlsDressesKids => '여아 드레스(아동)';

  @override
  String get sizeColumnPrimaryEu => '기본: EU';

  @override
  String get sizeColumnPrimaryJp => '기본: 일본';

  @override
  String get sizeColumnPrimaryMixed => '기본: 혼합(EU→US→UK→JP)';

  @override
  String get sizeColumnPrimaryUk => '기본: 영국';

  @override
  String get sizeColumnPrimaryUs => '기본: 미국';

  @override
  String get sizeConverterAppBarSubtitle => '의류 및 신발';

  @override
  String get sizeConverterCategory => '범주';

  @override
  String get sizeConverterHeader => '의류 및 신발';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · 변경하려면 탭하세요.';
  }

  @override
  String get sizeConverterYourBaseSize => '기본 크기(태그에 있음)';

  @override
  String get sizeConverterYourCountry => '귀하의 국가/지역';

  @override
  String get sizeEquivalentSizesHeader => '동등한 크기';

  @override
  String get sizeHintBelts => '예를 들어 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => '예를 들어 38x32 또는 38×32';

  @override
  String get sizeHintMensJeansInseam => '예를 들어 32(밑아래\") 또는 38x32 → 밑아래 32 사용';

  @override
  String get sizeHintMensJeansWaist => '예를 들어 38(허리\") 또는 38x32 → 허리 38 사용';

  @override
  String get sizeHintMensPants => '예를 들어 30, 32, 34 (허리\")';

  @override
  String get sizeHintMensShirts => '예를 들어 15, 38, 남';

  @override
  String get sizeHintMensShoes => '예를 들어 6~14, 42, 27';

  @override
  String get sizeHintMensTshirts => '예를 들어 S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => '예를 들어 8, 38, M, XL';

  @override
  String get sizeHintWomensDresses => '예를 들어 8, 38, 남';

  @override
  String get sizeHintWomensPants => '예를 들어 6, 10, 38, 남';

  @override
  String get sizeHintWomensShoes => '예를 들어 5~12, 39, 25';

  @override
  String get sizeHintWomensTshirts => '예를 들어 XS, M, 38';

  @override
  String get sizeHintBoysShoes => '예를 들어 11C, 3Y, 32, 21';

  @override
  String get sizeHintGirlsShoes => '예를 들어 10C, 2Y, 33, 20';

  @override
  String get sizeHintBoysTshirts => '예를 들어 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => '예를 들어 6, 8, 10(미국 어린이)';

  @override
  String get sizeHintGirlsTshirts => '예를 들어 6, 8, 남, 에스';

  @override
  String get sizeHintGirlsPants => '예를 들어 6, 8, 10(미국 어린이)';

  @override
  String get sizeHintGirlsDressesKids => '예를 들어 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty => '의류나 신발에 인쇄된 사이즈를 입력하세요.';

  @override
  String get sizeNoMatchRow =>
      '이 카테고리에 일치하는 크기 행이 없습니다. 해당하는 경우 미국, 영국, EU, JP 번호 또는 문자(S, M, L)를 사용해 보세요.';

  @override
  String get sizeTipJeansCombo =>
      '예 US 38×32: 허리 ≒ EU 48, JP 허리 태그는 종종 ~96–97cm; 안쪽 솔기 32\" ≒ ~81cm. 브랜드마다 다르므로 이를 출발점으로 사용하세요.';

  @override
  String get sizeTipJeansInseam =>
      '안쪽 솔기는 다리 안쪽 길이(인치)입니다(예: 32). 일본에서는 32인치 안쪽 솔기에 ~81cm가 표시될 수 있습니다. 38×32를 입력하세요. 우리는 안쪽 솔기에 32를 사용합니다.';

  @override
  String get sizeTipJeansWaist =>
      '아시아 태그에 있는 숫자 중 하나는 허리를 나타내는 경우가 많습니다. 즉, 센티미터(38\" ≒ 96–97cm) 또는 미국 허리 인치(38)입니다. 줄자와 비교해 보세요. 여기에 38×32를 입력할 수 있습니다. 여기서는 허리에 38을 사용합니다.';

  @override
  String get timezonePickerEmpty => '일치하는 항목 없음';

  @override
  String get timezonePickerHint => 'IANA 이름 검색(예: 유럽, 도쿄)';

  @override
  String get timezonePickerTitle => '시간대 선택';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$total 영역 중 $shown';
  }

  @override
  String get timezoneSheetSearchHint => 'IANA 이름 검색(예: 유럽, 도쿄)';

  @override
  String get timezoneSheetTitle => '시간대 선택';

  @override
  String get tipAmount => '팁 금액';

  @override
  String get tipAppBarSubtitle => '팁 및 청구서';

  @override
  String get tipBillHint => '예를 들어 \$1,250,000.00';

  @override
  String get tipCountryBrazil => '브라질';

  @override
  String get tipCountryChina => '중국';

  @override
  String get tipCountryColombia => '콜롬비아';

  @override
  String get tipCountryDominicanRepublic => '도미니카 공화국';

  @override
  String get tipCountryEgypt => '이집트';

  @override
  String get tipCountryFrance => '프랑스';

  @override
  String get tipCountryGermany => '독일';

  @override
  String get tipCountryHongKong => '홍콩';

  @override
  String get tipCountryIndonesia => '인도네시아 공화국';

  @override
  String get tipCountryItaly => '이탈리아';

  @override
  String get tipCountryJapan => '일본';

  @override
  String get tipCountryMexico => '멕시코';

  @override
  String get tipCountryMorocco => '모로코 가죽';

  @override
  String get tipCountryPortugal => '포르투갈';

  @override
  String get tipCountrySingapore => '싱가포르';

  @override
  String get tipCountrySpain => '스페인';

  @override
  String get tipCountryThailand => '태국';

  @override
  String get tipCountryTurkey => '칠면조';

  @override
  String get tipCountryUae => '아랍에미리트(두바이)';

  @override
  String get tipCountryUnitedKingdom => '영국';

  @override
  String get tipCountryUsa => '미국';

  @override
  String get tipZeroReasonChina =>
      '팁을 주는 것은 중국 본토에서는 관례가 아니며 많은 곳에서 거부되거나 이상하게 보일 수 있습니다.';

  @override
  String get tipZeroReasonFrance =>
      '레스토랑 청구서에는 일반적으로 15%의 서비스 요금이 포함됩니다(서비스 구성). 탁월한 서비스를 위해 추가 팁은 선택 사항입니다.';

  @override
  String get tipZeroReasonJapan =>
      '일본에서는 팁을 주는 행위가 시행되지 않으며 혼란이나 불쾌감을 줄 수 있습니다.';

  @override
  String get tipZeroReasonSingapore =>
      '팁은 예상되지 않습니다. 많은 장소에서는 청구서에 10%의 봉사료를 추가합니다.';

  @override
  String get tipZeroReasonGeneric =>
      '여기서는 0% 팁이 일반적입니다. 뛰어난 서비스에 대한 팁을 추가할 수 있습니다.';

  @override
  String get tipZeroReasonTitle => '왜 0%인가요?';

  @override
  String get tipCurrentCountry => '현재 국가';

  @override
  String get tipPeople => '사람들';

  @override
  String get tipPerPerson => '1인당 금액';

  @override
  String get tipPercentHint => '팁 %(예: 15 또는 27.5)를 입력하세요.';

  @override
  String get tipPercentLabel => '팁 %';

  @override
  String get tipResults => '결과';

  @override
  String get tipSmartHeader => '스마트팁';

  @override
  String get tipTotalBill => '총 청구금액';

  @override
  String get tipTotalWithTip => '팁 포함 합계';

  @override
  String get toolBrainstorm => '영감';

  @override
  String get toolBudget => '예산';

  @override
  String get toolBudgetSubtitle => '여행 예산 계획 및 비용 추적';

  @override
  String get toolBudgetTitle => '예산';

  @override
  String get toolItinerarySubtitle => '날짜별 항공편, 호텔, 계획';

  @override
  String get toolItineraryTitle => '여행일정';

  @override
  String get toolCrypto => '암호화폐';

  @override
  String get toolCryptoSubtitle => 'USD 인기 코인의 가치';

  @override
  String get toolCryptoTitle => '암호화폐';

  @override
  String get toolDocumentVault => '문서 금고';

  @override
  String get toolMindMapSubtitle => '무한한 캔버스에 담긴 아이디어 · 오프라인';

  @override
  String get toolMindMapTitle => '브레인스토밍 마인드맵';

  @override
  String get toolPacking => '포장';

  @override
  String get toolPackingSubtitle => '여행별 스마트 짐 꾸리기 체크리스트';

  @override
  String get toolPackingTitle => '포장';

  @override
  String get toolSchedulerSubtitle => '이중 시간대 · 시차 계획';

  @override
  String get toolSchedulerTitle => '시간 및 날짜';

  @override
  String get toolSettingsAboutSubtitle => '공지사항, 도움말, 개인정보 보호 및 약관';

  @override
  String get toolSettingsAboutTitle => '설정 및 정보';

  @override
  String get toolSettingsInfo => '설정 및 정보';

  @override
  String get toolSizeSubtitle => '미국·영국·EU·일본(JP)';

  @override
  String get toolSizeTitle => '의류 사이즈 변환기';

  @override
  String get toolTimeDate => '시간 및 날짜';

  @override
  String get toolTipSubtitle => '국가 팁 규범 · 최대 20명으로 분할';

  @override
  String get toolTipTitle => '스마트 팁 및 청구서 분배기';

  @override
  String get toolUnits => '단위';

  @override
  String get toolUnitsSubtitle => '길이, 무게, 온도, 부피';

  @override
  String get toolUnitsTitle => '단위';

  @override
  String get toolVaultSubtitle => '중요한 여행 서류를 위한 오프라인 저장 공간';

  @override
  String get toolVaultTitle => '문서 금고';

  @override
  String get unitAcres => '에이커';

  @override
  String get unitCategoryArea => '영역';

  @override
  String get unitCategoryDistance => '거리';

  @override
  String get unitCategoryLength => '길이';

  @override
  String get unitCategoryTemperature => '온도';

  @override
  String get unitCategoryVolume => '용량';

  @override
  String get unitCategoryWeight => '무게';

  @override
  String get unitCelsius => '섭씨';

  @override
  String get unitCentimeters => '센티미터';

  @override
  String get unitFahrenheit => '화씨';

  @override
  String get unitFeet => '피트';

  @override
  String get unitGrams => '그램';

  @override
  String get unitHectares => '헥타르';

  @override
  String get unitInches => '신장';

  @override
  String get unitKilograms => '킬로그램';

  @override
  String get unitKilometers => '킬로미터';

  @override
  String get unitLiters => '리터';

  @override
  String get unitMeters => '미터';

  @override
  String get unitMiles => '마일리지';

  @override
  String get unitMilliliters => '밀리리터';

  @override
  String get unitOunces => '온스';

  @override
  String get unitPounds => '파운드';

  @override
  String get unitSquareCentimeters => '평방센티미터';

  @override
  String get unitSquareFeet => '평방피트';

  @override
  String get unitSquareInches => '평방인치';

  @override
  String get unitSquareKilometers => '평방킬로미터';

  @override
  String get unitSquareMeters => '평방미터';

  @override
  String get unitSquareYards => '평방야드';

  @override
  String get unitUsFluidOunces => '미국 액량 온스';

  @override
  String get unitUsGallons => '미국 갤런';

  @override
  String get unitYards => '야드';

  @override
  String get unitsHeader => '단위';

  @override
  String get vaultCategoryArrivalCard => '도착 카드';

  @override
  String get vaultCategoryHotelReservation => '호텔 예약';

  @override
  String get vaultCategoryOther => '다른';

  @override
  String get vaultCategoryPassportCopy => '여권 사본';

  @override
  String get vaultCategoryReturnFlight => '귀국 항공편';

  @override
  String get vaultCategoryVisa => '비자';

  @override
  String get vaultDocumentTitle => '문서';

  @override
  String get vaultIntro =>
      '출입국 관리소에서 오프라인으로 액세스하고 빠르게 제출할 수 있도록 중요한 여행 문서를 안전하게 저장하세요.';

  @override
  String vaultProcessFailed(String error) {
    return '문서 처리 실패: $error';
  }

  @override
  String get vaultTapToUpload => '업로드하려면 탭하세요.';

  @override
  String get vaultTapToView => '보려면 탭하세요.';

  @override
  String get vaultVaultWord => '둥근 천장';

  @override
  String get bucketListTitle => '버킷리스트';

  @override
  String get bucketListSubtitle => '가본 곳, 가고 싶은 곳, 앞으로 할 일.';

  @override
  String get bucketListToolSubtitle => '지도와 목록에 있는 꿈의 목적지';

  @override
  String get bucketListViewModeList => '목록';

  @override
  String get bucketListViewModeMap => '지도';

  @override
  String get bucketListViewModePopular => '인기 있는';

  @override
  String get bucketListPopularHint =>
      'Been, Live 및 Lived가 지도와 목록을 업데이트합니다. Want 및 Upcoming은 목록으로만 표시되며 지도에는 표시되지 않습니다.';

  @override
  String get bucketListCategoryBeen => '계속 ~ 이다';

  @override
  String get bucketListCategoryWant => '원하다';

  @override
  String get bucketListCategoryLive => '살다';

  @override
  String get bucketListCategoryLived => '살았다';

  @override
  String get bucketListCategoryUpcoming => '예정';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => '범주';

  @override
  String get bucketListDetailDates => '날짜';

  @override
  String get bucketListMapLegend => '자세한 내용을 보려면 아이콘을 탭하세요.';

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
    return '$name은 세계의 $worldPercent%를 탐험했습니다. 세계 인구의 $populationPercent% 이상을 여행했습니다.';
  }

  @override
  String get bucketListShareMapTravelerFallback => '라파엘';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return '세계 인구의 $percent% 이상을 여행했습니다.';
  }

  @override
  String get bucketListShareMapCountriesLabel => '국가';

  @override
  String get bucketListShareMapCitiesLabel => '도시';

  @override
  String get bucketListEmptyCategory => '이 카테고리에는 아직 장소가 없습니다.';

  @override
  String get bucketListTravelStats => '여행 통계';

  @override
  String get bucketListStatWorld => '탐험된 세계';

  @override
  String get bucketListStatUs => '미국 탐험';

  @override
  String get bucketListStatEurope => '유럽을 탐험했다';

  @override
  String get bucketListStatAsia => '아시아 탐험';

  @override
  String get bucketListStatAfrica => '아프리카 탐험';

  @override
  String get bucketListStatRegionalCaption => '지역';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count 고유 · $total 중';
  }

  @override
  String get bucketListAddDestination => '목적지 추가';

  @override
  String get bucketListEditDestination => '목적지 수정';

  @override
  String get bucketListSave => '구하다';

  @override
  String get bucketListFieldCity => '도시';

  @override
  String get bucketListFieldCountry => '국가';

  @override
  String get bucketListFieldCategory => '범주';

  @override
  String get bucketListFieldRegionHint => '주/도(선택사항)';

  @override
  String get bucketListFieldLatitude => '위도';

  @override
  String get bucketListFieldLongitude => '경도';

  @override
  String get bucketListFieldStart => '시작일';

  @override
  String get bucketListFieldEnd => '종료일';

  @override
  String get bucketListFieldTripDates => '여행 날짜';

  @override
  String get bucketListValidationRequired => '이 필드는 필수입니다.';

  @override
  String get bucketListValidationNumber => '유효한 숫자를 입력하세요.';

  @override
  String get bucketListValidationDates => '종료일은 시작일 또는 그 이후여야 합니다.';

  @override
  String get bucketListGeocodeNotFound => '지도에서 이 위치를 찾을 수 없습니다. 철자를 확인해주세요.';

  @override
  String get bucketListShareSummarySubject => '나의 Tripmetic 버킷리스트';

  @override
  String get bucketListShareTooltip => '목록 및 지도 공유';

  @override
  String bucketListShareFailed(String error) {
    return '공유할 수 없음: $error';
  }

  @override
  String get bucketListShareNeedMap => '지도 이미지를 캡처하기 전에 지도 보기를 엽니다.';

  @override
  String get bucketListDeleteHint => '스와이프하여 삭제';

  @override
  String get bucketListTapEditHint => '수정하려면 탭하세요.';

  @override
  String bucketListCloudSyncFailed(String error) {
    return '클라우드 동기화 실패: $error';
  }

  @override
  String get bucketListRetry => '다시 해 보다';

  @override
  String get bucketListBackupTooltip => '백업 및 등록';

  @override
  String get bucketListBackupTitle => '클라우드 백업';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic은 계정 없이도 완벽하게 작동합니다. 버킷리스트와 공유 그룹 여행을 위한 클라우드 백업이 필요하다면 언제든지 추가하세요.';

  @override
  String bucketListSignedInAs(String email) {
    return '$email(으)로 로그인됨';
  }

  @override
  String get bucketListBackupEmail => '이메일';

  @override
  String get bucketListBackupPassword => '비밀번호';

  @override
  String get bucketListBackupConfirmPassword => '비밀번호 확인';

  @override
  String get bucketListAuthTabSignUp => '가입';

  @override
  String get bucketListAuthPasswordMismatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get bucketListRegister => '계정 생성 및 백업';

  @override
  String get bucketListSignIn => '로그인';

  @override
  String get bucketListSignOut => '로그아웃';

  @override
  String get bucketListBackupUploading => '클라우드에 업로드 중…';

  @override
  String get bucketListAuthSuccessSignIn => '성공적으로 로그인되었습니다!';

  @override
  String get bucketListAuthSuccessSignUp => '계정이 성공적으로 생성되었습니다!';

  @override
  String get signUpSuccessMessage => '계정이 생성되었습니다. Tripmetic에 오신 것을 환영합니다!';

  @override
  String get signUpErrorEmailInUse => '이 이메일은 이미 등록되어 있습니다. 로그인해 보세요.';

  @override
  String get signUpErrorInvalidEmail => '유효한 이메일을 입력하세요.';

  @override
  String get signUpErrorWeakPassword => '비밀번호가 너무 취약합니다. 8자 이상을 사용하세요.';

  @override
  String signUpErrorGeneric(String message) {
    return '가입할 수 없음: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => '로그인';

  @override
  String bucketListAuthFailed(String error) {
    return '인증할 수 없습니다: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => '아직 메모나 링크가 없습니다.';

  @override
  String get groupPlannerTitle => '그룹 플래너';

  @override
  String get groupPlannerToolTitle => '그룹 플래너';

  @override
  String get groupPlannerToolSubtitle => '실시간으로 함께 여행을 계획해보세요';

  @override
  String get groupPlannerLandingPlanTitle => '단체 여행 계획하기';

  @override
  String get groupPlannerLandingPlanSubtitle => '목적지, 날짜, 예산이 포함된 공유 여행을 만드세요.';

  @override
  String get groupPlannerLandingJoinTitle => '단체 여행에 참여하세요';

  @override
  String get groupPlannerLandingJoinSubtitle => '초대장에 있는 여행 코드나 링크를 입력하세요.';

  @override
  String get groupPlannerCreateTripTitle => '새로운 단체 여행';

  @override
  String get groupPlannerSelectDates => '여행 날짜 범위를 선택하세요.';

  @override
  String get groupPlannerBudgetPerPersonOption => '1인당';

  @override
  String get groupPlannerBudgetGroupOption => '그룹 합계';

  @override
  String get groupPlannerBudgetNoneOption => '없음';

  @override
  String get groupPlannerBudgetAmountLabel => '예산 금액';

  @override
  String get groupPlannerOpenTitle => '단체 여행 열기';

  @override
  String get groupPlannerOpenSubtitle => '초대장에 있는 여행 코드를 붙여넣으세요.';

  @override
  String get groupPlannerOpenTripCodeLabel => '여행 코드';

  @override
  String get groupPlannerOpenHint => '단축 코드, 여행 ID 또는 초대 링크';

  @override
  String get groupPlannerOpenButton => '오픈트립';

  @override
  String get groupPlannerDestination => '목적지';

  @override
  String get groupPlannerDates => '날짜';

  @override
  String get groupPlannerGroupSize => '그룹 규모';

  @override
  String get groupPlannerBudget => '예산';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return '1인당: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return '그룹 합계: $amount';
  }

  @override
  String get groupPlannerBudgetNone => '예산이 설정되지 않았습니다.';

  @override
  String get groupPlannerInviteMembers => '회원 초대';

  @override
  String get groupPlannerManageMembers => '회원 관리';

  @override
  String get groupPlannerItinerary => '여행일정';

  @override
  String get groupPlannerItineraryEditorHint =>
      '여행 관리자 또는 여행 코디네이터는 활동을 추가하고 일정을 변경할 수 있습니다.';

  @override
  String get groupPlannerItineraryViewerHint =>
      '읽기 전용: 엄지손가락을 위 또는 아래로 표시하여 추천 활동에 투표합니다. 여행 관리자와 여행 코디네이터만 항목을 추가하거나 변경할 수 있습니다.';

  @override
  String get groupPlannerNoActivities => '아직 활동이 없습니다.';

  @override
  String get groupPlannerTripNotFound => '이 여행을 로드할 수 없습니다.';

  @override
  String get groupPlannerSignInTitle => '로그인이 필요합니다';

  @override
  String get groupPlannerSignInBody =>
      '버킷리스트 → 클라우드 백업에서 로그인하시면 공유된 여행을 보실 수 있습니다.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      '새로운 단체 여행을 저장하려면 계정이 필요합니다. 계속하려면 로그인하세요. 다른 Tripmetic 기능은 로그인 없이도 작동합니다.';

  @override
  String get groupPlannerMembersTitle => '회원';

  @override
  String get groupPlannerRoleAdmin => '관리자';

  @override
  String get groupPlannerRoleCoPlanner => '여행 코디네이터';

  @override
  String get groupPlannerRoleViewOnly => '보기 전용';

  @override
  String get groupPlannerOwner => '소유자';

  @override
  String get groupPlannerRemoveMember => '제거하다';

  @override
  String get groupPlannerRemoveMemberTitle => '구성원을 삭제하시겠습니까?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return '이 여행에서 $email을(를) 삭제하시겠습니까?';
  }

  @override
  String get groupPlannerCancel => '취소';

  @override
  String get groupPlannerNotes => '메모';

  @override
  String get groupPlannerOpenLink => '링크 열기';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return '투표를 저장할 수 없습니다: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return '회원을 업데이트할 수 없습니다: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return '공유 시트를 열 수 없습니다: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return '여행을 열 수 없습니다: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => '당신의 여행';

  @override
  String get groupPlannerMyTripsEmpty => '아직 여행이 없습니다. 위에서 하나를 만듭니다.';

  @override
  String get groupPlannerExamplesTitle => '여행 예시';

  @override
  String get groupPlannerExamplesSubtitle =>
      '샘플 카드 - 위에서 여행을 만들어 나만의 여행을 추가하세요.';

  @override
  String get groupPlannerExampleTapBody =>
      '이는 샘플일 뿐입니다. \'단체 여행 계획하기\'를 이용해 공유할 수 있는 실제 여행을 만들어보세요.';

  @override
  String get groupPlannerExampleLisbonTitle => '리스본 팀 오프사이트';

  @override
  String get groupPlannerExampleKyotoTitle => '교토 봄 여행';

  @override
  String get groupPlannerAddActivity => '활동 추가';

  @override
  String get groupPlannerActivityTitleLabel => '활동 제목';

  @override
  String get groupPlannerActivityWhenLabel => '날짜 및 시간';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      '여행 날짜를 정하고 시간을 정하세요. 여행 일정을 편집할 수 있는 사람은 누구나 나중에 이를 변경할 수 있습니다.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      '해당 날짜는 이번 여행이 아닌 날짜입니다. 여행 시작일과 종료일 사이의 날짜를 선택하세요.';

  @override
  String get groupPlannerActivityTitleRequired => '활동 제목을 입력하세요.';

  @override
  String get groupPlannerActivityDateUnset =>
      '날짜가 설정되지 않았습니다. 일정을 예약하려면 편집을 탭하세요.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count명';
  }

  @override
  String get groupPlannerEditActivity => '활동 수정';

  @override
  String get groupPlannerDeleteActivity => '삭제';

  @override
  String get groupPlannerDeleteActivityTitle => '활동을 삭제하시겠습니까?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return '여행 일정에서 \"$title\"을(를) 제거하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return '활동을 삭제할 수 없습니다: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return '활동을 업데이트할 수 없습니다: $error';
  }

  @override
  String get groupPlannerEditTripTitle => '여행 수정';

  @override
  String get groupPlannerEditTripAction => '여행 수정';

  @override
  String get groupPlannerDeleteTripTitle => '여행을 삭제하시겠습니까?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return '모든 사람의 \'$destination\' 여행 및 여행 일정을 영구적으로 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get groupPlannerDeleteTripAction => '여행 삭제';

  @override
  String get groupPlannerTripDeleted => '여행이 삭제되었습니다.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return '여행을 삭제할 수 없습니다: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return '여행을 업데이트할 수 없습니다: $error';
  }

  @override
  String get widgetInstructionTitle => '듀얼 시계 위젯';

  @override
  String get widgetInstructionSubtitle =>
      '잠금 화면이나 홈 화면에서 집과 목적지 시간대를 직접 추적하세요.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => '잠금 화면';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      '잠금 화면을 길게 누르고 \'사용자 지정\'을 탭하세요.';

  @override
  String get widgetInstructionIosLockScreenStep2 => '\'잠금 ​​화면\' 미리보기를 선택하세요.';

  @override
  String get widgetInstructionIosLockScreenStep3 => '시간 바로 아래의 위젯 영역을 탭하세요.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      '아래로 스크롤하여 Tripmetic을 선택하고 탭하여 위젯을 추가하세요.';

  @override
  String get widgetInstructionIosHomeScreenTitle => '홈 화면';

  @override
  String get widgetInstructionIosHomeScreenStep1 => '홈 화면의 빈 공간을 길게 누르세요.';

  @override
  String get widgetInstructionIosHomeScreenStep2 => '왼쪽 상단에 있는 + 아이콘을 탭하세요.';

  @override
  String get widgetInstructionIosHomeScreenStep3 => '\'Tripmetic\'을 검색하세요.';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      '원하는 위젯 크기를 선택하고 \'위젯 추가\'를 탭하세요.';

  @override
  String get widgetInstructionAndroidStep1 => '홈 화면으로 이동하여 빈 공간을 길게 누르세요.';

  @override
  String get widgetInstructionAndroidStep2 => '\"위젯\"을 탭하세요.';

  @override
  String get widgetInstructionAndroidStep3 => 'Tripmetic까지 아래로 스크롤합니다.';

  @override
  String get widgetInstructionAndroidStep4 => '듀얼 시계 위젯을 길게 누른 후 화면으로 드래그하세요.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      '잠금 화면에서 두 시계를 모두 보려면 설정을 열고 → \'잠금 화면\' 또는 \'위젯\'을 검색하고 휴대전화에서 잠금 화면 위젯을 제공하는 경우(일부 기기에서는 그렇지 않음) Tripmetic을 추가하세요.';

  @override
  String get widgetInstructionConfigureCta => '위젯 도시 구성';

  @override
  String get currencyWidgetInstructionTitle => '환율 계산기 위젯';

  @override
  String get currencyWidgetInstructionSubtitle =>
      '기본 통화와 목표 통화를 Android 홈 화면에 고정하세요. Tripmetic에서 변환기를 사용할 때마다 요금이 동기화됩니다.';

  @override
  String get currencyWidgetInstructionAndroidTitle => '홈 화면에 추가';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      '통화 도구를 한 번 열고 처음 두 통화(기본 및 목표)를 설정하세요.';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      '홈 화면으로 이동하여 빈 공간을 길게 누르세요.';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      '\'위젯\'을 탭하고 Tripmetic으로 스크롤한 다음 \'통화 변환기\'를 선택하세요.';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      '위젯을 홈 화면으로 드래그하거나, 런처에서 지원하는 경우 추가를 탭하세요.';

  @override
  String get currencyWidgetInstructionUsageTitle => '위젯 사용';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      'Tripmetic에서 통화 선택을 열려면 변경(또는 위젯 본문)을 탭하세요.';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      '↻ 새로 고침을 눌러 백그라운드 위젯의 요율을 업데이트하세요(앱은 열리지 않습니다).';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      '앱에서 통화나 가치를 편집하면 금액이 자동으로 업데이트됩니다.';

  @override
  String get currencyWidgetInstructionPinCta => '홈 화면에 위젯 추가';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta => '위젯 통화 변경';

  @override
  String get currencyWidgetInstructionIosHint =>
      '통화 홈 화면 위젯은 Android에서 사용할 수 있습니다. iPhone에서는 앱 내 통화 도구를 사용하세요.';

  @override
  String get currencyWidgetPinUnsupported =>
      '귀하의 런처는 앱에서 이 위젯을 추가하는 것을 지원하지 않습니다. 홈 화면을 길게 누르고 대신 위젯을 선택하세요.';

  @override
  String get currencyWidgetPinFailed =>
      '위젯 선택기를 열 수 없습니다. 홈 화면에서 위젯을 수동으로 추가하세요.';

  @override
  String get dualClockScreenTitle => '듀얼 시계 위젯';

  @override
  String get dualClockConfigTitle => '도시 구성';

  @override
  String get dualClockConfigSubtitle =>
      '두 개의 도시와 시간대를 선택하세요. 선택 사항은 Tripmetic 홈 화면 위젯(Android) 및 잠금 화면 위젯(iOS)에 동기화됩니다.';

  @override
  String get dualClockCity1Label => '첫 번째 도시';

  @override
  String get dualClockCity2Label => '두 번째 도시';

  @override
  String get dualClockSave => '위젯 저장 및 업데이트';

  @override
  String get dualClockSaved => '위젯이 업데이트되었습니다.';

  @override
  String get dualClockSaveError => '위젯 데이터를 저장할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get dualClockAppearanceTitle => '위젯 모양';

  @override
  String get dualClockAppearanceHint =>
      '텍스트 크기, 색상, 홈 화면 배경을 사용자 정의하세요. 잠금 화면에서는 글꼴 크기(및 시스템에서 허용하는 색상)를 사용합니다.';

  @override
  String get dualClockFontScaleLabel => '텍스트 크기';

  @override
  String get dualClockColorCity => '도시 이름';

  @override
  String get dualClockColorTime => '타임스';

  @override
  String get dualClockColorDate => '날짜';

  @override
  String get dualClockColorBackground => '홈 배경';

  @override
  String get dualClockShadowLabel => '텍스트 그림자';

  @override
  String get dualClockShadowSubtitle => '바쁘거나 사진이 있는 배경화면에 대비를 추가합니다.';

  @override
  String get moreToolsDualClockBannerTitle => '듀얼 시계 위젯';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      '잠금 화면이나 홈 화면에서 두 가지 시간대를 확인하세요. 탭하여 설정하세요.';

  @override
  String get moreToolsDualClockBannerCta => '설정';

  @override
  String get settingsDualClockWidgetTitle => '듀얼 시계 위젯';

  @override
  String get settingsDualClockWidgetSubtitle => '위젯을 추가하고 도시를 선택하세요';

  @override
  String get widgetNewFeatureBadge => '새로운';

  @override
  String get globalNavAccountCloudSyncTooltip => '계정 및 클라우드 백업';

  @override
  String get exchangeRatesForceRefreshTooltip => '최신 환율 가져오기';

  @override
  String get exchangeRatesRefreshedOk => '환율이 업데이트되었습니다.';

  @override
  String get exchangeRatesRefreshFailed => '환율을 새로고침할 수 없습니다.';

  @override
  String get bucketListStatUsTerritories => '미국 영토';

  @override
  String get bucketListAuthErrUserNotFound => '이 이메일에 대한 계정을 찾을 수 없습니다.';

  @override
  String get bucketListAuthErrWrongPassword => '이메일이나 비밀번호가 잘못되었습니다.';

  @override
  String get bucketListAuthErrEmailInUse => '이 이메일에 대한 계정이 이미 존재합니다.';

  @override
  String get bucketListAuthErrInvalidEmail => '이메일 주소가 잘못되었습니다.';

  @override
  String get bucketListAuthErrWeakPassword => '비밀번호가 너무 취약합니다.';

  @override
  String get bucketListAuthErrUserDisabled => '이 계정은 비활성화되었습니다.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      '시도 횟수가 너무 많습니다. 나중에 다시 시도하세요.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      '이메일/비밀번호 로그인이 활성화되지 않았습니다.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => '이메일 주소가 잘못되었습니다.';

  @override
  String get bucketListAuthValidationPasswordShort => '비밀번호는 6자 이상이어야 합니다.';

  @override
  String get bucketListAuthValidationPasswordRequired => '비밀번호를 입력하세요.';

  @override
  String get currencyWidgetAppearanceTitle => '모습';

  @override
  String get currencyWidgetAppearanceHint =>
      '글꼴 크기, 텍스트 색상, 홈 화면 배경을 사용자 정의하세요. 홈 위젯은 고정된 크기를 유지하므로 큰 글꼴은 자동으로 맞춰져 모든 행이 계속 표시됩니다. 잠금 화면에서는 글꼴 크기(및 시스템에서 허용하는 색상)를 사용합니다.';

  @override
  String get currencyWidgetFontScaleLabel => '글꼴 크기';

  @override
  String get currencyWidgetColorPrimary => '기본 텍스트(금액/기본)';

  @override
  String get currencyWidgetColorAccent => '악센트 텍스트(쌍/사다리 라벨)';

  @override
  String get currencyWidgetColorCaption => '캡션 텍스트(요율 표시줄)';

  @override
  String get currencyWidgetColorBackground => '홈 배경';

  @override
  String get currencyWidgetSaveAppearance => '외모 저장';

  @override
  String get currencyWidgetAppearanceSaved => '통화 위젯 모양이 저장되었습니다.';

  @override
  String get currencyWidgetAppearanceSaveFailed => '위젯 모양을 저장할 수 없습니다.';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
