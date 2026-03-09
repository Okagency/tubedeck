# TubeDeck Localization Guide

This document lists all localized strings in TubeDeck for adding new language support.

## Supported Languages

| Code | Language | File |
|------|----------|------|
| `en` | English | `app_en.arb` |
| `ko` | 한국어 (Korean) | `app_ko.arb` |
| `ja` | 日本語 (Japanese) | `app_ja.arb` |

## Adding a New Language

1. Create a new ARB file in `lib/l10n/` (e.g., `app_de.arb` for German)
2. Copy all keys from `app_en.arb` (English is the template)
3. Translate each value
4. Run `flutter gen-l10n` to regenerate localization files
5. Add the locale to `lib/providers/locale_provider.dart` in `SupportedLocale` enum

## Localization Keys

### App Info
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `appSubtitle` | YouTube Subscription Manager | YouTube 구독 채널 관리 | App subtitle on splash screen |

### Navigation
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `navChannels` | Channels | 구독 | Navigation - channels tab |
| `navFeed` | Feed | 새 영상 | Navigation - feed tab |
| `navFavorites` | Favorites | 즐겨찾기 | Navigation - favorites tab |
| `navPlaylists` | Playlists | 재생목록 | Navigation - playlists tab |
| `navSettings` | Settings | 설정 | Navigation - settings tab |

### Settings - Section Headers
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsSectionCollections` | Collections | 컬렉션 | Settings section header |
| `settingsSectionDisplay` | Display | 표시 | Settings section header |
| `settingsSectionData` | Data | 데이터 | Settings section header |
| `settingsSectionInfo` | Information | 정보 | Settings section header |
| `settingsSectionAccount` | Account | 계정 | Settings section header |

### Settings - Collections
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsCollectionManage` | Manage Collections | 컬렉션 관리 | Settings item title |
| `settingsCollectionManageDesc` | Add, edit, delete collections | 컬렉션 추가, 수정, 삭제 | Settings item description |

### Settings - Display
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsLanguage` | Language / 언어 | 언어 / Language | Language setting (bilingual) |
| `settingsLanguageSystem` | System (시스템 설정) | 시스템 설정 (System) | System language option |
| `settingsChipLayout` | Chip Layout | 칩 레이아웃 | Chip layout setting |
| `settingsChipLayoutSingleLine` | Single Line | 한줄 | Single line option |
| `settingsChipLayoutWrap` | Wrap | 줄바꿈 | Wrap option |
| `settingsDefaultChannelSection` | Default Channel Section | 기본 채널 섹션 | Default section setting |
| `settingsVideosPerChannel` | Videos per Channel | 채널당 영상 개수 | Videos per channel setting |
| `settingsVideosPerChannelCount` | {count} | {count}개 | Video count format |
| `settingsCaptionDisplay` | Caption Display | 자막 표시 | Caption setting |
| `settingsCaptionShow` | Show | 표시 | Show captions |
| `settingsCaptionHide` | Hide | 숨김 | Hide captions |
| `settingsChannelTapAction` | Channel Tap Action | 채널 탭 액션 | Channel tap action setting |
| `settingsChannelTapLatestVideos` | View Latest Videos | 최신 영상 보기 | View latest videos option |
| `settingsChannelTapOpenYoutube` | Open in YouTube | 유튜브에서 열기 | Open in YouTube option |
| `settingsVideoCardTapAction` | Video Card Tap Action | 영상 카드 탭 액션 | Video card tap setting |
| `settingsVideoCardTapInAppPlayer` | In-App Player | 인앱 재생 | In-app player option |
| `settingsVideoCardTapOpenYoutube` | Open in YouTube | 유튜브에서 열기 | Open in YouTube option |
| `settingsVideoCardLayoutStyle` | Video Card Layout | 영상 카드 레이아웃 | Video card layout setting |
| `settingsVideoCardLayoutHorizontal` | Horizontal Card | 가로 카드 | Horizontal layout |
| `settingsVideoCardLayoutVertical` | Vertical Card | 세로 카드 | Vertical layout |
| `settingsMenuOrder` | Menu Order | 메뉴 순서 | Menu order setting |
| `settingsMenuOrderDesc` | Change bottom navigation bar order | 하단 네비게이션 바 순서 변경 | Menu order description |
| `settingsResetDisplay` | Reset Display Settings | 표시 설정 초기화 | Reset display settings |

### Settings - Data
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsBackup` | Backup Data | 데이터 백업 | Backup setting |
| `settingsRestore` | Restore Data | 데이터 복원 | Restore setting |
| `settingsClearCache` | Clear Image Cache | 이미지 캐시 삭제 | Clear cache setting |

### Settings - Info
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsVersion` | Version | 버전 | Version info |
| `settingsLicense` | Open Source Licenses | 오픈소스 라이선스 | License info |

### Settings - Account
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `settingsGoogleAccount` | Google Account | Google 계정 | Google account setting |
| `settingsNotLoggedIn` | Not logged in | 로그인되지 않음 | Not logged in status |
| `settingsLogout` | Logout | 로그아웃 | Logout button |

### Dialogs - Logout
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `dialogLogoutTitle` | Logout | 로그아웃 | Logout dialog title |
| `dialogLogoutContent` | Are you sure you want to logout? | 로그아웃하시겠습니까? | Logout confirmation |

### Dialogs - Reset Display
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `dialogResetDisplayTitle` | Reset Display Settings | 표시 설정 초기화 | Reset dialog title |
| `dialogResetDisplayContent` | Reset all display settings to default? | 표시 설정을 기본값으로 되돌리시겠습니까? | Reset confirmation |
| `dialogResetDisplaySuccess` | Display settings have been reset. | 표시 설정이 초기화되었습니다. | Reset success message |

### Dialogs - Clear Cache
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `dialogClearCacheTitle` | Clear Cache | 캐시 삭제 | Clear cache dialog title |
| `dialogClearCacheContent` | Clear image cache?\nImages will be reloaded when you restart the app. | 이미지 캐시를 삭제하시겠습니까?\n앱을 다시 시작하면 이미지가 다시 로드됩니다. | Clear cache confirmation |
| `dialogClearCacheSuccess` | Image cache cleared. | 이미지 캐시가 삭제되었습니다. | Clear cache success |
| `dialogClearCacheFailed` | Failed to clear cache | 캐시 삭제에 실패했습니다 | Clear cache error |

### Dialogs - Backup/Restore
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `dialogBackupSuccess` | Backup completed.\nSaved to: {filePath} | 백업이 완료되었습니다.\n저장 위치: {filePath} | Backup success message |
| `dialogBackupCancelled` | Backup cancelled. | 백업이 취소되었습니다. | Backup cancelled message |
| `dialogBackupFailed` | Backup failed | 백업 실패 | Backup error |
| `dialogRestoreTitle` | Restore Data | 데이터 복원 | Restore dialog title |
| `dialogRestoreContent` | Restore data from backup file?\nExisting sort order and collections may be changed. | 백업 파일에서 데이터를 복원하시겠습니까?\n기존 정렬 순서와 컬렉션이 변경될 수 있습니다. | Restore confirmation |
| `dialogRestoreSuccess` | Restore completed. | 복원이 완료되었습니다. | Restore success message |
| `dialogRestoreFailed` | Restore failed | 복원 실패 | Restore error |

### Collection Management
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `collectionCreate` | Create Collection | 컬렉션 생성 | Create collection dialog title |
| `collectionEdit` | Edit Collection | 컬렉션 수정 | Edit collection dialog title |
| `collectionDelete` | Delete Collection | 컬렉션 삭제 | Delete collection dialog title |
| `collectionName` | Collection name | 컬렉션 이름 | Collection name field label |
| `collectionCreated` | Collection created. | 컬렉션이 생성되었습니다. | Collection created message |
| `collectionUpdated` | Collection updated. | 컬렉션이 수정되었습니다. | Collection updated message |
| `collectionDeleted` | Collection deleted. | 컬렉션이 삭제되었습니다. | Collection deleted message |
| `collectionDeleteConfirm` | Delete "{name}" collection? | "{name}" 컬렉션을 삭제하시겠습니까? | Delete confirmation |
| `collectionManage` | Manage Collections | 컬렉션 관리 | Collection manage screen title |
| `collectionEmpty` | No collections | 컬렉션이 없습니다 | Empty state message |
| `collectionCreateNew` | Create collection | 컬렉션 만들기 | Create collection button |

### Channel Sections
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `sectionHome` | Home | 홈 | Home section |
| `sectionVideos` | Videos | 동영상 | Videos section |
| `sectionShorts` | Shorts | Shorts | Shorts section |
| `sectionLive` | Live | 라이브 | Live section |
| `sectionPodcasts` | Podcasts | 팟캐스트 | Podcasts section |
| `sectionPlaylists` | Playlists | 재생목록 | Playlists section |
| `sectionCommunity` | Community | 게시물 | Community section |

### Common Actions
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `cancel` | Cancel | 취소 | Cancel button |
| `confirm` | OK | 확인 | Confirm/OK button |
| `delete` | Delete | 삭제 | Delete button |
| `create` | Create | 생성 | Create button |
| `edit` | Edit | 수정 | Edit button |
| `select` | Select | 선택 | Select button |
| `selectAll` | Select All | 전체 선택 | Select all button |
| `retry` | Retry | 다시 시도 | Retry button |

### Time Formats
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `timeJustNow` | Just now | 방금 전 | Just now |
| `timeMinutesAgo` | {count}m ago | {count}분 전 | Minutes ago |
| `timeHoursAgo` | {count}h ago | {count}시간 전 | Hours ago |
| `timeDaysAgo` | {count}d ago | {count}일 전 | Days ago |
| `timeWeeksAgo` | {count}w ago | {count}주 전 | Weeks ago |
| `timeMonthsAgo` | {count}mo ago | {count}개월 전 | Months ago |
| `timeYearsAgo` | {count}y ago | {count}년 전 | Years ago |

### Count Formats
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `videoCount` | {count} videos | {count}개 영상 | Video count |
| `channelCount` | {count} channels | {count}개 채널 | Channel count |
| `playlistCount` | {count} playlists loaded | {count}개 재생목록 로드 완료 | Playlist count |
| `itemCount` | {count} items | {count}개 | Item count |
| `subscriberCount` | {count} subscribers | 구독자 {count}명 | Subscriber count |
| `channelsSelected` | {count} channels selected | {count}개 채널 선택됨 | Selected channels count |
| `itemsSelected` | {count} selected | {count}개 선택됨 | Selected items count |

### Number Formats (for large numbers)
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `formatTenThousand` | {count}K | {count}만 | 10,000+ format |
| `formatThousand` | {count}K | {count}천 | 1,000+ format |
| `formatMillion` | {count}M | {count}만 | 1,000,000+ format |

### Channel/Video Actions
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `addToCollection` | Add to Collection | 컬렉션에 추가 | Add to collection menu |
| `removeFromCollection` | Remove from Collection | 컬렉션에서 제거 | Remove from collection |
| `deleteChannel` | Delete Channel | 채널 삭제 | Delete channel menu |
| `openInYoutube` | Open in YouTube | 유튜브에서 열기 | Open in YouTube |
| `latestVideos` | Latest videos | 최신 영상 | Latest videos menu |
| `multiSelect` | Multi select | 멀티 선택 | Multi select mode |
| `customOrder` | Custom order | 사용자 지정 순서 | Custom order mode |
| `alphabetical` | Alphabetical | 가나다순 | Alphabetical order |

### Channel Actions Confirmation
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `deleteChannelConfirm` | Are you sure you want to completely delete {name}?\nIt will be removed from all collections. | {name}을(를) 완전히 삭제하시겠습니까?\n모든 컬렉션에서도 제거됩니다. | Delete channel confirmation |
| `removeChannelConfirm` | Are you sure you want to remove {name} from this collection?\nIt will remain in your subscriptions. | {name}을(를) 이 컬렉션에서 제거하시겠습니까?\n구독메뉴에는 유지됩니다. | Remove from collection |
| `deleteChannelsConfirm` | Are you sure you want to completely delete {count} channels?\nThey will be removed from all collections. | 선택한 {count}개 채널을 완전히 삭제하시겠습니까?\n모든 컬렉션에서도 제거됩니다. | Delete multiple channels |
| `removeChannelsConfirm` | Are you sure you want to remove {count} channels from this collection?\nThey will remain in your subscriptions. | 선택한 {count}개 채널을 이 컬렉션에서 제거하시겠습니까?\n구독메뉴에는 유지됩니다. | Remove multiple channels |

### Channel Action Messages
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `channelDeleted` | Channel deleted | 채널이 삭제되었습니다 | Channel deleted message |
| `removedFromCollection` | Removed from collection | 컬렉션에서 제거되었습니다 | Removed message |
| `addedToCollection` | Added to {name} | {name}에 추가되었습니다 | Added message |
| `channelsDeleted` | {count} channels deleted | {count}개 채널이 삭제되었습니다 | Multiple deleted message |
| `channelsRemoved` | {count} channels removed | {count}개 채널이 제거되었습니다 | Multiple removed message |
| `channelsAddedTo` | {count} channels added to {name} | {count}개 채널이 {name}에 추가되었습니다 | Multiple added message |
| `channelsUpdated` | Channel list updated | 채널 목록이 업데이트되었습니다 | Channels updated message |

### Section Settings
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `sectionSettings` | Section Settings | 섹션 설정 | Section settings menu |
| `sectionSettingsTitle` | {title}\nSection Settings | {title}\n섹션 설정 | Section settings dialog title |
| `useDefaultSection` | Use default ({section}) | 기본값 사용 ({section}) | Use default option |
| `sectionSetToDefault` | Section set to default | 섹션이 기본값으로 설정되었습니다 | Default set message |
| `sectionSetTo` | Set to {section} section | {section} 섹션으로 설정되었습니다 | Section set message |

### Favorites
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `deleteConfirmTitle` | Delete | 삭제 확인 | Delete confirm title |
| `deleteSelectedVideosConfirm` | Delete {count} selected videos? | 선택한 {count}개의 영상을 삭제하시겠습니까? | Delete videos confirm |
| `deleteFavoriteConfirm` | Remove from favorites? | 즐겨찾기에서 삭제하시겠습니까? | Remove favorite confirm |

### Empty States
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `noSubscriptions` | No subscribed channels | 구독 채널이 없습니다 | No subscriptions message |
| `noSearchResults` | No search results | 검색 결과가 없습니다 | No search results |
| `cannotLoadPlaylists` | Cannot load playlists | 재생목록을 불러올 수 없습니다 | Playlist load error |
| `noPlaylists` | No playlists | 재생목록이 없습니다 | No playlists message |
| `noVideos` | No videos | 영상이 없습니다 | No videos message |

### Loading States
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `loadingVideos` | Loading videos... | 영상을 가져오는 중... | Loading videos message |

### Filter Chips
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `allChannelsFilter` | Subscribed | 구독 | All channels filter chip label |

### Other
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `cannotOpenChannel` | Cannot open channel | 채널을 열 수 없습니다 | Channel open error |
| `pleaseSelectChannels` | Please select channels | 채널을 선택해주세요 | Select channels prompt |
| `createCollectionFirst` | Please create a collection first | 먼저 컬렉션을 만들어주세요 | Create collection prompt |
| `createCategoryFirst` | Please create a category first | 먼저 카테고리를 만들어주세요 | Create category prompt |
| `unsubscribed` | Unsubscribed | 미구독 | Unsubscribed status |
| `uploadedAgo` | uploaded {time} | {time} 업로드 | Upload time format |

### Error Messages
| Key | English | Korean | Description |
|-----|---------|--------|-------------|
| `errorUnknown` | An unknown error occurred. | 알 수 없는 오류가 발생했습니다. | Unknown error |
| `errorNetwork` | Please check your internet connection. | 인터넷 연결을 확인해주세요. | Network error |
| `errorUnauthorized` | Login has expired. | 로그인이 만료되었습니다. | Auth expired error |
| `errorQuotaExceeded` | YouTube API daily quota exceeded.\nPlease try again after 5 PM (Korea time) tomorrow. | YouTube API 일일 할당량이 초과되었습니다.\n내일 오후 5시(한국 시간)에 다시 시도해주세요. | API quota exceeded |
| `errorNotFound` | The requested data could not be found. | 요청한 데이터를 찾을 수 없습니다. | Not found error |
| `errorTimeout` | Request timed out. | 요청 시간이 초과되었습니다. | Timeout error |
| `errorGeneric` | An error occurred: {error} | 오류가 발생했습니다: {error} | Generic error with details |

## Code Locations

The localization is implemented in the following files:

- **ARB Files**: `lib/l10n/app_en.arb`, `lib/l10n/app_ko.arb`, `lib/l10n/app_ja.arb`
- **Generated Files**: `lib/l10n/app_localizations.dart`, `lib/l10n/app_localizations_en.dart`, `lib/l10n/app_localizations_ko.dart`, `lib/l10n/app_localizations_ja.dart`
- **Locale Provider**: `lib/providers/locale_provider.dart`
- **Usage Pattern**: `AppLocalizations.of(context)!.keyName`

## Extension Methods with Locale Support

Some models use extension methods for locale-aware display names:

### ChannelSection (lib/models/channel.dart)
```dart
section.getDisplayName(context)  // Locale-aware
section.displayName              // Fallback (English)
```

### NavItem (lib/providers/settings_provider.dart)
```dart
navItem.getDisplayName(context)  // Locale-aware
navItem.displayName              // Fallback (English)
```

### Helpers (lib/utils/helpers.dart)
```dart
// Locale-aware confirmation dialog (uses l10n.cancel and l10n.confirm as defaults)
Helpers.showConfirmDialog(
  context,
  title: l10n.dialogLogoutTitle,
  content: l10n.dialogLogoutContent,
);

// Locale-aware error messages (pass context for localized messages)
Helpers.getErrorMessage(error, context)  // Locale-aware
Helpers.getErrorMessage(error)           // Fallback (English)
```

## Notes for Translators

1. **Placeholders**: Keep `{variable}` placeholders unchanged (e.g., `{count}`, `{name}`, `{filePath}`)
2. **Newlines**: Keep `\n` for line breaks
3. **Consistent Terms**: Maintain consistent translations for common terms across all strings
4. **Context**: Some strings appear in dialogs, some in buttons - consider the context
5. **Length**: Consider UI space constraints for translations
