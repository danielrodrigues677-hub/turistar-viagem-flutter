import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme_premium.dart';
import 'providers/app_providers.dart';

void main() {
  runApp(const TuristarViagemApp());
}

class TuristarViagemApp extends StatelessWidget {
  const TuristarViagemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Turistar Viagem',
      theme: AppThemePremium.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.home,
      routes: AppRouter.routes,
      onUnknownRoute: AppRouter.onUnknownRoute,
      debugShowCheckedModeBanner: false,
    );

    final providers = AppProviders.providers;
    if (providers.isEmpty) {
      return app;
    }

    return MultiProvider(
      providers: providers,
      child: app,
    );
  }
}
