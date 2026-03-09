import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/theme.dart';
import 'services/storage_service.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // StorageService 초기화
  await StorageService().init();

  runApp(
    const ProviderScope(
      child: TubeDeckApp(),
    ),
  );
}

class TubeDeckApp extends ConsumerWidget {
  const TubeDeckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'TubeDeck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        Locale('ja'),
        Locale('zh'),
        Locale('zh', 'TW'),
        Locale('de'),
        Locale('th'),
        Locale('vi'),
        Locale('fr'),
        Locale('es'),
        Locale('pt'),
        Locale('id'),
        Locale('ru'),
        Locale('hi'),
        Locale('ar'),
        Locale('tr'),
        Locale('it'),
      ],
      home: const SplashScreen(),
    );
  }
}
