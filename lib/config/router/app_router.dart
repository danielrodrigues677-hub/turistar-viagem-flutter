import 'package:flutter/material.dart';

import '../../screens/checkout/checkout_screen.dart';
import '../../screens/confirmation/confirmation_screen.dart';
import '../../screens/flights/flight_results_screen.dart';
import '../../screens/home/home_screen_premium.dart';

class AppRoutes {
  static const home = '/';
  static const flights = '/flights';
  static const flightResults = '/flights/results';
  static const checkout = '/checkout';
  static const confirmation = '/confirmation';
}

class AppRouter {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (context) => const HomeScreenPremium(),
      AppRoutes.flights: (context) => const FlightResultsScreen(),
      AppRoutes.flightResults: (context) => const FlightResultsScreen(),
      AppRoutes.checkout: (context) => const CheckoutScreen(),
      AppRoutes.confirmation: (context) => const ConfirmationScreen(),
    };
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Turistar Viagens')),
        body: Center(
          child: Text('Página não encontrada: ${settings.name ?? ''}'),
        ),
      ),
    );
  }
}
