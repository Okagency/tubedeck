# TubeDeck 설계 문서

## 프로젝트 개요

### 앱 정보
- **앱명**: TubeDeck
- **설명**: YouTube 구독 채널을 자유롭게 정렬하고 관리하는 모바일 앱
- **패키지명**: com.tubedeck.app
- **타겟**: YouTube 헤비유저, 구독 채널 50개 이상 관리하는 사용자
- **버전**: 1.0.0

### 개발 환경
- **플랫폼**: Android 우선 (iOS 추후)
- **프레임워크**: Flutter 3.16+
- **언어**: Dart 3.0+
- **IDE**: Android Studio 또는 VS Code
- **최소 지원**: Android 7.0 (API 24) 이상

---

## 기술 스택

### 핵심 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 상태관리
  flutter_riverpod: ^2.4.9
  
  # YouTube API
  googleapis: ^13.1.0
  googleapis_auth: ^1.5.1
  google_sign_in: ^6.2.1
  
  # 데이터베이스
  sqflite: ^2.3.0
  path: ^1.8.3
  
  # 네트워크 & 이미지
  http: ^1.1.0
  cached_network_image: ^3.3.1
  
  # URL 열기
  url_launcher: ^6.2.2
  
  # 로컬 저장소
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # UI 관련
  flutter_slidable: ^3.0.1
  shimmer: ^3.0.0
  
  # 유틸리티
  intl: ^0.19.0
  uuid: ^4.2.2
  freezed_annotation: ^2.4.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  freezed: ^2.4.5
  json_serializable: ^6.7.1
```

---

## 아키텍처

### Clean Architecture 기반 3레이어 구조

```
┌─────────────────────────────────────┐
│   Presentation Layer (UI)           │
│   - Screens                         │
│   - Widgets                         │
└──────────────┬──────────────────────┘
               ↓ ↑
┌──────────────┴──────────────────────┐
│   Business Logic Layer              │
│   - Providers (Riverpod)            │
│   - State Management                │
└──────────────┬──────────────────────┘
               ↓ ↑
┌──────────────┴──────────────────────┐
│   Data Layer                        │
│   - Services (API, Database)        │
│   - Models                          │
└─────────────────────────────────────┘
```

### 프로젝트 구조

```
tubedeck/
├── lib/
│   ├── main.dart                       # 앱 진입점
│   ├── config/                         # 설정 파일
│   │   ├── app_config.dart            # API 키, 환경변수
│   │   ├── theme.dart                 # 테마 정의
│   │   └── routes.dart                # 라우팅 설정
│   ├── models/                         # 데이터 모델
│   │   ├── channel.dart               # Channel 모델 (Freezed)
│   │   ├── collection.dart            # Collection 모델
│   │   └── user_settings.dart         # 사용자 설정
│   ├── services/                       # 외부 연동 서비스
│   │   ├── youtube_service.dart       # YouTube Data API v3
│   │   ├── database_service.dart      # SQLite CRUD
│   │   ├── auth_service.dart          # Google OAuth 2.0
│   │   └── storage_service.dart       # SharedPreferences
│   ├── providers/                      # Riverpod 상태관리
│   │   ├── channels_provider.dart     # 채널 상태
│   │   ├── collections_provider.dart  # 컬렉션 상태
│   │   ├── auth_provider.dart         # 인증 상태
│   │   └── ui_state_provider.dart     # UI 상태
│   ├── screens/                        # 화면 단위
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── login/
│   │   │   └── login_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── collections/
│   │   │   └── collection_manage_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   ├── widgets/                        # 재사용 위젯
│   │   ├── channel_card.dart          # 채널 카드
│   │   ├── collection_chip.dart       # 컬렉션 칩
│   │   ├── draggable_list.dart        # 드래그 리스트
│   │   └── custom_app_bar.dart        # 커스텀 앱바
│   └── utils/                          # 유틸리티
│       ├── constants.dart             # 상수
│       ├── extensions.dart            # 확장 메서드
│       └── helpers.dart               # 헬퍼 함수
├── android/
├── ios/
├── assets/
│   └── images/
├── test/
└── pubspec.yaml
```

---

## 데이터베이스 설계 (SQLite)

### ERD

```
┌─────────────┐       ┌──────────────────┐       ┌─────────────┐
│  channels   │───┬───│channel_collections│───┬───│ collections │
└─────────────┘   │   └──────────────────┘   │   └─────────────┘
                  │                            │
                  │   ┌──────────────────┐    │
                  └───│collection_orders │────┘
                      └──────────────────┘
```

### 테이블 스키마

#### 1. channels (채널 정보)
```sql
CREATE TABLE channels (
  id TEXT PRIMARY KEY,              -- YouTube 채널 ID
  title TEXT NOT NULL,              -- 채널명
  thumbnail_url TEXT,               -- 썸네일 URL
  subscriber_count INTEGER,         -- 구독자 수
  last_upload_date TEXT,            -- 최근 업로드 날짜 (ISO 8601)
  sort_order INTEGER NOT NULL,      -- 전역 정렬 순서
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_channels_sort_order ON channels(sort_order);
```

#### 2. collections (컬렉션)
```sql
CREATE TABLE collections (
  id TEXT PRIMARY KEY,              -- UUID
  name TEXT NOT NULL,               -- 컬렉션명
  color_code INTEGER NOT NULL,      -- ARGB 색상 코드
  display_order INTEGER NOT NULL,   -- 컬렉션 표시 순서
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_collections_display_order ON collections(display_order);
```

#### 3. channel_collections (채널-컬렉션 매핑)
```sql
CREATE TABLE channel_collections (
  channel_id TEXT NOT NULL,
  collection_id TEXT NOT NULL,
  PRIMARY KEY (channel_id, collection_id),
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE,
  FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE
);
```

#### 4. collection_orders (컬렉션별 정렬 순서)
```sql
CREATE TABLE collection_orders (
  collection_id TEXT NOT NULL,
  channel_id TEXT NOT NULL,
  sort_order INTEGER NOT NULL,      -- 컬렉션 내 정렬 순서
  PRIMARY KEY (collection_id, channel_id),
  FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
);

CREATE INDEX idx_collection_orders ON collection_orders(collection_id, sort_order);
```

### 정렬 로직
- **전체 보기**: `channels.sort_order` 기준 정렬
- **컬렉션 필터**: `collection_orders.sort_order` 기준 정렬
- **드래그 앤 드롭**: 해당 테이블의 sort_order 일괄 업데이트

---

## 화면 설계

### 1. Splash Screen

**목적**: 초기화 및 로그인 상태 확인

**플로우**:
```
앱 실행
  ↓
로고 표시 (1-2초)
  ↓
로그인 상태 체크
  ↓
┌─────────────┬─────────────┐
│ 로그인 O    │ 로그인 X    │
↓             ↓
Home Screen   Login Screen
```

### 2. Login Screen

**레이아웃**:
```
┌─────────────────────────────┐
│                             │
│         TubeDeck            │
│         [로고]              │
│                             │
│   YouTube 구독 채널을       │
│   자유롭게 정리하세요       │
│                             │
│  ┌───────────────────────┐ │
│  │  Google로 로그인       │ │
│  └───────────────────────┘ │
│                             │
│  YouTube 읽기 권한이        │
│  필요합니다                 │
│                             │
└─────────────────────────────┘
```

**기능**:
- Google Sign-In 버튼
- YouTube 권한 요청 안내
- OAuth 2.0 인증 플로우
- 인증 성공 → YouTube API 구독 목록 fetch → Home

### 3. Home Screen (메인)

**레이아웃**:
```
┌─────────────────────────────────────┐
│ [≡] TubeDeck      [🔍] [새로고침] [⚙️] │ AppBar
├─────────────────────────────────────┤
│ 칩: [전체] [개발] [뉴스] [엔터]...   │ 컬렉션 필터
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ [썸네일]  채널명              [⋮]│ │ 드래그 핸들
│ │  80x80    구독자 12.5만         │ │
│ │           3일 전 · [개발][뉴스] │ │
│ └─────────────────────────────────┘ │
│ ┌─────────────────────────────────┐ │
│ │ [썸네일]  또다른 채널          [⋮]│ │
│ │  80x80    구독자 5.2만          │ │
│ │           1주 전 · [엔터]       │ │
│ └─────────────────────────────────┘ │
│                ...                  │
│                                     │
└─────────────────────────────────────┘
```

**기능**:
- **드래그 앤 드롭**: ReorderableListView로 구현
  - 길게 누르면 드래그 시작
  - 드래그 중 카드 반투명 + 그림자
  - 드롭 위치에 파란색 라인 표시
  - 햅틱 피드백 (진동)
- **채널 카드 터치**: YouTube 앱/브라우저 열기
- **채널 카드 슬라이드**: 컬렉션 추가/제거, 구독 취소
- **상단 검색**: 채널명 실시간 필터링
- **Pull-to-refresh**: YouTube API 재호출
- **컬렉션 칩 필터**: 선택한 컬렉션의 채널만 표시

**채널 카드 상세**:
```
┌─────────────────────────────────┐
│ [썸네일]  채널명              [⋮]│
│  80x80    ㄴ 최대 2줄 표시      │
│           구독자 12.5만         │
│           3일 전 업로드         │
│           [개발] [뉴스]         │
└─────────────────────────────────┘
```
- 썸네일: 80x80 dp, 둥근 사각형
- 채널명: 최대 2줄, 넘으면 ellipsis
- 구독자 수: K/M 단위 표시
- 최근 업로드: 상대 시간 (3일 전, 1주 전)
- 컬렉션 태그: Chip, 최대 3개 표시 (+N)

**우클릭/슬라이드 메뉴**:
- 컬렉션에 추가
- 컬렉션에서 제거
- 채널 페이지 열기
- 구독 취소

### 4. Collection Manage Screen

**레이아웃**:
```
┌─────────────────────────────────────┐
│ [←] 컬렉션 관리               [+]    │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ [🔴] 개발         채널 15개  [⋮] │ │
│ └─────────────────────────────────┘ │
│ ┌─────────────────────────────────┐ │
│ │ [🟢] 뉴스         채널 8개   [⋮] │ │
│ └─────────────────────────────────┘ │
│ ┌─────────────────────────────────┐ │
│ │ [🔵] 엔터         채널 23개  [⋮] │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

**기능**:
- 컬렉션 생성/수정/삭제
- 각 컬렉션의 채널 수 표시
- 색상 선택 (Color Picker)
- 드래그로 컬렉션 순서 변경
- 컬렉션 클릭 → 해당 컬렉션 채널 목록

### 5. Settings Screen

**레이아웃**:
```
┌─────────────────────────────────────┐
│ [←] 설정                            │
├─────────────────────────────────────┤
│ 계정                                │
│   Google 계정: user@gmail.com       │
│   [로그아웃]                        │
├─────────────────────────────────────┤
│ 동기화                              │
│   자동 새로고침: 3시간마다          │
│   마지막 동기화: 2시간 전           │
├─────────────────────────────────────┤
│ 표시                                │
│   테마: 시스템 설정 따름            │
│   채널 카드 크기: 보통              │
├─────────────────────────────────────┤
│ 데이터                              │
│   이미지 캐시 삭제                  │
│   정렬 데이터 백업                  │
│   정렬 데이터 복원                  │
├─────────────────────────────────────┤
│ 정보                                │
│   버전: 1.0.0                       │
│   오픈소스 라이선스                 │
│   피드백 보내기                     │
└─────────────────────────────────────┘
```

**기능**:
- 로그아웃
- 자동 새로고침 간격 (1시간/3시간/6시간/수동)
- 테마 선택 (라이트/다크/시스템)
- 캐시 삭제
- 정렬 데이터 백업/복원 (JSON)
- 앱 정보, 라이선스

---

## YouTube API 연동

### 사용 API

#### 1. subscriptions.list
- **목적**: 구독 채널 목록 가져오기
- **파라미터**: 
  - part: snippet, contentDetails
  - mine: true
  - maxResults: 50 (최대)
- **비용**: 호출당 1 unit

#### 2. channels.list
- **목적**: 채널 상세 정보 (구독자 수, 최근 활동)
- **파라미터**:
  - part: snippet, statistics, contentDetails
  - id: 채널 ID 리스트 (최대 50개)
- **비용**: 호출당 1 unit

#### 3. search.list (옵션)
- **목적**: 최근 업로드 영상 확인
- **파라미터**:
  - part: snippet
  - channelId: 채널 ID
  - order: date
  - maxResults: 1
- **비용**: 호출당 100 units (비쌈!)

### API 호출 전략

**초기 로드**:
```
1. subscriptions.list 호출 (페이지네이션)
   - 50개씩 가져오기
   - nextPageToken으로 반복
   ↓
2. 전체 채널 ID 수집
   ↓
3. channels.list로 상세 정보 (50개씩 배치)
   ↓
4. SQLite DB에 저장
```

**증분 업데이트**:
```
1. 기존 DB의 채널 ID 목록 가져오기
   ↓
2. API로 현재 구독 목록 가져오기
   ↓
3. 차이 계산
   - 신규 구독: DB에 추가
   - 구독 취소: DB에서 삭제
   ↓
4. 변경된 것만 channels.list 호출
```

### API 할당량 관리

**할당량**: 1일 10,000 units

**예상 사용량**:
- 구독 100개 초기 로드: 약 100 units
- 증분 업데이트: 약 20 units
- 여유롭게 하루 5회 새로고침 가능

**에러 처리**:
- **네트워크 오류**: 로컬 DB 데이터로 계속 작동
- **401 인증 오류**: 재로그인 유도
- **403 할당량 초과**: Toast 메시지 + 로컬 데이터 사용
- **429 Rate Limit**: 백오프 알고리즘 적용

---

## 인증 플로우

### OAuth 2.0 인증

```
1. 사용자가 "Google로 로그인" 버튼 클릭
   ↓
2. Google Sign-In SDK 호출
   ↓
3. Google 계정 선택 화면 (브라우저/인앱)
   ↓
4. YouTube 읽기 권한 허용 요청
   ↓
5. Authorization Code 획득
   ↓
6. Access Token + Refresh Token 교환
   ↓
7. flutter_secure_storage에 토큰 암호화 저장
   ↓
8. YouTube API 사용 가능
```

### 토큰 관리

**저장 위치**: flutter_secure_storage
- Android: Keystore
- iOS: Keychain

**토큰 구조**:
```json
{
  "access_token": "ya29.a0AfH6SMB...",
  "refresh_token": "1//0eXxxx...",
  "expires_in": 3600,
  "token_type": "Bearer"
}
```

**자동 갱신**:
- Access Token 만료 전 자동 갱신
- Refresh Token으로 새 Access Token 발급
- 갱신 실패 시 재로그인 요청

**로그아웃**:
- 토큰 삭제
- DB 초기화 옵션 제공
- Google Sign-In 세션 종료

---

## 데이터 플로우

### 앱 최초 실행 플로우

```
앱 시작
  ↓
Splash Screen
  ↓
로그인 상태 체크 (Secure Storage)
  ↓
┌─────────────┬─────────────┐
│ 토큰 있음   │ 토큰 없음   │
↓             ↓
토큰 유효성   Login Screen
체크          ↓
↓             Google OAuth
┌─┴─┐         ↓
│OK │NG       토큰 저장
↓   ↓         ↓
│   재로그인  YouTube API 호출
│   ←─────────┤
│             ↓
│         구독 목록 fetch
│             ↓
│         채널 상세 정보 fetch
│             ↓
│         SQLite DB 저장
│             ↓
└─────────────┘
      ↓
  Home Screen
```

### 드래그 앤 드롭 플로우

```
사용자가 채널 카드 길게 누름
  ↓
드래그 모드 활성화
  ↓
카드 반투명 + 그림자
  ↓
손가락 이동
  ↓
드롭 위치에 파란색 라인 표시
  ↓
손가락 뗌 (드롭)
  ↓
새 위치 계산
  ↓
┌───────────────────────────┐
│ 전체 보기 모드            │
│ channels.sort_order 업데이트│
└───────────────────────────┘
┌───────────────────────────┐
│ 컬렉션 필터 모드          │
│ collection_orders.sort_order│
│ 업데이트                  │
└───────────────────────────┘
  ↓
DB 트랜잭션으로 일괄 저장
  ↓
UI 즉시 반영
  ↓
햅틱 피드백 (진동)
```

### 새로고침 플로우

```
사용자가 새로고침 버튼 클릭
또는
Pull-to-refresh 제스처
  ↓
로딩 인디케이터 표시
  ↓
YouTube API 호출
  ↓
현재 구독 목록 가져오기
  ↓
DB의 기존 목록과 비교
  ↓
┌─────────┬──────────┬─────────┐
│ 신규    │ 삭제됨   │ 변경됨  │
↓         ↓          ↓
DB INSERT DB DELETE  DB UPDATE
└─────────┴──────────┴─────────┘
  ↓
sort_order 재정렬
(기존 순서 최대한 유지)
  ↓
UI 업데이트
  ↓
"N개 채널 업데이트됨" Toast
```

---

## UI/UX 상세

### 테마

**라이트 모드**:
```dart
Primary: #2196F3 (Blue)
Secondary: #03DAC6 (Teal)
Background: #FFFFFF
Surface: #F5F5F5
Error: #B00020
```

**다크 모드**:
```dart
Primary: #BB86FC (Purple)
Secondary: #03DAC6 (Teal)
Background: #121212
Surface: #1E1E1E
Error: #CF6679
```

### 애니메이션

**드래그 앤 드롭**:
- Duration: 200ms
- Curve: easeInOut
- 드래그 중 opacity: 0.7
- 드래그 중 scale: 1.05

**카드 터치**:
- Ripple effect
- Duration: 150ms
- Haptic feedback: medium

**페이지 전환**:
- Slide transition
- Duration: 300ms
- Curve: easeOut

### 로딩 상태

**Shimmer 효과**:
- 채널 카드 로딩 시
- 회색 그라데이션 애니메이션
- 실제 카드 레이아웃과 동일

**Pull-to-refresh**:
- Material Design CircularProgressIndicator
- Primary color

**무한 스크롤**:
- 하단 도달 시 자동 로드
- 작은 로딩 인디케이터

---

## 성능 최적화

### 이미지 캐싱

**cached_network_image 설정**:
```dart
CachedNetworkImage(
  imageUrl: channel.thumbnailUrl,
  memCacheWidth: 160,  // 80dp * 2 (retina)
  memCacheHeight: 160,
  maxHeightDiskCache: 200,
  maxWidthDiskCache: 200,
  fadeInDuration: Duration(milliseconds: 200),
  placeholder: (context, url) => ShimmerPlaceholder(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

**캐시 정책**:
- 메모리 캐시: 100개
- 디스크 캐시: 200MB
- 유효기간: 7일

### 리스트 최적화

**ListView.builder**:
- 화면에 보이는 아이템만 렌더링
- 스크롤 성능: 60fps 목표
- 아이템 재사용 (RecyclerView 패턴)

**대용량 데이터**:
- 구독 채널 100개 이상 시
- 가상 스크롤링
- 청크 단위 로딩 (50개씩)

### DB 쿼리 최적화

**인덱스 활용**:
- sort_order 컬럼 인덱스
- (collection_id, sort_order) 복합 인덱스

**트랜잭션 배치**:
- 드래그 앤 드롭 시 여러 행 업데이트
- 단일 트랜잭션으로 묶어 처리
- ROLLBACK 지원

**필요한 컬럼만 SELECT**:
```sql
-- Bad
SELECT * FROM channels;

-- Good
SELECT id, title, thumbnail_url, sort_order 
FROM channels 
WHERE id IN (...)
ORDER BY sort_order;
```

---

## 보안

### API 키 관리

**app_config.dart**:
```dart
class AppConfig {
  static const String youtubeApiKey = String.fromEnvironment(
    'YOUTUBE_API_KEY',
    defaultValue: '',
  );
}
```

**빌드 시 주입**:
```bash
flutter build apk --dart-define=YOUTUBE_API_KEY=YOUR_KEY_HERE
```

**환경 파일** (.gitignore에 추가):
```
.env
android/key.properties
ios/Runner/GoogleService-Info.plist
```

### 토큰 보안

**flutter_secure_storage**:
- Android: EncryptedSharedPreferences + Keystore
- iOS: Keychain Services
- 앱 삭제 시 자동 삭제

**네트워크**:
- HTTPS only
- Certificate pinning (옵션)

---

## 에러 처리

### 사용자 친화적 메시지

**네트워크 오류**:
```
"인터넷 연결을 확인해주세요"
→ 로컬 데이터로 계속 사용 가능
→ [재시도] 버튼 제공
```

**인증 오류**:
```
"로그인이 만료되었습니다"
→ [다시 로그인] 버튼
```

**API 할당량 초과**:
```
"일일 새로고침 한도를 초과했습니다"
→ 내일 다시 시도하거나
→ 로컬 데이터 사용
```

### 로깅

**디버그 모드**:
- 모든 API 호출 로그
- DB 쿼리 로그
- 에러 스택 트레이스

**프로덕션 모드**:
- 심각한 에러만 로그
- 개인정보 제외
- Crashlytics 연동 (옵션)

---

## 테스트 전략

### Unit Test
- Model 직렬화/역직렬화
- 정렬 로직
- 날짜 포맷팅
- Utility 함수

### Widget Test
- 채널 카드 렌더링
- 드래그 앤 드롭 동작
- 검색 필터링
- 컬렉션 칩 선택

### Integration Test
- 로그인 플로우
- 채널 목록 불러오기
- 드래그 후 DB 저장 확인
- 새로고침 동작

---

## 배포

### Android

**build.gradle 설정**:
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.tubedeck.app"
        minSdkVersion 24
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    signingConfigs {
        release {
            storeFile file("key.jks")
            storePassword System.getenv("KEY_STORE_PASSWORD")
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
        }
    }
}
```

**앱 권한** (AndroidManifest.xml):
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.VIBRATE" />
```

**ProGuard 난독화**:
```
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

### Google Play Console

**스토어 리스팅**:
- 앱명: TubeDeck
- 짧은 설명: YouTube 구독 채널을 자유롭게 정리
- 카테고리: 생산성
- 스크린샷: 5장 (필수)
- 아이콘: 512x512 PNG

**개인정보 처리방침**:
- YouTube 데이터 사용 목적 명시
- 로컬 저장 정보 설명
- 삭제 방법 안내

### Google Cloud Console

**설정 항목**:
1. 프로젝트 생성
2. YouTube Data API v3 활성화
3. OAuth 2.0 클라이언트 ID 생성
   - Android: SHA-1 인증서 등록
   - iOS: Bundle ID 등록
4. API 키 생성 (옵션)
5. 할당량 모니터링

---

## 향후 계획 (v1.1+)

### 알림 기능
- Firebase Cloud Messaging
- 특정 채널 업로드 시 푸시 알림
- 알림 우선순위 설정

### 통계 대시보드
- 가장 자주 본 채널 Top 10
- 30일 이상 안 본 채널 목록
- 구독자 수 증감 그래프
- 업로드 주기 분석

### Android 위젯
- 홈 스크린에 즐겨찾기 채널 표시
- 탭하면 바로 YouTube 앱 열기
- 4x2, 4x4 사이즈

### iOS 버전
- SwiftUI 네이티브 또는 Flutter 공유
- iOS 특화 제스처
- ShareSheet 연동

### 백업/동기화
- Google Drive 백업
- 여러 기기 간 동기화
- 자동 백업 스케줄

### 고급 정렬
- 알파벳순
- 최근 업로드순
- 구독자 수순
- 구독 날짜순
- 커스텀 가중치

---

## 부록

### 참고 문서
- [Flutter 공식 문서](https://flutter.dev/docs)
- [YouTube Data API v3](https://developers.google.com/youtube/v3)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)
- [Riverpod 공식 문서](https://riverpod.dev)

### 유사 앱 분석
- Pocket Tube (브라우저 확장)
- FreshTube (Android, 광고 차단 중심)
- NewPipe (오픈소스, YouTube 클라이언트)

### 디자인 참고
- Material Design 3
- YouTube 공식 앱 UI/UX
- Google Keep (드래그 앤 드롭)

---

## 문서 버전

- **작성일**: 2026-01-08
- **버전**: 1.0
- **작성자**: 원펏
- **최종 수정**: 2026-01-08
