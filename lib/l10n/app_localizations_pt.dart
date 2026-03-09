// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get navChannels => 'Canais';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navPlaylists => 'Playlists';

  @override
  String get navSettings => 'Configurações';

  @override
  String get settingsSectionFolders => 'Pastas';

  @override
  String get settingsFolderManage => 'Gerenciar pastas';

  @override
  String get settingsFolderManageDesc => 'Adicionar, editar, excluir pastas';

  @override
  String get settingsSectionDisplay => 'Exibição';

  @override
  String get settingsLanguage => 'Idioma / Language';

  @override
  String get settingsLanguageSystem => 'Sistema (System)';

  @override
  String get settingsChipLayout => 'Layout de pasta';

  @override
  String get settingsChipLayoutSingleLine => 'Linha única';

  @override
  String get settingsChipLayoutWrap => 'Quebrar linha';

  @override
  String get chipLayoutToggleWrap => 'Ver com quebra';

  @override
  String get chipLayoutToggleSingleLine => 'Ver em linha única';

  @override
  String get settingsFolderView => 'Visualização de pasta';

  @override
  String get settingsShowChannelCount => 'Mostrar contagem de canais';

  @override
  String get settingsShowVideoCount => 'Mostrar contagem de vídeos';

  @override
  String get settingsFolderSizeLarge => 'Grande';

  @override
  String get settingsFolderSizeSmall => 'Pequeno';

  @override
  String get settingsDefaultChannelSection => 'Aba do YouTube';

  @override
  String get settingsVideosPerChannel => 'Vídeos por canal';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Exibir legendas';

  @override
  String get settingsCaptionShow => 'Mostrar';

  @override
  String get settingsCaptionHide => 'Ocultar';

  @override
  String get settingsChannelTapAction => 'Ação ao tocar no canal';

  @override
  String get settingsChannelTapLatestVideos => 'Ver últimos vídeos';

  @override
  String get settingsChannelTapOpenYoutube => 'Abrir no YouTube';

  @override
  String get settingsVideoCardTapAction => 'Ação ao tocar no vídeo';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Player integrado';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Abrir no YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Layout do cartão de vídeo';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Cartão horizontal';

  @override
  String get settingsVideoCardLayoutVertical => 'Cartão vertical';

  @override
  String get settingsMenuOrder => 'Ordem do menu';

  @override
  String get settingsMenuOrderDesc => 'Alterar ordem da navegação';

  @override
  String get settingsResetApp => 'Redefinir aplicativo';

  @override
  String get settingsSectionData => 'Dados';

  @override
  String get settingsBackup => 'Backup de dados';

  @override
  String get settingsRestore => 'Restaurar dados';

  @override
  String get settingsClearCache => 'Limpar cache de imagens';

  @override
  String get settingsSectionInfo => 'Informações';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicense => 'Licenças de código aberto';

  @override
  String get settingsSectionAccount => 'Conta';

  @override
  String get settingsGoogleAccount => 'Conta Google';

  @override
  String get settingsNotLoggedIn => 'Não conectado';

  @override
  String get settingsLogout => 'Sair';

  @override
  String get addToFolder => 'Adicionar à pasta';

  @override
  String get sectionSettings => 'Aba do YouTube';

  @override
  String subscriberCount(String count) {
    return '$count inscritos';
  }

  @override
  String channelsSelected(int count) {
    return '$count canais selecionados';
  }

  @override
  String itemsSelected(int count) {
    return '$count selecionados';
  }

  @override
  String get timeJustNow => 'Agora';

  @override
  String timeMinutesAgo(int count) {
    return 'há $count min';
  }

  @override
  String timeHoursAgo(int count) {
    return 'há $count h';
  }

  @override
  String timeDaysAgo(int count) {
    return 'há $count d';
  }

  @override
  String timeWeeksAgo(int count) {
    return 'há $count sem';
  }

  @override
  String timeMonthsAgo(int count) {
    return 'há $count mês';
  }

  @override
  String itemCount(int count) {
    return '$count itens';
  }

  @override
  String get deleteConfirmTitle => 'Confirmar exclusão';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Excluir $count vídeos selecionados?';
  }

  @override
  String get deleteFavoriteConfirm => 'Remover dos favoritos?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get selectAll => 'Selecionar tudo';

  @override
  String get select => 'Selecionar';

  @override
  String timeYearsAgo(int count) {
    return 'há $count ano(s)';
  }

  @override
  String videoCount(int count) {
    return '$count vídeos';
  }

  @override
  String channelCount(int count) {
    return '$count canais';
  }

  @override
  String playlistCount(int count) {
    return '$count playlists carregadas';
  }

  @override
  String get removeFromFolder => 'Remover da pasta';

  @override
  String get deleteChannel => 'Excluir canal';

  @override
  String deleteChannelConfirm(String name) {
    return 'Excluir completamente $name?\nSerá removido de todas as pastas.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Remover $name desta pasta?\nContinuará nas suas inscrições.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Excluir completamente $count canais?\nSerão removidos de todas as pastas.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Remover $count canais desta pasta?\nContinuarão nas suas inscrições.';
  }

  @override
  String get channelDeleted => 'Canal excluído';

  @override
  String get removedFromFolder => 'Removido da pasta';

  @override
  String addedToFolder(String name) {
    return 'Adicionado a $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count canais excluídos';
  }

  @override
  String channelsRemoved(int count) {
    return '$count canais removidos';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count canais adicionados a $name';
  }

  @override
  String get cannotOpenChannel => 'Não é possível abrir o canal';

  @override
  String get pleaseSelectChannels => 'Por favor selecione canais';

  @override
  String get createFolderFirst => 'Por favor crie uma pasta primeiro';

  @override
  String get createCategoryFirst => 'Por favor crie uma categoria primeiro';

  @override
  String get unsubscribed => 'Desinscrito';

  @override
  String uploadedAgo(String time) {
    return 'enviado $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nConfigurações da seção';
  }

  @override
  String useDefaultSection(String section) {
    return 'Usar padrão ($section)';
  }

  @override
  String get sectionSetToDefault => 'Seção definida como padrão';

  @override
  String sectionSetTo(String section) {
    return 'Definido para seção $section';
  }

  @override
  String get channelsUpdated => 'Lista de canais atualizada';

  @override
  String get noSubscriptions => 'Sem canais inscritos';

  @override
  String get noSearchResults => 'Sem resultados';

  @override
  String get cannotLoadPlaylists => 'Não é possível carregar playlists';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get noPlaylists => 'Sem playlists';

  @override
  String get noVideos => 'Sem vídeos';

  @override
  String get noFavorites => 'Sem vídeos favoritos';

  @override
  String get customOrder => 'Ordem personalizada';

  @override
  String get alphabetical => 'Alfabética';

  @override
  String get multiSelect => 'Seleção múltipla';

  @override
  String get openInYoutube => 'Abrir no YouTube';

  @override
  String get latestVideos => 'Últimos vídeos';

  @override
  String formatTenThousand(String count) {
    return '$count mil';
  }

  @override
  String formatThousand(String count) {
    return '$count mil';
  }

  @override
  String formatMillion(String count) {
    return '$count mi';
  }

  @override
  String get dialogLogoutTitle => 'Sair';

  @override
  String get dialogLogoutContent => 'Tem certeza que deseja sair?';

  @override
  String get dialogResetAppTitle => 'Redefinir aplicativo';

  @override
  String get dialogResetAppContent =>
      'Todos os dados serão excluídos, incluindo inscrições, pastas, favoritos e playlists.\n\nDeseja redefinir o aplicativo?';

  @override
  String get dialogResetAppSuccess => 'O aplicativo foi redefinido.';

  @override
  String get dialogClearCacheTitle => 'Limpar cache';

  @override
  String get dialogClearCacheContent =>
      'Limpar cache de imagens?\nAs imagens serão recarregadas ao reiniciar o app.';

  @override
  String get dialogClearCacheSuccess => 'Cache de imagens limpo.';

  @override
  String get dialogClearCacheFailed => 'Falha ao limpar cache';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Backup concluído.\nSalvo em: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Backup cancelado.';

  @override
  String get dialogBackupFailed => 'Falha no backup';

  @override
  String get dialogRestoreTitle => 'Restaurar dados';

  @override
  String get dialogRestoreContent =>
      'Restaurar dados do backup?\nA ordem e pastas existentes podem mudar.';

  @override
  String get dialogRestoreSuccess => 'Restauração concluída.';

  @override
  String get dialogRestoreFailed => 'Falha na restauração';

  @override
  String get folderCreate => 'Criar pasta';

  @override
  String get folderEdit => 'Editar pasta';

  @override
  String get folderDelete => 'Excluir pasta';

  @override
  String get folderName => 'Nome da pasta';

  @override
  String get folderCreated => 'Pasta criada.';

  @override
  String get folderUpdated => 'Pasta atualizada.';

  @override
  String get folderDeleted => 'Pasta excluída.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Excluir pasta \"$name\"?';
  }

  @override
  String get folderManage => 'Gerenciar pastas';

  @override
  String get folderEmpty => 'Sem pastas';

  @override
  String get folderCreateNew => 'Criar pasta';

  @override
  String get create => 'Criar';

  @override
  String get edit => 'Editar';

  @override
  String get sectionHome => 'Início';

  @override
  String get sectionVideos => 'Vídeos';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Ao vivo';

  @override
  String get sectionPodcasts => 'Podcasts';

  @override
  String get sectionPlaylists => 'Playlists';

  @override
  String get sectionCommunity => 'Comunidade';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Ocorreu um erro desconhecido.';

  @override
  String get errorNetwork => 'Por favor verifique sua conexão com a internet.';

  @override
  String get errorUnauthorized => 'A sessão expirou.';

  @override
  String get errorQuotaExceeded =>
      'Cota diária da API do YouTube excedida.\nPor favor tente após as 17h (horário da Coreia) amanhã.';

  @override
  String get errorNotFound => 'Os dados solicitados não foram encontrados.';

  @override
  String get errorTimeout => 'A solicitação expirou.';

  @override
  String errorGeneric(String error) {
    return 'Ocorreu um erro: $error';
  }

  @override
  String get appSubtitle => 'Gerenciador de inscrições do YouTube';

  @override
  String get loadingVideos => 'Carregando vídeos...';

  @override
  String get allChannelsFilter => 'Inscrito';

  @override
  String get showFolderFab => 'Mostrar botão de pasta';

  @override
  String get hideFolderFab => 'Ocultar botão de pasta';

  @override
  String get refreshSubscriptions => 'Atualizar inscrições';

  @override
  String get refreshPlaylists => 'Atualizar playlists';

  @override
  String get fetchSubscriptionsTitle => 'Sem Inscrições';

  @override
  String get fetchSubscriptionsMessage =>
      'Deseja buscar suas inscrições do YouTube?';

  @override
  String get fetchSubscriptionsYes => 'Buscar';

  @override
  String get fetchSubscriptionsNo => 'Depois';

  @override
  String get createFolderDialogTitle => 'Sem Pastas';

  @override
  String get createFolderDialogMessage => 'Deseja criar uma pasta?';

  @override
  String get createFolderDialogYes => 'Criar';

  @override
  String get createFolderDialogNo => 'Depois';

  @override
  String get createFolderDialogDontShowAgain => 'Não mostrar novamente';

  @override
  String get createFolderDialogManualGuide =>
      'Você pode adicionar pastas depois em Configurações > Gerenciar pastas.';

  @override
  String get swipeEnabledDescription =>
      'Apenas pastas marcadas são acessíveis ao deslizar';

  @override
  String get filterByChannel => 'Filtrar por canal';

  @override
  String get allChannels => 'Todos';

  @override
  String get errorDetail => 'Detalhes do erro';

  @override
  String get viewErrorMessage => 'Ver mensagem de erro';

  @override
  String get sortDialogTitle => 'Ordenar';

  @override
  String get sortPlaylistOrder => 'Ordem da playlist';

  @override
  String get sortPlaylistOrderReverse => 'Ordem inversa da playlist';

  @override
  String get sortNewest => 'Mais recentes';

  @override
  String get sortOldest => 'Mais antigos';

  @override
  String get sortTitle => 'Título';

  @override
  String get loginSubtitle => 'Organize livremente suas\ninscrições do YouTube';

  @override
  String get loginWithGoogle => 'Entrar com Google';

  @override
  String get loggingIn => 'Entrando...';

  @override
  String get loginPermissionNotice =>
      'Permissão de leitura do YouTube necessária';

  @override
  String get loadingSubscriptions => 'Carregando inscrições...';

  @override
  String get loginFailed => 'Falha no login.';

  @override
  String get longPressReorder => 'Toque longo: Reordenar';

  @override
  String get longPressDelete => 'Toque longo: Excluir';

  @override
  String get showDeleteConfirmation => 'Mostrar confirmação ao excluir';
}
