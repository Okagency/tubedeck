import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class Helpers {
  /// SnackBar 표시
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 로딩 다이얼로그 표시
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(message),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 로딩 다이얼로그 닫기
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// 확인 다이얼로그 표시 (locale-aware)
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelText ?? l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(confirmText ?? l10n.confirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 에러 메시지 변환 (locale-aware)
  static String getErrorMessage(dynamic error, [BuildContext? context]) {
    final l10n = context != null ? AppLocalizations.of(context) : null;

    if (error == null) {
      return l10n?.errorUnknown ?? 'An unknown error occurred.';
    }

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') ||
        errorString.contains('socket') ||
        errorString.contains('connection')) {
      return l10n?.errorNetwork ?? 'Please check your internet connection.';
    } else if (errorString.contains('401') ||
        errorString.contains('unauthorized')) {
      return l10n?.errorUnauthorized ?? 'Login has expired.';
    } else if (errorString.contains('403') ||
        errorString.contains('quota') ||
        errorString.contains('exceeded')) {
      return l10n?.errorQuotaExceeded ?? 'YouTube API daily quota exceeded.\nPlease try again after 5 PM (Korea time) tomorrow.';
    } else if (errorString.contains('404')) {
      return l10n?.errorNotFound ?? 'The requested data could not be found.';
    } else if (errorString.contains('timeout')) {
      return l10n?.errorTimeout ?? 'Request timed out.';
    }

    return l10n?.errorGeneric(error.toString()) ?? 'An error occurred: ${error.toString()}';
  }

  /// 햅틱 피드백
  static Future<void> hapticFeedback() async {
    // TODO: 햅틱 피드백 구현
    // HapticFeedback.mediumImpact();
  }
}
