import 'package:provider/provider.dart';

// Import services
// import 'package:turistar_viagem/services/api_service.dart';
// import 'package:turistar_viagem/services/auth_service.dart';
// import 'package:turistar_viagem/services/flight_service.dart';

class AppProviders {
  static List<ChangeNotifierProvider> get providers {
    return [
      // ChangeNotifierProvider(create: (_) => ApiService()),
      // ChangeNotifierProvider(create: (_) => AuthService()),
      // ChangeNotifierProvider(create: (_) => FlightService()),
    ];
  }
}
