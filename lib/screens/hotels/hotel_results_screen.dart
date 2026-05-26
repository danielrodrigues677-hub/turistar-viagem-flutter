import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_theme.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';

class HotelResultsScreen extends StatefulWidget {
  const HotelResultsScreen({Key? key}) : super(key: key);

  @override
  State<HotelResultsScreen> createState() => _HotelResultsScreenState();
}

class _HotelResultsScreenState extends State<HotelResultsScreen> {
  String _sortBy = 'price';
  int? _selectedHotelIndex;

  final List<Map<String, dynamic>> _hotels = [
    {
      'name': 'Hilton Miami Downtown',
      'city': 'Miami, FL',
      'stars': 5,
      'rating': 4.8,
      'reviews': 2340,
      'pricePerNight': 450,
      'amenities': ['Wi-Fi', 'Piscina', 'Spa', 'Academia'],
    },
    {
      'name': 'Marriott Biscayne Bay',
      'city': 'Miami, FL',
      'stars': 4,
      'rating': 4.5,
      'reviews': 1850,
      'pricePerNight': 320,
      'amenities': ['Wi-Fi', 'Piscina', 'Restaurante'],
    },
    {
      'name': 'Holiday Inn Express',
      'city': 'Miami Beach, FL',
      'stars': 3,
      'rating': 4.2,
      'reviews': 980,
      'pricePerNight': 180,
      'amenities': ['Wi-Fi', 'Café da manhã', 'Estacionamento'],
    },
    {
      'name': 'Faena Hotel Miami Beach',
      'city': 'Miami Beach, FL',
      'stars': 5,
      'rating': 4.9,
      'reviews': 1200,
      'pricePerNight': 780,
      'amenities': ['Wi-Fi', 'Piscina', 'Spa', 'Praia Privativa'],
    },
    {
      'name': 'Ibis Budget Miami',
      'city': 'Miami, FL',
      'stars': 2,
      'rating': 3.8,
      'reviews': 650,
      'pricePerNight': 95,
      'amenities': ['Wi-Fi', 'Ar-condicionado'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.gridCrossAxisCount(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotéis em Miami',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: AppTheme.primaryNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppTheme.primaryNavy.withOpacity(0.05),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_hotels.length} hotéis encontrados',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                DropdownButton<String>(
                  value: _sortBy,
                  onChanged: (value) => setState(() => _sortBy = value ?? 'price'),
                  items: [
                    DropdownMenuItem(value: 'price', child: Text('Menor Preço', style: GoogleFonts.inter())),
                    DropdownMenuItem(value: 'rating', child: Text('Melhor Avaliação', style: GoogleFonts.inter())),
                    DropdownMenuItem(value: 'stars', child: Text('Mais Estrelas', style: GoogleFonts.inter())),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: crossAxisCount > 1
                ? GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: _hotels.length,
                    itemBuilder: (context, index) => _buildHotelCard(_hotels[index], index),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _hotels.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildHotelCard(_hotels[index], index),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel, int index) {
    final isSelected = _selectedHotelIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedHotelIndex = index),
      child: Card(
        elevation: isSelected ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? AppThemePremium.accentOrange : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      hotel['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      hotel['stars'],
                      (_) => Icon(Icons.star, color: AppThemePremium.accentOrange, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: AppThemePremium.textTertiary),
                  const SizedBox(width: 4),
                  Text(hotel['city'], style: AppThemePremium.bodySmall),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppThemePremium.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${hotel['rating']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppThemePremium.successColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(${hotel['reviews']} avaliações)',
                    style: AppThemePremium.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: (hotel['amenities'] as List<String>).take(3).map((a) {
                  return Chip(
                    label: Text(a, style: GoogleFonts.inter(fontSize: 10)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${hotel['pricePerNight']}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppThemePremium.accentOrange,
                        ),
                      ),
                      Text('/noite', style: AppThemePremium.bodySmall),
                    ],
                  ),
                  if (isSelected)
                    ElevatedButton(
                      onPressed: () => context.push('/checkout'),
                      child: Text('Reservar', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
