import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_theme.dart';
import '../../widgets/flight_card.dart';

class FlightResultsScreen extends StatefulWidget {
  const FlightResultsScreen({Key? key}) : super(key: key);

  @override
  State<FlightResultsScreen> createState() => _FlightResultsScreenState();
}

class _FlightResultsScreenState extends State<FlightResultsScreen> {
  String _sortBy = 'price';
  RangeValues _priceRange = const RangeValues(500, 5000);
  List<String> _selectedAirlines = [];
  int? _selectedFlightId;

  final List<Map<String, dynamic>> _flights = [
    {
      'id': 1,
      'airline': 'LATAM Airlines',
      'departure': 'GRU',
      'arrival': 'MIA',
      'departureTime': '08:00',
      'arrivalTime': '14:30',
      'duration': '7h 30m',
      'price': 1200,
      'stops': 0,
    },
    {
      'id': 2,
      'airline': 'Gol Linhas Aéreas',
      'departure': 'GRU',
      'arrival': 'MIA',
      'departureTime': '10:15',
      'arrivalTime': '16:45',
      'duration': '7h 30m',
      'price': 950,
      'stops': 0,
    },
    {
      'id': 3,
      'airline': 'Azul Linhas Aéreas',
      'departure': 'GRU',
      'arrival': 'MIA',
      'departureTime': '14:00',
      'arrivalTime': '20:30',
      'duration': '7h 30m',
      'price': 1100,
      'stops': 0,
    },
    {
      'id': 4,
      'airline': 'United Airlines',
      'departure': 'GRU',
      'arrival': 'MIA',
      'departureTime': '06:30',
      'arrivalTime': '13:00',
      'duration': '7h 30m',
      'price': 1350,
      'stops': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resultados de Voos',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: AppTheme.primaryNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with results count
            Container(
              color: AppTheme.primaryNavy.withOpacity(0.05),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_flights.length} voos encontrados',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _sortBy,
                    onChanged: (value) {
                      setState(() => _sortBy = value ?? 'price');
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'price',
                        child: Text('Menor Preço', style: GoogleFonts.inter()),
                      ),
                      DropdownMenuItem(
                        value: 'duration',
                        child: Text('Menor Duração', style: GoogleFonts.inter()),
                      ),
                      DropdownMenuItem(
                        value: 'departure',
                        child: Text('Mais Cedo', style: GoogleFonts.inter()),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Flights List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: _flights.length,
              itemBuilder: (context, index) {
                final flight = _flights[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FlightCard(
                    airline: flight['airline'],
                    departure: flight['departure'],
                    arrival: flight['arrival'],
                    departureTime: flight['departureTime'],
                    arrivalTime: flight['arrivalTime'],
                    duration: flight['duration'],
                    price: flight['price'].toDouble(),
                    isSelected: _selectedFlightId == flight['id'],
                    onTap: () {
                      setState(() {
                        _selectedFlightId = flight['id'];
                      });
                    },
                  ),
                );
              },
            ),

            // CTA Button
            if (_selectedFlightId != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/checkout');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Continuar para Checkout',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
