import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_theme.dart';
import 'config/router/app_router.dart';
import 'providers/app_providers.dart';

void main() {
  runApp(const TuristarViagemApp());
}

class TuristarViagemApp extends StatelessWidget {
  const TuristarViagemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp.router(
        title: 'Turistar Viagem',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
