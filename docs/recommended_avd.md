# 추천 가상 디바이스 (AVD)

## 구형 기기 테스트용

SM-T820 (Galaxy Tab S3, 2017년)과 같은 구형 기기 호환성 테스트를 위한 AVD 추천 목록입니다.

### 스마트폰

| AVD | Android 버전 | API Level | 특징 |
|-----|-------------|-----------|------|
| Pixel | Android 7.1 | API 25 | 가장 오래된 테스트 대상 |
| Pixel 2 | Android 8.0 | API 26 | 2017년 기기, 구형 테스트에 적합 |
| Pixel 3 | Android 9.0 | API 28 | 중간 버전 테스트 |

### 태블릿

| AVD | Android 버전 | API Level | 특징 |
|-----|-------------|-----------|------|
| Nexus 9 | Android 7.1 | API 25 | 구형 태블릿 테스트용 |
| Pixel Tablet | Android 13+ | API 33+ | 최신 태블릿 테스트용 |

## 권장 테스트 조합

1. **최소 지원 버전**: API 25 (Android 7.1) 또는 API 26 (Android 8.0)
2. **중간 버전**: API 28 (Android 9.0)
3. **최신 버전**: API 34 (Android 14)

## 참고

- SM-T820 (Galaxy Tab S3): Android 7.0 ~ 9.0 지원
- 구형 삼성 기기에서 `FilePicker`의 `FileType.custom` 필터가 동작하지 않는 문제 발견됨
  - 해결: `FileType.any` 사용으로 모든 기기 호환성 확보
