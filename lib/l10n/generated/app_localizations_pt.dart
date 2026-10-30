// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get addItineraryEnterTitle => 'Por favor insira um título';

  @override
  String get addItineraryFieldLocation => 'Localização';

  @override
  String get addItineraryFieldNotes => 'Notas/confirmação';

  @override
  String get addItineraryFieldTitle => 'Título';

  @override
  String get addItineraryHintLocation => 'Aeroporto, endereço do hotel…';

  @override
  String get addItineraryHintNotes => 'Localizador de registros, links…';

  @override
  String get addItineraryHintTitle => 'Voo para Lisboa';

  @override
  String get addItinerarySave => 'Salvar evento';

  @override
  String get addItineraryTitle => 'Adicionar evento de itinerário';

  @override
  String get addPackingAddToList => 'Adicionar à lista';

  @override
  String get addPackingEnterName => 'Por favor insira um nome de item';

  @override
  String get addPackingFieldCategory => 'Categoria';

  @override
  String get addPackingFieldItemName => 'Nome do item';

  @override
  String get addPackingHint => 'por exemplo Adaptador de energia';

  @override
  String get addPackingIcon => 'Ícone';

  @override
  String get addPackingQuantity => 'Quantidade';

  @override
  String get addPackingTitle => 'Adicionar item de embalagem';

  @override
  String get announcementsLatest => 'Últimas atualizações';

  @override
  String get appTitle => 'Tripmetic.app';

  @override
  String get budgetBaseCurrency => 'MOEDA BASE';

  @override
  String get budgetCategoryDialogHint => 'por exemplo Lembranças';

  @override
  String get budgetCategoryNameExists => 'O nome já existe';

  @override
  String get budgetCategoryNameMax => 'Máximo de 40 caracteres';

  @override
  String get budgetDailyFood => 'Comida diária';

  @override
  String get budgetDestinationSearchHint => 'Pesquisar país ou código de moeda';

  @override
  String get budgetDestinationTitle => 'Adicionar destino';

  @override
  String get budgetDialogAdd => 'Adicionar';

  @override
  String get budgetDialogNewCategory => 'Nova categoria de despesas';

  @override
  String budgetDialogRemoveBody(String name) {
    return 'Remover \"$name\" e seu valor?';
  }

  @override
  String get budgetDialogRemoveTitle => 'Remover categoria';

  @override
  String get budgetDialogRename => 'Renomear';

  @override
  String get budgetDialogRenameCategory => 'Renomear categoria';

  @override
  String get budgetEdit => 'Editar orçamento';

  @override
  String get budgetExpenseDailyFood => 'Alimentação Diária';

  @override
  String get budgetExpenseEatingOut => 'Comer fora';

  @override
  String get budgetExpenseEntertainment => 'Entretenimento';

  @override
  String get budgetExpenseFlights => 'Voos';

  @override
  String get budgetExpenseGrocery => 'Mercado';

  @override
  String get budgetExpenseHotels => 'Hotéis';

  @override
  String get budgetExpenseMisc => 'Diversos';

  @override
  String get budgetExpensePhoneService => 'Serviço telefônico';

  @override
  String get budgetExpenseShopping => 'Compras';

  @override
  String get budgetExpenseTourism => 'Turismo';

  @override
  String get budgetExpenseTransportation => 'Transporte';

  @override
  String get budgetExpenseTravelInsurance => 'Seguro de viagem';

  @override
  String get budgetHintDays => '7';

  @override
  String get budgetHintTotal => '3.000';

  @override
  String get budgetHintZero => '0';

  @override
  String get budgetInDestinations => 'Em seus destinos';

  @override
  String get budgetNoCategories => 'Ainda não há categorias de despesas';

  @override
  String budgetOtherExpenses(String code) {
    return 'OUTRAS DESPESAS ($code)';
  }

  @override
  String get budgetPerDayEstimate => 'Por dia (estimativa)';

  @override
  String budgetPerDayValue(String amount) {
    return '≈ $amount / dia';
  }

  @override
  String budgetRemainingAfter(String code) {
    return 'Restante após despesas · $code';
  }

  @override
  String get budgetSave => 'Economize orçamento';

  @override
  String get budgetSpendingPower => 'Poder de gasto';

  @override
  String get budgetSpentVsBudget => 'Gasto versus orçamento';

  @override
  String budgetTotalBudget(String code) {
    return 'ORÇAMENTO TOTAL ($code)';
  }

  @override
  String budgetTotalForTrip(String code) {
    return 'Total da viagem ($code)';
  }

  @override
  String get budgetTripDashboard => 'painel';

  @override
  String get budgetTripLengthDays => 'Duração da viagem (dias)';

  @override
  String get budgetTripTitle => 'Orçamento de viagem';

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonOk => 'OK';

  @override
  String get commonRemove => 'Remover';

  @override
  String get commonRename => 'Renomear';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonKeyboardDone => 'Feito';

  @override
  String countryCountriesCount(String count) {
    return '$count países';
  }

  @override
  String get countryPickerTitle => 'Selecione o país';

  @override
  String get countrySheetSearchHint => 'Pesquise o nome do país ou código ISO';

  @override
  String get countrySheetTitle => 'País/região base';

  @override
  String get cryptoHeader => 'CRIPTO';

  @override
  String cryptoMockPerUnit(String price) {
    return 'Simulação ~$price / unidade';
  }

  @override
  String get cryptoPickerTitle => 'Escolha uma moeda';

  @override
  String get cryptoSheetTitle => 'Selecione criptomoeda';

  @override
  String get currencyPickerSearchHint => 'Pesquisar ticker ou nome';

  @override
  String get currencyPickerTitle => 'Escolha uma moeda';

  @override
  String currencySheetCountShown(String shown, String total) {
    return '$shown de $total mostrado';
  }

  @override
  String get currencySheetSearchHint =>
      'Código de pesquisa, nome ou numérico ISO';

  @override
  String get currencySheetTitle => 'Selecione a moeda';

  @override
  String get exchangeBaseSuffix => '·Base';

  @override
  String exchangeCouldNotLoad(String error) {
    return 'Não foi possível carregar as taxas\n$error';
  }

  @override
  String get exchangeHeader => 'INTERCÂMBIO';

  @override
  String exchangeLastUpdated(String mins) {
    return 'Última atualização há $mins minutos';
  }

  @override
  String exchangeLastUpdatedOffline(String mins) {
    return 'Última atualização há $mins minutos (off-line)';
  }

  @override
  String get exchangeResetOne => 'Redefinir para 1 (base USD)';

  @override
  String get exchangeResetTooltip => 'Redefinir valores';

  @override
  String get exchangeResetZero => 'Limpar para 0';

  @override
  String itineraryDayPrefix(String day, String date) {
    return 'Dia $day: $date';
  }

  @override
  String get itineraryEmpty =>
      'Nenhum evento ainda.\nToque em + para adicionar voos, hotéis e planos.';

  @override
  String get itineraryHeader => 'ITINERÁRIO';

  @override
  String itineraryHiveError(String error) {
    return 'Não foi possível abrir os dados do itinerário salvo.\nVocê ainda pode tentar adicionar eventos — eles podem não persistir.\n($error)';
  }

  @override
  String get itineraryOpenOnMap => 'Abrir no mapa';

  @override
  String get mapAddToTrip => 'Adicionar à viagem';

  @override
  String get mapClearRoute => 'Rota e orientação claras';

  @override
  String get mapClearTooltip => 'Claro';

  @override
  String get mapDisplayCurrentViewport => 'Janela de visualização atual';

  @override
  String get mapDisplaySavedSearch => 'Pesquisa salva';

  @override
  String get mapDisplayTripDestination => 'Destino da viagem';

  @override
  String get mapDownloadAll => 'Baixar tudo';

  @override
  String get mapDownloadCurrentRegion =>
      'Baixe a região atual para uso offline';

  @override
  String get mapDownloadThisDestination => 'Baixe este destino';

  @override
  String get mapDownloadedRegions => 'Regiões baixadas';

  @override
  String get mapDownloadingRegion => 'Baixando região...';

  @override
  String mapDownloadingTitle(String title) {
    return 'Baixando $title...';
  }

  @override
  String get mapFromItinerary => 'Do seu itinerário';

  @override
  String get mapItineraryEmptyHint =>
      'Adicione destinos de itinerário para pré-baixá-los aqui.';

  @override
  String get mapLoadingRegions => 'Carregando regiões off-line…';

  @override
  String mapLocatingQuery(String query) {
    return 'Localizando $query...';
  }

  @override
  String get mapMarkCategoryBody => 'Escolha como rotular este pin offline.';

  @override
  String get mapMarkCategoryTitle => 'Categoria para esta marca';

  @override
  String get mapMarkFood => 'Comida';

  @override
  String get mapMarkHotel => 'Hotel';

  @override
  String get mapMarkLandmark => 'Marco';

  @override
  String get mapMarkOther => 'Outro';

  @override
  String mapNextInstruction(String current, String total) {
    return 'Próxima instrução ($current/$total)';
  }

  @override
  String get mapNoLocationSet => 'Nenhum local definido';

  @override
  String get mapNoRegionsYet => 'Você ainda não baixou nenhuma região.';

  @override
  String get mapOfflineIntro =>
      'Salve a região atualmente visível ou baixe previamente os destinos da sua viagem para que você possa navegar quando estiver fora da rede.';

  @override
  String get mapOfflineMapsTitle => 'Mapas off-line';

  @override
  String get mapRefreshTooltip => 'Atualizar';

  @override
  String get mapRemovePinTooltip => 'Remover pino';

  @override
  String get mapSaveOffline => 'Salvar off-line';

  @override
  String get mapSavePinToMap => 'Salvar alfinete no mapa';

  @override
  String get mapSavedPinsBody =>
      'Pins que você salvou da pesquisa. Toque em excluir para remover um do mapa.';

  @override
  String get mapSavedPinsTitle => 'Pins de mapa salvos';

  @override
  String get mapSearchHint =>
      'Pesquise uma cidade, endereço ou ponto de referência…';

  @override
  String mapSnackAddedOfflineMark(String title) {
    return '$title adicionado às suas marcas offline.';
  }

  @override
  String get mapSnackArrived => 'Você chegou.';

  @override
  String mapSnackCouldNotFind(String query) {
    return 'Não foi possível encontrar \"$query\".';
  }

  @override
  String mapSnackDeleteFailed(String error) {
    return 'Falha na exclusão: $error';
  }

  @override
  String mapSnackDownloadFailed(String error) {
    return 'Falha no download off-line: $error';
  }

  @override
  String mapSnackDownloadedEvent(String title) {
    return 'Baixado \"$title\".';
  }

  @override
  String mapSnackEventNoLocation(String title) {
    return '\"$title\" não tem local definido.';
  }

  @override
  String mapSnackFinishedBatch(String count) {
    return 'O download de $count região(ões) do itinerário foi concluído.';
  }

  @override
  String mapSnackLoadRegionsFailed(String error) {
    return 'Não foi possível carregar regiões off-line: $error';
  }

  @override
  String get mapSnackLocationOff =>
      'O serviço de localização está desativado. Ative-o para iniciar a navegação.';

  @override
  String get mapSnackLocationPermission =>
      'É necessária permissão de localização para passo a passo.';

  @override
  String get mapSnackLocationDeniedForMap =>
      'É necessária permissão de localização para centralizar o mapa em você.';

  @override
  String get mapSnackLocateFail =>
      'Não é possível obter sua localização no momento.';

  @override
  String get mapLocateMeTooltip => 'Ir para minha localização';

  @override
  String get mapSnackMapNotReady =>
      'O mapa ainda não está pronto. Por favor, espere um momento.';

  @override
  String get mapSnackNavStartFail =>
      'Não é possível iniciar a navegação neste momento.';

  @override
  String get mapSnackNavStopped => 'A navegação parou.';

  @override
  String get mapSnackNoItineraryLocations =>
      'Nenhum evento de itinerário possui localização ou ponto de mapa para download.';

  @override
  String get mapSnackNoManeuver =>
      'Esta etapa não possui ponto de manobra preciso.';

  @override
  String get mapSnackNoRoute =>
      'Não foi possível encontrar uma rota; mostrando o destino.';

  @override
  String get mapSnackRegionDownloaded =>
      'Região baixada com sucesso! Agora você pode navegar offline.';

  @override
  String get mapSnackRemovedPin => 'Pin salvo removido.';

  @override
  String mapSnackRemovedRegion(String name) {
    return 'Região offline \"$name\" removida.';
  }

  @override
  String get mapSnackRouteCleared => 'Rota e orientação apagadas.';

  @override
  String mapSnackRoutingFailed(String error) {
    return 'Falha no roteamento: $error';
  }

  @override
  String mapSnackSearchFailed(String error) {
    return 'Falha na pesquisa: $error';
  }

  @override
  String get mapStartNavigation => 'Iniciar navegação';

  @override
  String get mapStartingNav => 'Iniciando a navegação...';

  @override
  String get mapStopNavigation => 'Parar navegação';

  @override
  String get mapTravelDriving => 'Condução';

  @override
  String get mapTravelWalking => 'Andando';

  @override
  String mapTurnByTurn(String mode) {
    return 'Passo a passo ($mode)';
  }

  @override
  String get mindMapCaptureFail =>
      'Não foi possível capturar o mapa mental. Tente novamente.';

  @override
  String get mindMapClearBody =>
      'Isso remove todos os nós e restaura o mapa mental de demonstração (exemplo centralizado).';

  @override
  String get mindMapClearTitle => 'Tela transparente?';

  @override
  String get mindMapClearTooltip => 'Limpar/Redefinir';

  @override
  String mindMapCouldNotSave(String error) {
    return 'Não foi possível salvar: $error';
  }

  @override
  String mindMapCouldNotSaveType(String type) {
    return 'Não foi possível salvar: $type';
  }

  @override
  String get mindMapEmailShare => 'E-mail / Compartilhar';

  @override
  String get mindMapEmptyNode => 'Nó Vazio';

  @override
  String get mindMapHelpHint =>
      'Aperte para ampliar · arraste a tela · arraste cartões · toque em um cartão para editar · + adiciona um filho';

  @override
  String get mindMapNodeAddLeftTooltip => 'Adicionar filho esquerdo';

  @override
  String get mindMapNodeAddRightTooltip => 'Adicionar filho certo';

  @override
  String get mindMapNodeDeleteTooltip => 'Excluir nó';

  @override
  String get mindMapNodeEditTitle => 'Editar nó';

  @override
  String get mindMapNodeHint => 'Insira um rótulo curto';

  @override
  String get mindMapPhotoAccess =>
      'O acesso à biblioteca de fotos é necessário para salvar a imagem.';

  @override
  String get mindMapReset => 'Reiniciar';

  @override
  String get mindMapSavePhoto => 'Salvar como foto';

  @override
  String get mindMapSavedPhotos => 'Salvo em fotos';

  @override
  String get mindMapShareCaptureFail =>
      'Não foi possível capturar o mapa mental para compartilhar.';

  @override
  String get mindMapShareCompleted => 'Compartilhamento concluído';

  @override
  String mindMapShareFailed(String error) {
    return 'Falha no compartilhamento: $error';
  }

  @override
  String get mindMapShareReady =>
      'Imagem pronta – escolha um aplicativo para compartilhar';

  @override
  String get mindMapShareSheetClosed => 'Compartilhar planilha fechada';

  @override
  String get mindMapShareSubject => 'Tripmetic — Mapa mental';

  @override
  String get mindMapShareText => 'Exportação de mapa mental de Tripmetic';

  @override
  String get mindMapTapToEdit => 'Toque para editar';

  @override
  String get moreToolsHeader => 'MAIS FERRAMENTAS';

  @override
  String get moreToolsSubtitle => 'Utilitários de viagem';

  @override
  String get navCurrency => 'Moeda';

  @override
  String get navItinerary => 'Itinerário';

  @override
  String get navMoreTools => 'Mais ferramentas';

  @override
  String get navOfflineMap => 'Mapa off-line';

  @override
  String get navDashboard => 'Painel';

  @override
  String get navMoreMenu => 'Mais';

  @override
  String get navEditNavigation => 'Editar navegação';

  @override
  String get navDoneEditing => 'Feito';

  @override
  String get navSelectSlotHint =>
      'Toque em um slot e, em seguida, toque em uma ferramenta para atribuí-lo.';

  @override
  String get navSavePins => 'Salvar';

  @override
  String get navPinnedSectionTitle => 'Fixado na barra inferior';

  @override
  String get navAvailableSectionTitle => 'Recursos disponíveis';

  @override
  String get navEmptySlot => 'Vazio - adicione o disponível abaixo';

  @override
  String get navPinFullHint =>
      'Todas as quatro vagas estão ocupadas. Remova um para adicionar outro.';

  @override
  String get navEditPinnedHint =>
      'Use − para liberar um espaço, + para preencher um espaço ou arraste para reordenar. Salve quando todos os quatro estiverem preenchidos.';

  @override
  String get navAddToPinned => 'Adicionar à barra inferior';

  @override
  String get navRemoveFromPinned => 'Remover da barra inferior';

  @override
  String get navFeatureBadgeFree => 'Livre';

  @override
  String get navFeatureBadgePro => 'PRÓ';

  @override
  String get moreMenuSectionFree => 'Recursos gratuitos';

  @override
  String get moreMenuSectionPro => 'Tripmetic Pró';

  @override
  String get ourAppsMenuTitle => 'Nossos aplicativos';

  @override
  String get ourAppsMenuSubtitle => 'Mais software da equipe p1.do';

  @override
  String get ourAppsScreenTitle => 'Nossos aplicativos';

  @override
  String get ourAppsIntro =>
      'Software da equipe p1.do: toque em um aplicativo ativo para abrir seu site. O Stream CRM estará disponível em breve.';

  @override
  String get ourAppsBadgeLive => 'Disponível';

  @override
  String get ourAppsBadgeSoon => 'Em breve';

  @override
  String get ourAppsBadgeThisApp => 'Este aplicativo';

  @override
  String get ourAppsViewOnline => 'Veja tudo em p1.do';

  @override
  String get ourAppsPlatformWeb => 'Web';

  @override
  String get ourAppsPlatformMacos => 'macOS';

  @override
  String get ourAppsPlatformIosAndroid => 'iOS · Android';

  @override
  String get ourAppsPlatformIosAndroidWeb => 'iOS · Android · Web';

  @override
  String get ourAppsPlatformWebMobile => 'Web · Celular';

  @override
  String get ourAppsPlatformWebTabletMobile => 'Web · Tablet · Celular';

  @override
  String get ourAppsTravelRecapTagline =>
      'AI rotas de viagem e resumos de fotos';

  @override
  String get ourAppsTravelRecapSummary =>
      'Planeje viagens com várias paradas em um mapa interativo, gere rotas com AI, adicione destinos e exporte recapitulações de viagens refinadas a partir de suas fotos.';

  @override
  String get ourAppsP1doTagline => 'Link na bio e criador CRM';

  @override
  String get ourAppsP1doSummary =>
      'Link na bio para criadores que capturam CRM leads — além de Premium Selling e agendamento de compromissos — sem uma redução extra do seu lucro além da taxa mensal.';

  @override
  String get ourAppsDockTxtTagline =>
      'macOS scratchpad fixado na borda e comparação exata';

  @override
  String get ourAppsDockTxtSummary =>
      'Uma gaveta flutuante nativa gratuita macOS para trabalho de rascunho de texto simples, limpeza de espaços em branco, embelezamento JSON e diferenças em nível de caractere.';

  @override
  String get ourAppsTripmeticTagline =>
      'Kit de ferramentas de viagens globais e planejador de orçamento';

  @override
  String get ourAppsTripmeticSummary =>
      'Um painel para listas de desejos, mapas off-line, itinerários de grupo, orçamentos de vários países, widgets de fuso horário, listas de embalagem e conversores.';

  @override
  String get ourAppsPayxtTagline =>
      'Faturas de texto para pagamento em segundos';

  @override
  String get ourAppsPayxtSummary =>
      'Transforme uma mensagem de texto em uma fatura paga segura com links de checkout com tecnologia Stripe- e PayPal para profissionais móveis.';

  @override
  String get ourAppsPermitMobileTagline =>
      'Rastreador de licença de construção para remodeladores';

  @override
  String get ourAppsPermitMobileSummary =>
      'Monitore o status da licença de construção municipal no local da obra – números, endereços e atualizações de aprovação nos portais da cidade.';

  @override
  String get ourAppsTrackkrTagline => 'Gestão de parcelas de apartamentos';

  @override
  String get ourAppsTrackkrSummary =>
      'Registre pacotes recebidos em segundos, notifique os locatários por e-mail (e SMS opcional) e gerencie unidades ilimitadas em um plano básico gratuito para sempre.';

  @override
  String get ourAppsKeyForecastsTagline =>
      'Controlador fracionário para líderes HVAC';

  @override
  String get ourAppsKeyForecastsSummary =>
      'Inteligência financeira executiva para HVAC e construção — custos de trabalhos, previsão de fluxo de caixa sazonal e relatórios prontos para escala.';

  @override
  String get ourAppsStreamCrmTagline =>
      'TikTok rastreamento de presentes ao vivo e doador CRM';

  @override
  String get ourAppsStreamCrmSummary =>
      'Rastreie presentes ao vivo de TikTok em tempo real, separe os gastos dos presenteadores de seus ganhos e incentive os principais apoiadores com perfis de doadores.';

  @override
  String get proGlassTeaserTitle => 'Tripmetic Recurso Profissional';

  @override
  String get dashboardWorldExplorerSection => 'Explorador Mundial';

  @override
  String get dashboardWorldExplorerCountriesLabel => 'Países visitados';

  @override
  String get dashboardWorldExplorerPercentLabel => 'Do mundo explorado';

  @override
  String dashboardWorldExplorerPercentValue(String percent) {
    return '$percent%';
  }

  @override
  String get bucketListDisplayNameLabel => 'Nome de exibição';

  @override
  String get bucketListMapUnavailable =>
      'O mapa não está disponível porque nenhum token de acesso do Mapbox foi configurado.';

  @override
  String get bucketListAuthValidationDisplayName => 'Digite seu nome';

  @override
  String get authSignUpScreenTitle => 'Crie sua conta Tripmetic';

  @override
  String get authSignUpScreenSubtitle =>
      'Opcional – somente se você quiser backup na nuvem. Você pode continuar usando todas as ferramentas deste dispositivo sem se inscrever.';

  @override
  String get authSignInScreenTitle => 'Faça login em Tripmetic';

  @override
  String get authSignInScreenSubtitle =>
      'Opcional – para sincronizar sua lista de desejos e viagens em grupo na nuvem. O resto do Tripmetic funciona sem conta.';

  @override
  String get authForgotPassword => 'Esqueceu sua senha?';

  @override
  String get authPasswordResetConfirmation =>
      'Se existir uma conta para esse e-mail, você receberá um link para redefinir sua senha.';

  @override
  String get authUnexpectedError =>
      'Algo deu errado. Por favor, tente novamente.';

  @override
  String get authBackupBulletBucketList =>
      'Os destinos da lista de buckets são salvos na nuvem e mesclados quando você faz login.';

  @override
  String get authBackupBulletGroupTrips =>
      'As viagens em grupo que você cria ou participa são armazenadas em sua conta.';

  @override
  String get authBackupBulletMultiDevice =>
      'Faça login em outro dispositivo para restaurar seus dados sincronizados.';

  @override
  String get authLinkAlreadyHaveAccount => 'Já tem uma conta? Entrar';

  @override
  String get authLinkNeedAccount => 'Precisa de uma conta? Crie um';

  @override
  String get authFullSignUpCta => 'Use a tela de inscrição completa';

  @override
  String get authFullSignInCta => 'Usar tela de login completa';

  @override
  String dashboardGreeting(String name) {
    return 'Olá, $name';
  }

  @override
  String get dashboardGuestName => 'Viajante';

  @override
  String get dashboardWelcomeSubtitle =>
      'Planejem juntos, mantenham-se organizados e acessem as ferramentas com um toque.';

  @override
  String get dashboardPlanGroupTrip => 'Planeje uma nova viagem em grupo';

  @override
  String get dashboardAddBucketList => 'Adicionar à lista de baldes';

  @override
  String get dashboardActiveTripSection => 'Instantâneo da viagem ativa';

  @override
  String get dashboardNoUpcomingTripTitle => 'Nenhuma próxima viagem em grupo';

  @override
  String get dashboardNoUpcomingTripBody =>
      'Quando você planeja com amigos, o resumo da sua próxima viagem aparece aqui.';

  @override
  String get dashboardQuickToolsSection => 'Ferramentas rápidas';

  @override
  String dashboardCountdownStartsIn(String days) {
    return 'Começa em $days dias';
  }

  @override
  String dashboardCountdownEndsIn(String days) {
    return 'Termina em $days dias';
  }

  @override
  String get navDashboardBody =>
      'Seu centro de viagem: abra ferramentas na barra ou no menu Mais.';

  @override
  String get appSettings => 'Configurações do aplicativo';

  @override
  String get settingsSectionTripmeticPro => 'Tripmetic Pró';

  @override
  String get settingsSubscriptionActive => 'Assinatura ativa';

  @override
  String get settingsSubscriptionLifetime => 'Acesso vitalício';

  @override
  String get settingsSubscriptionFree => 'Plano grátis';

  @override
  String get settingsManageBilling => 'Gerenciar faturamento';

  @override
  String get settingsTestModeSectionTitle => 'Modo de teste';

  @override
  String get settingsTestModeProTitle => 'Teste como Tripmetic Pro';

  @override
  String get settingsTestModeProSubtitle =>
      'Substituição local para testes; ignora RevenueCat.';

  @override
  String get settingsTestModeProCaption =>
      'Quando ativado, este dispositivo desbloqueia todos os recursos Pro localmente. Destinado apenas a testes internos – não altera sua assinatura real.';

  @override
  String get settingsUnitsTitle => 'Unidades de medida';

  @override
  String get settingsLanguageTitle => 'Linguagem';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsClockWidgetTitle => 'Widget de relógio';

  @override
  String get settingsCurrencyWidgetTitle => 'Widget de moeda';

  @override
  String get settingsCurrencyWidgetSubtitle =>
      'Tela inicial e de bloqueio: 1, 20, 100 de sua moeda base';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Luz';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsLanguageSystem => 'Padrão do sistema';

  @override
  String get settingsLanguageEnglish => 'Inglês';

  @override
  String get settingsLanguageSpanish => 'Espanhol';

  @override
  String get settingsProfileTitle => 'Sincronização de perfil e nuvem';

  @override
  String get settingsLogout => 'Sair';

  @override
  String get settingsLogoutConfirm => 'Sair desta conta?';

  @override
  String get settingsDeleteAccount => 'Excluir conta';

  @override
  String get settingsDeleteAccountBody =>
      'A exclusão da conta é feita pelo suporte. Você pode sair abaixo.';

  @override
  String get settingsSectionAccount => 'Conta';

  @override
  String get accountManagementListTitle => 'Gerenciar conta';

  @override
  String get accountManagementListSubtitle =>
      'Atualize seu nome, e-mail e senha';

  @override
  String get accountManagementTitle => 'Gerenciamento de contas';

  @override
  String get accountSectionProfile => 'Perfil';

  @override
  String get accountSectionSignIn => 'Entrar';

  @override
  String get accountFieldDisplayName => 'Nome de exibição';

  @override
  String get accountFieldEmail => 'E-mail';

  @override
  String get accountFieldCurrentPassword => 'Senha atual';

  @override
  String get accountFieldNewPassword => 'Nova Senha';

  @override
  String get accountSaveName => 'Salvar nome';

  @override
  String get accountChangeEmail => 'Enviar verificação e alterar e-mail';

  @override
  String get accountChangePassword => 'Alterar a senha';

  @override
  String get accountSignedOutMessage =>
      'Você deve estar conectado para gerenciar sua conta.';

  @override
  String get accountSignInCta => 'Entrar';

  @override
  String get accountNameSaved => 'Nome atualizado';

  @override
  String accountEmailVerificationSent(String email) {
    return 'Link de verificação enviado para $email. Confirme para mudar seu endereço de login.';
  }

  @override
  String get accountPasswordChanged => 'Senha atualizada';

  @override
  String accountReauthRequired(String field) {
    return 'Por segurança, faça login novamente para alterar seu $field.';
  }

  @override
  String get accountFieldLabelEmail => 'e-mail';

  @override
  String get accountFieldLabelPassword => 'senha';

  @override
  String accountErrorGeneric(String field, String error) {
    return 'Não foi possível atualizar $field: $error';
  }

  @override
  String get accountReauthAction => 'Faça login novamente';

  @override
  String get accountValidationEmailRequired => 'Digite seu e-mail';

  @override
  String get accountValidationEmailInvalid => 'Insira um e-mail válido';

  @override
  String get accountValidationNameRequired => 'Digite seu nome';

  @override
  String get accountValidationPasswordTooShort => 'Use pelo menos 8 caracteres';

  @override
  String accountCurrentEmailLabel(String email) {
    return 'E-mail atual: $email';
  }

  @override
  String get proPaywallTitle => 'Tripmetic Pró';

  @override
  String get proPaywallSubtitle =>
      'Desbloqueie mapas offline, ferramentas de viagem profundas e colaboração.';

  @override
  String get proPaywallBenefits =>
      'Mapas off-line e downloads de regiões\nItinerário, orçamento, cofre e embalagem\nPlanejador de grupo e sincronização em tempo real';

  @override
  String get proPaywallBullets =>
      'Mapas off-line e downloads de regiões|Itinerário, orçamento, cofre e embalagem|Planejador de grupo e sincronização em tempo real';

  @override
  String get proPaywallUpgradeRevenueCat => 'Atualizar via RevenueCat';

  @override
  String get upgradeNow => 'Atualize agora';

  @override
  String get packingCatClothing => 'ROUPAS';

  @override
  String get packingCatDocuments => 'DOCUMENTOS';

  @override
  String get packingCatMedications => 'MEDICAMENTOS';

  @override
  String get packingCatMisc => 'DIVERSOS';

  @override
  String get packingCatReservations => 'RESERVAS';

  @override
  String get packingEmpty =>
      'Sua lista está vazia.\nToque em + para adicionar itens.';

  @override
  String get packingEmptyHidden =>
      'Não sobrou nada para embalar - ou desative \"Ocultar concluídos\" para ver os itens concluídos.';

  @override
  String get packingHeader => 'EMBALAGEM E LOGÍSTICA';

  @override
  String get packingHideCompleted => 'Ocultar concluído';

  @override
  String get packingHideCompletedSubtitle =>
      'Os itens concluídos permanecem salvos; apenas oculto desta visualização';

  @override
  String get packingStarterPassport => 'Passaporte';

  @override
  String get packingStarterShirts => 'Camisas';

  @override
  String get packingStarterSocks => 'Meias';

  @override
  String get packingStarterTickets => 'Bilhetes de avião';

  @override
  String get packingStarterToothbrush => 'Escova de dentes';

  @override
  String get paywallDisabledBody =>
      'RevenueCat o acesso pago está temporariamente desativado para revisão da IU.';

  @override
  String get paywallDisabledTitle => 'Acesso pago desativado';

  @override
  String get presentationDeleteBody =>
      'Tem certeza de que deseja remover este documento do cofre?';

  @override
  String get presentationDeleteTitle => 'Excluir documento?';

  @override
  String get presentationImageLoadFail => 'Falha ao carregar imagem';

  @override
  String get proActive => 'Ativo';

  @override
  String get proManageHintFree =>
      'Desbloqueie recursos Pro com uma assinatura mensal.';

  @override
  String get proManageHintPro => 'Gerencie sua assinatura ou restaure compras.';

  @override
  String get proManageSubscription => 'Gerenciar assinatura';

  @override
  String get proName => 'Tripmetic Pró';

  @override
  String get proPaywallError =>
      'Não foi possível mostrar o acesso pago. Verifique sua oferta RevenueCat.';

  @override
  String get proPaywallNotConfigured =>
      'Assinaturas não estão disponíveis nesta instalação. Instale Tripmetic de Google Play para atualizar para Pro.';

  @override
  String proRestoreFailed(String message) {
    return 'Falha na restauração: $message';
  }

  @override
  String get proTrialCta => 'Comece seu teste gratuito de 3 dias';

  @override
  String get proWelcome => 'Bem-vindo ao Tripmetic Pro';

  @override
  String get schedulerAvailabilityGood => 'Bom';

  @override
  String get schedulerAvailabilityOffHours => 'Fora do horário comercial';

  @override
  String get schedulerAvailabilityOk => 'OK';

  @override
  String get schedulerBaseLocation => 'Localização básica';

  @override
  String schedulerBaseTooltip(String zone) {
    return 'Data, hora e controle deslizante se aplicam ao relógio base ($zone). Cada linha de cidade mostra o mesmo instante naquela zona.';
  }

  @override
  String get schedulerConvertedCities => 'Cidades convertidas';

  @override
  String get schedulerDayNext => '+1 dia';

  @override
  String get schedulerDayPrevious => '-1 dia';

  @override
  String get schedulerDaySame => 'Mesmo dia';

  @override
  String get schedulerMeetingTime => 'Hora da reunião';

  @override
  String get schedulerSubtitle => 'Sobreposição de reuniões';

  @override
  String get schedulerTitle => 'Agendador global';

  @override
  String get settingsAndInfo => 'Configurações e informações';

  @override
  String get settingsContact => 'Contate-nos';

  @override
  String get settingsCopyright => '© 2026 Tripmetic.app';

  @override
  String get settingsCouldNotOpenLink => 'Não foi possível abrir o link';

  @override
  String get settingsHelpFaq => 'Ajuda e perguntas frequentes';

  @override
  String get settingsPrivacy => 'Política de Privacidade';

  @override
  String get settingsSupportLegal => 'Suporte e jurídico';

  @override
  String get settingsTerms => 'Termos de uso';

  @override
  String get settingsMapboxAttributionTitle => 'Dados do mapa (Mapbox)';

  @override
  String get settingsMapboxAttributionBody =>
      'Tripmetic usa mapas Mapbox. © Mapbox, © OpenStreetMap e outros contribuidores de dados. O logotipo no mapa e o controle de atribuição ficam ocultos no aplicativo para um layout mais claro e menos toques acidentais; este aviso atende aos requisitos de exibição do Mapbox.';

  @override
  String get settingsMapboxAttributionMapboxLink => 'Mapbox — Sobre mapas';

  @override
  String get sizeCatBelts => 'Cintos';

  @override
  String get sizeCatMensJeansCombo => 'Jeans masculinos – W×L (EUA)';

  @override
  String get sizeCatMensJeansInseam =>
      'Calça jeans masculina – costura interna (L)';

  @override
  String get sizeCatMensJeansWaist => 'Calça jeans masculina – cintura (W)';

  @override
  String get sizeCatMensPants => 'Calças masculinas';

  @override
  String get sizeCatMensShirts => 'Camisas masculinas';

  @override
  String get sizeCatMensShoes => 'Calçados Masculinos';

  @override
  String get sizeCatMensTshirts => 'Camisetas masculinas';

  @override
  String get sizeCatWomensBlouses => 'Blusas Femininas';

  @override
  String get sizeCatWomensDresses => 'Vestidos femininos';

  @override
  String get sizeCatWomensPants => 'Calças Femininas';

  @override
  String get sizeCatWomensShoes => 'Calçados femininos';

  @override
  String get sizeCatWomensTshirts => 'Camisetas femininas';

  @override
  String get sizeCatBoysShoes => 'Sapatos de menino (crianças)';

  @override
  String get sizeCatGirlsShoes => 'Sapatos de menina (crianças)';

  @override
  String get sizeCatBoysTshirts => 'Tops/camisetas de menino';

  @override
  String get sizeCatBoysPants => 'Calças de menino';

  @override
  String get sizeCatGirlsTshirts => 'Tops/camisetas de menina';

  @override
  String get sizeCatGirlsPants => 'Calças de menina';

  @override
  String get sizeCatGirlsDressesKids => 'Vestidos de menina (crianças)';

  @override
  String get sizeColumnPrimaryEu => 'Primário: UE';

  @override
  String get sizeColumnPrimaryJp => 'Primário: JP';

  @override
  String get sizeColumnPrimaryMixed =>
      'Primário: misto (UE → EUA → Reino Unido → JP)';

  @override
  String get sizeColumnPrimaryUk => 'Primário: Reino Unido';

  @override
  String get sizeColumnPrimaryUs => 'Primário: EUA';

  @override
  String get sizeConverterAppBarSubtitle => 'Roupas e sapatos';

  @override
  String get sizeConverterCategory => 'Categoria';

  @override
  String get sizeConverterHeader => 'ROUPAS E SAPATOS';

  @override
  String sizeConverterTapToChange(String code) {
    return '$code · toque para alterar';
  }

  @override
  String get sizeConverterYourBaseSize => 'Seu tamanho base (na etiqueta)';

  @override
  String get sizeConverterYourCountry => 'Seu país/região';

  @override
  String get sizeEquivalentSizesHeader => 'TAMANHOS EQUIVALENTES';

  @override
  String get sizeHintBelts => 'por exemplo 32, 34, 85, 90';

  @override
  String get sizeHintMensJeansCombo => 'por exemplo 38x32 ou 38x32';

  @override
  String get sizeHintMensJeansInseam =>
      'por exemplo 32 (costura interna\") ou 38x32 → usa costura interna 32';

  @override
  String get sizeHintMensJeansWaist =>
      'por exemplo 38 (cintura\") ou 38x32 → usa cintura 38';

  @override
  String get sizeHintMensPants => 'por exemplo 30, 32, 34 (cintura\")';

  @override
  String get sizeHintMensShirts => 'por exemplo 15, 38, M';

  @override
  String get sizeHintMensShoes => 'por exemplo 6–14, 42, 27';

  @override
  String get sizeHintMensTshirts => 'por exemplo S, M, L, 48';

  @override
  String get sizeHintWomensBlouses => 'por exemplo 8, 38, M, GG';

  @override
  String get sizeHintWomensDresses => 'por exemplo 8, 38, M';

  @override
  String get sizeHintWomensPants => 'por exemplo 6, 10, 38, M';

  @override
  String get sizeHintWomensShoes => 'por exemplo 5–12, 39, 25';

  @override
  String get sizeHintWomensTshirts => 'por exemplo XS, M, 38';

  @override
  String get sizeHintBoysShoes => 'por exemplo 11C, 3Y, 32, 21';

  @override
  String get sizeHintGirlsShoes => 'por exemplo 10C, 2Y, 33, 20';

  @override
  String get sizeHintBoysTshirts => 'por exemplo 6, 8, M, XS';

  @override
  String get sizeHintBoysPants => 'por exemplo 6, 8, 10 (crianças dos EUA)';

  @override
  String get sizeHintGirlsTshirts => 'por exemplo 6, 8, M, S';

  @override
  String get sizeHintGirlsPants => 'por exemplo 6, 8, 10 (crianças dos EUA)';

  @override
  String get sizeHintGirlsDressesKids => 'por exemplo 4, 6, 8, 104';

  @override
  String get sizeNoMatchEmpty =>
      'Insira o tamanho impresso em sua roupa ou sapato.';

  @override
  String get sizeNoMatchRow =>
      'Nenhuma linha de tamanho correspondente para esta categoria. Experimente números dos EUA, Reino Unido, UE, JP ou uma letra (S, M, L), quando aplicável.';

  @override
  String get sizeTipJeansCombo =>
      'Exemplo US 38×32: cintura ≈ EU 48, etiqueta de cintura JP geralmente ~96–97 cm; costura interna 32\" ≈ ~81 cm. As marcas diferem - use isso como ponto de partida.';

  @override
  String get sizeTipJeansInseam =>
      'Costura interna é o comprimento interno da perna em polegadas (por exemplo, 32). O Japão pode mostrar ~81 cm para uma costura interna de 32\". Digite 38×32 — usamos 32 para costura interna.';

  @override
  String get sizeTipJeansWaist =>
      'Um número em uma etiqueta asiática geralmente é a cintura: centímetros (38 \"≈ 96–97 cm) ou polegadas da cintura dos EUA (38). Compare com uma fita métrica. Você pode digitar 38 × 32 aqui - usamos 38 para cintura.';

  @override
  String get timezonePickerEmpty => 'Nenhuma correspondência';

  @override
  String get timezonePickerHint =>
      'Pesquise o nome da IANA (por exemplo, Europa, Tóquio)';

  @override
  String get timezonePickerTitle => 'Escolha um fuso horário';

  @override
  String timezoneSheetCountZones(String shown, String total) {
    return '$shown de $total zonas';
  }

  @override
  String get timezoneSheetSearchHint =>
      'Pesquise o nome da IANA (por exemplo, Europa, Tóquio)';

  @override
  String get timezoneSheetTitle => 'Selecione o fuso horário';

  @override
  String get tipAmount => 'Valor da gorjeta';

  @override
  String get tipAppBarSubtitle => 'Gorjeta e fatura';

  @override
  String get tipBillHint => 'por exemplo US\$ 1.250.000,00';

  @override
  String get tipCountryBrazil => 'Brasil';

  @override
  String get tipCountryChina => 'China';

  @override
  String get tipCountryColombia => 'Colômbia';

  @override
  String get tipCountryDominicanRepublic => 'República Dominicana';

  @override
  String get tipCountryEgypt => 'Egito';

  @override
  String get tipCountryFrance => 'França';

  @override
  String get tipCountryGermany => 'Alemanha';

  @override
  String get tipCountryHongKong => 'Hong Kong';

  @override
  String get tipCountryIndonesia => 'Indonésia';

  @override
  String get tipCountryItaly => 'Itália';

  @override
  String get tipCountryJapan => 'Japão';

  @override
  String get tipCountryMexico => 'México';

  @override
  String get tipCountryMorocco => 'Marrocos';

  @override
  String get tipCountryPortugal => 'Portugal';

  @override
  String get tipCountrySingapore => 'Cingapura';

  @override
  String get tipCountrySpain => 'Espanha';

  @override
  String get tipCountryThailand => 'Tailândia';

  @override
  String get tipCountryTurkey => 'Peru';

  @override
  String get tipCountryUae => 'Emirados Árabes Unidos (Dubai)';

  @override
  String get tipCountryUnitedKingdom => 'Reino Unido';

  @override
  String get tipCountryUsa => 'Estados Unidos';

  @override
  String get tipZeroReasonChina =>
      'Dar gorjetas não é habitual na China continental e pode ser recusado ou considerado estranho em muitos lugares.';

  @override
  String get tipZeroReasonFrance =>
      'As contas dos restaurantes geralmente incluem uma taxa de serviço de 15% (serviço incluído). Gorjetas extras são opcionais para um serviço excepcional.';

  @override
  String get tipZeroReasonJapan =>
      'A gorjeta não é praticada no Japão e pode causar confusão ou ofensa.';

  @override
  String get tipZeroReasonSingapore =>
      'Gorjetas não são esperadas; muitos locais adicionam uma taxa de serviço de 10% à conta.';

  @override
  String get tipZeroReasonGeneric =>
      'Uma gorjeta de 0% é típica aqui. Você ainda pode adicionar uma gorjeta pelo excelente atendimento.';

  @override
  String get tipZeroReasonTitle => 'Por que 0%?';

  @override
  String get tipCurrentCountry => 'País atual';

  @override
  String get tipPeople => 'Pessoas';

  @override
  String get tipPerPerson => 'Valor por pessoa';

  @override
  String get tipPercentHint => 'Digite % da gorjeta (por exemplo, 15 ou 27,5)';

  @override
  String get tipPercentLabel => 'Dica %';

  @override
  String get tipResults => 'RESULTADOS';

  @override
  String get tipSmartHeader => 'DICA INTELIGENTE';

  @override
  String get tipTotalBill => 'Valor total da fatura';

  @override
  String get tipTotalWithTip => 'Total com gorjeta';

  @override
  String get toolBrainstorm => 'Brainstorming';

  @override
  String get toolBudget => 'Orçamento';

  @override
  String get toolBudgetSubtitle =>
      'Planejamento de orçamento de viagem e controle de despesas';

  @override
  String get toolBudgetTitle => 'Orçamento';

  @override
  String get toolItinerarySubtitle => 'Voos, hotéis e planos por dia';

  @override
  String get toolItineraryTitle => 'Itinerário';

  @override
  String get toolCrypto => 'Criptografia';

  @override
  String get toolCryptoSubtitle => 'Valores USD em moedas populares';

  @override
  String get toolCryptoTitle => 'Criptografia';

  @override
  String get toolDocumentVault => 'Cofre de documentos';

  @override
  String get toolMindMapSubtitle => 'Ideias em uma tela infinita · offline';

  @override
  String get toolMindMapTitle => 'Mapa mental de brainstorming';

  @override
  String get toolPacking => 'Embalagem';

  @override
  String get toolPackingSubtitle =>
      'Listas de verificação de embalagem inteligentes por viagem';

  @override
  String get toolPackingTitle => 'Embalagem';

  @override
  String get toolSchedulerSubtitle =>
      'Fusos horários duplos · planeamento do jet lag';

  @override
  String get toolSchedulerTitle => 'Hora e data';

  @override
  String get toolSettingsAboutSubtitle =>
      'Anúncios, ajuda, privacidade e termos';

  @override
  String get toolSettingsAboutTitle => 'Configurações e sobre';

  @override
  String get toolSettingsInfo => 'Configurações e informações';

  @override
  String get toolSizeSubtitle => 'EUA · Reino Unido · UE · Japão (JP)';

  @override
  String get toolSizeTitle => 'Conversor de tamanho de roupas';

  @override
  String get toolTimeDate => 'Hora e data';

  @override
  String get toolTipSubtitle =>
      'Normas de dicas do país · dividir até 20 pessoas';

  @override
  String get toolTipTitle => 'Dica inteligente e divisor de contas';

  @override
  String get toolUnits => 'Unidades';

  @override
  String get toolUnitsSubtitle => 'Comprimento, peso, temperatura, volume';

  @override
  String get toolUnitsTitle => 'Unidades';

  @override
  String get toolVaultSubtitle =>
      'Armazenamento offline para documentos de viagem vitais';

  @override
  String get toolVaultTitle => 'Cofre de documentos';

  @override
  String get unitAcres => 'Hectares';

  @override
  String get unitCategoryArea => 'Área';

  @override
  String get unitCategoryDistance => 'Distância';

  @override
  String get unitCategoryLength => 'Comprimento';

  @override
  String get unitCategoryTemperature => 'Temperatura';

  @override
  String get unitCategoryVolume => 'Volume';

  @override
  String get unitCategoryWeight => 'Peso';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get unitCentimeters => 'Centímetros';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitFeet => 'Pés';

  @override
  String get unitGrams => 'Gramas';

  @override
  String get unitHectares => 'Hectares';

  @override
  String get unitInches => 'Polegadas';

  @override
  String get unitKilograms => 'Quilogramas';

  @override
  String get unitKilometers => 'Quilômetros';

  @override
  String get unitLiters => 'Litros';

  @override
  String get unitMeters => 'Metros';

  @override
  String get unitMiles => 'Milhas';

  @override
  String get unitMilliliters => 'Mililitros';

  @override
  String get unitOunces => 'Onças';

  @override
  String get unitPounds => 'Libras';

  @override
  String get unitSquareCentimeters => 'Centímetros quadrados';

  @override
  String get unitSquareFeet => 'Pés quadrados';

  @override
  String get unitSquareInches => 'Polegadas quadradas';

  @override
  String get unitSquareKilometers => 'Quilômetros quadrados';

  @override
  String get unitSquareMeters => 'Metros quadrados';

  @override
  String get unitSquareYards => 'Jardas quadradas';

  @override
  String get unitUsFluidOunces => 'Onças Fluidas dos EUA';

  @override
  String get unitUsGallons => 'Galões americanos';

  @override
  String get unitYards => 'Jardas';

  @override
  String get unitsHeader => 'UNIDADES';

  @override
  String get vaultCategoryArrivalCard => 'Cartão de chegada';

  @override
  String get vaultCategoryHotelReservation => 'Reserva de hotel';

  @override
  String get vaultCategoryOther => 'Outro';

  @override
  String get vaultCategoryPassportCopy => 'Cópia do passaporte';

  @override
  String get vaultCategoryReturnFlight => 'Voo de retorno';

  @override
  String get vaultCategoryVisa => 'Visa';

  @override
  String get vaultDocumentTitle => 'Documento';

  @override
  String get vaultIntro =>
      'Armazene com segurança documentos de viagem vitais para acesso off-line e apresentação rápida na imigração.';

  @override
  String vaultProcessFailed(String error) {
    return 'Falha ao processar o documento: $error';
  }

  @override
  String get vaultTapToUpload => 'Toque para fazer upload';

  @override
  String get vaultTapToView => 'Toque para visualizar';

  @override
  String get vaultVaultWord => 'cofre';

  @override
  String get bucketListTitle => 'Lista de baldes';

  @override
  String get bucketListSubtitle =>
      'Lugares onde você esteve, deseja ir e o que vem a seguir.';

  @override
  String get bucketListToolSubtitle =>
      'Destinos de sonho em um mapa e em listas';

  @override
  String get bucketListViewModeList => 'Lista';

  @override
  String get bucketListViewModeMap => 'Mapa';

  @override
  String get bucketListViewModePopular => 'Popular';

  @override
  String get bucketListPopularHint =>
      'Já esteve, viveu e viveu, atualize seu mapa e lista. Want e Upcoming são apenas listas e nunca aparecem no mapa.';

  @override
  String get bucketListCategoryBeen => 'Estive';

  @override
  String get bucketListCategoryWant => 'Querer';

  @override
  String get bucketListCategoryLive => 'Ao vivo';

  @override
  String get bucketListCategoryLived => 'Vivido';

  @override
  String get bucketListCategoryUpcoming => 'Por vir';

  @override
  String bucketListDatesRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get bucketListDetailCategory => 'Categoria';

  @override
  String get bucketListDetailDates => 'Datas';

  @override
  String get bucketListMapLegend => 'Toque em um marcador para ver detalhes';

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
    return '$name explorou $worldPercent% do mundo. Viajou mais de $populationPercent% da população mundial.';
  }

  @override
  String get bucketListShareMapTravelerFallback => 'Rafael';

  @override
  String bucketListShareMapStatPopulation(int percent) {
    return 'Viajou mais de $percent% da população mundial';
  }

  @override
  String get bucketListShareMapCountriesLabel => 'Países';

  @override
  String get bucketListShareMapCitiesLabel => 'Cidades';

  @override
  String get bucketListEmptyCategory => 'Ainda não há lugares nesta categoria.';

  @override
  String get bucketListTravelStats => 'Estatísticas de viagem';

  @override
  String get bucketListStatWorld => 'Mundo explorado';

  @override
  String get bucketListStatUs => 'EUA explorados';

  @override
  String get bucketListStatEurope => 'Europa explorada';

  @override
  String get bucketListStatAsia => 'Ásia explorada';

  @override
  String get bucketListStatAfrica => 'África explorada';

  @override
  String get bucketListStatRegionalCaption => 'Regional';

  @override
  String bucketListStatSubtitle(int count, int total) {
    return '$count único · de $total';
  }

  @override
  String get bucketListAddDestination => 'Adicionar destino';

  @override
  String get bucketListEditDestination => 'Editar destino';

  @override
  String get bucketListSave => 'Salvar';

  @override
  String get bucketListFieldCity => 'Cidade';

  @override
  String get bucketListFieldCountry => 'País';

  @override
  String get bucketListFieldCategory => 'Categoria';

  @override
  String get bucketListFieldRegionHint => 'Estado/província (opcional)';

  @override
  String get bucketListFieldLatitude => 'Latitude';

  @override
  String get bucketListFieldLongitude => 'Longitude';

  @override
  String get bucketListFieldStart => 'Data de início';

  @override
  String get bucketListFieldEnd => 'Data de término';

  @override
  String get bucketListFieldTripDates => 'Datas da viagem';

  @override
  String get bucketListValidationRequired => 'Este campo é obrigatório.';

  @override
  String get bucketListValidationNumber => 'Insira um número válido.';

  @override
  String get bucketListValidationDates =>
      'A data de término deve ser igual ou posterior à data de início.';

  @override
  String get bucketListGeocodeNotFound =>
      'Não foi possível encontrar este local no mapa. Por favor, verifique a ortografia.';

  @override
  String get bucketListShareSummarySubject =>
      'Minha lista de desejos Tripmetic';

  @override
  String get bucketListShareTooltip => 'Compartilhar lista e mapa';

  @override
  String bucketListShareFailed(String error) {
    return 'Não foi possível compartilhar: $error';
  }

  @override
  String get bucketListShareNeedMap =>
      'Abra a visualização do mapa antes de capturar a imagem do mapa.';

  @override
  String get bucketListDeleteHint => 'Deslize para remover';

  @override
  String get bucketListTapEditHint => 'Toque para editar';

  @override
  String bucketListCloudSyncFailed(String error) {
    return 'Falha na sincronização na nuvem: $error';
  }

  @override
  String get bucketListRetry => 'Tentar novamente';

  @override
  String get bucketListBackupTooltip => 'Backup e registro';

  @override
  String get bucketListBackupTitle => 'Backup na nuvem';

  @override
  String get bucketListBackupGuestIntro =>
      'Tripmetic funciona totalmente sem uma conta. Adicione um a qualquer momento se desejar backup na nuvem para sua lista de desejos e viagens em grupo compartilhadas.';

  @override
  String bucketListSignedInAs(String email) {
    return 'Conectado como $email';
  }

  @override
  String get bucketListBackupEmail => 'E-mail';

  @override
  String get bucketListBackupPassword => 'Senha';

  @override
  String get bucketListBackupConfirmPassword => 'Confirme sua senha';

  @override
  String get bucketListAuthTabSignUp => 'Inscrever-se';

  @override
  String get bucketListAuthPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get bucketListRegister => 'Criar conta e backup';

  @override
  String get bucketListSignIn => 'Entrar';

  @override
  String get bucketListSignOut => 'sair';

  @override
  String get bucketListBackupUploading => 'Fazendo upload para a nuvem…';

  @override
  String get bucketListAuthSuccessSignIn => 'Login realizado com sucesso!';

  @override
  String get bucketListAuthSuccessSignUp => 'Conta criada com sucesso!';

  @override
  String get signUpSuccessMessage => 'Conta criada. Bem-vindo ao Tripmetic!';

  @override
  String get signUpErrorEmailInUse =>
      'Este e-mail já está registado. Tente fazer login.';

  @override
  String get signUpErrorInvalidEmail => 'Insira um e-mail válido.';

  @override
  String get signUpErrorWeakPassword =>
      'A senha é muito fraca. Use pelo menos 8 caracteres.';

  @override
  String signUpErrorGeneric(String message) {
    return 'Não foi possível inscrever-se: $message';
  }

  @override
  String get signUpErrorEmailInUseAction => 'Entrar';

  @override
  String bucketListAuthFailed(String error) {
    return 'Não foi possível autenticar: $error';
  }

  @override
  String get groupPlannerNoExtraDetails => 'Nenhuma nota ou link ainda.';

  @override
  String get groupPlannerTitle => 'Planejador de grupo';

  @override
  String get groupPlannerToolTitle => 'Planejador de grupo';

  @override
  String get groupPlannerToolSubtitle =>
      'Planeje uma viagem juntos em tempo real';

  @override
  String get groupPlannerLandingPlanTitle => 'Planeje uma viagem em grupo';

  @override
  String get groupPlannerLandingPlanSubtitle =>
      'Crie uma viagem compartilhada com destino, datas e orçamento.';

  @override
  String get groupPlannerLandingJoinTitle => 'Participe de uma viagem em grupo';

  @override
  String get groupPlannerLandingJoinSubtitle =>
      'Digite o código da viagem ou link do seu convite.';

  @override
  String get groupPlannerCreateTripTitle => 'Nova viagem em grupo';

  @override
  String get groupPlannerSelectDates =>
      'Selecione um intervalo de datas da viagem.';

  @override
  String get groupPlannerBudgetPerPersonOption => 'Por pessoa';

  @override
  String get groupPlannerBudgetGroupOption => 'Total do grupo';

  @override
  String get groupPlannerBudgetNoneOption => 'Nenhum';

  @override
  String get groupPlannerBudgetAmountLabel => 'Valor do orçamento';

  @override
  String get groupPlannerOpenTitle => 'Abra uma viagem em grupo';

  @override
  String get groupPlannerOpenSubtitle =>
      'Cole o código de viagem do seu convite.';

  @override
  String get groupPlannerOpenTripCodeLabel => 'Código de viagem';

  @override
  String get groupPlannerOpenHint =>
      'Código curto, ID da viagem ou link de convite';

  @override
  String get groupPlannerOpenButton => 'Viagem aberta';

  @override
  String get groupPlannerDestination => 'Destino';

  @override
  String get groupPlannerDates => 'Datas';

  @override
  String get groupPlannerGroupSize => 'Tamanho do grupo';

  @override
  String get groupPlannerBudget => 'Orçamento';

  @override
  String groupPlannerBudgetPerPerson(String amount) {
    return 'Por pessoa: $amount';
  }

  @override
  String groupPlannerBudgetGroup(String amount) {
    return 'Total do grupo: $amount';
  }

  @override
  String get groupPlannerBudgetNone => 'Nenhum orçamento definido';

  @override
  String get groupPlannerInviteMembers => 'Convidar membros';

  @override
  String get groupPlannerManageMembers => 'Gerenciar membros';

  @override
  String get groupPlannerItinerary => 'Itinerário';

  @override
  String get groupPlannerItineraryEditorHint =>
      'Como administrador ou coordenador de viagem, você pode adicionar atividades e alterar a programação.';

  @override
  String get groupPlannerItineraryViewerHint =>
      'Somente leitura: vote nas atividades sugeridas com o polegar para cima ou para baixo. Somente administradores e coordenadores de viagem podem adicionar ou alterar itens.';

  @override
  String get groupPlannerNoActivities => 'Nenhuma atividade ainda.';

  @override
  String get groupPlannerTripNotFound =>
      'Não foi possível carregar esta viagem.';

  @override
  String get groupPlannerSignInTitle => 'É necessário fazer login';

  @override
  String get groupPlannerSignInBody =>
      'Faça login em Bucket list → Cloud backup para visualizar viagens compartilhadas.';

  @override
  String get groupPlannerCreateTripSignInRequired =>
      'Salvar uma nova viagem em grupo requer uma conta. Faça login para continuar — outros recursos do Tripmetic funcionam sem ele.';

  @override
  String get groupPlannerMembersTitle => 'Membros';

  @override
  String get groupPlannerRoleAdmin => 'Administrador';

  @override
  String get groupPlannerRoleCoPlanner => 'Coordenador de viagem';

  @override
  String get groupPlannerRoleViewOnly => 'Somente visualização';

  @override
  String get groupPlannerOwner => 'Proprietário';

  @override
  String get groupPlannerRemoveMember => 'Remover';

  @override
  String get groupPlannerRemoveMemberTitle => 'Remover membro?';

  @override
  String groupPlannerRemoveMemberBody(String email) {
    return 'Remover $email desta viagem?';
  }

  @override
  String get groupPlannerCancel => 'Cancelar';

  @override
  String get groupPlannerNotes => 'Notas';

  @override
  String get groupPlannerOpenLink => 'Abrir link';

  @override
  String groupPlannerNetVotes(String count) {
    return '$count';
  }

  @override
  String groupPlannerVoteError(String error) {
    return 'Não foi possível salvar o voto: $error';
  }

  @override
  String groupPlannerManageError(String error) {
    return 'Não foi possível atualizar os membros: $error';
  }

  @override
  String groupPlannerInviteError(String error) {
    return 'Não foi possível abrir a planilha de compartilhamento: $error';
  }

  @override
  String groupPlannerUnknownTripCode(String error) {
    return 'Não foi possível abrir a viagem: $error';
  }

  @override
  String get groupPlannerMyTripsSectionTitle => 'Suas viagens';

  @override
  String get groupPlannerMyTripsEmpty => 'Nenhuma viagem ainda. Crie um acima.';

  @override
  String get groupPlannerExamplesTitle => 'Exemplos de viagens';

  @override
  String get groupPlannerExamplesSubtitle =>
      'Exemplos de cartões — crie uma viagem acima para adicionar a sua.';

  @override
  String get groupPlannerExampleTapBody =>
      'Estas são apenas amostras. Use “Planejar uma viagem em grupo” para criar uma viagem real que você possa compartilhar.';

  @override
  String get groupPlannerExampleLisbonTitle => 'Equipa de Lisboa fora do local';

  @override
  String get groupPlannerExampleKyotoTitle => 'Excursão de primavera em Kyoto';

  @override
  String get groupPlannerAddActivity => 'Adicionar atividade';

  @override
  String get groupPlannerActivityTitleLabel => 'Título da atividade';

  @override
  String get groupPlannerActivityWhenLabel => 'Data e hora';

  @override
  String get groupPlannerActivityTripDateRangeHelp =>
      'Escolha um dia da sua viagem e depois um horário. Qualquer pessoa que possa editar o itinerário poderá alterá-lo posteriormente.';

  @override
  String get groupPlannerActivityDateOutOfRange =>
      'Essa data está fora desta viagem. Escolha um dia entre o início e o fim da viagem.';

  @override
  String get groupPlannerActivityTitleRequired =>
      'Insira um título de atividade.';

  @override
  String get groupPlannerActivityDateUnset =>
      'Data não definida – toque em Editar para agendar.';

  @override
  String groupPlannerPeopleCount(String count) {
    return '$count pessoas';
  }

  @override
  String get groupPlannerEditActivity => 'Editar atividade';

  @override
  String get groupPlannerDeleteActivity => 'Excluir';

  @override
  String get groupPlannerDeleteActivityTitle => 'Excluir atividade?';

  @override
  String groupPlannerDeleteActivityBody(String title) {
    return 'Remover \"$title\" do itinerário? Isto não pode ser desfeito.';
  }

  @override
  String groupPlannerActivityDeleteError(String error) {
    return 'Não foi possível excluir a atividade: $error';
  }

  @override
  String groupPlannerActivityEditError(String error) {
    return 'Não foi possível atualizar a atividade: $error';
  }

  @override
  String get groupPlannerEditTripTitle => 'Editar viagem';

  @override
  String get groupPlannerEditTripAction => 'Editar viagem';

  @override
  String get groupPlannerDeleteTripTitle => 'Excluir viagem?';

  @override
  String groupPlannerDeleteTripBody(String destination) {
    return 'Remover permanentemente a viagem \"$destination\" e seu itinerário para todos? Isto não pode ser desfeito.';
  }

  @override
  String get groupPlannerDeleteTripAction => 'Excluir viagem';

  @override
  String get groupPlannerTripDeleted => 'Viagem removida.';

  @override
  String groupPlannerTripDeleteError(String error) {
    return 'Não foi possível excluir a viagem: $error';
  }

  @override
  String groupPlannerTripUpdateError(String error) {
    return 'Não foi possível atualizar a viagem: $error';
  }

  @override
  String get widgetInstructionTitle => 'Widget de relógio duplo';

  @override
  String get widgetInstructionSubtitle =>
      'Acompanhe os fusos horários de sua casa e destino diretamente na tela de bloqueio ou na tela inicial.';

  @override
  String get widgetInstructionTabIos => 'iOS';

  @override
  String get widgetInstructionTabAndroid => 'Android';

  @override
  String get widgetInstructionIosLockScreenTitle => 'Tela de bloqueio';

  @override
  String get widgetInstructionIosLockScreenStep1 =>
      'Mantenha pressionada a tela de bloqueio e toque em \'Personalizar\'.';

  @override
  String get widgetInstructionIosLockScreenStep2 =>
      'Selecione a visualização da ‘Tela de bloqueio’.';

  @override
  String get widgetInstructionIosLockScreenStep3 =>
      'Toque na área do widget diretamente abaixo da hora.';

  @override
  String get widgetInstructionIosLockScreenStep4 =>
      'Role para baixo, selecione Tripmetic e toque para adicionar o widget.';

  @override
  String get widgetInstructionIosHomeScreenTitle => 'Tela inicial';

  @override
  String get widgetInstructionIosHomeScreenStep1 =>
      'Mantenha pressionado um espaço vazio na tela inicial.';

  @override
  String get widgetInstructionIosHomeScreenStep2 =>
      'Toque no ícone + no canto superior esquerdo.';

  @override
  String get widgetInstructionIosHomeScreenStep3 =>
      'Procure por \'Tripmetic\'.';

  @override
  String get widgetInstructionIosHomeScreenStep4 =>
      'Selecione o tamanho de widget de sua preferência e toque em \'Adicionar Widget\'.';

  @override
  String get widgetInstructionAndroidStep1 =>
      'Vá para a tela inicial e mantenha pressionada uma área vazia.';

  @override
  String get widgetInstructionAndroidStep2 => 'Toque em \"Widgets\".';

  @override
  String get widgetInstructionAndroidStep3 => 'Role para baixo até Tripmetic.';

  @override
  String get widgetInstructionAndroidStep4 =>
      'Toque e segure o widget Relógio duplo e arraste-o para a tela.';

  @override
  String get widgetInstructionAndroidLockScreenHint =>
      'Para ver os dois relógios na tela de bloqueio: abra Configurações → pesquise “tela de bloqueio” ou “widgets” e adicione Tripmetic lá se o seu telefone oferecer widgets de tela de bloqueio (nem todos os dispositivos oferecem).';

  @override
  String get widgetInstructionConfigureCta => 'Configurar cidades widget';

  @override
  String get currencyWidgetInstructionTitle => 'Widget Conversor de Moeda';

  @override
  String get currencyWidgetInstructionSubtitle =>
      'Fixe suas moedas base e alvo na tela inicial do Android. As taxas são sincronizadas sempre que você usa o conversor em Tripmetic.';

  @override
  String get currencyWidgetInstructionAndroidTitle =>
      'Adicionar à tela inicial';

  @override
  String get currencyWidgetInstructionAndroidStep1 =>
      'Abra a ferramenta Moeda uma vez e defina suas duas primeiras moedas (base e destino).';

  @override
  String get currencyWidgetInstructionAndroidStep2 =>
      'Vá para a tela inicial e mantenha pressionado uma área vazia.';

  @override
  String get currencyWidgetInstructionAndroidStep3 =>
      'Toque em \"Widgets\", vá até Tripmetic e escolha \"Conversor de moeda\".';

  @override
  String get currencyWidgetInstructionAndroidStep4 =>
      'Arraste o widget para a tela inicial ou toque em Adicionar se o seu iniciador for compatível.';

  @override
  String get currencyWidgetInstructionUsageTitle => 'Usando o widget';

  @override
  String get currencyWidgetInstructionUsageStep1 =>
      'Toque em Alterar (ou no corpo do widget) para abrir a seleção de moeda em Tripmetic.';

  @override
  String get currencyWidgetInstructionUsageStep2 =>
      'Toque em ↻ Atualizar para atualizar as taxas no widget em segundo plano (o aplicativo não abre).';

  @override
  String get currencyWidgetInstructionUsageStep3 =>
      'Os valores são atualizados automaticamente quando você edita moedas ou valores no aplicativo.';

  @override
  String get currencyWidgetInstructionPinCta =>
      'Adicionar widget à tela inicial';

  @override
  String get currencyWidgetInstructionOpenCurrencyCta =>
      'Alterar moedas de widgets';

  @override
  String get currencyWidgetInstructionIosHint =>
      'O widget da tela inicial da moeda está disponível em Android. Em iPhone, use a ferramenta Moeda do aplicativo.';

  @override
  String get currencyWidgetPinUnsupported =>
      'Seu iniciador não suporta a adição deste widget do aplicativo. Mantenha pressionada a tela inicial e escolha Widgets.';

  @override
  String get currencyWidgetPinFailed =>
      'Não foi possível abrir o seletor de widgets. Adicione o widget manualmente na tela inicial.';

  @override
  String get dualClockScreenTitle => 'Widget de relógio duplo';

  @override
  String get dualClockConfigTitle => 'Configurar cidades';

  @override
  String get dualClockConfigSubtitle =>
      'Escolha duas cidades e fusos horários. Suas seleções são sincronizadas com o widget da tela inicial Tripmetic (Android) e o widget da tela de bloqueio (iOS).';

  @override
  String get dualClockCity1Label => 'Primeira cidade';

  @override
  String get dualClockCity2Label => 'Segunda cidade';

  @override
  String get dualClockSave => 'Salvar e atualizar widget';

  @override
  String get dualClockSaved => 'Widget atualizado.';

  @override
  String get dualClockSaveError =>
      'Não foi possível salvar os dados do widget. Por favor, tente novamente.';

  @override
  String get dualClockAppearanceTitle => 'Aparência do widget';

  @override
  String get dualClockAppearanceHint =>
      'Personalize o tamanho do texto, as cores e o plano de fundo da tela inicial. A tela de bloqueio usa tamanho de fonte (e cores onde o sistema permite).';

  @override
  String get dualClockFontScaleLabel => 'Tamanho do texto';

  @override
  String get dualClockColorCity => 'Nomes de cidades';

  @override
  String get dualClockColorTime => 'Tempos';

  @override
  String get dualClockColorDate => 'Datas';

  @override
  String get dualClockColorBackground => 'Plano de fundo inicial';

  @override
  String get dualClockShadowLabel => 'Sombra de texto';

  @override
  String get dualClockShadowSubtitle =>
      'Adiciona contraste em papéis de parede ocupados ou fotográficos.';

  @override
  String get moreToolsDualClockBannerTitle => 'Widget de relógio duplo';

  @override
  String get moreToolsDualClockBannerSubtitle =>
      'Veja dois fusos horários na tela de bloqueio ou na tela inicial – toque para configurar.';

  @override
  String get moreToolsDualClockBannerCta => 'Configurar';

  @override
  String get settingsDualClockWidgetTitle => 'Widget de relógio duplo';

  @override
  String get settingsDualClockWidgetSubtitle =>
      'Adicione o widget e escolha suas cidades';

  @override
  String get widgetNewFeatureBadge => 'Novo';

  @override
  String get globalNavAccountCloudSyncTooltip => 'Backup de conta e nuvem';

  @override
  String get exchangeRatesForceRefreshTooltip =>
      'Obtenha as taxas de câmbio mais recentes';

  @override
  String get exchangeRatesRefreshedOk => 'Taxas de câmbio atualizadas.';

  @override
  String get exchangeRatesRefreshFailed =>
      'Não foi possível atualizar as taxas de câmbio.';

  @override
  String get bucketListStatUsTerritories => 'Territórios dos EUA';

  @override
  String get bucketListAuthErrUserNotFound =>
      'Nenhuma conta encontrada para este e-mail.';

  @override
  String get bucketListAuthErrWrongPassword => 'E-mail ou senha incorretos.';

  @override
  String get bucketListAuthErrEmailInUse =>
      'Já existe uma conta para este e-mail.';

  @override
  String get bucketListAuthErrInvalidEmail => 'Endereço de e-mail inválido.';

  @override
  String get bucketListAuthErrWeakPassword => 'A senha é muito fraca.';

  @override
  String get bucketListAuthErrUserDisabled => 'Esta conta foi desativada.';

  @override
  String get bucketListAuthErrTooManyRequests =>
      'Muitas tentativas. Tente novamente mais tarde.';

  @override
  String get bucketListAuthErrOperationNotAllowed =>
      'O login por e-mail/senha não está ativado.';

  @override
  String bucketListAuthErrDetail(String detail) {
    return '$detail';
  }

  @override
  String get bucketListAuthValidationInvalidEmail =>
      'Endereço de e-mail inválido.';

  @override
  String get bucketListAuthValidationPasswordShort =>
      'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get bucketListAuthValidationPasswordRequired => 'Digite sua senha.';

  @override
  String get currencyWidgetAppearanceTitle => 'Aparência';

  @override
  String get currencyWidgetAppearanceHint =>
      'Personalize o tamanho da fonte, as cores do texto e o plano de fundo da tela inicial. Os widgets iniciais mantêm um tamanho fixo, de modo que fontes grandes se ajustam automaticamente para que todas as linhas permaneçam visíveis. A tela de bloqueio usa tamanho de fonte (e cores onde o sistema permite).';

  @override
  String get currencyWidgetFontScaleLabel => 'Tamanho da fonte';

  @override
  String get currencyWidgetColorPrimary => 'Texto primário (valores/base)';

  @override
  String get currencyWidgetColorAccent =>
      'Texto de destaque (etiquetas de pares/escada)';

  @override
  String get currencyWidgetColorCaption => 'Texto da legenda (linha de taxa)';

  @override
  String get currencyWidgetColorBackground => 'Plano de fundo inicial';

  @override
  String get currencyWidgetSaveAppearance => 'Salvar aparência';

  @override
  String get currencyWidgetAppearanceSaved =>
      'Aparência do widget de moeda salva';

  @override
  String get currencyWidgetAppearanceSaveFailed =>
      'Não foi possível salvar a aparência do widget';

  @override
  String get currencyWidgetInstructionIosTitle => 'iPhone';
}
