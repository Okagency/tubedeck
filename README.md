# TubeDeck

YouTube 구독 채널을 자유롭게 정렬하고 관리하는 Flutter 모바일 앱

## 프로젝트 개요

TubeDeck은 YouTube 헤비유저를 위한 구독 채널 관리 앱입니다. 50개 이상의 구독 채널을 효율적으로 정리하고, 컬렉션으로 그룹화하며, 드래그 앤 드롭으로 자유롭게 정렬할 수 있습니다.

## 주요 기능

- ✅ Google OAuth 2.0 인증
- ✅ YouTube Data API v3를 통한 구독 채널 가져오기
- ✅ 드래그 앤 드롭으로 채널 순서 변경
- ✅ 컬렉션(태그)으로 채널 그룹화
- ✅ 로컬 SQLite DB로 정렬 순서 저장
- ✅ 채널 검색 기능
- ✅ Pull-to-refresh로 구독 목록 동기화

## 기술 스택

- **프레임워크**: Flutter 3.16+
- **언어**: Dart 3.0+
- **상태관리**: Riverpod 2.4+
- **데이터베이스**: SQLite
- **API**: YouTube Data API v3
- **인증**: Google Sign-In

## 프로젝트 구조

```
tubedeck/
├── lib/
│   ├── main.dart                     # 앱 진입점
│   ├── config/                       # 설정 파일
│   │   ├── app_config.dart          # API 키, 환경변수
│   │   └── theme.dart               # 테마 정의
│   ├── models/                       # 데이터 모델 (Freezed)
│   │   ├── channel.dart
│   │   ├── collection.dart
│   │   └── user_settings.dart
│   ├── services/                     # 외부 연동 서비스
│   │   ├── youtube_service.dart     # YouTube Data API
│   │   ├── database_service.dart    # SQLite CRUD
│   │   ├── auth_service.dart        # Google OAuth
│   │   └── storage_service.dart     # SharedPreferences
│   ├── providers/                    # Riverpod 상태관리
│   │   ├── auth_provider.dart
│   │   ├── channels_provider.dart
│   │   └── collections_provider.dart
│   ├── screens/                      # 화면
│   │   ├── splash/
│   │   ├── login/
│   │   ├── home/
│   │   ├── collections/
│   │   └── settings/
│   ├── widgets/                      # 재사용 위젯
│   │   ├── channel_card.dart
│   │   └── collection_chip.dart
│   └── utils/                        # 유틸리티
│       ├── constants.dart
│       ├── extensions.dart
│       └── helpers.dart
└── docs/
    └── TubeDeck_Design_Document.md  # 상세 설계 문서
```

## 시작하기

### 사전 요구사항

- Flutter SDK 3.16 이상
- Dart SDK 3.0 이상
- Android Studio 또는 VS Code
- Google Cloud Console 계정 (YouTube API 키 발급용)

### 설치

1. 저장소 클론
```bash
cd tubedeck
```

2. 의존성 설치
```bash
flutter pub get
```

3. Freezed 코드 생성
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Google OAuth 설정

1. [Google Cloud Console](https://console.cloud.google.com/)에서 프로젝트 생성
2. YouTube Data API v3 활성화
3. OAuth 2.0 클라이언트 ID 생성
   - Android: SHA-1 인증서 등록
   - iOS: Bundle ID 등록

4. 환경변수 설정 (빌드 시)
```bash
flutter run --dart-define=YOUTUBE_API_KEY=YOUR_API_KEY --dart-define=ANDROID_CLIENT_ID=YOUR_CLIENT_ID
```

### 실행

```bash
# 개발 모드
flutter run

# 릴리스 빌드
flutter build apk --release
```

## 데이터베이스 스키마

### channels
- id (TEXT PRIMARY KEY): YouTube 채널 ID
- title (TEXT): 채널명
- thumbnail_url (TEXT): 썸네일 URL
- subscriber_count (INTEGER): 구독자 수
- last_upload_date (TEXT): 최근 업로드 날짜
- sort_order (INTEGER): 전역 정렬 순서

### collections
- id (TEXT PRIMARY KEY): UUID
- name (TEXT): 컬렉션명
- color_code (INTEGER): ARGB 색상 코드
- display_order (INTEGER): 표시 순서

### channel_collections
- channel_id (TEXT): 채널 ID
- collection_id (TEXT): 컬렉션 ID

### collection_orders
- collection_id (TEXT): 컬렉션 ID
- channel_id (TEXT): 채널 ID
- sort_order (INTEGER): 컬렉션 내 정렬 순서

## 개발 상태

### ✅ 완료된 기능
- [x] Flutter 프로젝트 초기 설정
- [x] 데이터 모델 정의 (Freezed)
- [x] SQLite 데이터베이스 서비스
- [x] YouTube API 연동
- [x] Google OAuth 인증
- [x] Riverpod 상태관리
- [x] UI 화면 (Splash, Login, Home)
- [x] 채널 카드 컴포넌트
- [x] 컬렉션 관리 화면
- [x] 설정 화면

### 🚧 진행 중
- [ ] 드래그 앤 드롭 햅틱 피드백
- [ ] 채널 상세 메뉴 (컬렉션 추가/제거)
- [ ] 검색 기능 개선
- [ ] 이미지 캐시 관리
- [ ] 데이터 백업/복원

### 📋 예정
- [ ] Android 위젯
- [ ] iOS 버전
- [ ] 알림 기능
- [ ] 통계 대시보드
- [ ] 테마 설정

## 라이선스

이 프로젝트는 개인 프로젝트입니다.

## 참고 문서

- [설계 문서](docs/TubeDeck_Design_Document.md)
- [Flutter 공식 문서](https://flutter.dev/docs)
- [YouTube Data API v3](https://developers.google.com/youtube/v3)
- [Riverpod 공식 문서](https://riverpod.dev)

## 작성자

원펏
