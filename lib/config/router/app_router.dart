import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Import screens
// import 'package:turistar_viagem/screens/home/home_screen.dart';
// import 'package:turistar_viagem/screens/flights/flight_search_screen.dart';
// import 'package:turistar_viagem/screens/flights/flight_results_screen.dart';
// import 'package:turistar_viagem/screens/checkout/checkout_screen.dart';
// import 'package:turistar_viagem/screens/confirmation/confirmation_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home')),
        ),
      ),
      GoRoute(
        path: '/flights/search',
        name: 'flight_search',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Flight Search')),
        ),
      ),
      GoRoute(
        path: '/flights/results',
        name: 'flight_results',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Flight Results')),
        ),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Checkout')),
        ),
      ),
      GoRoute(
        path: '/confirmation',
        name: 'confirmation',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Confirmation')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.location}'),
      ),
    ),
  );
}
