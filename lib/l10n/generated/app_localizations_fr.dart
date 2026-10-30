// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'Veuillez entrer un titre';

  @override
  String get addItineraryFieldLocation => 'Emplacement';

  @override
  String get addItineraryFieldNotes => 'Remarques / confirmation';

  @override
  String get addItineraryFieldTitle => 'Titre';

  @override
  String get addItineraryHintLocation => 'Aéroport, adresse de l’hôtel…';

  @override
  String get addItineraryHintNotes => 'Localisateur d\'enregistrements, liens…';

  @override
  String get addItineraryHintTitle => 'Vol pour Lisbonne';

  @override
  String get addItinerarySave => 'Enregistrer l\'événement';

  @override
  String get addItineraryTitle => 'Ajouter un événement d\'itinéraire';

  @override
  String get addPackingAddToList => 'Ajouter à la liste';

  @override
  String get addPackingEnterName => 'Veuillez saisir un nom d\'article';

  @override
  String get addPackingFieldCategory => 'Catégorie';

  @override
  String get addPackingFieldItemName => 'Nom de l\'article';

  @override
  String get addPackingHint => 'par ex. Adaptateur secteur';

  @override
  String get addPackingIcon => 'Icône';

  @override
  String get addPackingQuantity => 'Quantité';

  @override
  String get addPackingTitle => 'Ajouter un article d\'emballage';

  @override
  String get announcementsLatest => 'Dernières mises à jour';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => 'MONNAIE DE BASE';

  @override
  String get budgetCategoryDialogHint => 'par ex. Souvenirs';

  @override
  String get budgetCategoryNameExists => 'Le nom existe déjà';

  @override
  String get budgetCategoryNameMax => '40 caractères maximum';

  @override
  String get budgetDailyFood => 'Nourriture quotidienne';

  @override
  String get budgetDestinationSearchHint =>
      'Rechercher un pays ou un code de devise';

  @override
  String get budgetDestinationTitle => 'Ajouter une destination';

  @override
  String get budgetDialogAdd => 'Ajouter';

  @override
  String get budgetDialogNewCategory => 'Nouvelle catégorie de dépenses';

  @override
  String budgetDialogRemoveBody(String name) {
    return 'Supprimer \"$name\" et son montant ?';
  }

  @override
  String get budgetDialogRemoveTitle => 'Supprimer la catégorie';

  @override
  String get budgetDialogRename => 'Rebaptiser';

  @override
  String get budgetDialogRenameCategory => 'Renommer la catégorie';

  @override
  String get budgetEdit => 'Modifier le budget';

  @override
  String get budgetExpenseDailyFood => 'Nourriture quotidienne';

  @override
  String get budgetExpenseEatingOut => 'Manger au restaurant';

  @override
  String get budgetExpenseEntertainment => 'Divertissement';

  @override
  String get budgetExpenseFlights => 'Vols';

  @override
  String get budgetExpenseGrocery => 'Épicerie';

  @override
  String get budgetExpenseHotels => 'Hôtels';

  @override
  String get budgetExpenseMisc => 'Divers';

  @override
  String get budgetExpensePhoneService => 'Service téléphonique';

  @override
  String get budgetExpenseShopping => 'Achats';

  @override
  String get budgetExpenseTourism => 'Tourisme';

  @override
  String get budgetExpenseTransportation => 'Transport';

  @override
  String get budgetExpenseTravelInsurance => 'Assurance voyage';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3 000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => 'Dans vos destinations';

  @override
  String get budgetNoCategories =>
      'Aucune catégorie de dépenses pour l\'instant';

  @override
  String budgetOtherExpenses(String code) {
    return 'AUTRES DÉPENSES ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'Par jour (estimation)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / jour';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'Restant après dépenses · $code';
  }

  @override
  String get budgetSave => 'Économisez votre budget';

  @override
  String get budgetSpendingPower => 'Pouvoir d’achat';

  @override
  String get budgetSpentVsBudget => 'Dépensé par rapport au budget';

  @override
  String budgetTotalBudget(String code) {
    return 'BUDGET TOTAL ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return 'Total pour le voyage ($code)';
  }

  @override
  String get budgetTripDashboard => 'tableau de bord';

  @override
  String get budgetTripLengthDays => 'Durée du voyage (jours)';

  @override
  String get budgetTripTitle => 'Budget voyage';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonOk => 'D\'ACCORD';

  @override
  String get commonRemove => 'Retirer';

  @override
  String get commonRename => 'Rebaptiser';

  @override
  String get commonSave => 'Sauvegarder';

  @override
  String get commonKeyboardDone => 'Fait';

  @override
  String countryCountriesCount(String count) {
    return '$count pays';
  }

  @override
  String get countryPickerTitle => 'Sélectionnez un pays';

  @override
  String get countrySheetSearchHint =>
      'Rechercher le nom du pays ou le code ISO';

  @override
  String get countrySheetTitle => 'Pays de base/région';

  @override
  String get cryptoHeader => 'CRYPTO';

  @override
  String cryptoMockPerUnit(String price) {
    return 'Maquette ~$price / unité';
  }

  @override
  String get cryptoPickerTitle => 'Choisissez une pièce';

  @override
  String get cryptoSheetTitle => 'Sélectionnez la crypto-monnaie';

  @override
  String get currencyPickerSearchHint => 'Rechercher un ticker ou un nom';

  @override
  String get currencyPickerTitle => 'Choisissez une devise';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown sur $total affiché';
  }

  @override
  String get currencySheetSearchHint => 'Code de recherche, nom ou chiffre ISO';

  @override
  String get currencySheetTitle => 'Sélectionnez la devise';

  @override
  String get exchangeBaseSuffix => '· Base';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'Impossible de charger les tarifs\n$error';
  }

  @override
  String get exchangeHeader => 'ÉCHANGE';

  @override
  String exchangeLastUpdated(String mins) {
    return 'Dernière mise à jour il y a $mins min';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'Dernière mise à jour il y a $mins min (Hors ligne)';
  }

  @override
  String get exchangeResetOne => 'Remise à 1 (base USD)';

  @override
  String get exchangeResetTooltip => 'Réinitialiser les montants';

  @override
  String get exchangeResetZero => 'Effacer à 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'Jour $day : $date';
  }

  @override
  String get itineraryEmpty =>
      'Aucun événement pour l\'instant.\nAppuyez sur + pour ajouter des vols, des hôtels et des forfaits.';

  @override
  String get itineraryHeader => 'ITINÉRAIRE';

  @override
  String itineraryHiveError(String error) {
    return 'Impossible d\'ouvrir les données d\'itinéraire enregistrées.\nVous pouvez toujours essayer d\'ajouter des événements : ils risquent de ne pas persister.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'Ouvrir sur la carte';

  @override
  String get mapAddToTrip => 'Ajouter au voyage';

  @override
  String get mapClearRoute => 'Itinéraire et guidage clairs';

  @override
  String get mapClearTooltip => 'Clair';

  @override
  String get mapDisplayCurrentViewport => 'Fenêtre actuelle';

  @override
  String get mapDisplaySavedSearch => 'Recherche enregistrée';

  @override
  String get mapDisplayTripDestination => 'Destination du voyage';

  @override
  String get mapDownloadAll => 'Téléchargez tout';

  @override
  String get mapDownloadCurrentRegion =>
      'Télécharger la région actuelle pour une utilisation hors ligne';

  @override
  String get mapDownloadThisDestination => 'Téléchargez cette destination';

  @override
  String get mapDownloadedRegions => 'Régions téléchargées';

  @override
  String get mapDownloadingRegion => 'Région de téléchargement...';

  @override
  String mapDownloadingTitle(String title) {
    return 'Téléchargement de $title...';
  }

  @override
  String get mapFromItinerary => 'De votre itinéraire';

  @override
  String get mapItineraryEmptyHint =>
      'Ajoutez des destinations d\'itinéraire pour les pré-télécharger ici.';

  @override
  String get mapLoadingRegions => 'Chargement des régions hors ligne…';

  @override
  String mapLocatingQuery(String query) {
    return 'Localisation de $query...';
  }

  @override
  String get mapMarkCategoryBody =>
      'Choisissez comment étiqueter cette épingle hors ligne.';

  @override
  String get mapMarkCategoryTitle => 'Catégorie pour cette marque';

  @override
  String get mapMarkFood => 'Nourriture';

  @override
  String get mapMarkHotel => 'Hôtel';

  @override
  String get mapMarkLandmark => 'Point de repère';

  @override
  String get mapMarkOther => 'Autre';

  @override
  String mapNextInstruction(String current, String total) {
    return 'Instruction suivante ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'Aucun emplacement défini';

  @override
  String get mapNoRegionsYet => 'Vous n\'avez encore téléchargé aucune région.';

  @override
  String get mapOfflineIntro =>
      'Enregistrez la région actuellement visible ou pré-téléchargez vos destinations de voyage afin de pouvoir naviguer lorsque vous êtes hors réseau.';

  @override
  String get mapOfflineMapsTitle => 'Cartes hors ligne';

  @override
  String get mapRefreshTooltip => 'Rafraîchir';

  @override
  String get mapRemovePinTooltip => 'Supprimer la broche';

  @override
  String get mapSaveOffline => 'Enregistrer hors ligne';

  @override
  String get mapSavePinToMap => 'Enregistrer l\'épingle sur la carte';

  @override
  String get mapSavedPinsBody =>
      'Épingles que vous avez enregistrées à partir de la recherche. Appuyez sur Supprimer pour en supprimer un de la carte.';

  @override
  String get mapSavedPinsTitle => 'Épingles de carte enregistrées';

  @override
  String get mapSearchHint =>
      'Recherchez une ville, une adresse ou un point de repère…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title ajouté à vos marques hors ligne.';
  }

  @override
  String get mapSnackArrived => 'Vous êtes arrivé.';

  @override
  String mapSnackCouldNotFind(String query) {
    return 'Impossible de trouver \"$query\".';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'Échec de la suppression : $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return 'Échec du téléchargement hors ligne : $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return 'Téléchargé \"$title\".';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\" n\'a aucun emplacement défini.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'Téléchargement terminé de la ou des régions d\'itinéraire $count.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'Impossible de charger les régions hors ligne : $error';
  }

  @override
  String get mapSnackLocationOff =>
      'Le service de localisation est désactivé. Activez-le pour démarrer la navigation.';

  @override
  String get mapSnackLocationPermission =>
      'Une autorisation de localisation est requise pour le tour par tour.';

  @override
  String get mapSnackLocationDeniedForMap =>
      'Une autorisation de localisation est requise pour centrer la carte sur vous.';

  @override
  String get mapSnackLocateFail =>
      'Impossible d\'obtenir votre position pour le moment.';

  @override
  String get mapLocateMeTooltip => 'Aller à mon emplacement';

  @override
  String get mapSnackMapNotReady =>
      'La carte n\'est pas encore prête. Veuillez patienter un instant.';

  @override
  String get mapSnackNavStartFail =>
      'Impossible de démarrer la navigation pour le moment.';

  @override
  String get mapSnackNavStopped => 'La navigation s\'est arrêtée.';

  @override
  String get mapSnackNoItineraryLocations =>
      'Aucun événement d\'itinéraire n\'a de lieu ou de point de carte à télécharger.';

  @override
  String get mapSnackNoManeuver =>
      'Cette étape n\'a pas de point de manœuvre précis.';

  @override
  String get mapSnackNoRoute =>
      'Impossible de trouver un itinéraire ; montrant la destination.';

  @override
  String get mapSnackRegionDownloaded =>
      'Région téléchargée avec succès ! Vous pouvez désormais naviguer hors ligne.';

  @override
  String get mapSnackRemovedPin => 'Épingle enregistrée supprimée.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'Région hors ligne « $name » supprimée.';
  }

  @override
  String get mapSnackRouteCleared => 'Itinéraire et guidage effacés.';

  @override
  String mapSnackRoutingFailed(String error) {
    return 'Échec du routage : $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return 'Échec de la recherche : $error';
  }

  @override
  String get mapStartNavigation => 'Démarrer la navigation';

  @override
  String get mapStartingNav => 'Démarrage de la navigation...';

  @override
  String get mapStopNavigation => 'Arrêter la navigation';

  @override
  String get mapTravelDriving => 'Conduite';

  @override
  String get mapTravelWalking => 'Marche';

  @override
  String mapTurnByTurn(String mode) {
    return 'Tour par tour ($mode)';
  }

  @override
  String get mindMapCaptureFail =>
      'Impossible de capturer la carte mentale. Essayer à nouveau.';

  @override
  String get mindMapClearBody =>
      'Cela supprime tous les nœuds et restaure la carte mentale de démonstration (exemple centré).';

  @override
  String get mindMapClearTitle => 'Toile transparente ?';

  @override
  String get mindMapClearTooltip => 'Effacer/Réinitialiser';

  @override
  String mindMapCouldNotSave(String error) {
    return 'Impossible d\'enregistrer : $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'Impossible d\'enregistrer : $type';
  }

  @override
  String get mindMapEmailShare => 'Envoyer par e-mail / Partager';

  @override
  String get mindMapEmptyNode => 'Nœud vide';

  @override
  String get mindMapHelpHint =>
      'Pincez pour zoomer · faites glisser le canevas · faites glisser les cartes · appuyez sur une carte pour la modifier · + ajoute un enfant';

  @override
  String get mindMapNodeAddLeftTooltip => 'Ajouter l\'enfant de gauche';

  @override
  String get mindMapNodeAddRightTooltip => 'Ajouter le bon enfant';

  @override
  String get mindMapNodeDeleteTooltip => 'Supprimer le nœud';

  @override
  String get mindMapNodeEditTitle => 'Modifier le nœud';

  @override
  String get mindMapNodeHint => 'Saisissez un libellé court';

  @override
  String get mindMapPhotoAccess =>
      'L’accès à la photothèque est requis pour enregistrer l’image.';

  @override
  String get mindMapReset => 'Réinitialiser';

  @override
  String get mindMapSavePhoto => 'Enregistrer sous photo';

  @override
  String get mindMapSavedPhotos => 'Enregistré dans les photos';

  @override
  String get mindMapShareCaptureFail =>
      'Impossible de capturer la carte mentale pour la partager.';

  @override
  String get mindMapShareCompleted => 'Partage terminé';

  @override
  String mindMapShareFailed(String error) {
    return 'Échec du partage : $error';
  }

  @override
  String get mindMapShareReady =>
      'Image prête : choisissez une application à partager';

  @override
  String get mindMapShareSheetClosed => 'Feuille de partage fermée';

  @override
  String get mindMapShareSubject => 'Tripmetic — Carte mentale';

  @override
  String get mindMapShareText =>
      'Exportation de cartes mentales depuis Tripmetic';

  @override
  String get mindMapTapToEdit => 'Appuyez pour modifier';

  @override
  String get moreToolsHeader => 'PLUS D\'OUTILS';

  @override
  String get moreToolsSubtitle => 'Utilitaires de voyage';

  @override
  String get navCurrency => 'Devise';

  @override
  String get navItinerary => 'Itinéraire';

  @override
  String get navMoreTools => 'Plus d\'outils';

  @override
  String get navOfflineMap => 'Carte hors ligne';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navMoreMenu => 'Plus';

  @override
  String get navEditNavigation => 'Modifier la navigation';

  @override
  String get navDoneEditing => 'Fait';

  @override
  String get navSelectSlotHint =>
      'Appuyez sur un emplacement, puis appuyez sur un outil pour l\'attribuer.';

  @override
  String get navSavePins => 'Sauvegarder';

  @override
  String get navPinnedSectionTitle => 'Épinglé sur la barre inférieure';

  @override
  String get navAvailableSectionTitle => 'Fonctionnalités disponibles';

  @override
  String get navEmptySlot => 'Vide — ajouter parmi les disponibles ci-dessous';

  @override
  String get navPinFullHint =>
      'Les quatre emplacements sont pleins. Supprimez-en un pour en ajouter un autre.';

  @override
  String get navEditPinnedHint =>
      'Utilisez − pour libérer un emplacement, + pour remplir un emplacement ou faites glisser pour réorganiser. Économisez lorsque les quatre sont remplis.';

  @override
  String get navAddToPinned => 'Ajouter à la barre inférieure';

  @override
  String get navRemoveFromPinned => 'Supprimer de la barre inférieure';

  @override
  String get navFeatureBadgeFree => 'Gratuit';

  @override
  String get navFeatureBadgePro => 'PRO';

  @override
  String get moreMenuSectionFree => 'Fonctionnalités gratuites';

  @override
  String get moreMenuSectionPro => 'Tripmetic Pro';

  @override
  String get ourAppsMenuTitle => 'Nos applications';

  @override
  String get ourAppsMenuSubtitle => 'Plus de logiciels de l\'équipe p1.do';

  @override
  String get ourAppsScreenTitle => 'Nos applications';

  @override
  String get ourAppsIntro =>
      'Logiciel de l\'équipe p1.do : appuyez sur une application en direct pour ouvrir son site. Stream CRM arrive bientôt.';

  @override
  String get ourAppsBadgeLive => 'Disponible';

  @override
  String get ourAppsBadgeSoon => 'À venir';

  @override
  String get ourAppsBadgeThisApp => 'Cette application';

  @override
  String get ourAppsViewOnline => 'Tout voir sur p1.do';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => 'Internet · Mobile';

  @override
  String get ourAppsPlatformWebTabletMobile => 'Web · Tablette · Mobile';

  @override
  String get ourAppsTravelRecapTagline =>
      'AI itinéraires de voyage et récapitulatifs photos';

  @override
  String get ourAppsTravelRecapSummary =>
      'Planifiez des voyages à arrêts multiples sur une carte interactive, générez des itinéraires avec AI, ajoutez des destinations et exportez des récapitulatifs de voyage soignés à partir de vos photos.';

  @override
  String get ourAppsP1doTagline => 'Lien dans la bio et créateur CRM';

  @override
  String get ourAppsP1doSummary =>
      'Lien dans la bio pour les créateurs qui capturent CRM leads, plus Premium Selling et la prise de rendez-vous, sans réduction supplémentaire de vos bénéfices en plus des frais mensuels.';

  @override
  String get ourAppsDockTxtTagline =>
      'Bloc-notes épinglé sur bord macOS et différence exacte';

  @override
  String get ourAppsDockTxtSummary =>
      'Un tiroir flottant macOS natif gratuit pour le travail sur bloc-notes en texte brut, la désinfection des espaces, l\'embellissement JSON et les différences au niveau des caractères.';

  @override
  String get ourAppsTripmeticTagline =>
      'Boîte à outils de voyage mondial et planificateur de budget';

  @override
  String get ourAppsTripmeticSummary =>
      'Un tableau de bord pour les listes de choses à faire, les cartes hors ligne, les itinéraires de groupe, les budgets multi-pays, les widgets de fuseau horaire, les listes de colisage et les convertisseurs.';

  @override
  String get ourAppsPayxtTagline =>
      'Envoyer des factures par SMS en quelques secondes';

  @override
  String get ourAppsPayxtSummary =>
      'Transformez un message texte en une facture payée sécurisée avec les liens de paiement alimentés par Stripe- et PayPal pour les professionnels mobiles.';

  @override
  String get ourAppsPermitMobileTagline =>
      'Suivi des permis de construire pour les rénovateurs';

  @override
  String get ourAppsPermitMobileSummary =>
      'Surveillez l\'état des permis de construire municipaux depuis le chantier : numéros, adresses et mises à jour d\'approbation à partir des portails de la ville.';

  @override
  String get ourAppsTrackkrTagline => 'Gestion des parcelles d\'appartements';

  @override
  String get ourAppsTrackkrSummary =>
      'Enregistrez les colis entrants en quelques secondes, informez les locataires par e-mail (et SMS en option) et gérez un nombre illimité d\'unités sur un plan de base gratuit pour toujours.';

  @override
  String get ourAppsKeyForecastsTagline =>
      'Contrôleur fractionnaire pour les dirigeants HVAC';

  @override
  String get ourAppsKeyForecastsSummary =>
      'Intelligence financière exécutive pour HVAC et la construction : calcul des coûts des travaux, prévision des flux de trésorerie saisonniers et reporting prêt à l\'échelle.';

  @override
  String get ourAppsStreamCrmTagline =>
      'TikTok suivi des cadeaux en direct et donateur CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'Suivez les cadeaux en direct de TikTok en temps réel, séparez les dépenses des cadeaux de vos revenus et encouragez les meilleurs supporters avec des profils de donateurs.';

  @override
  String get proGlassTeaserTitle => 'Tripmetic Fonctionnalité Pro';

  @override
  String get dashboardWorldExplorerSection => 'Explorateur du monde';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'Pays visités';

  @override
  String get dashboardWorldExplorerPercentLabel => 'Du monde exploré';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => 'Nom d\'affichage';

  @override
  String get bucketListMapUnavailable =>
      'La carte est indisponible car aucun jeton d\'accès Mapbox n\'a été configuré.';

  @override
  String get bucketListAuthValidationDisplayName => 'Entrez votre nom';

  @override
  String get authSignUpScreenTitle => 'Créez votre compte Tripmetic';

  @override
  String get authSignUpScreenSubtitle =>
      'Facultatif – uniquement si vous souhaitez une sauvegarde dans le cloud. Vous pouvez continuer à utiliser tous les outils de cet appareil sans vous inscrire.';

  @override
  String get authSignInScreenTitle => 'Connectez-vous à Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      'Facultatif : pour synchroniser votre liste de choses à faire et vos voyages de groupe cloud. Le reste de Tripmetic fonctionne sans compte.';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authPasswordResetConfirmation =>
      'Si un compte existe pour cet e-mail, vous recevrez un lien pour réinitialiser votre mot de passe.';

  @override
  String get authUnexpectedError =>
      'Quelque chose s\'est mal passé. Veuillez réessayer.';

  @override
  String get authBackupBulletBucketList =>
      'Les destinations de la liste de souhaits sont enregistrées dans le cloud et fusionnées lorsque vous vous connectez.';

  @override
  String get authBackupBulletGroupTrips =>
      'Les voyages de groupe que vous créez ou rejoignez sont stockés sous votre compte.';

  @override
  String get authBackupBulletMultiDevice =>
      'Connectez-vous sur un autre appareil pour restaurer vos données synchronisées.';

  @override
  String get authLinkAlreadyHaveAccount =>
      'Vous avez déjà un compte ? Se connecter';

  @override
  String get authLinkNeedAccount => 'Besoin d\'un compte ? Créez-en un';

  @override
  String get authFullSignUpCta => 'Utiliser l\'écran d\'inscription complet';

  @override
  String get authFullSignInCta => 'Utiliser l\'écran de connexion complet';

  @override
  String dashboardGreeting(String name) {
    return 'Bonjour, $name';
  }

  @override
  String get dashboardGuestName => 'Voyageur';

  @override
  String get dashboardWelcomeSubtitle =>
      'Planifiez ensemble, restez organisé et accédez aux outils en un seul clic.';

  @override
  String get dashboardPlanGroupTrip => 'Planifier un nouveau voyage de groupe';

  @override
  String get dashboardAddBucketList => 'Ajouter à la bucket list';

  @override
  String get dashboardActiveTripSection => 'Instantané du trajet actif';

  @override
  String get dashboardNoUpcomingTripTitle => 'Pas de voyage de groupe à venir';

  @override
  String get dashboardNoUpcomingTripBody =>
      'Lorsque vous planifiez avec des amis, le résumé de votre prochain voyage apparaît ici.';

  @override
  String get dashboardQuickToolsSection => 'Outils rapides';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'Commence dans $days jours';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'Se termine dans $days jours';
  }

  @override
  String get navDashboardBody =>
      'Votre hub de voyage : ouvrez les outils depuis la barre ou le menu Plus.';

  @override
  String get appSettings => 'Paramètres de l\'application';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic Pro';

  @override
  String get settingsSubscriptionActive => 'Abonnement actif';

  @override
  String get settingsSubscriptionLifetime => 'Accès à vie';

  @override
  String get settingsSubscriptionFree => 'Forfait gratuit';

  @override
  String get settingsManageBilling => 'Gérer la facturation';

  @override
  String get settingsTestModeSectionTitle => 'Mode test';

  @override
  String get settingsTestModeProTitle => 'Tester en tant que Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'Remplacement local pour les tests ; ignore RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'Lorsqu\'il est activé, cet appareil déverrouille toutes les fonctionnalités Pro localement. Destiné uniquement aux tests internes – cela ne modifie pas votre véritable abonnement.';

  @override
  String get settingsUnitsTitle => 'Unités de mesure';

  @override
  String get settingsLanguageTitle => 'Langue';

  @override
  String get settingsThemeTitle => 'Thème';

  @override
  String get settingsClockWidgetTitle => 'Widget horloge';

  @override
  String get settingsCurrencyWidgetTitle => 'Widget de devise';

  @override
  String get settingsCurrencyWidgetSubtitle =>
      'Écran d\'accueil et de verrouillage : 1, 20, 100 de votre devise de base';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Lumière';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsLanguageSystem => 'Valeur par défaut du système';

  @override
  String get settingsLanguageEnglish => 'Anglais';

  @override
  String get settingsLanguageSpanish => 'Espagnol';

  @override
  String get settingsProfileTitle => 'Synchronisation du profil et du cloud';

  @override
  String get settingsLogout => 'Se déconnecter';

  @override
  String get settingsLogoutConfirm => 'Se déconnecter de ce compte ?';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountBody =>
      'La suppression du compte est gérée par le support. Vous pouvez vous déconnecter ci-dessous.';

  @override
  String get settingsSectionAccount => 'Compte';

  @override
  String get accountManagementListTitle => 'Gérer le compte';

  @override
  String get accountManagementListSubtitle =>
      'Mettez à jour votre nom, votre adresse e-mail et votre mot de passe';

  @override
  String get accountManagementTitle => 'Gestion des comptes';

  @override
  String get accountSectionProfile => 'Profil';

  @override
  String get accountSectionSignIn => 'Se connecter';

  @override
  String get accountFieldDisplayName => 'Nom d\'affichage';

  @override
  String get accountFieldEmail => 'E-mail';

  @override
  String get accountFieldCurrentPassword => 'Mot de passe actuel';

  @override
  String get accountFieldNewPassword => 'Nouveau mot de passe';

  @override
  String get accountSaveName => 'Enregistrer le nom';

  @override
  String get accountChangeEmail =>
      'Envoyer une vérification et modifier l\'e-mail';

  @override
  String get accountChangePassword => 'Changer le mot de passe';

  @override
  String get accountSignedOutMessage =>
      'Vous devez être connecté pour gérer votre compte.';

  @override
  String get accountSignInCta => 'Se connecter';

  @override
  String get accountNameSaved => 'Nom mis à jour';

  @override
  String accountEmailVerificationSent(String email) {
    return 'Lien de vérification envoyé à $email. Confirmez-le pour changer votre adresse de connexion.';
  }

  @override
  String get accountPasswordChanged => 'Mot de passe mis à jour';

  @override
  String accountReauthRequired(String field) {
    return 'Pour des raisons de sécurité, connectez-vous à nouveau pour modifier votre $field.';
  }

  @override
  String get accountFieldLabelEmail => 'e-mail';

  @override
  String get accountFieldLabelPassword => 'mot de passe';

  @override
  String accountErrorGeneric(String field, String error) {
    return 'Impossible de mettre à jour $field : $error';
  }

  @override
  String get accountReauthAction => 'Connectez-vous à nouveau';

  @override
  String get accountValidationEmailRequired => 'Entrez votre email';

  @override
  String get accountValidationEmailInvalid => 'Entrez un email valide';

  @override
  String get accountValidationNameRequired => 'Entrez votre nom';

  @override
  String get accountValidationPasswordTooShort =>
      'Utilisez au moins 8 caractères';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'Courriel actuel : $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic Pro';

  @override
  String get proPaywallSubtitle =>
      'Débloquez des cartes hors ligne, des outils de voyage approfondis et la collaboration.';

  @override
  String get proPaywallBenefits =>
      'Cartes hors ligne et téléchargements de régions\nItinéraire, budget, coffre-fort et emballage\nPlanificateur de groupe et synchronisation en temps réel';

  @override
  String get proPaywallBullets =>
      'Cartes hors ligne et téléchargements de régions|Itinéraire, budget, coffre-fort et emballage|Planificateur de groupe et synchronisation en temps réel';

  @override
  String get proPaywallUpgradeRevenueCat => 'Mise à niveau via RevenueCat';

  @override
  String get upgradeNow => 'Mettre à niveau maintenant';

  @override
  String get packingCatClothing => 'VÊTEMENTS';

  @override
  String get packingCatDocuments => 'DOCUMENTATION';

  @override
  String get packingCatMedications => 'MÉDICAMENTS';

  @override
  String get packingCatMisc => 'DIVERS';

  @override
  String get packingCatReservations => 'RÉSERVATIONS';

  @override
  String get packingEmpty =>
      'Votre liste est vide.\nAppuyez sur + pour ajouter des éléments.';

  @override
  String get packingEmptyHidden =>
      'Il ne reste plus rien à emballer — ou désactivez « Masquer les tâches terminées » pour voir les éléments terminés.';

  @override
  String get packingHeader => 'EMBALLAGE ET LOGISTIQUE';

  @override
  String get packingHideCompleted => 'Masquer terminé';

  @override
  String get packingHideCompletedSubtitle =>
      'Les éléments terminés restent enregistrés ; seulement caché de cette vue';

  @override
  String get packingStarterPassport => 'Passeport';

  @override
  String get packingStarterShirts => 'Chemises';

  @override
  String get packingStarterSocks => 'Chaussettes';

  @override
  String get packingStarterTickets => 'Billets d\'avion';

  @override
  String get packingStarterToothbrush => 'Brosse à dents';

  @override
  String get paywallDisabledBody =>
      'Le paywall RevenueCat est temporairement désactivé pour l\'examen de l\'interface utilisateur.';

  @override
  String get paywallDisabledTitle => 'Paywall désactivé';

  @override
  String get presentationDeleteBody =>
      'Êtes-vous sûr de vouloir supprimer ce document du coffre-fort ?';

  @override
  String get presentationDeleteTitle => 'Supprimer le document ?';

  @override
  String get presentationImageLoadFail => 'Échec du chargement de l\'image';

  @override
  String get proActive => 'Actif';

  @override
  String get proManageHintFree =>
      'Débloquez les fonctionnalités Pro avec un abonnement mensuel.';

  @override
  String get proManageHintPro =>
      'Gérez votre abonnement ou restaurez vos achats.';

  @override
  String get proManageSubscription => 'Gérer l\'abonnement';

  @override
  String get proName => 'Tripmetic Pro';

  @override
  String get proPaywallError =>
      'Paywall n\'a pas pu être affiché. Vérifiez votre offre RevenueCat.';

  @override
  String get proPaywallNotConfigured =>
      'Les abonnements ne sont pas disponibles dans cette installation. Installez Tripmetic à partir de Google Play pour passer à Pro.';

  @override
  String proRestoreFailed(String message) {
    return 'Échec de la restauration : $message';
  }

  @override
  String get proTrialCta => 'Commencez votre essai gratuit de 3 jours';

  @override
  String get proWelcome => 'Bienvenue dans Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'Bien';

  @override
  String get schedulerAvailabilityOffHours => 'Hors heures d\'ouverture';

  @override
  String get schedulerAvailabilityOk => 'D\'ACCORD';

  @override
  String get schedulerBaseLocation => 'Emplacement de base';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'La date, l\'heure et le curseur s\'appliquent à l\'horloge de base ($zone). Chaque ligne de ville affiche le même instant dans cette zone.';
  }

  @override
  String get schedulerConvertedCities => 'Villes converties';

  @override
  String get schedulerDayNext => '+1 jour';

  @override
  String get schedulerDayPrevious => '-1 jour';

  @override
  String get schedulerDaySame => 'Le même jour';

  @override
  String get schedulerMeetingTime => 'Heure de réunion';

  @override
  String get schedulerSubtitle => 'Chevauchement des réunions';

  @override
  String get schedulerTitle => 'Planificateur global';

  @override
  String get settingsAndInfo => 'Paramètres et informations';

  @override
  String get settingsContact => 'Contactez-nous';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String get settingsHelpFaq => 'Aide et FAQ';

  @override
  String get settingsPrivacy => 'Politique de confidentialité';

  @override
  String get settingsSupportLegal => 'Assistance et juridique';

  @override
  String get settingsTerms => 'Conditions d\'utilisation';

  @override
  String get settingsMapboxAttributionTitle =>
      'Données cartographiques (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic utilise les cartes Mapbox. © Mapbox, © OpenStreetMap et autres contributeurs de données. Le logo sur la carte et le contrôle d\'attribution sont masqués dans l\'application pour une présentation plus claire et moins de clics accidentels ; cet avis satisfait aux exigences d’affichage de Mapbox.';

  @override
  String get settingsMapboxAttributionMapboxLink =>
      'Mapbox — À propos des cartes';

  @override
  String get sizeCatBelts => 'Ceintures';

  @override
  String get sizeCatMensJeansCombo => 'Jeans pour hommes — W×L (US)';

  @override
  String get sizeCatMensJeansInseam => 'Jeans pour hommes — entrejambe (L)';

  @override
  String get sizeCatMensJeansWaist => 'Jeans pour hommes — taille (W)';

  @override
  String get sizeCatMensPants => 'Pantalons pour hommes';

  @override
  String get sizeCatMensShirts => 'Chemises pour hommes';

  @override
  String get sizeCatMensShoes => 'Chaussures pour hommes';

  @override
  String get sizeCatMensTshirts => 'T-shirts pour hommes';

  @override
  String get sizeCatWomensBlouses => 'Chemisiers pour femmes';

  @override
  String get sizeCatWomensDresses => 'Robes pour femmes';

  @override
  String get sizeCatWomensPants => 'Pantalons pour femmes';

  @override
  String get sizeCatWomensShoes => 'Chaussures pour femmes';

  @override
  String get sizeCatWomensTshirts => 'T-shirts pour femmes';

  @override
  String get sizeCatBoysShoes => 'Chaussures pour garçons (enfants)';

  @override
  String get sizeCatGirlsShoes => 'Chaussures pour filles (enfants)';

  @override
  String get sizeCatBoysTshirts => 'Hauts / T-shirts garçon';

  @override
  String get sizeCatBoysPants => 'Pantalons pour garçons';

  @override
  String get sizeCatGirlsTshirts => 'Hauts / T-shirts fille';

  @override
  String get sizeCatGirlsPants => 'Pantalons pour filles';

  @override
  String get sizeCatGirlsDressesKids => 'Robes pour filles (enfants)';

  @override
  String get sizeColumnPrimaryEu => 'Primaire : UE';

  @override
  String get sizeColumnPrimaryJp => 'Primaire : JP';

  @override
  String get sizeColumnPrimaryMixed => 'Primaire : mixte (UE→US→UK→JP)';

  @override
  String get sizeColumnPrimaryUk => 'Primaire : Royaume-Uni';

  @override
  String get sizeColumnPrimaryUs => 'Primaire : États-Unis';

  @override
  String get sizeConverterAppBarSubtitle => 'Vêtements et chaussures';

  @override
  String get sizeConverterCategory => 'Catégorie';

  @override
  String get sizeConverterHeader => 'VÊTEMENTS ET CHAUSSURES';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · appuyez pour modifier';
  }

  @override
  String get sizeConverterYourBaseSize =>
      'Votre taille de base (sur l\'étiquette)';

  @override
  String get sizeConverterYourCountry => 'Votre pays/région';

  @override
  String get sizeEquivalentSizesHeader => 'TAILLES ÉQUIVALENTES';

  @override
  String get sizeHintBelts => 'par ex. 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => 'par ex. 38x32 ou 38×32';

  @override
  String get sizeHintMensJeansInseam =>
      'par ex. 32 (entrejambe\") ou 38x32 → utilise l\'entrejambe 32';

  @override
  String get sizeHintMensJeansWaist =>
      'par ex. 38 (taille\") ou 38x32 → utilise la taille 38';

  @override
  String get sizeHintMensPants => 'par ex. 30, 32, 34 (taille\")';

  @override
  String get sizeHintMensShirts => 'par ex. 15, 38, M';

  @override
  String get sizeHintMensShoes => 'par ex. 6-14, 42, 27';

  @override
  String get sizeHintMensTshirts => 'par ex. S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => 'par ex. 8, 38, M, XL';

  @override
  String get sizeHintWomensDresses => 'par ex. 8, 38, M';

  @override
  String get sizeHintWomensPants => 'par ex. 6, 10, 38, M';

  @override
  String get sizeHintWomensShoes => 'par ex. 5-12, 39, 25';

  @override
  String get sizeHintWomensTshirts => 'par ex. XS, M, 38';

  @override
  String get sizeHintBoysShoes => 'par ex. 11C, 3A, 32, 21';

  @override
  String get sizeHintGirlsShoes => 'par ex. 10C, 2A, 33, 20';

  @override
  String get sizeHintBoysTshirts => 'par ex. 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => 'par ex. 6, 8, 10 (enfants américains)';

  @override
  String get sizeHintGirlsTshirts => 'par ex. 6, 8, M, S';

  @override
  String get sizeHintGirlsPants => 'par ex. 6, 8, 10 (enfants américains)';

  @override
  String get sizeHintGirlsDressesKids => 'par ex. 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty =>
      'Entrez la taille imprimée sur votre vêtement ou chaussure.';

  @override
  String get sizeNoMatchRow =>
      'Aucune ligne de taille correspondante pour cette catégorie. Essayez les numéros américains, britanniques, européens, japonais ou une lettre (S, M, L), le cas échéant.';

  @override
  String get sizeTipJeansCombo =>
      'Exemple US 38×32 : taille ≈ EU 48, étiquette de taille JP souvent ~96–97 cm ; entrejambe 32\" ≈ ~81 cm. Les marques diffèrent — utilisez-le comme point de départ.';

  @override
  String get sizeTipJeansInseam =>
      'L\'entrejambe est la longueur de l\'intérieur de la jambe en pouces (par exemple 32). Le Japon peut afficher ~81 cm pour un entrejambe de 32\". Tapez 38×32 — nous utilisons 32 pour l\'entrejambe.';

  @override
  String get sizeTipJeansWaist =>
      'Un chiffre sur une étiquette asiatique correspond souvent à la taille : soit en centimètres (38\" ≈ 96-97 cm), soit en pouces de taille américains (38). Comparez avec un ruban à mesurer. Vous pouvez taper 38×32 ici — nous utilisons 38 pour la taille.';

  @override
  String get timezonePickerEmpty => 'Aucune correspondance';

  @override
  String get timezonePickerHint =>
      'Rechercher le nom IANA (par exemple Europe, Tokyo)';

  @override
  String get timezonePickerTitle => 'Choisissez un fuseau horaire';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown de $total zones';
  }

  @override
  String get timezoneSheetSearchHint =>
      'Rechercher le nom IANA (par exemple Europe, Tokyo)';

  @override
  String get timezoneSheetTitle => 'Sélectionnez le fuseau horaire';

  @override
  String get tipAmount => 'Montant du pourboire';

  @override
  String get tipAppBarSubtitle => 'Pourboire et facture';

  @override
  String get tipBillHint => 'par ex. 1 250 000,00 \$';

  @override
  String get tipCountryBrazil => 'Brésil';

  @override
  String get tipCountryChina => 'Chine';

  @override
  String get tipCountryColombia => 'Colombie';

  @override
  String get tipCountryDominicanRepublic => 'République dominicaine';

  @override
  String get tipCountryEgypt => 'Egypte';

  @override
  String get tipCountryFrance => 'France';

  @override
  String get tipCountryGermany => 'Allemagne';

  @override
  String get tipCountryHongKong => 'Hong Kong';

  @override
  String get tipCountryIndonesia => 'Indonésie';

  @override
  String get tipCountryItaly => 'Italie';

  @override
  String get tipCountryJapan => 'Japon';

  @override
  String get tipCountryMexico => 'Mexique';

  @override
  String get tipCountryMorocco => 'Maroc';

  @override
  String get tipCountryPortugal => 'Portugal';

  @override
  String get tipCountrySingapore => 'Singapour';

  @override
  String get tipCountrySpain => 'Espagne';

  @override
  String get tipCountryThailand => 'Thaïlande';

  @override
  String get tipCountryTurkey => 'Turquie';

  @override
  String get tipCountryUae => 'Émirats arabes unis (Dubaï)';

  @override
  String get tipCountryUnitedKingdom => 'Royaume-Uni';

  @override
  String get tipCountryUsa => 'États-Unis';

  @override
  String get tipZeroReasonChina =>
      'Le pourboire n’est pas habituel en Chine continentale et peut être refusé ou considéré comme étrange dans de nombreux endroits.';

  @override
  String get tipZeroReasonFrance =>
      'Les factures des restaurants incluent généralement des frais de service de 15 % (service compris). Un pourboire supplémentaire est facultatif pour un service exceptionnel.';

  @override
  String get tipZeroReasonJapan =>
      'Donner un pourboire n’est pas pratiqué au Japon et peut prêter à confusion ou offenser.';

  @override
  String get tipZeroReasonSingapore =>
      'Aucun pourboire n\'est prévu ; de nombreux sites ajoutent des frais de service de 10 % à la facture.';

  @override
  String get tipZeroReasonGeneric =>
      'Un pourboire de 0 % est typique ici. Vous pouvez toujours ajouter un pourboire pour un service exceptionnel.';

  @override
  String get tipZeroReasonTitle => 'Pourquoi 0% ?';

  @override
  String get tipCurrentCountry => 'Pays actuel';

  @override
  String get tipPeople => 'Personnes';

  @override
  String get tipPerPerson => 'Montant par personne';

  @override
  String get tipPercentHint => 'Tapez % de pourboire (par exemple 15 ou 27,5)';

  @override
  String get tipPercentLabel => 'Conseil %';

  @override
  String get tipResults => 'RÉSULTATS';

  @override
  String get tipSmartHeader => 'CONSEIL INTELLIGENT';

  @override
  String get tipTotalBill => 'Montant total de la facture';

  @override
  String get tipTotalWithTip => 'Total avec pourboire';

  @override
  String get toolBrainstorm => 'Remue-méninges';

  @override
  String get toolBudget => 'Budget';

  @override
  String get toolBudgetSubtitle =>
      'Planification du budget de voyage et suivi des dépenses';

  @override
  String get toolBudgetTitle => 'Budget';

  @override
  String get toolItinerarySubtitle => 'Vols, hôtels et projets par jour';

  @override
  String get toolItineraryTitle => 'Itinéraire';

  @override
  String get toolCrypto => 'Cryptomonnaie';

  @override
  String get toolCryptoSubtitle => 'Valeurs USD sur les pièces populaires';

  @override
  String get toolCryptoTitle => 'Cryptomonnaie';

  @override
  String get toolDocumentVault => 'Coffre-fort de documents';

  @override
  String get toolMindMapSubtitle =>
      'Des idées sur une toile infinie · hors ligne';

  @override
  String get toolMindMapTitle => 'Carte mentale de brainstorming';

  @override
  String get toolPacking => 'Emballage';

  @override
  String get toolPackingSubtitle =>
      'Listes de contrôle d\'emballage intelligentes par voyage';

  @override
  String get toolPackingTitle => 'Emballage';

  @override
  String get toolSchedulerSubtitle =>
      'Deux fuseaux horaires · planification du décalage horaire';

  @override
  String get toolSchedulerTitle => 'Heure et date';

  @override
  String get toolSettingsAboutSubtitle =>
      'Annonces, aide, confidentialité et conditions';

  @override
  String get toolSettingsAboutTitle => 'Paramètres et à propos';

  @override
  String get toolSettingsInfo => 'Paramètres et informations';

  @override
  String get toolSizeSubtitle => 'États-Unis · Royaume-Uni · UE · Japon (JP)';

  @override
  String get toolSizeTitle => 'Convertisseur de taille de vêtements';

  @override
  String get toolTimeDate => 'Heure et date';

  @override
  String get toolTipSubtitle =>
      'Normes de pourboire du pays · réparti jusqu\'à 20 personnes';

  @override
  String get toolTipTitle =>
      'Séparateur de pourboires et de factures intelligents';

  @override
  String get toolUnits => 'Unités';

  @override
  String get toolUnitsSubtitle => 'Longueur, poids, température, volume';

  @override
  String get toolUnitsTitle => 'Unités';

  @override
  String get toolVaultSubtitle =>
      'Stockage hors ligne des documents de voyage vitaux';

  @override
  String get toolVaultTitle => 'Coffre-fort de documents';

  @override
  String get unitAcres => 'Acres';

  @override
  String get unitCategoryArea => 'Zone';

  @override
  String get unitCategoryDistance => 'Distance';

  @override
  String get unitCategoryLength => 'Longueur';

  @override
  String get unitCategoryTemperature => 'Température';

  @override
  String get unitCategoryVolume => 'Volume';

  @override
  String get unitCategoryWeight => 'Poids';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get unitCentimeters => 'Centimètres';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitFeet => 'Pieds';

  @override
  String get unitGrams => 'Grammes';

  @override
  String get unitHectares => 'Hectares';

  @override
  String get unitInches => 'Pouces';

  @override
  String get unitKilograms => 'Kilogrammes';

  @override
  String get unitKilometers => 'Kilomètres';

  @override
  String get unitLiters => 'Litres';

  @override
  String get unitMeters => 'Mètres';

  @override
  String get unitMiles => 'Milles';

  @override
  String get unitMilliliters => 'Millilitres';

  @override
  String get unitOunces => 'Onces';

  @override
  String get unitPounds => 'Livres';

  @override
  String get unitSquareCentimeters => 'Centimètres carrés';

  @override
  String get unitSquareFeet => 'Pieds carrés';

  @override
  String get unitSquareInches => 'Pouces carrés';

  @override
  String get unitSquareKilometers => 'Kilomètres carrés';

  @override
  String get unitSquareMeters => 'Mètres carrés';

  @override
  String get unitSquareYards => 'Verges carrées';

  @override
  String get unitUsFluidOunces => 'Onces liquides américaines';

  @override
  String get unitUsGallons => 'Gallons américains';

  @override
  String get unitYards => 'Verges';

  @override
  String get unitsHeader => 'UNITÉS';

  @override
  String get vaultCategoryArrivalCard => 'Carte d\'arrivée';

  @override
  String get vaultCategoryHotelReservation => 'Réservation d\'hôtel';

  @override
  String get vaultCategoryOther => 'Autre';

  @override
  String get vaultCategoryPassportCopy => 'Copie du passeport';

  @override
  String get vaultCategoryReturnFlight => 'Vol de retour';

  @override
  String get vaultCategoryVisa => 'Visa';

  @override
  String get vaultDocumentTitle => 'Document';

  @override
  String get vaultIntro =>
      'Stockez en toute sécurité les documents de voyage essentiels pour un accès hors ligne et une présentation rapide à l\'immigration.';

  @override
  String vaultProcessFailed(String error) {
    return 'Échec du traitement du document : $error';
  }

  @override
  String get vaultTapToUpload => 'Appuyez pour télécharger';

  @override
  String get vaultTapToView => 'Appuyez pour voir';

  @override
  String get vaultVaultWord => 'sauter';

  @override
  String get bucketListTitle => 'Liste de choses à faire';

  @override
  String get bucketListSubtitle =>
      'Les endroits que vous avez visités, que vous souhaitez visiter et quelle est la prochaine étape.';

  @override
  String get bucketListToolSubtitle =>
      'Des destinations de rêve sur une carte et dans des listes';

  @override
  String get bucketListViewModeList => 'Liste';

  @override
  String get bucketListViewModeMap => 'Carte';

  @override
  String get bucketListViewModePopular => 'Populaire';

  @override
  String get bucketListPopularHint =>
      'Été, Live et Vécu mettent à jour votre carte et votre liste. Want et Upcoming sont uniquement des listes et n\'apparaissent jamais sur la carte.';

  @override
  String get bucketListCategoryBeen => 'A été';

  @override
  String get bucketListCategoryWant => 'Vouloir';

  @override
  String get bucketListCategoryLive => 'En direct';

  @override
  String get bucketListCategoryLived => 'Vécu';

  @override
  String get bucketListCategoryUpcoming => 'Prochain';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'Catégorie';

  @override
  String get bucketListDetailDates => 'Dates';

  @override
  String get bucketListMapLegend =>
      'Appuyez sur un marqueur pour plus de détails';

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
    return '$name a exploré $worldPercent% du monde. A voyagé plus de $populationPercent % de la population mondiale.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'Raphaël';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'A voyagé plus de $percent % de la population mondiale';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'Pays';

  @override
  String get bucketListShareMapCitiesLabel => 'Villes';

  @override
  String get bucketListEmptyCategory =>
      'Aucune place dans cette catégorie pour l\'instant.';

  @override
  String get bucketListTravelStats => 'Statistiques de voyage';

  @override
  String get bucketListStatWorld => 'Monde exploré';

  @override
  String get bucketListStatUs => 'Les États-Unis ont exploré';

  @override
  String get bucketListStatEurope => 'L\'Europe explorée';

  @override
  String get bucketListStatAsia => 'L\'Asie explorée';

  @override
  String get bucketListStatAfrica => 'L\'Afrique explorée';

  @override
  String get bucketListStatRegionalCaption => 'Régional';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count unique · de $total';
  }

  @override
  String get bucketListAddDestination => 'Ajouter une destination';

  @override
  String get bucketListEditDestination => 'Modifier la destination';

  @override
  String get bucketListSave => 'Sauvegarder';

  @override
  String get bucketListFieldCity => 'Ville';

  @override
  String get bucketListFieldCountry => 'Pays';

  @override
  String get bucketListFieldCategory => 'Catégorie';

  @override
  String get bucketListFieldRegionHint => 'État/province (facultatif)';

  @override
  String get bucketListFieldLatitude => 'Latitude';

  @override
  String get bucketListFieldLongitude => 'Longitude';

  @override
  String get bucketListFieldStart => 'Date de début';

  @override
  String get bucketListFieldEnd => 'Date de fin';

  @override
  String get bucketListFieldTripDates => 'Dates du voyage';

  @override
  String get bucketListValidationRequired => 'Ce champ est obligatoire.';

  @override
  String get bucketListValidationNumber => 'Entrez un numéro valide.';

  @override
  String get bucketListValidationDates =>
      'La date de fin doit être identique ou postérieure à la date de début.';

  @override
  String get bucketListGeocodeNotFound =>
      'Impossible de trouver cet emplacement sur la carte. Veuillez vérifier l\'orthographe.';

  @override
  String get bucketListShareSummarySubject =>
      'Ma liste de choses à faire Tripmetic';

  @override
  String get bucketListShareTooltip => 'Partager la liste et la carte';

  @override
  String bucketListShareFailed(String error) {
    return 'Impossible de partager : $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'Ouvrez la vue Carte avant de capturer l’image de la carte.';

  @override
  String get bucketListDeleteHint => 'Faites glisser pour supprimer';

  @override
  String get bucketListTapEditHint => 'Appuyez pour modifier';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'Échec de la synchronisation cloud : $error';
  }

  @override
  String get bucketListRetry => 'Réessayer';

  @override
  String get bucketListBackupTooltip => 'Sauvegarde et enregistrement';

  @override
  String get bucketListBackupTitle => 'Sauvegarde dans le cloud';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic fonctionne entièrement sans compte. Ajoutez-en un à tout moment si vous souhaitez une sauvegarde dans le cloud pour votre liste de choses à faire et vos voyages de groupe partagés.';

  @override
  String bucketListSignedInAs(String email) {
    return 'Connecté en tant que $email';
  }

  @override
  String get bucketListBackupEmail => 'E-mail';

  @override
  String get bucketListBackupPassword => 'Mot de passe';

  @override
  String get bucketListBackupConfirmPassword => 'Confirmez le mot de passe';

  @override
  String get bucketListAuthTabSignUp => 'S\'inscrire';

  @override
  String get bucketListAuthPasswordMismatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get bucketListRegister => 'Créer un compte et une sauvegarde';

  @override
  String get bucketListSignIn => 'Se connecter';

  @override
  String get bucketListSignOut => 'se déconnecter';

  @override
  String get bucketListBackupUploading => 'Téléchargement vers le cloud…';

  @override
  String get bucketListAuthSuccessSignIn => 'Connecté avec succès !';

  @override
  String get bucketListAuthSuccessSignUp => 'Compte créé avec succès !';

  @override
  String get signUpSuccessMessage => 'Compte créé. Bienvenue à Tripmetic !';

  @override
  String get signUpErrorEmailInUse =>
      'Cet e-mail est déjà enregistré. Essayez de vous connecter.';

  @override
  String get signUpErrorInvalidEmail => 'Entrez un email valide.';

  @override
  String get signUpErrorWeakPassword =>
      'Le mot de passe est trop faible. Utilisez au moins 8 caractères.';

  @override
  String signUpErrorGeneric(String message) {
    return 'Impossible de s\'inscrire : $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'Se connecter';

  @override
  String bucketListAuthFailed(String error) {
    return 'Impossible d\'authentifier : $error';
  }

  @override
  String get groupPlannerNoExtraDetails =>
      'Aucune note ni lien pour l\'instant.';

  @override
  String get groupPlannerTitle => 'Planificateur de groupe';

  @override
  String get groupPlannerToolTitle => 'Planificateur de groupe';

  @override
  String get groupPlannerToolSubtitle =>
      'Planifiez un voyage ensemble en temps réel';

  @override
  String get groupPlannerLandingPlanTitle => 'Planifier un voyage de groupe';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'Créez un voyage partagé avec destination, dates et budget.';

  @override
  String get groupPlannerLandingJoinTitle => 'Rejoignez un voyage de groupe';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'Entrez le code de voyage ou le lien de votre invitation.';

  @override
  String get groupPlannerCreateTripTitle => 'Nouveau voyage de groupe';

  @override
  String get groupPlannerSelectDates =>
      'Sélectionnez une plage de dates de voyage.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'Par personne';

  @override
  String get groupPlannerBudgetGroupOption => 'Total du groupe';

  @override
  String get groupPlannerBudgetNoneOption => 'Aucun';

  @override
  String get groupPlannerBudgetAmountLabel => 'Montant budgétaire';

  @override
  String get groupPlannerOpenTitle => 'Ouvrir un voyage de groupe';

  @override
  String get groupPlannerOpenSubtitle =>
      'Collez le code de voyage de votre invitation.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'Code de voyage';

  @override
  String get groupPlannerOpenHint =>
      'Code court, identifiant de voyage ou lien d\'invitation';

  @override
  String get groupPlannerOpenButton => 'Voyage ouvert';

  @override
  String get groupPlannerDestination => 'Destination';

  @override
  String get groupPlannerDates => 'Dates';

  @override
  String get groupPlannerGroupSize => 'Taille du groupe';

  @override
  String get groupPlannerBudget => 'Budget';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'Par personne : $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'Total du groupe : $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'Aucun budget fixé';

  @override
  String get groupPlannerInviteMembers => 'Inviter des membres';

  @override
  String get groupPlannerManageMembers => 'Gérer les membres';

  @override
  String get groupPlannerItinerary => 'Itinéraire';

  @override
  String get groupPlannerItineraryEditorHint =>
      'En tant qu\'administrateur de voyage ou coordinateur de voyage, vous pouvez ajouter des activités et modifier le calendrier.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'Lecture seule : votez sur les activités suggérées avec le pouce vers le haut ou vers le bas. Seuls les administrateurs et les coordinateurs de voyage peuvent ajouter ou modifier des éléments.';

  @override
  String get groupPlannerNoActivities => 'Aucune activité pour l\'instant.';

  @override
  String get groupPlannerTripNotFound => 'Ce voyage n\'a pas pu être chargé.';

  @override
  String get groupPlannerSignInTitle => 'Connexion requise';

  @override
  String get groupPlannerSignInBody =>
      'Connectez-vous sous Bucket list → Sauvegarde cloud pour afficher les voyages partagés.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'L\'enregistrement d\'un nouveau voyage de groupe nécessite un compte. Connectez-vous pour continuer : les autres fonctionnalités Tripmetic fonctionnent sans cette fonctionnalité.';

  @override
  String get groupPlannerMembersTitle => 'Membres';

  @override
  String get groupPlannerRoleAdmin => 'Administrateur';

  @override
  String get groupPlannerRoleCoPlanner => 'Coordinateur de voyage';

  @override
  String get groupPlannerRoleViewOnly => 'Lecture seule';

  @override
  String get groupPlannerOwner => 'Propriétaire';

  @override
  String get groupPlannerRemoveMember => 'Retirer';

  @override
  String get groupPlannerRemoveMemberTitle => 'Supprimer un membre ?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return 'Supprimer $email de ce voyage ?';
  }

  @override
  String get groupPlannerCancel => 'Annuler';

  @override
  String get groupPlannerNotes => 'Remarques';

  @override
  String get groupPlannerOpenLink => 'Ouvrir le lien';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'Impossible d\'enregistrer le vote : $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'Impossible de mettre à jour les membres : $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'Impossible d\'ouvrir la feuille de partage : $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'Impossible d\'ouvrir le voyage : $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'Vos voyages';

  @override
  String get groupPlannerMyTripsEmpty =>
      'Pas encore de voyages. Créez-en un ci-dessus.';

  @override
  String get groupPlannerExamplesTitle => 'Exemples de voyages';

  @override
  String get groupPlannerExamplesSubtitle =>
      'Exemples de cartes : créez un voyage ci-dessus pour ajouter le vôtre.';

  @override
  String get groupPlannerExampleTapBody =>
      'Ce ne sont que des échantillons. Utilisez « Planifier un voyage de groupe » pour créer un véritable voyage que vous pourrez partager.';

  @override
  String get groupPlannerExampleLisbonTitle => 'Équipe de Lisbonne hors site';

  @override
  String get groupPlannerExampleKyotoTitle => 'Visite du printemps à Kyoto';

  @override
  String get groupPlannerAddActivity => 'Ajouter une activité';

  @override
  String get groupPlannerActivityTitleLabel => 'Titre de l\'activité';

  @override
  String get groupPlannerActivityWhenLabel => 'Date et heure';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'Choisissez un jour de votre voyage, puis une heure. Toute personne pouvant modifier l\'itinéraire peut le modifier ultérieurement.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'Cette date est en dehors de ce voyage. Choisissez un jour entre le début et la fin du voyage.';

  @override
  String get groupPlannerActivityTitleRequired =>
      'Saisissez un titre d\'activité.';

  @override
  String get groupPlannerActivityDateUnset =>
      'Date non définie : appuyez sur Modifier pour planifier.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count personnes';
  }

  @override
  String get groupPlannerEditActivity => 'Modifier l\'activité';

  @override
  String get groupPlannerDeleteActivity => 'Supprimer';

  @override
  String get groupPlannerDeleteActivityTitle => 'Supprimer l\'activité ?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return 'Supprimer « $title » de l\'itinéraire ? Cela ne peut pas être annulé.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'Impossible de supprimer l\'activité : $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'Impossible de mettre à jour l\'activité : $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'Modifier le voyage';

  @override
  String get groupPlannerEditTripAction => 'Modifier le voyage';

  @override
  String get groupPlannerDeleteTripTitle => 'Supprimer le voyage ?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return 'Supprimer définitivement le voyage \"$destination\" et son itinéraire pour tout le monde ? Cela ne peut pas être annulé.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'Supprimer le voyage';

  @override
  String get groupPlannerTripDeleted => 'Voyage supprimé.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'Impossible de supprimer le voyage : $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'Impossible de mettre à jour le voyage : $error';
  }

  @override
  String get widgetInstructionTitle => 'Widget double horloge';

  @override
  String get widgetInstructionSubtitle =>
      'Suivez les fuseaux horaires de votre domicile et de votre destination directement depuis votre écran de verrouillage ou votre écran d\'accueil.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'Écran de verrouillage';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'Appuyez longuement sur votre écran de verrouillage et appuyez sur « Personnaliser ».';

  @override
  String get widgetInstructionIosLockScreenStep2 =>
      'Sélectionnez l\'aperçu « Écran de verrouillage ».';

  @override
  String get widgetInstructionIosLockScreenStep3 =>
      'Appuyez sur la zone du widget directement sous l\'heure.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      'Faites défiler vers le bas, sélectionnez Tripmetic et appuyez sur pour ajouter le widget.';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'Écran d\'accueil';

  @override
  String get widgetInstructionIosHomeScreenStep1 =>
      'Appuyez longuement sur un espace vide de votre écran d\'accueil.';

  @override
  String get widgetInstructionIosHomeScreenStep2 =>
      'Appuyez sur l\'icône + dans le coin supérieur gauche.';

  @override
  String get widgetInstructionIosHomeScreenStep3 => 'Recherchez « Tripmetic ».';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      'Sélectionnez la taille de votre widget préférée et appuyez sur « Ajouter un widget ».';

  @override
  String get widgetInstructionAndroidStep1 =>
      'Accédez à votre écran d’accueil et appuyez longuement sur une zone vide.';

  @override
  String get widgetInstructionAndroidStep2 => 'Appuyez sur « Widgets ».';

  @override
  String get widgetInstructionAndroidStep3 =>
      'Faites défiler jusqu\'à Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'Appuyez longuement sur le widget Dual Clock, puis faites-le glisser sur votre écran.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'Pour voir les deux horloges sur l\'écran de verrouillage : ouvrez Paramètres → recherchez « écran de verrouillage » ou « widgets » et ajoutez-y Tripmetic si votre téléphone propose des widgets d\'écran de verrouillage (tous les appareils ne le font pas).';

  @override
  String get widgetInstructionConfigureCta =>
      'Configurer les villes des widgets';

  @override
  String get currencyWidgetInstructionTitle =>
      'Widget de conversion de devises';

  @override
  String get currencyWidgetInstructionSubtitle =>
      'Épinglez vos devises de base et cible sur votre écran d’accueil Android. Les tarifs se synchronisent chaque fois que vous utilisez le convertisseur dans Tripmetic.';

  @override
  String get currencyWidgetInstructionAndroidTitle =>
      'Ajouter à l\'écran d\'accueil';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      'Ouvrez l\'outil Devise une fois et définissez vos deux premières devises (de base et cible).';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      'Accédez à votre écran d’accueil et appuyez longuement sur une zone vide.';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      'Appuyez sur « Widgets », faites défiler jusqu\'à Tripmetic et choisissez « Convertisseur de devises ».';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      'Faites glisser le widget sur votre écran d\'accueil ou appuyez sur Ajouter si votre lanceur le prend en charge.';

  @override
  String get currencyWidgetInstructionUsageTitle => 'Utiliser le widget';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      'Appuyez sur Modifier (ou sur le corps du widget) pour ouvrir la sélection de devises dans Tripmetic.';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      'Appuyez sur ↻ Actualiser pour mettre à jour les tarifs sur le widget en arrière-plan (l\'application ne s\'ouvre pas).';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      'Les montants sont mis à jour automatiquement lorsque vous modifiez des devises ou des valeurs dans l\'application.';

  @override
  String get currencyWidgetInstructionPinCta =>
      'Ajouter un widget à l\'écran d\'accueil';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta =>
      'Changer les devises des widgets';

  @override
  String get currencyWidgetInstructionIosHint =>
      'Le widget de l\'écran d\'accueil des devises est disponible sur Android. Sur iPhone, utilisez l\'outil Devise intégré à l\'application.';

  @override
  String get currencyWidgetPinUnsupported =>
      'Votre lanceur ne prend pas en charge l\'ajout de ce widget depuis l\'application. Appuyez longuement sur votre écran d\'accueil et choisissez Widgets à la place.';

  @override
  String get currencyWidgetPinFailed =>
      'Impossible d\'ouvrir le sélecteur de widgets. Ajoutez le widget manuellement depuis votre écran d\'accueil.';

  @override
  String get dualClockScreenTitle => 'Widget double horloge';

  @override
  String get dualClockConfigTitle => 'Configurer les villes';

  @override
  String get dualClockConfigSubtitle =>
      'Choisissez deux villes et fuseaux horaires. Vos sélections se synchronisent avec le widget de l\'écran d\'accueil Tripmetic (Android) et le widget de l\'écran de verrouillage (iOS).';

  @override
  String get dualClockCity1Label => 'Première ville';

  @override
  String get dualClockCity2Label => 'Deuxième ville';

  @override
  String get dualClockSave => 'Enregistrer et mettre à jour le widget';

  @override
  String get dualClockSaved => 'Widget mis à jour.';

  @override
  String get dualClockSaveError =>
      'Impossible d\'enregistrer les données du widget. Veuillez réessayer.';

  @override
  String get dualClockAppearanceTitle => 'Apparence du widget';

  @override
  String get dualClockAppearanceHint =>
      'Personnalisez la taille du texte, les couleurs et l\'arrière-plan de l\'écran d\'accueil. L\'écran de verrouillage utilise la taille de la police (et les couleurs lorsque le système le permet).';

  @override
  String get dualClockFontScaleLabel => 'Taille du texte';

  @override
  String get dualClockColorCity => 'Noms de villes';

  @override
  String get dualClockColorTime => 'Fois';

  @override
  String get dualClockColorDate => 'Dates';

  @override
  String get dualClockColorBackground => 'Contexte de la maison';

  @override
  String get dualClockShadowLabel => 'Ombre du texte';

  @override
  String get dualClockShadowSubtitle =>
      'Ajoute du contraste aux fonds d\'écran occupés ou photo.';

  @override
  String get moreToolsDualClockBannerTitle => 'Widget double horloge';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'Affichez deux fuseaux horaires sur votre écran de verrouillage ou votre écran d\'accueil : appuyez pour configurer.';

  @override
  String get moreToolsDualClockBannerCta => 'Installation';

  @override
  String get settingsDualClockWidgetTitle => 'Widget double horloge';

  @override
  String get settingsDualClockWidgetSubtitle =>
      'Ajoutez le widget et choisissez vos villes';

  @override
  String get widgetNewFeatureBadge => 'Nouveau';

  @override
  String get globalNavAccountCloudSyncTooltip =>
      'Sauvegarde de compte et cloud';

  @override
  String get exchangeRatesForceRefreshTooltip =>
      'Récupérer les derniers taux de change';

  @override
  String get exchangeRatesRefreshedOk => 'Taux de change mis à jour.';

  @override
  String get exchangeRatesRefreshFailed =>
      'Impossible d\'actualiser les taux de change.';

  @override
  String get bucketListStatUsTerritories => 'Territoires américains';

  @override
  String get bucketListAuthErrUserNotFound =>
      'Aucun compte trouvé pour cet e-mail.';

  @override
  String get bucketListAuthErrWrongPassword =>
      'Email ou mot de passe incorrect.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'Un compte existe déjà pour cet email.';

  @override
  String get bucketListAuthErrInvalidEmail => 'Adresse e-mail invalide.';

  @override
  String get bucketListAuthErrWeakPassword =>
      'Le mot de passe est trop faible.';

  @override
  String get bucketListAuthErrUserDisabled => 'Ce compte a été désactivé.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'Trop de tentatives. Réessayez plus tard.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'La connexion par e-mail/mot de passe n’est pas activée.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail => 'Adresse e-mail invalide.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'Le mot de passe doit comporter au moins 6 caractères.';

  @override
  String get bucketListAuthValidationPasswordRequired =>
      'Entrez votre mot de passe.';

  @override
  String get currencyWidgetAppearanceTitle => 'Apparence';

  @override
  String get currencyWidgetAppearanceHint =>
      'Personnalisez la taille de la police, les couleurs du texte et l\'arrière-plan de l\'écran d\'accueil. Les widgets d\'accueil conservent une taille fixe, de sorte que les grandes polices s\'ajustent automatiquement afin que toutes les lignes restent visibles. L\'écran de verrouillage utilise la taille de la police (et les couleurs lorsque le système le permet).';

  @override
  String get currencyWidgetFontScaleLabel => 'Taille de la police';

  @override
  String get currencyWidgetColorPrimary => 'Texte principal (montants / base)';

  @override
  String get currencyWidgetColorAccent =>
      'Texte d\'accentuation (étiquettes paire/échelle)';

  @override
  String get currencyWidgetColorCaption => 'Texte de légende (ligne de tarif)';

  @override
  String get currencyWidgetColorBackground => 'Contexte de la maison';

  @override
  String get currencyWidgetSaveAppearance => 'Enregistrer l\'apparence';

  @override
  String get currencyWidgetAppearanceSaved =>
      'Apparence du widget de devise enregistrée';

  @override
  String get currencyWidgetAppearanceSaveFailed =>
      'Impossible d\'enregistrer l\'apparence du widget';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
