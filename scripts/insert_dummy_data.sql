-- 더미 영상 데이터 삽입
DELETE FROM videos;
DELETE FROM video_cache_metadata;

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'dQw4w9WgXcQ',
  'UC0M-_02RJqMlGTKUjF1WhJg',
  '플러터 완벽 가이드 - 초보자도 쉽게 배우는 앱 개발',
  '코딩 마스터',
  '플러터로 크로스 플랫폼 앱 개발을 시작하세요!',
  'https://i.ytimg.com/vi/dQw4w9WgXcQ/mqdefault.jpg',
  '2026-01-11T01:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'jNQXAC9IVRw',
  'UC4Aa3OPkMenwTANpf0oWVRQ',
  'Riverpod 상태 관리 완전 정복',
  '개발자 TV',
  'Provider보다 강력한 Riverpod 마스터하기',
  'https://i.ytimg.com/vi/jNQXAC9IVRw/mqdefault.jpg',
  '2026-01-10T22:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  '9bZkp7q19f0',
  'UCWlV3Lz_55UaX4JsMj-z__Q',
  'YouTube Data API 활용법 - 실전 프로젝트',
  '테크 채널',
  'Google API를 활용한 유튜브 앱 만들기',
  'https://i.ytimg.com/vi/9bZkp7q19f0/mqdefault.jpg',
  '2026-01-10T15:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'kJQP7kiw5Fk',
  'UC0M-_02RJqMlGTKUjF1WhJg',
  'SQLite 데이터베이스 최적화 팁',
  '코딩 마스터',
  '앱 성능을 높이는 DB 설계 방법',
  'https://i.ytimg.com/vi/kJQP7kiw5Fk/mqdefault.jpg',
  '2026-01-10T03:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'L_jWHffIx5E',
  'UCVuwFx3iLihi9Nrrv-PUlFA',
  '안드로이드 에뮬레이터 속도 개선 방법',
  '모바일 개발 스쿨',
  '개발 환경을 최적화하여 생산성 높이기',
  'https://i.ytimg.com/vi/L_jWHffIx5E/mqdefault.jpg',
  '2026-01-09T03:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'yKNxeF4KMsY',
  'UC4Aa3OPkMenwTANpf0oWVRQ',
  'UI/UX 디자인 패턴 Best Practices',
  '개발자 TV',
  '사용자 경험을 개선하는 디자인 원칙',
  'https://i.ytimg.com/vi/yKNxeF4KMsY/mqdefault.jpg',
  '2026-01-08T03:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'ZZ5LpwO-An4',
  'UCWlV3Lz_55UaX4JsMj-z__Q',
  'Git 브랜치 전략 - 협업을 위한 필수 가이드',
  '테크 채널',
  'Git Flow, GitHub Flow 비교 분석',
  'https://i.ytimg.com/vi/ZZ5LpwO-An4/mqdefault.jpg',
  '2026-01-06T03:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)
VALUES (
  'Hc79sDi3f0U',
  'UCVuwFx3iLihi9Nrrv-PUlFA',
  'Firebase 실시간 데이터베이스 vs Firestore',
  '모바일 개발 스쿨',
  '프로젝트에 맞는 Firebase DB 선택하기',
  'https://i.ytimg.com/vi/Hc79sDi3f0U/mqdefault.jpg',
  '2026-01-04T03:44:17.815205',
  '2026-01-11T03:44:17.815205'
);

-- 캐시 메타데이터 삽입
INSERT INTO video_cache_metadata (cache_key, last_fetched_at)
VALUES ('all', '2026-01-11T03:44:17.815205');
