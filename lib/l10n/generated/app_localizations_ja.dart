// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'タイトルを入力してください';

  @override
  String get addItineraryFieldLocation => '位置';

  @override
  String get addItineraryFieldNotes => '注意事項・確認事項';

  @override
  String get addItineraryFieldTitle => 'タイトル';

  @override
  String get addItineraryHintLocation => '空港、ホテルの住所…';

  @override
  String get addItineraryHintNotes => 'レコードロケーター、リンク…';

  @override
  String get addItineraryHintTitle => 'リスボン行きのフライト';

  @override
  String get addItinerarySave => 'イベントの保存';

  @override
  String get addItineraryTitle => '旅程イベントを追加';

  @override
  String get addPackingAddToList => 'リストに追加';

  @override
  String get addPackingEnterName => '項目名を入力してください';

  @override
  String get addPackingFieldCategory => 'カテゴリ';

  @override
  String get addPackingFieldItemName => '項目名';

  @override
  String get addPackingHint => '例えば電源アダプター';

  @override
  String get addPackingIcon => 'アイコン';

  @override
  String get addPackingQuantity => '量';

  @override
  String get addPackingTitle => '梱包アイテムの追加';

  @override
  String get announcementsLatest => '最新のアップデート';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => '基本通貨';

  @override
  String get budgetCategoryDialogHint => '例えばお土産';

  @override
  String get budgetCategoryNameExists => '名前はすでに存在します';

  @override
  String get budgetCategoryNameMax => '最大40文字';

  @override
  String get budgetDailyFood => '毎日の食事';

  @override
  String get budgetDestinationSearchHint => '国または通貨コードを検索する';

  @override
  String get budgetDestinationTitle => '目的地を追加';

  @override
  String get budgetDialogAdd => '追加';

  @override
  String get budgetDialogNewCategory => '新しい経費カテゴリ';

  @override
  String budgetDialogRemoveBody(String name) {
    return '「$name」とその金額を削除しますか?';
  }

  @override
  String get budgetDialogRemoveTitle => 'カテゴリを削除する';

  @override
  String get budgetDialogRename => '名前の変更';

  @override
  String get budgetDialogRenameCategory => 'カテゴリの名前を変更';

  @override
  String get budgetEdit => '予算を編集する';

  @override
  String get budgetExpenseDailyFood => '毎日の食事';

  @override
  String get budgetExpenseEatingOut => '外食';

  @override
  String get budgetExpenseEntertainment => 'エンターテインメント';

  @override
  String get budgetExpenseFlights => 'フライト';

  @override
  String get budgetExpenseGrocery => '食料品';

  @override
  String get budgetExpenseHotels => 'ホテル';

  @override
  String get budgetExpenseMisc => 'その他';

  @override
  String get budgetExpensePhoneService => '電話サービス';

  @override
  String get budgetExpenseShopping => '買い物';

  @override
  String get budgetExpenseTourism => '観光';

  @override
  String get budgetExpenseTransportation => '交通機関';

  @override
  String get budgetExpenseTravelInsurance => '旅行保険';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3,000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => '目的地で';

  @override
  String get budgetNoCategories => 'まだ経費カテゴリがありません';

  @override
  String budgetOtherExpenses(String code) {
    return 'その他の出費 ($code)';
  }

  @override
  String get budgetPerDayEstimate => '1日あたり（目安）';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / 日';
  }

  @override
  String budgetRemainingAfter(String code) {
    return '経費を引いた残り · $code';
  }

  @override
  String get budgetSave => '予算を節約する';

  @override
  String get budgetSpendingPower => '消費力';

  @override
  String get budgetSpentVsBudget => '支出と予算';

  @override
  String budgetTotalBudget(String code) {
    return '総予算 ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return '旅行の合計 ($code)';
  }

  @override
  String get budgetTripDashboard => 'ダッシュボード';

  @override
  String get budgetTripLengthDays => '旅行期間 (日数)';

  @override
  String get budgetTripTitle => '旅行の予算';

  @override
  String get commonAdd => '追加';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDelete => '消去';

  @override
  String get commonOk => 'わかりました';

  @override
  String get commonRemove => '取り除く';

  @override
  String get commonRename => '名前の変更';

  @override
  String get commonSave => '保存';

  @override
  String get commonKeyboardDone => '終わり';

  @override
  String countryCountriesCount(String count) {
    return '$count か国';
  }

  @override
  String get countryPickerTitle => '国を選択してください';

  @override
  String get countrySheetSearchHint => '国名またはISOコードを検索';

  @override
  String get countrySheetTitle => '拠点となる国・地域';

  @override
  String get cryptoHeader => '暗号';

  @override
  String cryptoMockPerUnit(String price) {
    return 'モック ~$price / ユニット';
  }

  @override
  String get cryptoPickerTitle => 'コインを選ぶ';

  @override
  String get cryptoSheetTitle => '暗号通貨を選択してください';

  @override
  String get currencyPickerSearchHint => 'ティッカーまたは名前を検索';

  @override
  String get currencyPickerTitle => '通貨を選択してください';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown/$total を表示';
  }

  @override
  String get currencySheetSearchHint => 'コード、名前、または数値 ISO を検索します';

  @override
  String get currencySheetTitle => '通貨を選択してください';

  @override
  String get exchangeBaseSuffix => '・ベース';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'レートを読み込めませんでした\n$error';
  }

  @override
  String get exchangeHeader => '交換';

  @override
  String exchangeLastUpdated(String mins) {
    return '最終更新日 $mins 分前';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return '最終更新日 $mins 分前 (オフライン)';
  }

  @override
  String get exchangeResetOne => '1 にリセット (USD ベース)';

  @override
  String get exchangeResetTooltip => '金額をリセットする';

  @override
  String get exchangeResetZero => '0までクリア';

  @override
  String itineraryDayPrefix(String day, String date) {
    return '$day 日: $date';
  }

  @override
  String get itineraryEmpty => 'まだイベントはありません。\n+ をタップして、フライト、ホテル、プランを追加します。';

  @override
  String get itineraryHeader => '旅程';

  @override
  String itineraryHiveError(String error) {
    return '保存された旅程データを開けませんでした。\nイベントを追加してみることはできますが、持続しない可能性があります。\n($error)';
  }

  @override
  String get itineraryOpenOnMap => '地図上で開く';

  @override
  String get mapAddToTrip => '旅行に追加';

  @override
  String get mapClearRoute => '明確なルートと案内';

  @override
  String get mapClearTooltip => 'クリア';

  @override
  String get mapDisplayCurrentViewport => '現在のビューポート';

  @override
  String get mapDisplaySavedSearch => '保存された検索';

  @override
  String get mapDisplayTripDestination => '旅行先';

  @override
  String get mapDownloadAll => 'すべてダウンロード';

  @override
  String get mapDownloadCurrentRegion => 'オフラインで使用するために現在のリージョンをダウンロード';

  @override
  String get mapDownloadThisDestination => 'この宛先をダウンロード';

  @override
  String get mapDownloadedRegions => 'ダウンロードされた地域';

  @override
  String get mapDownloadingRegion => '地域をダウンロード中...';

  @override
  String mapDownloadingTitle(String title) {
    return '$title をダウンロードしています...';
  }

  @override
  String get mapFromItinerary => '旅程から';

  @override
  String get mapItineraryEmptyHint => 'ここで旅程の目的地を追加して事前ダウンロードします。';

  @override
  String get mapLoadingRegions => 'オフライン リージョンをロード中…';

  @override
  String mapLocatingQuery(String query) {
    return '$query を探しています...';
  }

  @override
  String get mapMarkCategoryBody => 'このオフライン ピンにラベルを付ける方法を選択します。';

  @override
  String get mapMarkCategoryTitle => 'このマークのカテゴリ';

  @override
  String get mapMarkFood => '食べ物';

  @override
  String get mapMarkHotel => 'ホテル';

  @override
  String get mapMarkLandmark => 'ランドマーク';

  @override
  String get mapMarkOther => '他の';

  @override
  String mapNextInstruction(String current, String total) {
    return '次の命令 ($current/$total)';
  }

  @override
  String get mapNoLocationSet => '場所が設定されていません';

  @override
  String get mapNoRegionsYet => 'まだリージョンをダウンロードしていません。';

  @override
  String get mapOfflineIntro =>
      '現在表示されている地域を保存するか、旅行の目的地を事前にダウンロードして、オフグリッドの場所でも移動できるようにします。';

  @override
  String get mapOfflineMapsTitle => 'オフラインマップ';

  @override
  String get mapRefreshTooltip => 'リフレッシュ';

  @override
  String get mapRemovePinTooltip => 'ピンを外す';

  @override
  String get mapSaveOffline => 'オフラインで保存';

  @override
  String get mapSavePinToMap => 'ピンをマップに保存';

  @override
  String get mapSavedPinsBody => '検索から保存したピン。マップから 1 つを削除するには、「削除」をタップします。';

  @override
  String get mapSavedPinsTitle => '保存されたマップピン';

  @override
  String get mapSearchHint => '都市、住所、ランドマークを検索します…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title がオフライン マークに追加されました。';
  }

  @override
  String get mapSnackArrived => '到着しました。';

  @override
  String mapSnackCouldNotFind(String query) {
    return '「$query」が見つかりませんでした。';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return '削除に失敗しました: $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return 'オフライン ダウンロードに失敗しました: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return '「$title」をダウンロードしました。';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '「$title」には場所が設定されていません。';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return '$count 旅程地域のダウンロードが完了しました。';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'オフライン領域をロードできませんでした: $error';
  }

  @override
  String get mapSnackLocationOff => '位置情報サービスがオフになっています。ナビゲーションを開始するには有効にします。';

  @override
  String get mapSnackLocationPermission => 'ターンバイターンでは位置情報の許可が必要です。';

  @override
  String get mapSnackLocationDeniedForMap => '地図を自分の中心に配置するには、位置情報の許可が必要です。';

  @override
  String get mapSnackLocateFail => '現在位置情報を取得できません。';

  @override
  String get mapLocateMeTooltip => '私の場所に行く';

  @override
  String get mapSnackMapNotReady => '地図はまだ準備ができていません。しばらくお待ちください。';

  @override
  String get mapSnackNavStartFail => '現在ナビゲーションを開始できません。';

  @override
  String get mapSnackNavStopped => 'ナビゲーションが停止しました。';

  @override
  String get mapSnackNoItineraryLocations =>
      '旅程イベントには、ダウンロードする場所やマップ ポイントがありません。';

  @override
  String get mapSnackNoManeuver => 'このステップには正確な操作ポイントがありません。';

  @override
  String get mapSnackNoRoute => 'ルートが見つかりませんでした。目的地を示しています。';

  @override
  String get mapSnackRegionDownloaded =>
      'リージョンが正常にダウンロードされました。オフラインでナビゲートできるようになりました。';

  @override
  String get mapSnackRemovedPin => '保存されているピンを削除しました。';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'オフライン領域「$name」が削除されました。';
  }

  @override
  String get mapSnackRouteCleared => 'ルートと案内がクリアされました。';

  @override
  String mapSnackRoutingFailed(String error) {
    return 'ルーティングが失敗しました: $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return '検索に失敗しました: $error';
  }

  @override
  String get mapStartNavigation => 'ナビゲーションの開始';

  @override
  String get mapStartingNav => 'ナビゲーションを開始しています...';

  @override
  String get mapStopNavigation => 'ナビゲーションを停止する';

  @override
  String get mapTravelDriving => '運転';

  @override
  String get mapTravelWalking => 'ウォーキング';

  @override
  String mapTurnByTurn(String mode) {
    return 'ターンバイターン ($mode)';
  }

  @override
  String get mindMapCaptureFail => 'マインドマップをキャプチャできませんでした。もう一度やり直してください。';

  @override
  String get mindMapClearBody =>
      'これにより、すべてのノードが削除され、デモのマインド マップ (中央の例) が復元されます。';

  @override
  String get mindMapClearTitle => '透明なキャンバス？';

  @override
  String get mindMapClearTooltip => 'クリア/リセット';

  @override
  String mindMapCouldNotSave(String error) {
    return '保存できませんでした: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return '保存できませんでした: $type';
  }

  @override
  String get mindMapEmailShare => 'メールで送信/共有';

  @override
  String get mindMapEmptyNode => '空のノード';

  @override
  String get mindMapHelpHint =>
      'ピンチしてズーム · キャンバスをドラッグ · カードをドラッグ · カードをタップして編集 · + 子を追加';

  @override
  String get mindMapNodeAddLeftTooltip => '左の子を追加';

  @override
  String get mindMapNodeAddRightTooltip => '右の子を追加';

  @override
  String get mindMapNodeDeleteTooltip => 'ノードの削除';

  @override
  String get mindMapNodeEditTitle => 'ノードの編集';

  @override
  String get mindMapNodeHint => '短いラベルを入力してください';

  @override
  String get mindMapPhotoAccess => '画像を保存するにはフォトライブラリへのアクセスが必要です。';

  @override
  String get mindMapReset => 'リセット';

  @override
  String get mindMapSavePhoto => '写真として保存';

  @override
  String get mindMapSavedPhotos => '写真に保存しました';

  @override
  String get mindMapShareCaptureFail => '共有するマインド マップをキャプチャできませんでした。';

  @override
  String get mindMapShareCompleted => '共有完了';

  @override
  String mindMapShareFailed(String error) {
    return '共有に失敗しました: $error';
  }

  @override
  String get mindMapShareReady => '画像の準備ができました — 共有するアプリを選択してください';

  @override
  String get mindMapShareSheetClosed => '共有シートを閉じました';

  @override
  String get mindMapShareSubject => 'Tripmetic — マインドマップ';

  @override
  String get mindMapShareText => 'Tripmetic からのマインド マップのエクスポート';

  @override
  String get mindMapTapToEdit => 'タップして編集';

  @override
  String get moreToolsHeader => 'その他のツール';

  @override
  String get moreToolsSubtitle => '旅行公益事業';

  @override
  String get navCurrency => '通貨';

  @override
  String get navItinerary => '旅程';

  @override
  String get navMoreTools => 'その他のツール';

  @override
  String get navOfflineMap => 'オフラインマップ';

  @override
  String get navDashboard => 'ダッシュボード';

  @override
  String get navMoreMenu => 'もっと';

  @override
  String get navEditNavigation => 'ナビゲーションの編集';

  @override
  String get navDoneEditing => '終わり';

  @override
  String get navSelectSlotHint => 'スロットをタップし、次にツールをタップして割り当てます。';

  @override
  String get navSavePins => '保存';

  @override
  String get navPinnedSectionTitle => '一番下のバーに固定されています';

  @override
  String get navAvailableSectionTitle => '利用可能な機能';

  @override
  String get navEmptySlot => '空 — 以下の利用可能なものから追加します';

  @override
  String get navPinFullHint => '4 つのスロットがすべて埋まっています。 1 つを削除して別のものを追加します。';

  @override
  String get navEditPinnedHint =>
      '−を使用してスロットを解放するか、+を使用してスロットを埋めるか、ドラッグして順序を変更します。 4つすべてが埋まったら保存します。';

  @override
  String get navAddToPinned => '一番下のバーに追加';

  @override
  String get navRemoveFromPinned => '下部バーから削除';

  @override
  String get navFeatureBadgeFree => '無料';

  @override
  String get navFeatureBadgePro => 'プロ';

  @override
  String get moreMenuSectionFree => '無料機能';

  @override
  String get moreMenuSectionPro => 'Tripmetic プロ';

  @override
  String get ourAppsMenuTitle => '私たちのアプリ';

  @override
  String get ourAppsMenuSubtitle => 'p1.do チームのその他のソフトウェア';

  @override
  String get ourAppsScreenTitle => '私たちのアプリ';

  @override
  String get ourAppsIntro =>
      'p1.do チームのソフトウェア - ライブアプリをタップしてサイトを開きます。ストリーム CRM は近日公開予定です。';

  @override
  String get ourAppsBadgeLive => '公開中';

  @override
  String get ourAppsBadgeSoon => '近日公開';

  @override
  String get ourAppsBadgeThisApp => 'このアプリ';

  @override
  String get ourAppsViewOnline => 'p1.do ですべてを表示';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => 'ウェブ・モバイル';

  @override
  String get ourAppsPlatformWebTabletMobile => 'ウェブ・タブレット・モバイル';

  @override
  String get ourAppsTravelRecapTagline => 'AI 旅行ルートと写真の要約';

  @override
  String get ourAppsTravelRecapSummary =>
      'インタラクティブな地図上で複数の目的地を巡る旅行を計画し、AI でルートを生成し、目的地を追加して、写真から洗練された旅行の要約をエクスポートします。';

  @override
  String get ourAppsP1doTagline => 'プロフィール内のリンクと作成者 CRM';

  @override
  String get ourAppsP1doSummary =>
      '月額料金に加えて利益の追加カットなしで、CRM 件の見込み客 (さらに Premium Selling 件と予約) を獲得するクリエイター向けのリンクインバイオ。';

  @override
  String get ourAppsDockTxtTagline => 'macOS エッジ固定スクラッチパッドと正確な差分';

  @override
  String get ourAppsDockTxtSummary =>
      'プレーンテキストのスクラッチパッド作業、空白のサニタイズ、JSON の整形、および文字レベルの差分のための無料のネイティブ macOS フローティング ドロワー。';

  @override
  String get ourAppsTripmeticTagline => '世界的な旅行ツールキットと予算プランナー';

  @override
  String get ourAppsTripmeticSummary =>
      'バケット リスト、オフライン マップ、グループ旅程、複数国の予算、タイムゾーン ウィジェット、パッキング リスト、コンバーターを 1 つのダッシュボードで管理できます。';

  @override
  String get ourAppsPayxtTagline => '数秒で請求書をテキストで支払う';

  @override
  String get ourAppsPayxtSummary =>
      'モバイル専門家向けの Stripe および PayPal を利用したチェックアウト リンクを使用して、テキスト メッセージを安全な支払い済み請求書に変換します。';

  @override
  String get ourAppsPermitMobileTagline => 'リフォーム業者向けの建築許可トラッカー';

  @override
  String get ourAppsPermitMobileSummary =>
      '市のポータルサイトからの番号、住所、承認の更新など、自治体の建築許可ステータスを現場から監視します。';

  @override
  String get ourAppsTrackkrTagline => 'アパートの区画管理';

  @override
  String get ourAppsTrackkrSummary =>
      '受信パッケージを数秒で記録し、電子メール (およびオプションの SMS) でテナントに通知し、永久無料の基本プランで無制限のユニットを管理します。';

  @override
  String get ourAppsKeyForecastsTagline => 'HVAC リーダー用のフラクショナル コントローラー';

  @override
  String get ourAppsKeyForecastsSummary =>
      'HVAC と建設に関するエグゼクティブ財務インテリジェンス - 人件費計算、季節キャッシュ フロー予測、スケール対応レポート。';

  @override
  String get ourAppsStreamCrmTagline => 'TikTok ライブギフト追跡と寄付者 CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'TikTok ライブ ギフトをリアルタイムで追跡し、寄付者の支出と収益を分離し、寄付者のプロフィールを使用してトップ サポーターを育成します。';

  @override
  String get proGlassTeaserTitle => 'Tripmetic プロの機能';

  @override
  String get dashboardWorldExplorerSection => 'ワールドエクスプローラー';

  @override
  String get dashboardWorldExplorerCountriesLabel => '訪問国';

  @override
  String get dashboardWorldExplorerPercentLabel => '探索された世界の';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => '表示名';

  @override
  String get bucketListMapUnavailable => 'Mapbox アクセストークンが未設定のため、地図を表示できません。';

  @override
  String get bucketListAuthValidationDisplayName => 'あなたの名前を入力してください';

  @override
  String get authSignUpScreenTitle => 'Tripmetic アカウントを作成してください';

  @override
  String get authSignUpScreenSubtitle =>
      'オプション — クラウドバックアップが必要な場合のみ。サインアップせずに、このデバイス上のすべてのツールを引き続き使用できます。';

  @override
  String get authSignInScreenTitle => 'Tripmetic にサインインする';

  @override
  String get authSignInScreenSubtitle =>
      'オプション — バケット リストとクラウド グループ旅行を同期します。残りの Tripmetic はアカウントなしで動作します。';

  @override
  String get authForgotPassword => 'パスワードをお忘れですか？';

  @override
  String get authPasswordResetConfirmation =>
      'そのメールのアカウントが存在する場合は、パスワードをリセットするためのリンクが届きます。';

  @override
  String get authUnexpectedError => '何か問題が発生しました。もう一度試してください。';

  @override
  String get authBackupBulletBucketList =>
      'バケット リストの宛先はクラウドに保存され、サインイン時に結合されます。';

  @override
  String get authBackupBulletGroupTrips => '作成または参加したグループ旅行は、アカウントに保存されます。';

  @override
  String get authBackupBulletMultiDevice => '同期されたデータを復元するには、別のデバイスにサインインします。';

  @override
  String get authLinkAlreadyHaveAccount => 'すでにアカウントをお持ちですか?サインイン';

  @override
  String get authLinkNeedAccount => 'アカウントが必要ですか?作成する';

  @override
  String get authFullSignUpCta => 'フルサインアップ画面を使用する';

  @override
  String get authFullSignInCta => 'フルサインイン画面を使用する';

  @override
  String dashboardGreeting(String name) {
    return 'こんにちは、$name';
  }

  @override
  String get dashboardGuestName => '旅行者';

  @override
  String get dashboardWelcomeSubtitle => '一緒に計画を立て、整理整頓し、ワンタップでツールにアクセスできます。';

  @override
  String get dashboardPlanGroupTrip => '新しいグループ旅行を計画する';

  @override
  String get dashboardAddBucketList => 'バケットリストに追加';

  @override
  String get dashboardActiveTripSection => 'アクティブな旅行のスナップショット';

  @override
  String get dashboardNoUpcomingTripTitle => '今後の団体旅行は予定しておりません';

  @override
  String get dashboardNoUpcomingTripBody => '友達と計画を立てるとき、次の旅行の概要がここに表示されます。';

  @override
  String get dashboardQuickToolsSection => 'クイックツール';

  @override
  String dashboardCountdownStartsIn(String days) {
    return '$days日後に開始';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return '$days日後に終了します';
  }

  @override
  String get navDashboardBody => 'あなたの旅行ハブ — バーまたは [その他] メニューからツールを開きます。';

  @override
  String get appSettings => 'アプリの設定';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic プロ';

  @override
  String get settingsSubscriptionActive => 'アクティブなサブスクリプション';

  @override
  String get settingsSubscriptionLifetime => '生涯アクセス';

  @override
  String get settingsSubscriptionFree => '無料プラン';

  @override
  String get settingsManageBilling => '請求の管理';

  @override
  String get settingsTestModeSectionTitle => 'テストモード';

  @override
  String get settingsTestModeProTitle => 'Tripmetic Pro としてテストする';

  @override
  String get settingsTestModeProSubtitle =>
      'テスト用のローカルオーバーライド。 RevenueCat を無視します。';

  @override
  String get settingsTestModeProCaption =>
      '有効にすると、このデバイスはすべての Pro 機能をローカルでロック解除します。内部テストのみを目的としています。実際のサブスクリプションは変更されません。';

  @override
  String get settingsUnitsTitle => '測定単位';

  @override
  String get settingsLanguageTitle => '言語';

  @override
  String get settingsThemeTitle => 'テーマ';

  @override
  String get settingsClockWidgetTitle => '時計ウィジェット';

  @override
  String get settingsCurrencyWidgetTitle => '通貨ウィジェット';

  @override
  String get settingsCurrencyWidgetSubtitle => 'ホーム画面とロック画面: 基本通貨の 1、20、100';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => '暗い';

  @override
  String get settingsLanguageSystem => 'システムのデフォルト';

  @override
  String get settingsLanguageEnglish => '英語';

  @override
  String get settingsLanguageSpanish => 'スペイン語';

  @override
  String get settingsProfileTitle => 'プロファイルとクラウド同期';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get settingsLogoutConfirm => 'このアカウントからログアウトしますか?';

  @override
  String get settingsDeleteAccount => 'アカウントを削除する';

  @override
  String get settingsDeleteAccountBody => 'アカウントの削除はサポートが対応します。以下からログアウトできます。';

  @override
  String get settingsSectionAccount => 'アカウント';

  @override
  String get accountManagementListTitle => 'アカウントの管理';

  @override
  String get accountManagementListSubtitle => '名前、メールアドレス、パスワードを更新してください';

  @override
  String get accountManagementTitle => 'アカウント管理';

  @override
  String get accountSectionProfile => 'プロフィール';

  @override
  String get accountSectionSignIn => 'サインイン';

  @override
  String get accountFieldDisplayName => '表示名';

  @override
  String get accountFieldEmail => '電子メール';

  @override
  String get accountFieldCurrentPassword => '現在のパスワード';

  @override
  String get accountFieldNewPassword => '新しいパスワード';

  @override
  String get accountSaveName => '名前を保存する';

  @override
  String get accountChangeEmail => '確認メールを送信してメールアドレスを変更する';

  @override
  String get accountChangePassword => 'パスワードを変更する';

  @override
  String get accountSignedOutMessage => 'アカウントを管理するにはサインインする必要があります。';

  @override
  String get accountSignInCta => 'サインイン';

  @override
  String get accountNameSaved => '名前を更新しました';

  @override
  String accountEmailVerificationSent(String email) {
    return '確認リンクが $email に送信されました。確認してサインイン アドレスを切り替えます。';
  }

  @override
  String get accountPasswordChanged => 'パスワードが更新されました';

  @override
  String accountReauthRequired(String field) {
    return 'セキュリティのため、再度サインインして $field を変更してください。';
  }

  @override
  String get accountFieldLabelEmail => '電子メール';

  @override
  String get accountFieldLabelPassword => 'パスワード';

  @override
  String accountErrorGeneric(String field, String error) {
    return '$field を更新できませんでした: $error';
  }

  @override
  String get accountReauthAction => '再度サインインしてください';

  @override
  String get accountValidationEmailRequired => 'メールアドレスを入力してください';

  @override
  String get accountValidationEmailInvalid => '有効なメールアドレスを入力してください';

  @override
  String get accountValidationNameRequired => 'あなたの名前を入力してください';

  @override
  String get accountValidationPasswordTooShort => '少なくとも 8 文字を使用してください';

  @override
  String accountCurrentEmailLabel(String email) {
    return '現在のメールアドレス: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic プロ';

  @override
  String get proPaywallSubtitle => 'オフライン マップ、詳細な旅行ツール、コラボレーションを利用可能にします。';

  @override
  String get proPaywallBenefits =>
      'オフラインマップと地域のダウンロード\n旅程、予算、保管、梱包\nグループプランナーとリアルタイム同期';

  @override
  String get proPaywallBullets =>
      'オフラインマップと地域のダウンロード|旅程、予算、保管、梱包|グループプランナーとリアルタイム同期';

  @override
  String get proPaywallUpgradeRevenueCat => 'RevenueCat 経由でアップグレードする';

  @override
  String get upgradeNow => '今すぐアップグレードしてください';

  @override
  String get packingCatClothing => '衣服';

  @override
  String get packingCatDocuments => '書類';

  @override
  String get packingCatMedications => '薬';

  @override
  String get packingCatMisc => 'その他';

  @override
  String get packingCatReservations => '予約';

  @override
  String get packingEmpty => 'あなたのリストは空です。\n「＋」をタップして項目を追加します。';

  @override
  String get packingEmptyHidden =>
      '梱包するものは何も残っていない - 完了した項目を表示するには、「完了済みを非表示」をオフにします。';

  @override
  String get packingHeader => '梱包と物流';

  @override
  String get packingHideCompleted => '非表示完了';

  @override
  String get packingHideCompletedSubtitle =>
      '完了したアイテムは保存されたままになります。このビューからのみ隠されています';

  @override
  String get packingStarterPassport => 'パスポート';

  @override
  String get packingStarterShirts => 'シャツ';

  @override
  String get packingStarterSocks => 'ソックス';

  @override
  String get packingStarterTickets => '航空券';

  @override
  String get packingStarterToothbrush => '歯ブラシ';

  @override
  String get paywallDisabledBody =>
      'RevenueCat ペイウォールは UI レビューのため一時的に無効になっています。';

  @override
  String get paywallDisabledTitle => 'ペイウォールが無効になっています';

  @override
  String get presentationDeleteBody => 'このドキュメントをボールトから削除してもよろしいですか?';

  @override
  String get presentationDeleteTitle => 'ドキュメントを削除しますか?';

  @override
  String get presentationImageLoadFail => '画像のロードに失敗しました';

  @override
  String get proActive => 'アクティブ';

  @override
  String get proManageHintFree => '毎月のサブスクリプションで Pro 機能のロックを解除します。';

  @override
  String get proManageHintPro => 'サブスクリプションを管理したり、購入を復元したりできます。';

  @override
  String get proManageSubscription => 'サブスクリプションの管理';

  @override
  String get proName => 'Tripmetic プロ';

  @override
  String get proPaywallError => 'ペイウォールを表示できませんでした。 RevenueCat のサービスを確認してください。';

  @override
  String get proPaywallNotConfigured =>
      'このインストールではサブスクリプションは利用できません。 Pro にアップグレードするには、Google Play から Tripmetic をインストールします。';

  @override
  String proRestoreFailed(String message) {
    return '復元に失敗しました: $message';
  }

  @override
  String get proTrialCta => '3 日間の無料トライアルを開始する';

  @override
  String get proWelcome => 'Tripmetic プロへようこそ';

  @override
  String get schedulerAvailabilityGood => '良い';

  @override
  String get schedulerAvailabilityOffHours => '時間外';

  @override
  String get schedulerAvailabilityOk => 'わかりました';

  @override
  String get schedulerBaseLocation => '拠点の場所';

  @override
  String schedulerBaseTooltip(String zone) {
    return '日付、時刻、およびスライダーは基本クロック ($zone) に適用されます。各都市の行は、そのゾーンの同じ瞬間を示します。';
  }

  @override
  String get schedulerConvertedCities => '変換された都市';

  @override
  String get schedulerDayNext => '+1日';

  @override
  String get schedulerDayPrevious => '-1日';

  @override
  String get schedulerDaySame => '同日';

  @override
  String get schedulerMeetingTime => '集合時間';

  @override
  String get schedulerSubtitle => '会議の重複';

  @override
  String get schedulerTitle => 'グローバルスケジューラ';

  @override
  String get settingsAndInfo => '設定と情報';

  @override
  String get settingsContact => 'お問い合わせ';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'リンクを開けませんでした';

  @override
  String get settingsHelpFaq => 'ヘルプとよくある質問';

  @override
  String get settingsPrivacy => 'プライバシーポリシー';

  @override
  String get settingsSupportLegal => 'サポートと法務';

  @override
  String get settingsTerms => '利用規約';

  @override
  String get settingsMapboxAttributionTitle => '地図データ（Mapbox）';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic は Mapbox マップを使用します。 © Mapbox、© OpenStreetMap、およびその他のデータ提供者。マップ上のロゴと帰属コントロールはアプリ内で非表示になるため、レイアウトがより明確になり、誤ってタップする回数が減ります。この通知は Mapbox の表示要件を満たしています。';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — マップについて';

  @override
  String get sizeCatBelts => 'ベルト';

  @override
  String get sizeCatMensJeansCombo => 'メンズ ジーンズ — W×L (US)';

  @override
  String get sizeCatMensJeansInseam => 'メンズ ジーンズ - 股下 (L)';

  @override
  String get sizeCatMensJeansWaist => 'メンズジーンズ - ウエスト(W)';

  @override
  String get sizeCatMensPants => 'メンズパンツ';

  @override
  String get sizeCatMensShirts => 'メンズシャツ';

  @override
  String get sizeCatMensShoes => '紳士靴';

  @override
  String get sizeCatMensTshirts => 'メンズTシャツ';

  @override
  String get sizeCatWomensBlouses => 'レディースブラウス';

  @override
  String get sizeCatWomensDresses => 'レディースドレス';

  @override
  String get sizeCatWomensPants => 'レディースパンツ';

  @override
  String get sizeCatWomensShoes => '婦人靴';

  @override
  String get sizeCatWomensTshirts => 'レディースTシャツ';

  @override
  String get sizeCatBoysShoes => '男児靴（子供用）';

  @override
  String get sizeCatGirlsShoes => '女児靴（子供用）';

  @override
  String get sizeCatBoysTshirts => 'ボーイズトップス/Tシャツ';

  @override
  String get sizeCatBoysPants => '男の子用パンツ';

  @override
  String get sizeCatGirlsTshirts => 'ガールズトップス/Tシャツ';

  @override
  String get sizeCatGirlsPants => '女子パンツ';

  @override
  String get sizeCatGirlsDressesKids => '女児ドレス（子供）';

  @override
  String get sizeColumnPrimaryEu => '主な: EU';

  @override
  String get sizeColumnPrimaryJp => 'プライマリー: 日本';

  @override
  String get sizeColumnPrimaryMixed => 'プライマリー: 混合 (EU→米国→英国→日本)';

  @override
  String get sizeColumnPrimaryUk => 'プライマリー: 英国';

  @override
  String get sizeColumnPrimaryUs => 'プライマリー: 米国';

  @override
  String get sizeConverterAppBarSubtitle => '衣類と靴';

  @override
  String get sizeConverterCategory => 'カテゴリ';

  @override
  String get sizeConverterHeader => '衣服と靴';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · タップして変更します';
  }

  @override
  String get sizeConverterYourBaseSize => '基本サイズ（タグに記載）';

  @override
  String get sizeConverterYourCountry => 'あなたの国/地域';

  @override
  String get sizeEquivalentSizesHeader => '同等のサイズ';

  @override
  String get sizeHintBelts => '例えば32、34、85、90';

  @override
  String get sizeHintMensJeansCombo => '例えば38×32または38×32';

  @override
  String get sizeHintMensJeansInseam => '例えば32 (股下\") または 38x32 → 股下 32 を使用';

  @override
  String get sizeHintMensJeansWaist =>
      '例えば38 (ウエスト\") または 38x32 → ウエスト 38 を使用します';

  @override
  String get sizeHintMensPants => '例えば30、32、34 (ウエスト\")';

  @override
  String get sizeHintMensShirts => '例えば15、38、M';

  @override
  String get sizeHintMensShoes => '例えば6–14、42、27';

  @override
  String get sizeHintMensTshirts => '例えばS、M、L、48';

  @override
  String get sizeHintWomensBlouses => '例えば8、38、M、XL';

  @override
  String get sizeHintWomensDresses => '例えば8、38、M';

  @override
  String get sizeHintWomensPants => '例えば6、10、38、M';

  @override
  String get sizeHintWomensShoes => '例えば5～12、39、25';

  @override
  String get sizeHintWomensTshirts => '例えばXS、M、38';

  @override
  String get sizeHintBoysShoes => '例えば11C、3Y、32、21';

  @override
  String get sizeHintGirlsShoes => '例えば10C、2Y、33、20';

  @override
  String get sizeHintBoysTshirts => '例えば6、8、M、XS';

  @override
  String get sizeHintBoysPants => '例えば6、8、10 (米国の子供)';

  @override
  String get sizeHintGirlsTshirts => '例えば6、8、M、S';

  @override
  String get sizeHintGirlsPants => '例えば6、8、10 (米国の子供)';

  @override
  String get sizeHintGirlsDressesKids => '例えば4、6、8、104';

  @override
  String get sizeNoMatchEmpty => '衣服または靴に記載されているサイズを入力してください。';

  @override
  String get sizeNoMatchRow =>
      'このカテゴリに一致するサイズの行はありません。該当する場合は、米国、英国、EU、JP の番号、または文字 (S、M、L) を試してください。';

  @override
  String get sizeTipJeansCombo =>
      '例 US 38×32: ウエスト ≈ EU 48、JP ウエストタグは多くの場合 ~96 ～ 97 cm。股下 32\" ≈ ~81 cm。ブランドによって異なります。これを開始点として使用してください。';

  @override
  String get sizeTipJeansInseam =>
      '股下は脚の内側の長さをインチ単位で表します (例: 32)。日本では股下 32 インチの場合、約 81 cm と表示される場合があります。 38×32 と入力します — 股下には 32 を使用します。';

  @override
  String get sizeTipJeansWaist =>
      'アジアのタグに記載されている数字の 1 つは、多くの場合ウエストです。センチメートル (38 インチ ≈ 96 ～ 97 cm) または米国のウエスト インチ (38) のいずれかです。巻尺と比較してください。ここでは 38×32 と入力できます。ウエストには 38 を使用します。';

  @override
  String get timezonePickerEmpty => '一致しません';

  @override
  String get timezonePickerHint => 'IANA 名を検索 (例: ヨーロッパ、東京)';

  @override
  String get timezonePickerTitle => 'タイムゾーンを選択してください';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown/$total ゾーン';
  }

  @override
  String get timezoneSheetSearchHint => 'IANA 名を検索 (例: ヨーロッパ、東京)';

  @override
  String get timezoneSheetTitle => 'タイムゾーンの選択';

  @override
  String get tipAmount => 'チップの金額';

  @override
  String get tipAppBarSubtitle => 'チップと請求書';

  @override
  String get tipBillHint => '例えば\$1,250,000.00';

  @override
  String get tipCountryBrazil => 'ブラジル';

  @override
  String get tipCountryChina => '中国';

  @override
  String get tipCountryColombia => 'コロンビア';

  @override
  String get tipCountryDominicanRepublic => 'ドミニカ共和国';

  @override
  String get tipCountryEgypt => 'エジプト';

  @override
  String get tipCountryFrance => 'フランス';

  @override
  String get tipCountryGermany => 'ドイツ';

  @override
  String get tipCountryHongKong => '香港';

  @override
  String get tipCountryIndonesia => 'インドネシア';

  @override
  String get tipCountryItaly => 'イタリア';

  @override
  String get tipCountryJapan => '日本';

  @override
  String get tipCountryMexico => 'メキシコ';

  @override
  String get tipCountryMorocco => 'モロッコ';

  @override
  String get tipCountryPortugal => 'ポルトガル';

  @override
  String get tipCountrySingapore => 'シンガポール';

  @override
  String get tipCountrySpain => 'スペイン';

  @override
  String get tipCountryThailand => 'タイ';

  @override
  String get tipCountryTurkey => '七面鳥';

  @override
  String get tipCountryUae => 'アラブ首長国連邦 (ドバイ)';

  @override
  String get tipCountryUnitedKingdom => 'イギリス';

  @override
  String get tipCountryUsa => '米国';

  @override
  String get tipZeroReasonChina =>
      '中国本土ではチップの習慣はなく、多くの場所で断られたり、奇妙に思われたりすることがあります。';

  @override
  String get tipZeroReasonFrance =>
      'レストランの請求書には通常 15% のサービス料 (サービス料) が含まれます。優れたサービスを提供する場合、追加のチップはオプションです。';

  @override
  String get tipZeroReasonJapan => '日本ではチップは習慣化されていないため、混乱や不快感を引き起こす可能性があります。';

  @override
  String get tipZeroReasonSingapore =>
      'チップは期待されていません。多くの会場では、請求書に 10% のサービス料が追加されます。';

  @override
  String get tipZeroReasonGeneric =>
      'ここでは 0% のチップが一般的です。優れたサービスに対してチップを追加することもできます。';

  @override
  String get tipZeroReasonTitle => 'なぜ 0% なのでしょうか?';

  @override
  String get tipCurrentCountry => '現在の国';

  @override
  String get tipPeople => '人々';

  @override
  String get tipPerPerson => 'お一人様あたりの金額';

  @override
  String get tipPercentHint => 'チップ % を入力します (例: 15 または 27.5)';

  @override
  String get tipPercentLabel => 'ヒント ％';

  @override
  String get tipResults => '結果';

  @override
  String get tipSmartHeader => 'スマートなヒント';

  @override
  String get tipTotalBill => '請求総額';

  @override
  String get tipTotalWithTip => 'チップ込みの合計';

  @override
  String get toolBrainstorm => 'ブレーンストーミング';

  @override
  String get toolBudget => '予算';

  @override
  String get toolBudgetSubtitle => '旅行予算の計画と経費の追跡';

  @override
  String get toolBudgetTitle => '予算';

  @override
  String get toolItinerarySubtitle => '航空券、ホテル、日別プラン';

  @override
  String get toolItineraryTitle => '旅程';

  @override
  String get toolCrypto => '暗号';

  @override
  String get toolCryptoSubtitle => '人気のあるコイン全体の USD 値';

  @override
  String get toolCryptoTitle => '暗号';

  @override
  String get toolDocumentVault => '文書保管庫';

  @override
  String get toolMindMapSubtitle => '無限のキャンバス上のアイデア・オフライン';

  @override
  String get toolMindMapTitle => 'ブレーンストーミングのマインドマップ';

  @override
  String get toolPacking => 'パッキング';

  @override
  String get toolPackingSubtitle => '旅行ごとのスマートパッキングチェックリスト';

  @override
  String get toolPackingTitle => 'パッキング';

  @override
  String get toolSchedulerSubtitle => 'デュアルタイムゾーン・時差ボケ対策';

  @override
  String get toolSchedulerTitle => '時刻と日付';

  @override
  String get toolSettingsAboutSubtitle => 'お知らせ、ヘルプ、プライバシー、規約';

  @override
  String get toolSettingsAboutTitle => '設定と概要';

  @override
  String get toolSettingsInfo => '設定と情報';

  @override
  String get toolSizeSubtitle => '米国・英国・EU・日本（JP）';

  @override
  String get toolSizeTitle => '衣類のサイズコンバーター';

  @override
  String get toolTimeDate => '時刻と日付';

  @override
  String get toolTipSubtitle => 'カントリーチップの基準・最大20人までに分割';

  @override
  String get toolTipTitle => 'スマートチップ&紙幣スプリッター';

  @override
  String get toolUnits => '単位';

  @override
  String get toolUnitsSubtitle => '長さ、重さ、温度、体積';

  @override
  String get toolUnitsTitle => '単位';

  @override
  String get toolVaultSubtitle => '重要な旅行書類をオフラインで保管';

  @override
  String get toolVaultTitle => '文書保管庫';

  @override
  String get unitAcres => 'エーカー';

  @override
  String get unitCategoryArea => 'エリア';

  @override
  String get unitCategoryDistance => '距離';

  @override
  String get unitCategoryLength => '長さ';

  @override
  String get unitCategoryTemperature => '温度';

  @override
  String get unitCategoryVolume => '音量';

  @override
  String get unitCategoryWeight => '重さ';

  @override
  String get unitCelsius => '摂氏';

  @override
  String get unitCentimeters => 'センチメートル';

  @override
  String get unitFahrenheit => '華氏';

  @override
  String get unitFeet => '足';

  @override
  String get unitGrams => 'グラム';

  @override
  String get unitHectares => 'ヘクタール';

  @override
  String get unitInches => 'インチ';

  @override
  String get unitKilograms => 'キログラム';

  @override
  String get unitKilometers => 'キロメートル';

  @override
  String get unitLiters => 'リットル';

  @override
  String get unitMeters => 'メートル';

  @override
  String get unitMiles => 'マイル';

  @override
  String get unitMilliliters => 'ミリリットル';

  @override
  String get unitOunces => 'オンス';

  @override
  String get unitPounds => 'ポンド';

  @override
  String get unitSquareCentimeters => '平方センチメートル';

  @override
  String get unitSquareFeet => '平方フィート';

  @override
  String get unitSquareInches => '平方インチ';

  @override
  String get unitSquareKilometers => '平方キロメートル';

  @override
  String get unitSquareMeters => '平方メートル';

  @override
  String get unitSquareYards => '平方ヤード';

  @override
  String get unitUsFluidOunces => '米国液量オンス';

  @override
  String get unitUsGallons => '米ガロン';

  @override
  String get unitYards => 'ヤード';

  @override
  String get unitsHeader => '単位';

  @override
  String get vaultCategoryArrivalCard => '到着カード';

  @override
  String get vaultCategoryHotelReservation => 'ホテル予約';

  @override
  String get vaultCategoryOther => '他の';

  @override
  String get vaultCategoryPassportCopy => 'パスポートのコピー';

  @override
  String get vaultCategoryReturnFlight => '復路';

  @override
  String get vaultCategoryVisa => 'ビザ';

  @override
  String get vaultDocumentTitle => '書類';

  @override
  String get vaultIntro => '重要な旅行書類を安全に保管し、オフラインでアクセスして入国審査ですぐに提示できるようにします。';

  @override
  String vaultProcessFailed(String error) {
    return 'ドキュメントの処理に失敗しました: $error';
  }

  @override
  String get vaultTapToUpload => 'タップしてアップロード';

  @override
  String get vaultTapToView => 'タップして表示';

  @override
  String get vaultVaultWord => '金庫室';

  @override
  String get bucketListTitle => 'バケットリスト';

  @override
  String get bucketListSubtitle => '行ったことのある場所、行きたい場所、そしてこれからのこと。';

  @override
  String get bucketListToolSubtitle => '夢の目的地を地図とリストで表示';

  @override
  String get bucketListViewModeList => 'リスト';

  @override
  String get bucketListViewModeMap => '地図';

  @override
  String get bucketListViewModePopular => '人気のある';

  @override
  String get bucketListPopularHint =>
      'Been、Live、Lived はマップとリストを更新します。 Want と Upcoming はリストのみであり、マップ上には表示されません。';

  @override
  String get bucketListCategoryBeen => 'された';

  @override
  String get bucketListCategoryWant => '欲しい';

  @override
  String get bucketListCategoryLive => 'ライブ';

  @override
  String get bucketListCategoryLived => '住んでいた';

  @override
  String get bucketListCategoryUpcoming => '今後の予定';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'カテゴリ';

  @override
  String get bucketListDetailDates => '日付';

  @override
  String get bucketListMapLegend => 'マーカーをタップすると詳細が表示されます';

  @override
  String get bucketListShareMapWatermarkLarge => 'Tripmetic';

  @override
  String get bucketListShareMapWatermarkUrl => 'トリメティック.app';

  @override
  String bucketListShareMapStatExplore(
    String name,
    String worldPercent,
    int populationPercent,
  ) {
    return '$name は世界の $worldPercent% を探検しました。世界人口の$populationPercent%以上が旅行しました。';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'ラファエル';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return '世界人口の$percent%以上が旅行しました';
  }

  @override
  String get bucketListShareMapCountriesLabel => '国';

  @override
  String get bucketListShareMapCitiesLabel => '都市';

  @override
  String get bucketListEmptyCategory => 'このカテゴリにはまだ場所がありません。';

  @override
  String get bucketListTravelStats => '旅行統計';

  @override
  String get bucketListStatWorld => '探検した世界';

  @override
  String get bucketListStatUs => '米国が探検した';

  @override
  String get bucketListStatEurope => '探検したヨーロッパ';

  @override
  String get bucketListStatAsia => '探検したアジア';

  @override
  String get bucketListStatAfrica => 'アフリカを探検しました';

  @override
  String get bucketListStatRegionalCaption => '地域別';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count ユニーク · $total';
  }

  @override
  String get bucketListAddDestination => '目的地を追加';

  @override
  String get bucketListEditDestination => '目的地を編集する';

  @override
  String get bucketListSave => '保存';

  @override
  String get bucketListFieldCity => '市';

  @override
  String get bucketListFieldCountry => '国';

  @override
  String get bucketListFieldCategory => 'カテゴリ';

  @override
  String get bucketListFieldRegionHint => '州/県 (オプション)';

  @override
  String get bucketListFieldLatitude => '緯度';

  @override
  String get bucketListFieldLongitude => '経度';

  @override
  String get bucketListFieldStart => '開始日';

  @override
  String get bucketListFieldEnd => '終了日';

  @override
  String get bucketListFieldTripDates => '旅行日程';

  @override
  String get bucketListValidationRequired => 'この項目は必須です。';

  @override
  String get bucketListValidationNumber => '有効な番号を入力してください。';

  @override
  String get bucketListValidationDates => '終了日は開始日以降である必要があります。';

  @override
  String get bucketListGeocodeNotFound => '地図上でこの場所が見つかりませんでした。スペルを確認してください。';

  @override
  String get bucketListShareSummarySubject => '私のTripmeticやりたいことリスト';

  @override
  String get bucketListShareTooltip => 'リストとマップを共有する';

  @override
  String bucketListShareFailed(String error) {
    return '共有できませんでした: $error';
  }

  @override
  String get bucketListShareNeedMap => 'マップ画像をキャプチャする前に、マップ ビューを開きます。';

  @override
  String get bucketListDeleteHint => 'スワイプして削除します';

  @override
  String get bucketListTapEditHint => 'タップして編集';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'クラウド同期に失敗しました: $error';
  }

  @override
  String get bucketListRetry => 'リトライ';

  @override
  String get bucketListBackupTooltip => 'バックアップと登録';

  @override
  String get bucketListBackupTitle => 'クラウドバックアップ';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic はアカウントがなくても完全に動作します。やりたいことリストや共有グループ旅行のクラウドバックアップが必要な場合は、いつでも追加できます。';

  @override
  String bucketListSignedInAs(String email) {
    return '$email としてサインインしています';
  }

  @override
  String get bucketListBackupEmail => '電子メール';

  @override
  String get bucketListBackupPassword => 'パスワード';

  @override
  String get bucketListBackupConfirmPassword => 'パスワードを認証する';

  @override
  String get bucketListAuthTabSignUp => 'サインアップ';

  @override
  String get bucketListAuthPasswordMismatch => 'パスワードが一致しません。';

  @override
  String get bucketListRegister => 'アカウントの作成とバックアップ';

  @override
  String get bucketListSignIn => 'サインイン';

  @override
  String get bucketListSignOut => 'サインアウト';

  @override
  String get bucketListBackupUploading => 'クラウドにアップロード中…';

  @override
  String get bucketListAuthSuccessSignIn => 'ログインに成功しました!';

  @override
  String get bucketListAuthSuccessSignUp => 'アカウントが正常に作成されました!';

  @override
  String get signUpSuccessMessage => 'アカウントが作成されました。 Tripmetic へようこそ!';

  @override
  String get signUpErrorEmailInUse => 'このEメールはすでに登録されています。サインインしてみてください。';

  @override
  String get signUpErrorInvalidEmail => '有効な電子メールを入力してください。';

  @override
  String get signUpErrorWeakPassword => 'パスワードが弱すぎます。少なくとも 8 文字を使用してください。';

  @override
  String signUpErrorGeneric(String message) {
    return 'サインアップできませんでした: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'サインイン';

  @override
  String bucketListAuthFailed(String error) {
    return '認証できませんでした: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'まだメモやリンクはありません。';

  @override
  String get groupPlannerTitle => 'グループプランナー';

  @override
  String get groupPlannerToolTitle => 'グループプランナー';

  @override
  String get groupPlannerToolSubtitle => 'リアルタイムで一緒に旅行を計画する';

  @override
  String get groupPlannerLandingPlanTitle => 'グループ旅行を計画する';

  @override
  String get groupPlannerLandingPlanSubtitle => '目的地、日付、予算を指定して共有旅行を作成します。';

  @override
  String get groupPlannerLandingJoinTitle => 'グループ旅行に参加する';

  @override
  String get groupPlannerLandingJoinSubtitle => '旅行コードまたは招待状のリンクを入力します。';

  @override
  String get groupPlannerCreateTripTitle => '新しいグループ旅行';

  @override
  String get groupPlannerSelectDates => '旅行の日付範囲を選択します。';

  @override
  String get groupPlannerBudgetPerPersonOption => 'お一人様あたり';

  @override
  String get groupPlannerBudgetGroupOption => 'グループ合計';

  @override
  String get groupPlannerBudgetNoneOption => 'なし';

  @override
  String get groupPlannerBudgetAmountLabel => '予算額';

  @override
  String get groupPlannerOpenTitle => 'グループ旅行を開く';

  @override
  String get groupPlannerOpenSubtitle => '招待状にある旅行コードを貼り付けます。';

  @override
  String get groupPlannerOpenTripCodeLabel => 'トリップコード';

  @override
  String get groupPlannerOpenHint => 'ショートコード、旅行ID、または招待リンク';

  @override
  String get groupPlannerOpenButton => 'オープントリップ';

  @override
  String get groupPlannerDestination => '行き先';

  @override
  String get groupPlannerDates => '日付';

  @override
  String get groupPlannerGroupSize => 'グループの規模';

  @override
  String get groupPlannerBudget => '予算';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return '1 人あたり: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'グループ合計: $amount';
  }

  @override
  String get groupPlannerBudgetNone => '予算は設定されていません';

  @override
  String get groupPlannerInviteMembers => 'メンバーを招待する';

  @override
  String get groupPlannerManageMembers => 'メンバーを管理する';

  @override
  String get groupPlannerItinerary => '旅程';

  @override
  String get groupPlannerItineraryEditorHint =>
      '旅行管理者または旅行コーディネーターは、アクティビティを追加したり、スケジュールを変更したりできます。';

  @override
  String get groupPlannerItineraryViewerHint =>
      '読み取り専用: 提案されたアクティビティに賛成または反対で投票します。旅行管理者と旅行コーディネーターのみが項目を追加または変更できます。';

  @override
  String get groupPlannerNoActivities => 'まだアクティビティはありません。';

  @override
  String get groupPlannerTripNotFound => 'この旅行を読み込むことができませんでした。';

  @override
  String get groupPlannerSignInTitle => 'サインインが必要です';

  @override
  String get groupPlannerSignInBody =>
      '共有旅行を表示するには、「バケット リスト」→「クラウド バックアップ」でサインインします。';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      '新しいグループ旅行を保存するにはアカウントが必要です。続行するにはサインインしてください。他の Tripmetic 機能はサインインなしでも動作します。';

  @override
  String get groupPlannerMembersTitle => 'メンバー';

  @override
  String get groupPlannerRoleAdmin => '管理者';

  @override
  String get groupPlannerRoleCoPlanner => '旅行コーディネーター';

  @override
  String get groupPlannerRoleViewOnly => '表示専用';

  @override
  String get groupPlannerOwner => '所有者';

  @override
  String get groupPlannerRemoveMember => '取り除く';

  @override
  String get groupPlannerRemoveMemberTitle => 'メンバーを削除しますか?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return '$email をこの旅行から削除しますか?';
  }

  @override
  String get groupPlannerCancel => 'キャンセル';

  @override
  String get groupPlannerNotes => '注意事項';

  @override
  String get groupPlannerOpenLink => 'リンクを開く';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return '投票を保存できませんでした: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'メンバーを更新できませんでした: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return '共有シートを開けませんでした: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return '旅行を開けませんでした: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'あなたの旅行';

  @override
  String get groupPlannerMyTripsEmpty => 'まだ旅行はありません。上に作成します。';

  @override
  String get groupPlannerExamplesTitle => '旅行の例';

  @override
  String get groupPlannerExamplesSubtitle =>
      'サンプル カード — 上で旅行を作成し、独自のカードを追加します。';

  @override
  String get groupPlannerExampleTapBody =>
      'これらはサンプルのみです。 「グループ旅行を計画する」を使用して、共有できる実際の旅行を作成します。';

  @override
  String get groupPlannerExampleLisbonTitle => 'リスボンチームはオフサイト';

  @override
  String get groupPlannerExampleKyotoTitle => '春の京都ツアー';

  @override
  String get groupPlannerAddActivity => 'アクティビティの追加';

  @override
  String get groupPlannerActivityTitleLabel => '活動タイトル';

  @override
  String get groupPlannerActivityWhenLabel => '日付と時刻';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      '旅行の日を選択し、時間を選択します。旅程を編集できる人は、後でこれを変更できます。';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'その日付は今回の旅行の範囲外です。旅行の開始日と終了日の間の日を選択してください。';

  @override
  String get groupPlannerActivityTitleRequired => 'アクティビティのタイトルを入力します。';

  @override
  String get groupPlannerActivityDateUnset =>
      '日付が設定されていません — [編集] をタップしてスケジュールを設定します。';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count人';
  }

  @override
  String get groupPlannerEditActivity => 'アクティビティの編集';

  @override
  String get groupPlannerDeleteActivity => '消去';

  @override
  String get groupPlannerDeleteActivityTitle => 'アクティビティを削除しますか?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return '旅程から「$title」を削除しますか?これを元に戻すことはできません。';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'アクティビティを削除できませんでした: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'アクティビティを更新できませんでした: $error';
  }

  @override
  String get groupPlannerEditTripTitle => '旅行を編集する';

  @override
  String get groupPlannerEditTripAction => '旅行を編集する';

  @override
  String get groupPlannerDeleteTripTitle => '旅行を削除しますか?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return '旅行「$destination」とその旅程を全員に対して完全に削除しますか?これを元に戻すことはできません。';
  }

  @override
  String get groupPlannerDeleteTripAction => '旅行の削除';

  @override
  String get groupPlannerTripDeleted => 'トリップが削除されました。';

  @override
  String groupPlannerTripDeleteError(String error) {
    return '旅行を削除できませんでした: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return '旅行を更新できませんでした: $error';
  }

  @override
  String get widgetInstructionTitle => 'デュアルクロックウィジェット';

  @override
  String get widgetInstructionSubtitle =>
      'ロック画面またはホーム画面から自宅と目的地のタイムゾーンを直接追跡します。';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'ロック画面';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'ロック画面を長押しして「カスタマイズ」をタップします。';

  @override
  String get widgetInstructionIosLockScreenStep2 => '「ロック画面」プレビューを選択します。';

  @override
  String get widgetInstructionIosLockScreenStep3 => '時刻のすぐ下のウィジェットエリアをタップします。';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      '下にスクロールして Tripmetic を選択し、タップしてウィジェットを追加します。';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'ホーム画面';

  @override
  String get widgetInstructionIosHomeScreenStep1 => 'ホーム画面の空きスペースを長押しします。';

  @override
  String get widgetInstructionIosHomeScreenStep2 => '左上隅にある + アイコンをタップします。';

  @override
  String get widgetInstructionIosHomeScreenStep3 => '「Tripmetic」を検索します。';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      '好みのウィジェットサイズを選択し、「ウィジェットを追加」をタップします。';

  @override
  String get widgetInstructionAndroidStep1 => 'ホーム画面に移動し、空いている領域を長押しします。';

  @override
  String get widgetInstructionAndroidStep2 => '「ウィジェット」をタップします。';

  @override
  String get widgetInstructionAndroidStep3 => 'Tripmetic まで下にスクロールします。';

  @override
  String get widgetInstructionAndroidStep4 =>
      'デュアル時計ウィジェットをタップしたままにして、画面上にドラッグします。';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'ロック画面で両方の時計を表示するには、「設定」を開き、「ロック画面」または「ウィジェット」を検索し、携帯電話がロック画面ウィジェットを提供している場合はそこに Tripmetic を追加します (すべてのデバイスが提供しているわけではありません)。';

  @override
  String get widgetInstructionConfigureCta => 'ウィジェット都市の構成';

  @override
  String get currencyWidgetInstructionTitle => '通貨換算ウィジェット';

  @override
  String get currencyWidgetInstructionSubtitle =>
      '基本通貨とターゲット通貨を Android ホーム画面に固定します。 Tripmetic でコンバータを使用するたびにレートが同期されます。';

  @override
  String get currencyWidgetInstructionAndroidTitle => 'ホーム画面に追加';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      '通貨ツールを一度開き、最初の 2 つの通貨 (ベースとターゲット) を設定します。';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      'ホーム画面に移動し、何もない領域を長押しします。';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      '[ウィジェット] をタップし、Tripmetic までスクロールして、[通貨換算] を選択します。';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      'ウィジェットをホーム画面にドラッグするか、ランチャーがサポートしている場合は「追加」をタップします。';

  @override
  String get currencyWidgetInstructionUsageTitle => 'ウィジェットの使用';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      '[変更] (またはウィジェット本体) をタップして、Tripmetic で通貨の選択を開きます。';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      '↻ [更新] をタップして、バックグラウンドでウィジェットのレートを更新します (アプリは開きません)。';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      'アプリで通貨または値を編集すると、金額が自動的に更新されます。';

  @override
  String get currencyWidgetInstructionPinCta => 'ホーム画面にウィジェットを追加する';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta => 'ウィジェットの通貨を変更する';

  @override
  String get currencyWidgetInstructionIosHint =>
      '通貨のホーム画面ウィジェットは Android で利用できます。 iPhone では、アプリ内通貨ツールを使用します。';

  @override
  String get currencyWidgetPinUnsupported =>
      'ランチャーは、アプリからのこのウィジェットの追加をサポートしていません。ホーム画面を長押しして、代わりに [ウィジェット] を選択します。';

  @override
  String get currencyWidgetPinFailed =>
      'ウィジェットピッカーを開けませんでした。ホーム画面からウィジェットを手動で追加します。';

  @override
  String get dualClockScreenTitle => 'デュアルクロックウィジェット';

  @override
  String get dualClockConfigTitle => '都市を構成する';

  @override
  String get dualClockConfigSubtitle =>
      '2 つの都市とタイムゾーンを選択します。選択内容は、Tripmetic ホーム画面ウィジェット (Android) およびロック画面ウィジェット (iOS) に同期されます。';

  @override
  String get dualClockCity1Label => '最初の都市';

  @override
  String get dualClockCity2Label => '第二の都市';

  @override
  String get dualClockSave => 'ウィジェットの保存と更新';

  @override
  String get dualClockSaved => 'ウィジェットが更新されました。';

  @override
  String get dualClockSaveError => 'ウィジェットデータを保存できませんでした。もう一度試してください。';

  @override
  String get dualClockAppearanceTitle => 'ウィジェットの外観';

  @override
  String get dualClockAppearanceHint =>
      'テキストのサイズ、色、ホーム画面の背景をカスタマイズします。ロック画面ではフォント サイズ (およびシステムが許可する色) が使用されます。';

  @override
  String get dualClockFontScaleLabel => '文字サイズ';

  @override
  String get dualClockColorCity => '都市名';

  @override
  String get dualClockColorTime => '回';

  @override
  String get dualClockColorDate => '日付';

  @override
  String get dualClockColorBackground => '家の背景';

  @override
  String get dualClockShadowLabel => 'テキストシャドウ';

  @override
  String get dualClockShadowSubtitle => '忙しい壁紙や写真の壁紙にコントラストを加えます。';

  @override
  String get moreToolsDualClockBannerTitle => 'デュアルクロックウィジェット';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'ロック画面またはホーム画面で 2 つのタイムゾーンを表示します。タップして設定します。';

  @override
  String get moreToolsDualClockBannerCta => '設定';

  @override
  String get settingsDualClockWidgetTitle => 'デュアルクロックウィジェット';

  @override
  String get settingsDualClockWidgetSubtitle => 'ウィジェットを追加して都市を選択してください';

  @override
  String get widgetNewFeatureBadge => '新しい';

  @override
  String get globalNavAccountCloudSyncTooltip => 'アカウントとクラウドのバックアップ';

  @override
  String get exchangeRatesForceRefreshTooltip => '最新の為替レートを取得する';

  @override
  String get exchangeRatesRefreshedOk => '為替レートが更新されました。';

  @override
  String get exchangeRatesRefreshFailed => '為替レートを更新できませんでした。';

  @override
  String get bucketListStatUsTerritories => '米国の領土';

  @override
  String get bucketListAuthErrUserNotFound => 'このメールのアカウントは見つかりませんでした。';

  @override
  String get bucketListAuthErrWrongPassword => 'メールアドレスまたはパスワードが間違っています。';

  @override
  String get bucketListAuthErrEmailInUse => 'このメールのアカウントはすでに存在します。';

  @override
  String get bucketListAuthErrInvalidEmail => 'メールアドレスが無効です。';

  @override
  String get bucketListAuthErrWeakPassword => 'パスワードが弱すぎます。';

  @override
  String get bucketListAuthErrUserDisabled => 'このアカウントは無効になっています。';

  @override
  String get bucketListAuthErrTooManyRequests => '試行回数が多すぎます。後でもう一度試してください。';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      '電子メール/パスワードによるサインインが有効になっていません。';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => 'メールアドレスが無効です。';

  @override
  String get bucketListAuthValidationPasswordShort => 'パスワードは6文字以上である必要があります。';

  @override
  String get bucketListAuthValidationPasswordRequired => 'パスワードを入力してください。';

  @override
  String get currencyWidgetAppearanceTitle => '外観';

  @override
  String get currencyWidgetAppearanceHint =>
      'フォント サイズ、テキストの色、ホーム画面の背景をカスタマイズします。ホーム ウィジェットは固定サイズを維持するため、大きなフォントは自動的に調整され、すべての行が表示されたままになります。ロック画面ではフォント サイズ (およびシステムが許可する色) が使用されます。';

  @override
  String get currencyWidgetFontScaleLabel => 'フォントサイズ';

  @override
  String get currencyWidgetColorPrimary => '主なテキスト (金額 / ベース)';

  @override
  String get currencyWidgetColorAccent => 'アクセントテキスト（ペア/ラダーラベル）';

  @override
  String get currencyWidgetColorCaption => 'キャプションテキスト（レートライン）';

  @override
  String get currencyWidgetColorBackground => '家の背景';

  @override
  String get currencyWidgetSaveAppearance => '外観の保存';

  @override
  String get currencyWidgetAppearanceSaved => '通貨ウィジェットの外観が保存されました';

  @override
  String get currencyWidgetAppearanceSaveFailed => 'ウィジェットの外観を保存できませんでした';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
