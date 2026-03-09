void main() async {
  // SQL 문만 생성합니다.

  print('========================================');
  print('더미 영상 데이터 SQL 생성');
  print('========================================\n');

  final now = DateTime.now();
  final dummyVideos = [
    {
      'id': 'dQw4w9WgXcQ',
      'channel_id': 'UC0M-_02RJqMlGTKUjF1WhJg',
      'title': '플러터 완벽 가이드 - 초보자도 쉽게 배우는 앱 개발',
      'channel_title': '코딩 마스터',
      'description': '플러터로 크로스 플랫폼 앱 개발을 시작하세요!',
      'thumbnail_url': 'https://i.ytimg.com/vi/dQw4w9WgXcQ/mqdefault.jpg',
      'published_at': now.subtract(Duration(hours: 2)).toIso8601String(),
    },
    {
      'id': 'jNQXAC9IVRw',
      'channel_id': 'UC4Aa3OPkMenwTANpf0oWVRQ',
      'title': 'Riverpod 상태 관리 완전 정복',
      'channel_title': '개발자 TV',
      'description': 'Provider보다 강력한 Riverpod 마스터하기',
      'thumbnail_url': 'https://i.ytimg.com/vi/jNQXAC9IVRw/mqdefault.jpg',
      'published_at': now.subtract(Duration(hours: 5)).toIso8601String(),
    },
    {
      'id': '9bZkp7q19f0',
      'channel_id': 'UCWlV3Lz_55UaX4JsMj-z__Q',
      'title': 'YouTube Data API 활용법 - 실전 프로젝트',
      'channel_title': '테크 채널',
      'description': 'Google API를 활용한 유튜브 앱 만들기',
      'thumbnail_url': 'https://i.ytimg.com/vi/9bZkp7q19f0/mqdefault.jpg',
      'published_at': now.subtract(Duration(hours: 12)).toIso8601String(),
    },
    {
      'id': 'kJQP7kiw5Fk',
      'channel_id': 'UC0M-_02RJqMlGTKUjF1WhJg',
      'title': 'SQLite 데이터베이스 최적화 팁',
      'channel_title': '코딩 마스터',
      'description': '앱 성능을 높이는 DB 설계 방법',
      'thumbnail_url': 'https://i.ytimg.com/vi/kJQP7kiw5Fk/mqdefault.jpg',
      'published_at': now.subtract(Duration(days: 1)).toIso8601String(),
    },
    {
      'id': 'L_jWHffIx5E',
      'channel_id': 'UCVuwFx3iLihi9Nrrv-PUlFA',
      'title': '안드로이드 에뮬레이터 속도 개선 방법',
      'channel_title': '모바일 개발 스쿨',
      'description': '개발 환경을 최적화하여 생산성 높이기',
      'thumbnail_url': 'https://i.ytimg.com/vi/L_jWHffIx5E/mqdefault.jpg',
      'published_at': now.subtract(Duration(days: 2)).toIso8601String(),
    },
    {
      'id': 'yKNxeF4KMsY',
      'channel_id': 'UC4Aa3OPkMenwTANpf0oWVRQ',
      'title': 'UI/UX 디자인 패턴 Best Practices',
      'channel_title': '개발자 TV',
      'description': '사용자 경험을 개선하는 디자인 원칙',
      'thumbnail_url': 'https://i.ytimg.com/vi/yKNxeF4KMsY/mqdefault.jpg',
      'published_at': now.subtract(Duration(days: 3)).toIso8601String(),
    },
    {
      'id': 'ZZ5LpwO-An4',
      'channel_id': 'UCWlV3Lz_55UaX4JsMj-z__Q',
      'title': 'Git 브랜치 전략 - 협업을 위한 필수 가이드',
      'channel_title': '테크 채널',
      'description': 'Git Flow, GitHub Flow 비교 분석',
      'thumbnail_url': 'https://i.ytimg.com/vi/ZZ5LpwO-An4/mqdefault.jpg',
      'published_at': now.subtract(Duration(days: 5)).toIso8601String(),
    },
    {
      'id': 'Hc79sDi3f0U',
      'channel_id': 'UCVuwFx3iLihi9Nrrv-PUlFA',
      'title': 'Firebase 실시간 데이터베이스 vs Firestore',
      'channel_title': '모바일 개발 스쿨',
      'description': '프로젝트에 맞는 Firebase DB 선택하기',
      'thumbnail_url': 'https://i.ytimg.com/vi/Hc79sDi3f0U/mqdefault.jpg',
      'published_at': now.subtract(Duration(days: 7)).toIso8601String(),
    },
  ];

  print('다음 SQL을 실행하세요:\n');
  print('-- 더미 영상 데이터 삽입');
  print('DELETE FROM videos;');
  print('DELETE FROM video_cache_metadata;\n');

  for (final video in dummyVideos) {
    print("INSERT INTO videos (id, channel_id, title, channel_title, description, thumbnail_url, published_at, cached_at)");
    print("VALUES (");
    print("  '${video['id']}',");
    print("  '${video['channel_id']}',");
    print("  '${video['title']}',");
    print("  '${video['channel_title']}',");
    print("  '${video['description']}',");
    print("  '${video['thumbnail_url']}',");
    print("  '${video['published_at']}',");
    print("  '${now.toIso8601String()}'");
    print(");\n");
  }

  print("-- 캐시 메타데이터 삽입");
  print("INSERT INTO video_cache_metadata (cache_key, last_fetched_at)");
  print("VALUES ('all', '${now.toIso8601String()}');\n");

  print('\n========================================');
  print('Android Studio DB Inspector 사용법:');
  print('========================================');
  print('1. Android Studio 열기');
  print('2. View > Tool Windows > App Inspection');
  print('3. Database Inspector 탭 선택');
  print('4. 앱 선택 (com.tubedeck.app)');
  print('5. tubedeck.db 선택');
  print('6. 위 SQL을 Query 탭에 붙여넣기');
  print('7. 실행 버튼 클릭');
  print('8. 앱에서 영상 탭 새로고침\n');
}
