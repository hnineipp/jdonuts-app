import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class JDonutsApp extends ConsumerWidget {
  const JDonutsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp.router(
          title: "J'Donuts",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: ref.watch(appRouterProvider),
          builder: (context, child) => MediaQuery.withClampedTextScaling(
            maxScaleFactor: 1.3,
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      );
}
