import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_theme_premium.dart';
import 'providers/app_providers.dart';
import 'screens/home/home_screen_premium.dart';
import 'screens/flights/flight_results_screen.dart';
import 'screens/hotels/hotel_results_screen.dart';
import 'screens/cars/car_results_screen.dart';
import 'screens/packages/package_results_screen.dart';
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
          path: '/hotels/results',
          name: 'hotel_results',
          builder: (context, state) => const HotelResultsScreen(),
        ),
        GoRoute(
          path: '/cars/results',
          name: 'car_results',
          builder: (context, state) => const CarResultsScreen(),
        ),
        GoRoute(
          path: '/packages/results',
          name: 'package_results',
          builder: (context, state) => const PackageResultsScreen(),
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

    // MultiProvider requires at least one provider, so we'll skip it for now
    // and add it back when we have actual providers
    return MaterialApp.router(
      title: 'Turistar Viagem',
      theme: AppThemePremium.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
