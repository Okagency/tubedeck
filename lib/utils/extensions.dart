import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntExtension on int {
  /// 구독자 수를 천명/만명 단위로 포맷 (locale-aware)
  String toSubscriberCount([BuildContext? context]) {
    final isKorean = context != null &&
        Localizations.localeOf(context).languageCode == 'ko';

    if (isKorean) {
      // Korean format: 만 (10,000), 천 (1,000)
      if (this >= 10000) {
        final manCount = this / 10000;
        if (manCount >= 10) {
          return '${manCount.toStringAsFixed(0)}만';
        } else {
          return '${manCount.toStringAsFixed(1)}만';
        }
      } else if (this >= 1000) {
        final thousands = this / 1000;
        if (thousands >= 10) {
          return '${thousands.toStringAsFixed(0)}천';
        } else {
          return '${thousands.toStringAsFixed(1)}천';
        }
      } else {
        return toString();
      }
    } else {
      // English format: M (million), K (thousand)
      if (this >= 1000000) {
        final millions = this / 1000000;
        if (millions >= 10) {
          return '${millions.toStringAsFixed(0)}M';
        } else {
          return '${millions.toStringAsFixed(1)}M';
        }
      } else if (this >= 1000) {
        final thousands = this / 1000;
        if (thousands >= 10) {
          return '${thousands.toStringAsFixed(0)}K';
        } else {
          return '${thousands.toStringAsFixed(1)}K';
        }
      } else {
        return toString();
      }
    }
  }
}

extension DateTimeExtension on DateTime {
  /// 상대 시간 포맷 (3일 전, 1주 전 등) - locale-aware
  String toRelativeTime([BuildContext? context]) {
    final now = DateTime.now();
    final difference = now.difference(this);

    final isKorean = context != null &&
        Localizations.localeOf(context).languageCode == 'ko';

    if (isKorean) {
      // Korean format
      if (difference.inDays >= 365) {
        final years = (difference.inDays / 365).floor();
        return '$years년 전';
      } else if (difference.inDays >= 30) {
        final months = (difference.inDays / 30).floor();
        return '$months개월 전';
      } else if (difference.inDays >= 7) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks주 전';
      } else if (difference.inDays >= 1) {
        return '${difference.inDays}일 전';
      } else if (difference.inHours >= 1) {
        return '${difference.inHours}시간 전';
      } else if (difference.inMinutes >= 1) {
        return '${difference.inMinutes}분 전';
      } else {
        return '방금 전';
      }
    } else {
      // English format
      if (difference.inDays >= 365) {
        final years = (difference.inDays / 365).floor();
        return '${years}y ago';
      } else if (difference.inDays >= 30) {
        final months = (difference.inDays / 30).floor();
        return '${months}mo ago';
      } else if (difference.inDays >= 7) {
        final weeks = (difference.inDays / 7).floor();
        return '${weeks}w ago';
      } else if (difference.inDays >= 1) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours >= 1) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes >= 1) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    }
  }

  /// ISO 8601 포맷으로 변환
  String toIso8601() {
    return toIso8601String();
  }

  /// 날짜 포맷 (2024-01-08)
  String toDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// 시간 포맷 (오후 3:45)
  String toTimeString() {
    return DateFormat('a h:mm', 'ko_KR').format(this);
  }

  /// 날짜 + 시간 포맷
  String toDateTimeString() {
    return DateFormat('yyyy-MM-dd a h:mm', 'ko_KR').format(this);
  }
}

extension StringExtension on String {
  /// ISO 8601 문자열을 DateTime으로 변환
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }

  /// 문자열이 비어있는지 확인
  bool get isEmptyOrNull => isEmpty;

  /// 문자열을 최대 길이로 자르기
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }
}

extension ListExtension<T> on List<T> {
  /// 리스트가 비어있지 않은지 확인
  bool get isNotEmpty => !isEmpty;

  /// 안전하게 인덱스 접근
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
