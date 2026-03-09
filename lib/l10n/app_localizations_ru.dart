// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navChannels => 'Каналы';

  @override
  String get navFeed => 'Лента';

  @override
  String get navFavorites => 'Избранное';

  @override
  String get navPlaylists => 'Плейлисты';

  @override
  String get navSettings => 'Настройки';

  @override
  String get settingsSectionFolders => 'Папки';

  @override
  String get settingsFolderManage => 'Управление папками';

  @override
  String get settingsFolderManageDesc => 'Добавить, изменить, удалить папки';

  @override
  String get settingsSectionDisplay => 'Отображение';

  @override
  String get settingsLanguage => 'Язык / Language';

  @override
  String get settingsLanguageSystem => 'Системный (System)';

  @override
  String get settingsChipLayout => 'Расположение папки';

  @override
  String get settingsChipLayoutSingleLine => 'Одна строка';

  @override
  String get settingsChipLayoutWrap => 'Перенос';

  @override
  String get chipLayoutToggleWrap => 'Вид с переносом';

  @override
  String get chipLayoutToggleSingleLine => 'Вид в одну строку';

  @override
  String get settingsFolderView => 'Вид папки';

  @override
  String get settingsShowChannelCount => 'Показать количество каналов';

  @override
  String get settingsShowVideoCount => 'Показать количество видео';

  @override
  String get settingsFolderSizeLarge => 'Большой';

  @override
  String get settingsFolderSizeSmall => 'Маленький';

  @override
  String get settingsDefaultChannelSection => 'Вкладка YouTube';

  @override
  String get settingsVideosPerChannel => 'Видео на канал';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Отображение субтитров';

  @override
  String get settingsCaptionShow => 'Показать';

  @override
  String get settingsCaptionHide => 'Скрыть';

  @override
  String get settingsChannelTapAction => 'Действие при нажатии на канал';

  @override
  String get settingsChannelTapLatestVideos => 'Показать последние видео';

  @override
  String get settingsChannelTapOpenYoutube => 'Открыть в YouTube';

  @override
  String get settingsVideoCardTapAction => 'Действие при нажатии на видео';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Встроенный плеер';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Открыть в YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Макет карточки видео';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Горизонтальная карточка';

  @override
  String get settingsVideoCardLayoutVertical => 'Вертикальная карточка';

  @override
  String get settingsMenuOrder => 'Порядок меню';

  @override
  String get settingsMenuOrderDesc => 'Изменить порядок нижней навигации';

  @override
  String get settingsResetApp => 'Сбросить приложение';

  @override
  String get settingsSectionData => 'Данные';

  @override
  String get settingsBackup => 'Резервная копия';

  @override
  String get settingsRestore => 'Восстановить данные';

  @override
  String get settingsClearCache => 'Очистить кэш изображений';

  @override
  String get settingsSectionInfo => 'Информация';

  @override
  String get settingsVersion => 'Версия';

  @override
  String get settingsLicense => 'Лицензии открытого ПО';

  @override
  String get settingsSectionAccount => 'Аккаунт';

  @override
  String get settingsGoogleAccount => 'Аккаунт Google';

  @override
  String get settingsNotLoggedIn => 'Не авторизован';

  @override
  String get settingsLogout => 'Выйти';

  @override
  String get addToFolder => 'Добавить в папку';

  @override
  String get sectionSettings => 'Вкладка YouTube';

  @override
  String subscriberCount(String count) {
    return '$count подписчиков';
  }

  @override
  String channelsSelected(int count) {
    return '$count каналов выбрано';
  }

  @override
  String itemsSelected(int count) {
    return '$count выбрано';
  }

  @override
  String get timeJustNow => 'Только что';

  @override
  String timeMinutesAgo(int count) {
    return '$count мин назад';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count ч назад';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count дн назад';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count нед назад';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count мес назад';
  }

  @override
  String itemCount(int count) {
    return '$count элементов';
  }

  @override
  String get deleteConfirmTitle => 'Подтверждение удаления';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Удалить $count выбранных видео?';
  }

  @override
  String get deleteFavoriteConfirm => 'Удалить из избранного?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get select => 'Выбрать';

  @override
  String timeYearsAgo(int count) {
    return '$count г назад';
  }

  @override
  String videoCount(int count) {
    return '$count видео';
  }

  @override
  String channelCount(int count) {
    return '$count каналов';
  }

  @override
  String playlistCount(int count) {
    return '$count плейлистов загружено';
  }

  @override
  String get removeFromFolder => 'Удалить из папки';

  @override
  String get deleteChannel => 'Удалить канал';

  @override
  String deleteChannelConfirm(String name) {
    return 'Полностью удалить $name?\nБудет удалён из всех папок.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Удалить $name из этой папки?\nОстанется в ваших подписках.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Полностью удалить $count каналов?\nБудут удалены из всех папок.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Удалить $count каналов из этой папки?\nОстанутся в ваших подписках.';
  }

  @override
  String get channelDeleted => 'Канал удалён';

  @override
  String get removedFromFolder => 'Удалено из папки';

  @override
  String addedToFolder(String name) {
    return 'Добавлено в $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count каналов удалено';
  }

  @override
  String channelsRemoved(int count) {
    return '$count каналов удалено';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count каналов добавлено в $name';
  }

  @override
  String get cannotOpenChannel => 'Не удаётся открыть канал';

  @override
  String get pleaseSelectChannels => 'Пожалуйста, выберите каналы';

  @override
  String get createFolderFirst => 'Сначала создайте папку';

  @override
  String get createCategoryFirst => 'Сначала создайте категорию';

  @override
  String get unsubscribed => 'Отписан';

  @override
  String uploadedAgo(String time) {
    return 'загружено $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nНастройки раздела';
  }

  @override
  String useDefaultSection(String section) {
    return 'По умолчанию ($section)';
  }

  @override
  String get sectionSetToDefault => 'Раздел установлен по умолчанию';

  @override
  String sectionSetTo(String section) {
    return 'Установлен раздел $section';
  }

  @override
  String get channelsUpdated => 'Список каналов обновлён';

  @override
  String get noSubscriptions => 'Нет подписок';

  @override
  String get noSearchResults => 'Нет результатов';

  @override
  String get cannotLoadPlaylists => 'Не удаётся загрузить плейлисты';

  @override
  String get retry => 'Повторить';

  @override
  String get noPlaylists => 'Нет плейлистов';

  @override
  String get noVideos => 'Нет видео';

  @override
  String get noFavorites => 'Нет избранных видео';

  @override
  String get customOrder => 'Пользовательский порядок';

  @override
  String get alphabetical => 'По алфавиту';

  @override
  String get multiSelect => 'Множественный выбор';

  @override
  String get openInYoutube => 'Открыть в YouTube';

  @override
  String get latestVideos => 'Последние видео';

  @override
  String formatTenThousand(String count) {
    return '$countтыс';
  }

  @override
  String formatThousand(String count) {
    return '$countтыс';
  }

  @override
  String formatMillion(String count) {
    return '$countмлн';
  }

  @override
  String get dialogLogoutTitle => 'Выход';

  @override
  String get dialogLogoutContent => 'Вы уверены, что хотите выйти?';

  @override
  String get dialogResetAppTitle => 'Сбросить приложение';

  @override
  String get dialogResetAppContent =>
      'Все данные будут удалены, включая подписки, папки, избранное и плейлисты.\n\nВы хотите сбросить приложение?';

  @override
  String get dialogResetAppSuccess => 'Приложение сброшено.';

  @override
  String get dialogClearCacheTitle => 'Очистить кэш';

  @override
  String get dialogClearCacheContent =>
      'Очистить кэш изображений?\nИзображения будут загружены заново при перезапуске приложения.';

  @override
  String get dialogClearCacheSuccess => 'Кэш изображений очищен.';

  @override
  String get dialogClearCacheFailed => 'Не удалось очистить кэш';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Резервное копирование завершено.\nСохранено в: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Резервное копирование отменено.';

  @override
  String get dialogBackupFailed => 'Ошибка резервного копирования';

  @override
  String get dialogRestoreTitle => 'Восстановить данные';

  @override
  String get dialogRestoreContent =>
      'Восстановить данные из резервной копии?\nСуществующий порядок и папки могут измениться.';

  @override
  String get dialogRestoreSuccess => 'Восстановление завершено.';

  @override
  String get dialogRestoreFailed => 'Ошибка восстановления';

  @override
  String get folderCreate => 'Создать папку';

  @override
  String get folderEdit => 'Редактировать папку';

  @override
  String get folderDelete => 'Удалить папку';

  @override
  String get folderName => 'Название папки';

  @override
  String get folderCreated => 'Папка создана.';

  @override
  String get folderUpdated => 'Папка обновлена.';

  @override
  String get folderDeleted => 'Папка удалена.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Удалить папку \"$name\"?';
  }

  @override
  String get folderManage => 'Управление папками';

  @override
  String get folderEmpty => 'Нет папок';

  @override
  String get folderCreateNew => 'Создать папку';

  @override
  String get create => 'Создать';

  @override
  String get edit => 'Редактировать';

  @override
  String get sectionHome => 'Главная';

  @override
  String get sectionVideos => 'Видео';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Трансляции';

  @override
  String get sectionPodcasts => 'Подкасты';

  @override
  String get sectionPlaylists => 'Плейлисты';

  @override
  String get sectionCommunity => 'Сообщество';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Произошла неизвестная ошибка.';

  @override
  String get errorNetwork => 'Проверьте подключение к интернету.';

  @override
  String get errorUnauthorized => 'Сессия истекла.';

  @override
  String get errorQuotaExceeded =>
      'Превышена дневная квота API YouTube.\nПопробуйте снова после 17:00 (по корейскому времени) завтра.';

  @override
  String get errorNotFound => 'Запрошенные данные не найдены.';

  @override
  String get errorTimeout => 'Время запроса истекло.';

  @override
  String errorGeneric(String error) {
    return 'Произошла ошибка: $error';
  }

  @override
  String get appSubtitle => 'Менеджер подписок YouTube';

  @override
  String get loadingVideos => 'Загрузка видео...';

  @override
  String get allChannelsFilter => 'Подписан';

  @override
  String get showFolderFab => 'Показать кнопку папки';

  @override
  String get hideFolderFab => 'Скрыть кнопку папки';

  @override
  String get refreshSubscriptions => 'Обновить подписки';

  @override
  String get refreshPlaylists => 'Обновить плейлисты';

  @override
  String get fetchSubscriptionsTitle => 'Нет подписок';

  @override
  String get fetchSubscriptionsMessage =>
      'Хотите получить ваши подписки YouTube?';

  @override
  String get fetchSubscriptionsYes => 'Получить';

  @override
  String get fetchSubscriptionsNo => 'Позже';

  @override
  String get createFolderDialogTitle => 'Нет папок';

  @override
  String get createFolderDialogMessage => 'Хотите создать папку?';

  @override
  String get createFolderDialogYes => 'Создать';

  @override
  String get createFolderDialogNo => 'Позже';

  @override
  String get createFolderDialogDontShowAgain => 'Больше не показывать';

  @override
  String get createFolderDialogManualGuide =>
      'Вы можете добавить папки позже в Настройки > Управление папками.';

  @override
  String get swipeEnabledDescription =>
      'Только отмеченные папки доступны при свайпе';

  @override
  String get filterByChannel => 'Фильтр по каналу';

  @override
  String get allChannels => 'Все';

  @override
  String get errorDetail => 'Подробности ошибки';

  @override
  String get viewErrorMessage => 'Показать сообщение об ошибке';

  @override
  String get sortDialogTitle => 'Сортировка';

  @override
  String get sortPlaylistOrder => 'Порядок плейлиста';

  @override
  String get sortPlaylistOrderReverse => 'Порядок плейлиста (обратный)';

  @override
  String get sortNewest => 'Новые';

  @override
  String get sortOldest => 'Старые';

  @override
  String get sortTitle => 'По названию';

  @override
  String get loginSubtitle => 'Организуйте свои подписки\nYouTube свободно';

  @override
  String get loginWithGoogle => 'Войти через Google';

  @override
  String get loggingIn => 'Вход...';

  @override
  String get loginPermissionNotice => 'Требуется разрешение на чтение YouTube';

  @override
  String get loadingSubscriptions => 'Загрузка подписок...';

  @override
  String get loginFailed => 'Ошибка входа.';

  @override
  String get longPressReorder => 'Долгое нажатие: Сортировка';

  @override
  String get longPressDelete => 'Долгое нажатие: Удалить';

  @override
  String get showDeleteConfirmation => 'Показывать подтверждение удаления';
}
