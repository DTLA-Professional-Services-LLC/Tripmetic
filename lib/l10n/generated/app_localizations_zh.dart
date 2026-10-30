// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get addItineraryEnterTitle => '请输入标题';

  @override
  String get addItineraryFieldLocation => '地点';

  @override
  String get addItineraryFieldNotes => '备注/确认';

  @override
  String get addItineraryFieldTitle => '标题';

  @override
  String get addItineraryHintLocation => '机场、酒店地址……';

  @override
  String get addItineraryHintNotes => '记录定位器、链接...';

  @override
  String get addItineraryHintTitle => '飞往 里斯本 的航班';

  @override
  String get addItinerarySave => '保存事件';

  @override
  String get addItineraryTitle => '添加行程事件';

  @override
  String get addPackingAddToList => '添加到列表';

  @override
  String get addPackingEnterName => '请输入商品名称';

  @override
  String get addPackingFieldCategory => '类别';

  @override
  String get addPackingFieldItemName => '商品名称';

  @override
  String get addPackingHint => '例如电源适配器';

  @override
  String get addPackingIcon => '图标';

  @override
  String get addPackingQuantity => '数量';

  @override
  String get addPackingTitle => '添加包装项目';

  @override
  String get announcementsLatest => '最新更新';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => '基础货币';

  @override
  String get budgetCategoryDialogHint => '例如纪念品';

  @override
  String get budgetCategoryNameExists => '名称已存在';

  @override
  String get budgetCategoryNameMax => '最多 40 个字符';

  @override
  String get budgetDailyFood => '日常饮食';

  @override
  String get budgetDestinationSearchHint => '搜索国家或货币代码';

  @override
  String get budgetDestinationTitle => '添加目的地';

  @override
  String get budgetDialogAdd => '添加';

  @override
  String get budgetDialogNewCategory => '新的费用类别';

  @override
  String budgetDialogRemoveBody(String name) {
    return '删除“$name”及其金额？';
  }

  @override
  String get budgetDialogRemoveTitle => '删除类别';

  @override
  String get budgetDialogRename => '重命名';

  @override
  String get budgetDialogRenameCategory => '重命名类别';

  @override
  String get budgetEdit => '编辑预算';

  @override
  String get budgetExpenseDailyFood => '日常饮食';

  @override
  String get budgetExpenseEatingOut => '外出就餐';

  @override
  String get budgetExpenseEntertainment => '娱乐';

  @override
  String get budgetExpenseFlights => '航班';

  @override
  String get budgetExpenseGrocery => '杂货店';

  @override
  String get budgetExpenseHotels => '酒店';

  @override
  String get budgetExpenseMisc => '杂项';

  @override
  String get budgetExpensePhoneService => '电话服务';

  @override
  String get budgetExpenseShopping => '购物';

  @override
  String get budgetExpenseTourism => '旅游';

  @override
  String get budgetExpenseTransportation => '运输';

  @override
  String get budgetExpenseTravelInsurance => '旅游保险';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3,000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => '在您的目的地';

  @override
  String get budgetNoCategories => '还没有费用类别';

  @override
  String budgetOtherExpenses(String code) {
    return '其他费用 ($code)';
  }

  @override
  String get budgetPerDayEstimate => '每天（估计）';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / 天';
  }

  @override
  String budgetRemainingAfter(String code) {
    return '费用后剩余 · $code';
  }

  @override
  String get budgetSave => '节省预算';

  @override
  String get budgetSpendingPower => '消费能力';

  @override
  String get budgetSpentVsBudget => '支出与预算';

  @override
  String budgetTotalBudget(String code) {
    return '总预算 ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return '行程总计 ($code)';
  }

  @override
  String get budgetTripDashboard => '仪表板';

  @override
  String get budgetTripLengthDays => '行程长度（天）';

  @override
  String get budgetTripTitle => '旅行预算';

  @override
  String get commonAdd => '添加';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonOk => '好的';

  @override
  String get commonRemove => '消除';

  @override
  String get commonRename => '重命名';

  @override
  String get commonSave => '节省';

  @override
  String get commonKeyboardDone => '完毕';

  @override
  String countryCountriesCount(String count) {
    return '$count 国家';
  }

  @override
  String get countryPickerTitle => '选择国家';

  @override
  String get countrySheetSearchHint => '搜索国家/地区名称或 ISO 代码';

  @override
  String get countrySheetTitle => '基准国家/地区';

  @override
  String get cryptoHeader => '加密货币';

  @override
  String cryptoMockPerUnit(String price) {
    return '模拟 ~$price / 单位';
  }

  @override
  String get cryptoPickerTitle => '选择一枚硬币';

  @override
  String get cryptoSheetTitle => '选择加密货币';

  @override
  String get currencyPickerSearchHint => '搜索股票代码或名称';

  @override
  String get currencyPickerTitle => '选择货币';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '显示 $total 的 $shown';
  }

  @override
  String get currencySheetSearchHint => '搜索代码、名称或数字 ISO';

  @override
  String get currencySheetTitle => '选择货币';

  @override
  String get exchangeBaseSuffix => '· 根据';

  @override
  String exchangeCouldNotLoad(String error) {
    return '无法加载速率\n$error';
  }

  @override
  String get exchangeHeader => '交换';

  @override
  String exchangeLastUpdated(String mins) {
    return '上次更新于 $mins 分钟前';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return '最后更新于 $mins 分钟前（离线）';
  }

  @override
  String get exchangeResetOne => '重置为 1（USD 基）';

  @override
  String get exchangeResetTooltip => '重置金额';

  @override
  String get exchangeResetZero => '清零';

  @override
  String itineraryDayPrefix(String day, String date) {
    return '$day 日：$date';
  }

  @override
  String get itineraryEmpty => '还没有活动。\n点击 + 添加航班、酒店和计划。';

  @override
  String get itineraryHeader => '行程';

  @override
  String itineraryHiveError(String error) {
    return '无法打开保存的行程数据。\n您仍然可以尝试添加事件 - 它们可能不会持续存在。\n($error)';
  }

  @override
  String get itineraryOpenOnMap => '在地图上打开';

  @override
  String get mapAddToTrip => '添加到行程';

  @override
  String get mapClearRoute => '清晰的路线和指导';

  @override
  String get mapClearTooltip => '清除';

  @override
  String get mapDisplayCurrentViewport => '当前视口';

  @override
  String get mapDisplaySavedSearch => '已保存的搜索';

  @override
  String get mapDisplayTripDestination => '旅行目的地';

  @override
  String get mapDownloadAll => '下载全部';

  @override
  String get mapDownloadCurrentRegion => '下载当前区域以供离线使用';

  @override
  String get mapDownloadThisDestination => '下载这个目的地';

  @override
  String get mapDownloadedRegions => '下载区域';

  @override
  String get mapDownloadingRegion => '正在下载区域...';

  @override
  String mapDownloadingTitle(String title) {
    return '正在下载 $title...';
  }

  @override
  String get mapFromItinerary => '从你的行程来看';

  @override
  String get mapItineraryEmptyHint => '添加行程目的地以在此处预先下载。';

  @override
  String get mapLoadingRegions => '正在加载离线区域...';

  @override
  String mapLocatingQuery(String query) {
    return '正在定位 $query...';
  }

  @override
  String get mapMarkCategoryBody => '选择如何标记该离线图钉。';

  @override
  String get mapMarkCategoryTitle => '该标记的类别';

  @override
  String get mapMarkFood => '食物';

  @override
  String get mapMarkHotel => '酒店';

  @override
  String get mapMarkLandmark => '地标';

  @override
  String get mapMarkOther => '其他';

  @override
  String mapNextInstruction(String current, String total) {
    return '下一条指令 ($current/$total)';
  }

  @override
  String get mapNoLocationSet => '未设置位置';

  @override
  String get mapNoRegionsYet => '您尚未下载任何区域。';

  @override
  String get mapOfflineIntro => '保存当前可见的区域，或预先下载您的旅行目的地，以便在离网时进行导航。';

  @override
  String get mapOfflineMapsTitle => '离线地图';

  @override
  String get mapRefreshTooltip => '刷新';

  @override
  String get mapRemovePinTooltip => '移除销钉';

  @override
  String get mapSaveOffline => '离线保存';

  @override
  String get mapSavePinToMap => '将图钉保存到地图';

  @override
  String get mapSavedPinsBody => '您通过搜索保存的 Pin 图。点击删除即可从地图中删除一个。';

  @override
  String get mapSavedPinsTitle => '保存的地图图钉';

  @override
  String get mapSearchHint => '搜索城市、地址或地标......';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title 添加到您的离线标记中。';
  }

  @override
  String get mapSnackArrived => '你已经到了。';

  @override
  String mapSnackCouldNotFind(String query) {
    return '找不到“$query”。';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return '删除失败：$error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return '离线下载失败：$error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return '下载“$title”。';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '“$title”未设置位置。';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return '已完成 $count 行程地区的下载。';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return '无法加载离线区域：$error';
  }

  @override
  String get mapSnackLocationOff => '定位服务已关闭。启用它即可开始导航。';

  @override
  String get mapSnackLocationPermission => '逐向导航需要位置许可。';

  @override
  String get mapSnackLocationDeniedForMap => '需要位置权限才能使地图以您为中心。';

  @override
  String get mapSnackLocateFail => '目前无法获取您的位置。';

  @override
  String get mapLocateMeTooltip => '前往我的位置';

  @override
  String get mapSnackMapNotReady => '地图还没有准备好。请稍等。';

  @override
  String get mapSnackNavStartFail => '现在无法开始导航。';

  @override
  String get mapSnackNavStopped => '导航停止了。';

  @override
  String get mapSnackNoItineraryLocations => '没有任何行程活动有可供下载的位置或地图点。';

  @override
  String get mapSnackNoManeuver => '这一步没有精确的机动点。';

  @override
  String get mapSnackNoRoute => '找不到路线；显示目的地。';

  @override
  String get mapSnackRegionDownloaded => '地区下载成功！您现在可以离线导航。';

  @override
  String get mapSnackRemovedPin => '删除了保存的引脚。';

  @override
  String mapSnackRemovedRegion(String name) {
    return '删除了离线区域“$name”。';
  }

  @override
  String get mapSnackRouteCleared => '路线和指导已清除。';

  @override
  String mapSnackRoutingFailed(String error) {
    return '路由失败：$error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return '搜索失败：$error';
  }

  @override
  String get mapStartNavigation => '开始导航';

  @override
  String get mapStartingNav => '开始导航...';

  @override
  String get mapStopNavigation => '停止导航';

  @override
  String get mapTravelDriving => '驾驶';

  @override
  String get mapTravelWalking => '步行';

  @override
  String mapTurnByTurn(String mode) {
    return '逐向 ($mode)';
  }

  @override
  String get mindMapCaptureFail => '无法捕获思维导图。再试一次。';

  @override
  String get mindMapClearBody => '这将删除所有节点并恢复演示思维导图（居中示例）。';

  @override
  String get mindMapClearTitle => '透明画布？';

  @override
  String get mindMapClearTooltip => '清除/重置';

  @override
  String mindMapCouldNotSave(String error) {
    return '无法保存：$error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return '无法保存：$type';
  }

  @override
  String get mindMapEmailShare => '电子邮件/分享';

  @override
  String get mindMapEmptyNode => '空节点';

  @override
  String get mindMapHelpHint => '捏合缩放·拖动画布·拖动卡片·点击卡片进行编辑·+添加子项';

  @override
  String get mindMapNodeAddLeftTooltip => '添加左孩子';

  @override
  String get mindMapNodeAddRightTooltip => '添加右孩子';

  @override
  String get mindMapNodeDeleteTooltip => '删除节点';

  @override
  String get mindMapNodeEditTitle => '编辑节点';

  @override
  String get mindMapNodeHint => '输入短标签';

  @override
  String get mindMapPhotoAccess => '需要访问照片库才能保存图像。';

  @override
  String get mindMapReset => '重置';

  @override
  String get mindMapSavePhoto => '另存为照片';

  @override
  String get mindMapSavedPhotos => '保存到照片';

  @override
  String get mindMapShareCaptureFail => '无法捕获思维导图以供共享。';

  @override
  String get mindMapShareCompleted => '分享完成';

  @override
  String mindMapShareFailed(String error) {
    return '共享失败：$error';
  }

  @override
  String get mindMapShareReady => '图像准备就绪 - 选择要共享的应用程序';

  @override
  String get mindMapShareSheetClosed => '共享表已关闭';

  @override
  String get mindMapShareSubject => 'Tripmetic — 思维导图';

  @override
  String get mindMapShareText => '从 Tripmetic 导出思维导图';

  @override
  String get mindMapTapToEdit => '点击进行编辑';

  @override
  String get moreToolsHeader => '更多工具';

  @override
  String get moreToolsSubtitle => '旅行公用事业';

  @override
  String get navCurrency => '货币';

  @override
  String get navItinerary => '行程';

  @override
  String get navMoreTools => '更多工具';

  @override
  String get navOfflineMap => '离线地图';

  @override
  String get navDashboard => '仪表板';

  @override
  String get navMoreMenu => '更多的';

  @override
  String get navEditNavigation => '编辑导航';

  @override
  String get navDoneEditing => '完毕';

  @override
  String get navSelectSlotHint => '点击一个插槽，然后点击一个工具来分配它。';

  @override
  String get navSavePins => '节省';

  @override
  String get navPinnedSectionTitle => '固定到底部栏';

  @override
  String get navAvailableSectionTitle => '可用功能';

  @override
  String get navEmptySlot => '空 — 从下面添加';

  @override
  String get navPinFullHint => '四个插槽均已满。删除一个以添加另一个。';

  @override
  String get navEditPinnedHint => '使用 - 释放插槽，使用 + 填充插槽，或拖动以重新排序。四个都填满后保存。';

  @override
  String get navAddToPinned => '添加到底部栏';

  @override
  String get navRemoveFromPinned => '从底部栏移除';

  @override
  String get navFeatureBadgeFree => '自由的';

  @override
  String get navFeatureBadgePro => '专业版';

  @override
  String get moreMenuSectionFree => '免费功能';

  @override
  String get moreMenuSectionPro => 'Tripmetic 专业版';

  @override
  String get ourAppsMenuTitle => '我们的应用程序';

  @override
  String get ourAppsMenuSubtitle => 'p1.do 团队提供的更多软件';

  @override
  String get ourAppsScreenTitle => '我们的应用程序';

  @override
  String get ourAppsIntro => 'p1.do 团队的软件 — 点击实时应用程序即可打开其网站。 Stream CRM 即将推出。';

  @override
  String get ourAppsBadgeLive => '已上线';

  @override
  String get ourAppsBadgeSoon => '即将推出';

  @override
  String get ourAppsBadgeThisApp => '这个应用程序';

  @override
  String get ourAppsViewOnline => '在 p1.do 上查看全部内容';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => '网络 · 移动';

  @override
  String get ourAppsPlatformWebTabletMobile => '网络 · 平板电脑 · 移动设备';

  @override
  String get ourAppsTravelRecapTagline => 'AI 旅行路线和照片回顾';

  @override
  String get ourAppsTravelRecapSummary =>
      '在交互式地图上规划多站旅行，使用 AI 生成路线，添加目的地，并从照片中导出精美的旅行回顾。';

  @override
  String get ourAppsP1doTagline => '生物链接和创建者 CRM';

  @override
  String get ourAppsP1doSummary =>
      '为获得 CRM 潜在客户（加上 Premium Selling 和预约）的创作者提供链接生物，除月费外，您无需额外抽取利润。';

  @override
  String get ourAppsDockTxtTagline => 'macOS 边缘固定暂存器和精确差异';

  @override
  String get ourAppsDockTxtSummary =>
      '一个免费的原生 macOS 浮动抽屉，用于纯文本草稿本工作、空白清理、JSON 美化和字符级差异。';

  @override
  String get ourAppsTripmeticTagline => '全球旅行工具包和预算规划器';

  @override
  String get ourAppsTripmeticSummary =>
      '一个仪表板，包含愿望清单、离线地图、团体行程、多国预算、时区小部件、装箱单和转换器。';

  @override
  String get ourAppsPayxtTagline => '几秒钟内短信付款发票';

  @override
  String get ourAppsPayxtSummary =>
      '通过为移动专业人士提供 Stripe- 和 PayPal 支持的结帐链接，将短信转换为安全的付费发票。';

  @override
  String get ourAppsPermitMobileTagline => '改造商的建筑许可证跟踪器';

  @override
  String get ourAppsPermitMobileSummary =>
      '从工作现场监控市政建筑许可证状态——来自城市门户的号码、地址和审批更新。';

  @override
  String get ourAppsTrackkrTagline => '公寓地块管理';

  @override
  String get ourAppsTrackkrSummary =>
      '在几秒钟内记录传入的包裹，通过电子邮件（和可选的SMS）通知租户，并在永久免费的基本计划中管理无限的单位。';

  @override
  String get ourAppsKeyForecastsTagline => 'HVAC 领导者的分数控制器';

  @override
  String get ourAppsKeyForecastsSummary =>
      'HVAC 和建筑业的执行财务情报 — 作业成本核算、季节性现金流量预测和可扩展的报告。';

  @override
  String get ourAppsStreamCrmTagline => 'TikTok 实时礼物追踪和捐赠者 CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      '实时跟踪 TikTok 实时礼物，将礼物赠送者的支出与您的收入分开，并通过捐赠者资料培养顶级支持者。';

  @override
  String get proGlassTeaserTitle => 'Tripmetic 专业功能';

  @override
  String get dashboardWorldExplorerSection => '世界探索者';

  @override
  String get dashboardWorldExplorerCountriesLabel => '访问过的国家';

  @override
  String get dashboardWorldExplorerPercentLabel => '探索过的世界';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => '显示名称';

  @override
  String get bucketListMapUnavailable => '未配置 Mapbox 访问令牌，因此无法显示地图。';

  @override
  String get bucketListAuthValidationDisplayName => '输入你的名字';

  @override
  String get authSignUpScreenTitle => '创建您的 Tripmetic 帐户';

  @override
  String get authSignUpScreenSubtitle => '可选 - 仅当您需要云备份时。您无需注册即可继续使用该设备上的所有工具。';

  @override
  String get authSignInScreenTitle => '登录 Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      '可选 - 用于同步您的愿望清单和云团体旅行。 Tripmetic 的其余部分无需帐户即可工作。';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authPasswordResetConfirmation => '如果该电子邮件帐户存在，您将收到一个重置密码的链接。';

  @override
  String get authUnexpectedError => '出了点问题。请再试一次。';

  @override
  String get authBackupBulletBucketList => '遗愿清单目的地将保存到云端并在您登录时合并。';

  @override
  String get authBackupBulletGroupTrips => '您创建或加入的团体旅行存储在您的帐户下。';

  @override
  String get authBackupBulletMultiDevice => '在另一台设备上登录以恢复您的同步数据。';

  @override
  String get authLinkAlreadyHaveAccount => '已经有帐户？登入';

  @override
  String get authLinkNeedAccount => '需要帐户吗？创建一个';

  @override
  String get authFullSignUpCta => '使用完整的注册屏幕';

  @override
  String get authFullSignInCta => '使用完整的登录屏幕';

  @override
  String dashboardGreeting(String name) {
    return '你好，$name';
  }

  @override
  String get dashboardGuestName => '游客';

  @override
  String get dashboardWelcomeSubtitle => '一起计划、保持井井有条，并一键使用工具。';

  @override
  String get dashboardPlanGroupTrip => '计划新的团体旅行';

  @override
  String get dashboardAddBucketList => '添加到遗愿清单';

  @override
  String get dashboardActiveTripSection => '活动行程快照';

  @override
  String get dashboardNoUpcomingTripTitle => '没有即将进行的团体旅行';

  @override
  String get dashboardNoUpcomingTripBody => '当您与朋友一起计划时，您的下一次旅行摘要将显示在此处。';

  @override
  String get dashboardQuickToolsSection => '快速工具';

  @override
  String dashboardCountdownStartsIn(String days) {
    return '$days 天后开始';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return '$days 天后结束';
  }

  @override
  String get navDashboardBody => '您的旅行中心 - 从栏或更多菜单中打开工具。';

  @override
  String get appSettings => '应用程序设置';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic 专业版';

  @override
  String get settingsSubscriptionActive => '活跃订阅';

  @override
  String get settingsSubscriptionLifetime => '终身访问';

  @override
  String get settingsSubscriptionFree => '免费计划';

  @override
  String get settingsManageBilling => '管理账单';

  @override
  String get settingsTestModeSectionTitle => '测试模式';

  @override
  String get settingsTestModeProTitle => '作为 Tripmetic Pro 进行测试';

  @override
  String get settingsTestModeProSubtitle => '本地覆盖进行测试；忽略 RevenueCat。';

  @override
  String get settingsTestModeProCaption =>
      '启用后，该设备会在本地解锁所有 Pro 功能。仅用于内部测试 - 它不会改变您的实际订阅。';

  @override
  String get settingsUnitsTitle => '测量单位';

  @override
  String get settingsLanguageTitle => '语言';

  @override
  String get settingsThemeTitle => '主题';

  @override
  String get settingsClockWidgetTitle => '时钟小部件';

  @override
  String get settingsCurrencyWidgetTitle => '货币小部件';

  @override
  String get settingsCurrencyWidgetSubtitle => '主屏幕和锁定屏幕：1、20、100 的基础货币';

  @override
  String get settingsThemeSystem => '系统';

  @override
  String get settingsThemeLight => '光';

  @override
  String get settingsThemeDark => '黑暗的';

  @override
  String get settingsLanguageSystem => '系统默认';

  @override
  String get settingsLanguageEnglish => '英语';

  @override
  String get settingsLanguageSpanish => '西班牙语';

  @override
  String get settingsProfileTitle => '个人资料和云同步';

  @override
  String get settingsLogout => '退出';

  @override
  String get settingsLogoutConfirm => '退出该帐户？';

  @override
  String get settingsDeleteAccount => '删除帐户';

  @override
  String get settingsDeleteAccountBody => '帐户删除由支持人员处理。您可以在下面退出。';

  @override
  String get settingsSectionAccount => '帐户';

  @override
  String get accountManagementListTitle => '管理账户';

  @override
  String get accountManagementListSubtitle => '更新您的姓名、电子邮件和密码';

  @override
  String get accountManagementTitle => '账户管理';

  @override
  String get accountSectionProfile => '轮廓';

  @override
  String get accountSectionSignIn => '登入';

  @override
  String get accountFieldDisplayName => '显示名称';

  @override
  String get accountFieldEmail => '电子邮件';

  @override
  String get accountFieldCurrentPassword => '当前密码';

  @override
  String get accountFieldNewPassword => '新密码';

  @override
  String get accountSaveName => '保存名称';

  @override
  String get accountChangeEmail => '发送验证并更改电子邮件';

  @override
  String get accountChangePassword => '更改密码';

  @override
  String get accountSignedOutMessage => '您必须登录才能管理您的帐户。';

  @override
  String get accountSignInCta => '登入';

  @override
  String get accountNameSaved => '名称已更新';

  @override
  String accountEmailVerificationSent(String email) {
    return '验证链接已发送至 $email。确认后即可切换您的登录地址。';
  }

  @override
  String get accountPasswordChanged => '密码已更新';

  @override
  String accountReauthRequired(String field) {
    return '为了安全起见，请重新登录以更改您的 $field。';
  }

  @override
  String get accountFieldLabelEmail => '电子邮件';

  @override
  String get accountFieldLabelPassword => '密码';

  @override
  String accountErrorGeneric(String field, String error) {
    return '无法更新 $field：$error';
  }

  @override
  String get accountReauthAction => '重新登录';

  @override
  String get accountValidationEmailRequired => '输入您的电子邮件';

  @override
  String get accountValidationEmailInvalid => '输入有效的电子邮件';

  @override
  String get accountValidationNameRequired => '输入你的名字';

  @override
  String get accountValidationPasswordTooShort => '至少使用 8 个字符';

  @override
  String accountCurrentEmailLabel(String email) {
    return '当前电子邮件：$email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic 专业版';

  @override
  String get proPaywallSubtitle => '解锁离线地图、深度旅行工具和协作。';

  @override
  String get proPaywallBenefits => '离线地图和地区下载\n行程、预算、保管库和包装\n团体计划和实时同步';

  @override
  String get proPaywallBullets => '离线地图和地区下载|行程、预算、保管库和包装|团体计划和实时同步';

  @override
  String get proPaywallUpgradeRevenueCat => '通过 RevenueCat 升级';

  @override
  String get upgradeNow => '立即升级';

  @override
  String get packingCatClothing => '衣服';

  @override
  String get packingCatDocuments => '文件';

  @override
  String get packingCatMedications => '药物治疗';

  @override
  String get packingCatMisc => '管理信息中心';

  @override
  String get packingCatReservations => '预订';

  @override
  String get packingEmpty => '您的列表是空的。\n点击 + 添加项目。';

  @override
  String get packingEmptyHidden => '没有剩余的东西可以打包 - 或者关闭“隐藏已完成”以查看已完成的项目。';

  @override
  String get packingHeader => '包装与物流';

  @override
  String get packingHideCompleted => '隐藏完成';

  @override
  String get packingHideCompletedSubtitle => '已完成的项目将被保存；仅在此视图中隐藏';

  @override
  String get packingStarterPassport => '护照';

  @override
  String get packingStarterShirts => '衬衫';

  @override
  String get packingStarterSocks => '袜子';

  @override
  String get packingStarterTickets => '机票';

  @override
  String get packingStarterToothbrush => '牙刷';

  @override
  String get paywallDisabledBody => 'RevenueCat 付费专区已暂时禁用以供 UI 审核。';

  @override
  String get paywallDisabledTitle => '付费墙已禁用';

  @override
  String get presentationDeleteBody => '您确定要从保管库中删除此文档吗？';

  @override
  String get presentationDeleteTitle => '删除文档？';

  @override
  String get presentationImageLoadFail => '加载图像失败';

  @override
  String get proActive => '积极的';

  @override
  String get proManageHintFree => '通过按月订阅解锁专业版功能。';

  @override
  String get proManageHintPro => '管理您的订阅或恢复购买。';

  @override
  String get proManageSubscription => '管理订阅';

  @override
  String get proName => 'Tripmetic 专业版';

  @override
  String get proPaywallError => '无法显示付费专区。检查您的 RevenueCat 产品。';

  @override
  String get proPaywallNotConfigured =>
      '此安装中不提供订阅。从 Google Play 安装 Tripmetic 以升级到 Pro。';

  @override
  String proRestoreFailed(String message) {
    return '恢复失败：$message';
  }

  @override
  String get proTrialCta => '开始 3 天免费试用';

  @override
  String get proWelcome => '欢迎使用 Tripmetic 专业版';

  @override
  String get schedulerAvailabilityGood => '好的';

  @override
  String get schedulerAvailabilityOffHours => '下班时间';

  @override
  String get schedulerAvailabilityOk => '好的';

  @override
  String get schedulerBaseLocation => '基地位置';

  @override
  String schedulerBaseTooltip(String zone) {
    return '日期、时间和滑块适用于基准时钟 ($zone)。每个城市行显示该区域中的同一时刻。';
  }

  @override
  String get schedulerConvertedCities => '转换的城市';

  @override
  String get schedulerDayNext => '+1 天';

  @override
  String get schedulerDayPrevious => '-1天';

  @override
  String get schedulerDaySame => '同一天';

  @override
  String get schedulerMeetingTime => '集合时间';

  @override
  String get schedulerSubtitle => '会议重叠';

  @override
  String get schedulerTitle => '全局调度器';

  @override
  String get settingsAndInfo => '设置和信息';

  @override
  String get settingsContact => '联系我们';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => '无法打开链接';

  @override
  String get settingsHelpFaq => '帮助和常见问题解答';

  @override
  String get settingsPrivacy => '隐私政策';

  @override
  String get settingsSupportLegal => '支持与法律';

  @override
  String get settingsTerms => '使用条款';

  @override
  String get settingsMapboxAttributionTitle => '地图数据（Mapbox）';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic 使用 Mapbox 地图。 © Mapbox、© OpenStreetMap 和其他数据贡献者。地图上的徽标和归属控制隐藏在应用程序中，布局更清晰，误触次数更少；该通知满足Mapbox显示要求。';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — 关于地图';

  @override
  String get sizeCatBelts => '腰带';

  @override
  String get sizeCatMensJeansCombo => '男士牛仔裤 — 宽×长（美国）';

  @override
  String get sizeCatMensJeansInseam => '男士牛仔裤 — 内缝 (L)';

  @override
  String get sizeCatMensJeansWaist => '男士牛仔裤 — 腰围 (W)';

  @override
  String get sizeCatMensPants => '男士长裤';

  @override
  String get sizeCatMensShirts => '男士衬衫';

  @override
  String get sizeCatMensShoes => '男鞋';

  @override
  String get sizeCatMensTshirts => '男士 T 恤';

  @override
  String get sizeCatWomensBlouses => '女式衬衫';

  @override
  String get sizeCatWomensDresses => '女装连衣裙';

  @override
  String get sizeCatWomensPants => '女裤';

  @override
  String get sizeCatWomensShoes => '女鞋';

  @override
  String get sizeCatWomensTshirts => '女式 T 恤';

  @override
  String get sizeCatBoysShoes => '男童鞋（儿童）';

  @override
  String get sizeCatGirlsShoes => '女童鞋（儿童）';

  @override
  String get sizeCatBoysTshirts => '男童上衣/T 恤';

  @override
  String get sizeCatBoysPants => '男童裤子';

  @override
  String get sizeCatGirlsTshirts => '女童上衣/T 恤';

  @override
  String get sizeCatGirlsPants => '女童裤子';

  @override
  String get sizeCatGirlsDressesKids => '女童连衣裙（童装）';

  @override
  String get sizeColumnPrimaryEu => '主要：欧盟';

  @override
  String get sizeColumnPrimaryJp => '主要：JP';

  @override
  String get sizeColumnPrimaryMixed => '主要：混合（欧盟→美国→英国→日本）';

  @override
  String get sizeColumnPrimaryUk => '主要：英国';

  @override
  String get sizeColumnPrimaryUs => '主要：美国';

  @override
  String get sizeConverterAppBarSubtitle => '服装鞋履';

  @override
  String get sizeConverterCategory => '类别';

  @override
  String get sizeConverterHeader => '服装鞋履';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · 点击即可更改';
  }

  @override
  String get sizeConverterYourBaseSize => '您的基本尺寸（标签上）';

  @override
  String get sizeConverterYourCountry => '您所在的国家/地区';

  @override
  String get sizeEquivalentSizesHeader => '同等尺寸';

  @override
  String get sizeHintBelts => '例如32、34、85、90';

  @override
  String get sizeHintMensJeansCombo => '例如38x32 或 38×32';

  @override
  String get sizeHintMensJeansInseam => '例如32（内缝”）或 38x32 → 使用内缝 32';

  @override
  String get sizeHintMensJeansWaist => '例如38（腰围”）或 38x32 → 使用腰围 38';

  @override
  String get sizeHintMensPants => '例如30、32、34（腰围”）';

  @override
  String get sizeHintMensShirts => '例如15、38、男';

  @override
  String get sizeHintMensShoes => '例如6–14, 42, 27';

  @override
  String get sizeHintMensTshirts => '例如小号、中号、大号、48';

  @override
  String get sizeHintWomensBlouses => '例如8、38、M、XL';

  @override
  String get sizeHintWomensDresses => '例如8、38、男';

  @override
  String get sizeHintWomensPants => '例如6、10、38、中号';

  @override
  String get sizeHintWomensShoes => '例如5–12, 39, 25';

  @override
  String get sizeHintWomensTshirts => '例如XS、M、38';

  @override
  String get sizeHintBoysShoes => '例如11C、3Y、32、21';

  @override
  String get sizeHintGirlsShoes => '例如10C、2Y、33、20';

  @override
  String get sizeHintBoysTshirts => '例如6、8、中号、超小号';

  @override
  String get sizeHintBoysPants => '例如6、8、10（美国儿童）';

  @override
  String get sizeHintGirlsTshirts => '例如6、8、中、小';

  @override
  String get sizeHintGirlsPants => '例如6、8、10（美国儿童）';

  @override
  String get sizeHintGirlsDressesKids => '例如4、6、8、104';

  @override
  String get sizeNoMatchEmpty => '输入印在您衣服或鞋子上的尺码。';

  @override
  String get sizeNoMatchRow => '此类别没有匹配的尺寸行。尝试使用美国、英国、欧盟、日本号码或字母（S、M、L）（如果适用）。';

  @override
  String get sizeTipJeansCombo =>
      '例如美国 38×32：腰围 ≈ 欧盟 48，日本腰围标签通常约为 96–97 厘米；内缝 32\" ≈ ~81 厘米。品牌不同 - 以此为起点。';

  @override
  String get sizeTipJeansInseam =>
      '内缝是腿部内侧的长度，以英寸为单位（例如 32）。日本可能会显示 32 英寸内缝的 ~81 厘米。类型 38×32 — 我们使用 32 表示内缝。';

  @override
  String get sizeTipJeansWaist =>
      '亚洲标签上的一个数字通常是腰围：厘米 (38\" ≈ 96–97 cm) 或美国腰围英寸 (38)。与卷尺相比。您可以在此处输入 38×32 — 我们使用 38 表示腰围。';

  @override
  String get timezonePickerEmpty => '没有匹配项';

  @override
  String get timezonePickerHint => '搜索 IANA 名称（例如欧洲、东京）';

  @override
  String get timezonePickerTitle => '选择时区';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$total 区域中的 $shown';
  }

  @override
  String get timezoneSheetSearchHint => '搜索 IANA 名称（例如欧洲、东京）';

  @override
  String get timezoneSheetTitle => '选择时区';

  @override
  String get tipAmount => '小费金额';

  @override
  String get tipAppBarSubtitle => '小费和账单';

  @override
  String get tipBillHint => '例如1,250,000.00 美元';

  @override
  String get tipCountryBrazil => '巴西';

  @override
  String get tipCountryChina => '中国';

  @override
  String get tipCountryColombia => '哥伦比亚';

  @override
  String get tipCountryDominicanRepublic => '多明尼加共和国';

  @override
  String get tipCountryEgypt => '埃及';

  @override
  String get tipCountryFrance => '法国';

  @override
  String get tipCountryGermany => '德国';

  @override
  String get tipCountryHongKong => '香港';

  @override
  String get tipCountryIndonesia => '印度尼西亚';

  @override
  String get tipCountryItaly => '意大利';

  @override
  String get tipCountryJapan => '日本';

  @override
  String get tipCountryMexico => '墨西哥';

  @override
  String get tipCountryMorocco => '摩洛哥';

  @override
  String get tipCountryPortugal => '葡萄牙';

  @override
  String get tipCountrySingapore => '新加坡';

  @override
  String get tipCountrySpain => '西班牙';

  @override
  String get tipCountryThailand => '泰国';

  @override
  String get tipCountryTurkey => '火鸡';

  @override
  String get tipCountryUae => '阿拉伯联合酋长国（迪拜）';

  @override
  String get tipCountryUnitedKingdom => '英国';

  @override
  String get tipCountryUsa => '美国';

  @override
  String get tipZeroReasonChina => '在中国大陆，给小费并无惯例，在许多地方，给小费可能会被拒绝，或者被视为奇怪的行为。';

  @override
  String get tipZeroReasonFrance =>
      '餐厅账单通常包含15%的服务费（service compris）。为了获得卓越的服务，可以选择额外支付小费。';

  @override
  String get tipZeroReasonJapan => '日本不实行给小费的做法，这可能会引起混乱或冒犯。';

  @override
  String get tipZeroReasonSingapore => '无需支付小费；许多场所在账单上加收10%的服务费。';

  @override
  String get tipZeroReasonGeneric => '这里的小费通常是 0%。您仍然可以为出色的服务添加小费。';

  @override
  String get tipZeroReasonTitle => '为什么是0%？';

  @override
  String get tipCurrentCountry => '当前国家/地区';

  @override
  String get tipPeople => '人们';

  @override
  String get tipPerPerson => '每人金额';

  @override
  String get tipPercentHint => '输入小费 %（例如 15 或 27.5）';

  @override
  String get tipPercentLabel => '提示 ％';

  @override
  String get tipResults => '结果';

  @override
  String get tipSmartHeader => '智能提示';

  @override
  String get tipTotalBill => '账单总金额';

  @override
  String get tipTotalWithTip => '总计（含小费）';

  @override
  String get toolBrainstorm => '头脑风暴';

  @override
  String get toolBudget => '预算';

  @override
  String get toolBudgetSubtitle => '旅行预算规划和费用跟踪';

  @override
  String get toolBudgetTitle => '预算';

  @override
  String get toolItinerarySubtitle => '每日航班、酒店和计划';

  @override
  String get toolItineraryTitle => '行程';

  @override
  String get toolCrypto => '加密货币';

  @override
  String get toolCryptoSubtitle => 'USD 流行硬币的价值';

  @override
  String get toolCryptoTitle => '加密货币';

  @override
  String get toolDocumentVault => '文件库';

  @override
  String get toolMindMapSubtitle => '无限画布上的想法·离线';

  @override
  String get toolMindMapTitle => '头脑风暴思维导图';

  @override
  String get toolPacking => '包装';

  @override
  String get toolPackingSubtitle => '按行程列出的智能行李清单';

  @override
  String get toolPackingTitle => '包装';

  @override
  String get toolSchedulerSubtitle => '双时区·时差规划';

  @override
  String get toolSchedulerTitle => '时间和日期';

  @override
  String get toolSettingsAboutSubtitle => '公告、帮助、隐私和条款';

  @override
  String get toolSettingsAboutTitle => '设置及关于';

  @override
  String get toolSettingsInfo => '设置和信息';

  @override
  String get toolSizeSubtitle => '美国·英国·欧盟·日本（JP）';

  @override
  String get toolSizeTitle => '服装尺码转换器';

  @override
  String get toolTimeDate => '时间和日期';

  @override
  String get toolTipSubtitle => '国家小费规范 · 最多 20 人';

  @override
  String get toolTipTitle => '智能小费和账单分割器';

  @override
  String get toolUnits => '单位';

  @override
  String get toolUnitsSubtitle => '长度、重量、温度、体积';

  @override
  String get toolUnitsTitle => '单位';

  @override
  String get toolVaultSubtitle => '重要旅行证件的离线存储';

  @override
  String get toolVaultTitle => '文件库';

  @override
  String get unitAcres => '英亩';

  @override
  String get unitCategoryArea => '区域';

  @override
  String get unitCategoryDistance => '距离';

  @override
  String get unitCategoryLength => '长度';

  @override
  String get unitCategoryTemperature => '温度';

  @override
  String get unitCategoryVolume => '体积';

  @override
  String get unitCategoryWeight => '重量';

  @override
  String get unitCelsius => '摄氏度';

  @override
  String get unitCentimeters => '厘米';

  @override
  String get unitFahrenheit => '华氏度';

  @override
  String get unitFeet => '脚';

  @override
  String get unitGrams => '克';

  @override
  String get unitHectares => '公顷';

  @override
  String get unitInches => '英寸';

  @override
  String get unitKilograms => '公斤';

  @override
  String get unitKilometers => '公里';

  @override
  String get unitLiters => '升';

  @override
  String get unitMeters => '米';

  @override
  String get unitMiles => '英里';

  @override
  String get unitMilliliters => '毫升';

  @override
  String get unitOunces => '盎司';

  @override
  String get unitPounds => '磅';

  @override
  String get unitSquareCentimeters => '平方厘米';

  @override
  String get unitSquareFeet => '平方英尺';

  @override
  String get unitSquareInches => '平方英寸';

  @override
  String get unitSquareKilometers => '平方公里';

  @override
  String get unitSquareMeters => '平方米';

  @override
  String get unitSquareYards => '平方码';

  @override
  String get unitUsFluidOunces => '美式液量盎司';

  @override
  String get unitUsGallons => '美制加仑';

  @override
  String get unitYards => '码数';

  @override
  String get unitsHeader => '单位';

  @override
  String get vaultCategoryArrivalCard => '入境卡';

  @override
  String get vaultCategoryHotelReservation => '酒店预订';

  @override
  String get vaultCategoryOther => '其他';

  @override
  String get vaultCategoryPassportCopy => '护照复印件';

  @override
  String get vaultCategoryReturnFlight => '回程航班';

  @override
  String get vaultCategoryVisa => '签证';

  @override
  String get vaultDocumentTitle => '文档';

  @override
  String get vaultIntro => '安全地存储重要的旅行证件，以便离线访问并在移民时快速出示。';

  @override
  String vaultProcessFailed(String error) {
    return '处理文档失败：$error';
  }

  @override
  String get vaultTapToUpload => '点击上传';

  @override
  String get vaultTapToView => '点击查看';

  @override
  String get vaultVaultWord => '拱顶';

  @override
  String get bucketListTitle => '遗愿清单';

  @override
  String get bucketListSubtitle => '你去过的地方、想去的地方以及接下来要去的地方。';

  @override
  String get bucketListToolSubtitle => '地图和列表中的梦想目的地';

  @override
  String get bucketListViewModeList => '列表';

  @override
  String get bucketListViewModeMap => '地图';

  @override
  String get bucketListViewModePopular => '受欢迎的';

  @override
  String get bucketListPopularHint =>
      'Been、Live 和 Lived 更新您的地图和列表。想要和即将到来的只是列表，永远不会出现在地图上。';

  @override
  String get bucketListCategoryBeen => '到过';

  @override
  String get bucketListCategoryWant => '想';

  @override
  String get bucketListCategoryLive => '居住';

  @override
  String get bucketListCategoryLived => '住过';

  @override
  String get bucketListCategoryUpcoming => '即将推出';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => '类别';

  @override
  String get bucketListDetailDates => '枣子';

  @override
  String get bucketListMapLegend => '点击标记查看详细信息';

  @override
  String get bucketListShareMapWatermarkLarge => 'Tripmetic';

  @override
  String get bucketListShareMapWatermarkUrl => 'Tripmetic.app';

  @override
  String bucketListShareMapStatExplore(
    String name,
    String worldPercent,
    int populationPercent,
  ) {
    return '$name 探索了世界 $worldPercent%。旅行过世界上超过 $populationPercent% 的人口。';
  }

  @override
  String get bucketListShareMapTravelerFallback => '拉斐尔';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return '旅行过世界上超过 $percent% 的人口';
  }

  @override
  String get bucketListShareMapCountriesLabel => '国家';

  @override
  String get bucketListShareMapCitiesLabel => '城市';

  @override
  String get bucketListEmptyCategory => '此类别中还没有地方。';

  @override
  String get bucketListTravelStats => '旅行统计';

  @override
  String get bucketListStatWorld => '探索的世界';

  @override
  String get bucketListStatUs => '美国探索';

  @override
  String get bucketListStatEurope => '欧洲探索';

  @override
  String get bucketListStatAsia => '探索亚洲';

  @override
  String get bucketListStatAfrica => '探索非洲';

  @override
  String get bucketListStatRegionalCaption => '区域性';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$total $count 独特·';
  }

  @override
  String get bucketListAddDestination => '添加目的地';

  @override
  String get bucketListEditDestination => '编辑目的地';

  @override
  String get bucketListSave => '节省';

  @override
  String get bucketListFieldCity => '城市';

  @override
  String get bucketListFieldCountry => '国家';

  @override
  String get bucketListFieldCategory => '类别';

  @override
  String get bucketListFieldRegionHint => '州/省（可选）';

  @override
  String get bucketListFieldLatitude => '纬度';

  @override
  String get bucketListFieldLongitude => '经度';

  @override
  String get bucketListFieldStart => '开始日期';

  @override
  String get bucketListFieldEnd => '结束日期';

  @override
  String get bucketListFieldTripDates => '旅行日期';

  @override
  String get bucketListValidationRequired => '此字段是必需的。';

  @override
  String get bucketListValidationNumber => '输入有效号码。';

  @override
  String get bucketListValidationDates => '结束日期必须在开始日期当天或之后。';

  @override
  String get bucketListGeocodeNotFound => '在地图上找不到这个位置。请检查拼写。';

  @override
  String get bucketListShareSummarySubject => '我的 Tripmetic 愿望清单';

  @override
  String get bucketListShareTooltip => '分享列表和地图';

  @override
  String bucketListShareFailed(String error) {
    return '无法共享：$error';
  }

  @override
  String get bucketListShareNeedMap => '在捕获地图图像之前打开地图视图。';

  @override
  String get bucketListDeleteHint => '滑动即可删除';

  @override
  String get bucketListTapEditHint => '点击进行编辑';

  @override
  String bucketListCloudSyncFailed(String error) {
    return '云同步失败：$error';
  }

  @override
  String get bucketListRetry => '重试';

  @override
  String get bucketListBackupTooltip => '备份与注册';

  @override
  String get bucketListBackupTitle => '云备份';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic 无需帐户即可完全运行。如果您想要为您的愿望清单和共享团体旅行进行云备份，请随时添加一个。';

  @override
  String bucketListSignedInAs(String email) {
    return '以 $email 身份登录';
  }

  @override
  String get bucketListBackupEmail => '电子邮件';

  @override
  String get bucketListBackupPassword => '密码';

  @override
  String get bucketListBackupConfirmPassword => '确认密码';

  @override
  String get bucketListAuthTabSignUp => '报名';

  @override
  String get bucketListAuthPasswordMismatch => '密码不匹配。';

  @override
  String get bucketListRegister => '创建帐户并备份';

  @override
  String get bucketListSignIn => '登入';

  @override
  String get bucketListSignOut => '登出';

  @override
  String get bucketListBackupUploading => '正在上传至云端...';

  @override
  String get bucketListAuthSuccessSignIn => '登录成功！';

  @override
  String get bucketListAuthSuccessSignUp => '账户创建成功！';

  @override
  String get signUpSuccessMessage => '帐户已创建。欢迎来到Tripmetic！';

  @override
  String get signUpErrorEmailInUse => '此邮箱号已被注册。尝试登录。';

  @override
  String get signUpErrorInvalidEmail => '输入有效的电子邮件。';

  @override
  String get signUpErrorWeakPassword => '密码太弱。至少使用 8 个字符。';

  @override
  String signUpErrorGeneric(String message) {
    return '无法注册：$message';
  }

  @override
  String get signUpErrorEmailInUseAction => '登入';

  @override
  String bucketListAuthFailed(String error) {
    return '无法验证：$error';
  }

  @override
  String get groupPlannerNoExtraDetails => '还没有注释或链接。';

  @override
  String get groupPlannerTitle => '团体策划师';

  @override
  String get groupPlannerToolTitle => '团体策划师';

  @override
  String get groupPlannerToolSubtitle => '实时一起计划旅行';

  @override
  String get groupPlannerLandingPlanTitle => '计划团体旅行';

  @override
  String get groupPlannerLandingPlanSubtitle => '创建包含目的地、日期和预算的共享旅行。';

  @override
  String get groupPlannerLandingJoinTitle => '参加团体旅行';

  @override
  String get groupPlannerLandingJoinSubtitle => '输入邀请中的行程代码或链接。';

  @override
  String get groupPlannerCreateTripTitle => '新的团体旅行';

  @override
  String get groupPlannerSelectDates => '选择行程日期范围。';

  @override
  String get groupPlannerBudgetPerPersonOption => '每人';

  @override
  String get groupPlannerBudgetGroupOption => '团体总计';

  @override
  String get groupPlannerBudgetNoneOption => '没有任何';

  @override
  String get groupPlannerBudgetAmountLabel => '预算金额';

  @override
  String get groupPlannerOpenTitle => '开启团体旅行';

  @override
  String get groupPlannerOpenSubtitle => '粘贴邀请中的旅行代码。';

  @override
  String get groupPlannerOpenTripCodeLabel => '行程代码';

  @override
  String get groupPlannerOpenHint => '短代码、行程 ID 或邀请链接';

  @override
  String get groupPlannerOpenButton => '开启行程';

  @override
  String get groupPlannerDestination => '目的地';

  @override
  String get groupPlannerDates => '枣子';

  @override
  String get groupPlannerGroupSize => '团体规模';

  @override
  String get groupPlannerBudget => '预算';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return '每人：$amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return '团体总数：$amount';
  }

  @override
  String get groupPlannerBudgetNone => '未设定预算';

  @override
  String get groupPlannerInviteMembers => '邀请会员';

  @override
  String get groupPlannerManageMembers => '管理会员';

  @override
  String get groupPlannerItinerary => '行程';

  @override
  String get groupPlannerItineraryEditorHint => '作为旅行管理员或旅行协调员，您可以添加活动并更改日程安排。';

  @override
  String get groupPlannerItineraryViewerHint =>
      '只读：对建议的活动进行投票（赞成或反对）。只有旅行管理员和旅行协调员可以添加或更改项目。';

  @override
  String get groupPlannerNoActivities => '还没有活动。';

  @override
  String get groupPlannerTripNotFound => '无法加载此行程。';

  @override
  String get groupPlannerSignInTitle => '需要登录';

  @override
  String get groupPlannerSignInBody => '在“存储桶列表”→“云备份”下登录以查看共享行程。';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      '保存新的团体旅行需要一个帐户。登录以继续 — 其他 Tripmetic 功能无需任何功能即可工作。';

  @override
  String get groupPlannerMembersTitle => '会员';

  @override
  String get groupPlannerRoleAdmin => '行政';

  @override
  String get groupPlannerRoleCoPlanner => '旅行协调员';

  @override
  String get groupPlannerRoleViewOnly => '仅供查看';

  @override
  String get groupPlannerOwner => '所有者';

  @override
  String get groupPlannerRemoveMember => '消除';

  @override
  String get groupPlannerRemoveMemberTitle => '删除会员？';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return '从这次行程中删除 $email 吗？';
  }

  @override
  String get groupPlannerCancel => '取消';

  @override
  String get groupPlannerNotes => '笔记';

  @override
  String get groupPlannerOpenLink => '打开链接';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return '无法保存投票：$error';
  }

  @override
  String groupPlannerManageError(String error) {
    return '无法更新成员：$error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return '无法打开共享表：$error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return '无法打开行程：$error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => '你的旅行';

  @override
  String get groupPlannerMyTripsEmpty => '还没有旅行。在上面创建一个。';

  @override
  String get groupPlannerExamplesTitle => '行程示例';

  @override
  String get groupPlannerExamplesSubtitle => '示例卡 — 在上面创建一次旅行以添加您自己的旅行。';

  @override
  String get groupPlannerExampleTapBody => '这些只是示例。使用“计划团体旅行”来创建您可以分享的真实旅行。';

  @override
  String get groupPlannerExampleLisbonTitle => '里斯本团队场外';

  @override
  String get groupPlannerExampleKyotoTitle => '京都春游';

  @override
  String get groupPlannerAddActivity => '添加活动';

  @override
  String get groupPlannerActivityTitleLabel => '活动标题';

  @override
  String get groupPlannerActivityWhenLabel => '日期和时间';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      '选择旅行的一天，然后选择时间。任何可以编辑行程的人都可以稍后更改。';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      '该日期不在本次旅行之内。选择旅行开始和结束之间的一天。';

  @override
  String get groupPlannerActivityTitleRequired => '输入活动标题。';

  @override
  String get groupPlannerActivityDateUnset => '日期未设置 — 点击“编辑”进行安排。';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count 人';
  }

  @override
  String get groupPlannerEditActivity => '编辑活动';

  @override
  String get groupPlannerDeleteActivity => '删除';

  @override
  String get groupPlannerDeleteActivityTitle => '删除活动？';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return '从行程中删除“$title”吗？此操作无法撤消。';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return '无法删除活动：$error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return '无法更新活动：$error';
  }

  @override
  String get groupPlannerEditTripTitle => '编辑行程';

  @override
  String get groupPlannerEditTripAction => '编辑行程';

  @override
  String get groupPlannerDeleteTripTitle => '删除行程？';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return '为所有人永久删除行程“$destination”及其行程吗？此操作无法撤消。';
  }

  @override
  String get groupPlannerDeleteTripAction => '删除行程';

  @override
  String get groupPlannerTripDeleted => '行程已删除。';

  @override
  String groupPlannerTripDeleteError(String error) {
    return '无法删除行程：$error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return '无法更新行程：$error';
  }

  @override
  String get widgetInstructionTitle => '双时钟小部件';

  @override
  String get widgetInstructionSubtitle => '直接从锁定屏幕或主屏幕跟踪您的居住地和目的地时区。';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => '锁屏';

  @override
  String get widgetInstructionIosLockScreenStep1 => '长按锁定屏幕并点击“自定义”。';

  @override
  String get widgetInstructionIosLockScreenStep2 => '选择“锁定屏幕”预览。';

  @override
  String get widgetInstructionIosLockScreenStep3 => '点击时间正下方的小部件区域。';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      '向下滚动，选择 Tripmetic，然后点击以添加小部件。';

  @override
  String get widgetInstructionIosHomeScreenTitle => '主屏幕';

  @override
  String get widgetInstructionIosHomeScreenStep1 => '长按主屏幕上的空白区域。';

  @override
  String get widgetInstructionIosHomeScreenStep2 => '点击左上角的 + 图标。';

  @override
  String get widgetInstructionIosHomeScreenStep3 => '搜索“Tripmetic”。';

  @override
  String get widgetInstructionIosHomeScreenStep4 => '选择您喜欢的小部件尺寸，然后点击“添加小部件”。';

  @override
  String get widgetInstructionAndroidStep1 => '转到主屏幕并长按空白区域。';

  @override
  String get widgetInstructionAndroidStep2 => '点击“小部件”。';

  @override
  String get widgetInstructionAndroidStep3 => '向下滚动到 Tripmetic。';

  @override
  String get widgetInstructionAndroidStep4 => '点击并按住双时钟小部件，然后将其拖到屏幕上。';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      '要在锁定屏幕上查看两个时钟：打开“设置”→ 搜索“锁定屏幕”或“小部件”，如果您的手机提供锁屏小部件（并非所有设备都提供），则在其中添加 Tripmetic。';

  @override
  String get widgetInstructionConfigureCta => '配置小部件城市';

  @override
  String get currencyWidgetInstructionTitle => '货币转换器小工具';

  @override
  String get currencyWidgetInstructionSubtitle =>
      '将您的基础货币和目标货币固定到 Android 主屏幕。每当您使用 Tripmetic 中的转换器时，费率都会同步。';

  @override
  String get currencyWidgetInstructionAndroidTitle => '添加到主屏幕';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      '打开货币工具一次并设置前两种货币（基础货币和目标货币）。';

  @override
  String get currencyWidgetInstructionAndroidStep2 => '转到主屏幕并长按空白区域。';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      '点击“小部件”，滚动到 Tripmetic，然后选择“货币转换器”。';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      '将小部件拖到主屏幕上，或者如果您的启动器支持，请点击“添加”。';

  @override
  String get currencyWidgetInstructionUsageTitle => '使用小部件';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      '点击更改（或小部件主体）以在 Tripmetic 中打开货币选择。';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      '点击 ↻ 刷新可在后台更新小部件上的费率（应用程序不会打开）。';

  @override
  String get currencyWidgetInstructionUsageStep3 => '当您在应用程序中编辑货币或值时，金额会自动更新。';

  @override
  String get currencyWidgetInstructionPinCta => '将小部件添加到主屏幕';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta => '更改小部件货币';

  @override
  String get currencyWidgetInstructionIosHint =>
      '货币主屏幕小部件可在 Android 上找到。在 iPhone 上，使用应用内货币工具。';

  @override
  String get currencyWidgetPinUnsupported => '您的启动器不支持从应用程序添加此小部件。长按主屏幕并选择小部件。';

  @override
  String get currencyWidgetPinFailed => '无法打开小部件选择器。从主屏幕手动添加小部件。';

  @override
  String get dualClockScreenTitle => '双时钟小部件';

  @override
  String get dualClockConfigTitle => '配置城市';

  @override
  String get dualClockConfigSubtitle =>
      '选择两个城市和时区。您的选择会同步到 Tripmetic 主屏幕小部件 (Android) 和锁定屏幕小部件 (iOS)。';

  @override
  String get dualClockCity1Label => '第一城市';

  @override
  String get dualClockCity2Label => '第二城市';

  @override
  String get dualClockSave => '保存并更新小部件';

  @override
  String get dualClockSaved => '小部件已更新。';

  @override
  String get dualClockSaveError => '无法保存小部件数据。请再试一次。';

  @override
  String get dualClockAppearanceTitle => '小部件外观';

  @override
  String get dualClockAppearanceHint =>
      '自定义文本大小、颜色和主屏幕背景。锁定屏幕使用字体大小（以及系统允许的颜色）。';

  @override
  String get dualClockFontScaleLabel => '文字大小';

  @override
  String get dualClockColorCity => '城市名称';

  @override
  String get dualClockColorTime => '时代';

  @override
  String get dualClockColorDate => '枣子';

  @override
  String get dualClockColorBackground => '首页背景';

  @override
  String get dualClockShadowLabel => '文字阴影';

  @override
  String get dualClockShadowSubtitle => '添加繁忙或照片壁纸的对比度。';

  @override
  String get moreToolsDualClockBannerTitle => '双时钟小部件';

  @override
  String get moreToolsDualClockBannerSubtitle => '在锁定屏幕或主屏幕上查看两个时区 - 点击进行设置。';

  @override
  String get moreToolsDualClockBannerCta => '设置';

  @override
  String get settingsDualClockWidgetTitle => '双时钟小部件';

  @override
  String get settingsDualClockWidgetSubtitle => '添加小部件并选择您的城市';

  @override
  String get widgetNewFeatureBadge => '新的';

  @override
  String get globalNavAccountCloudSyncTooltip => '账户及云备份';

  @override
  String get exchangeRatesForceRefreshTooltip => '获取最新汇率';

  @override
  String get exchangeRatesRefreshedOk => '汇率已更新。';

  @override
  String get exchangeRatesRefreshFailed => '无法刷新汇率。';

  @override
  String get bucketListStatUsTerritories => '美国领土';

  @override
  String get bucketListAuthErrUserNotFound => '找不到此电子邮件的帐户。';

  @override
  String get bucketListAuthErrWrongPassword => '电子邮件或密码不正确。';

  @override
  String get bucketListAuthErrEmailInUse => '该电子邮件的帐户已存在。';

  @override
  String get bucketListAuthErrInvalidEmail => '电子邮件地址无效。';

  @override
  String get bucketListAuthErrWeakPassword => '密码太弱。';

  @override
  String get bucketListAuthErrUserDisabled => '该帐户已被禁用。';

  @override
  String get bucketListAuthErrTooManyRequests => '尝试次数太多。稍后再试。';

  @override
  String get bucketListAuthErrOperationNotAllowed => '未启用电子邮件/密码登录。';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => '电子邮件地址无效。';

  @override
  String get bucketListAuthValidationPasswordShort => '密码必须至少包含 6 个字符。';

  @override
  String get bucketListAuthValidationPasswordRequired => '输入您的密码。';

  @override
  String get currencyWidgetAppearanceTitle => '外貌';

  @override
  String get currencyWidgetAppearanceHint =>
      '自定义字体大小、文本颜色和主屏幕背景。主页小部件保持固定大小，因此大字体会自动调整，因此所有行都保持可见。锁定屏幕使用字体大小（以及系统允许的颜色）。';

  @override
  String get currencyWidgetFontScaleLabel => '字体大小';

  @override
  String get currencyWidgetColorPrimary => '主要文本（数量/基数）';

  @override
  String get currencyWidgetColorAccent => '强调文本（对/梯形标签）';

  @override
  String get currencyWidgetColorCaption => '标题文本（速率线）';

  @override
  String get currencyWidgetColorBackground => '首页背景';

  @override
  String get currencyWidgetSaveAppearance => '保存外观';

  @override
  String get currencyWidgetAppearanceSaved => '货币小部件外观已保存';

  @override
  String get currencyWidgetAppearanceSaveFailed => '无法保存小部件外观';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
