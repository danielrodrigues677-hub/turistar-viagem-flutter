import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_theme.dart';
import 'config/theme/app_theme_premium.dart';
import 'config/router/app_router.dart';
import 'providers/app_providers.dart';
import 'screens/home/home_screen_premium.dart';
import 'screens/flights/flight_results_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/confirmation/confirmation_screen.dart';

void main() {
  runApp(const TuristarViagemApp());
}

class TuristarViagemApp extends StatelessWidget {
  const TuristarViagemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreenPremium(),
        ),
        GoRoute(
          path: '/flights/results',
          name: 'flight_results',
          builder: (context, state) => const FlightResultsScreen(),
        ),
        GoRoute(
          path: '/checkout',
          name: 'checkout',
          builder: (context, state) => const CheckoutScreen(),
        ),
        GoRoute(
          path: '/confirmation',
          name: 'confirmation',
          builder: (context, state) => const ConfirmationScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Página não encontrada: ${state.uri}'),
        ),
      ),
    );

    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp.router(
        title: 'Turistar Viagem',
        theme: AppThemePremium.lightTheme,
        themeMode: ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
