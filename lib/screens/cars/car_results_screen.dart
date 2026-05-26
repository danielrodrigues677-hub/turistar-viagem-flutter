import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_theme.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';

class CarResultsScreen extends StatefulWidget {
  const CarResultsScreen({Key? key}) : super(key: key);

  @override
  State<CarResultsScreen> createState() => _CarResultsScreenState();
}

class _CarResultsScreenState extends State<CarResultsScreen> {
  String _sortBy = 'price';
  int? _selectedCarIndex;

  final List<Map<String, dynamic>> _cars = [
    {
      'company': 'Localiza',
      'model': 'Fiat Mobi',
      'category': 'Econômico',
      'pricePerDay': 89,
      'seats': 5,
      'transmission': 'Manual',
      'bags': 1,
      'ac': true,
    },
    {
      'company': 'Movida',
      'model': 'VW Polo',
      'category': 'Compacto',
      'pricePerDay': 120,
      'seats': 5,
      'transmission': 'Automático',
      'bags': 2,
      'ac': true,
    },
    {
      'company': 'Unidas',
      'model': 'Jeep Renegade',
      'category': 'SUV',
      'pricePerDay': 195,
      'seats': 5,
      'transmission': 'Automático',
      'bags': 3,
      'ac': true,
    },
    {
      'company': 'Hertz',
      'model': 'Toyota Corolla',
      'category': 'Intermediário',
      'pricePerDay': 150,
      'seats': 5,
      'transmission': 'Automático',
      'bags': 2,
      'ac': true,
    },
    {
      'company': 'Localiza',
      'model': 'BMW 320i',
      'category': 'Luxo',
      'pricePerDay': 450,
      'seats': 5,
      'transmission': 'Automático',
      'bags': 2,
      'ac': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.gridCrossAxisCount(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carros Disponíveis',
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
                  '${_cars.length} carros disponíveis',
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
                    DropdownMenuItem(value: 'category', child: Text('Categoria', style: GoogleFonts.inter())),
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
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _cars.length,
                    itemBuilder: (context, index) => _buildCarCard(_cars[index], index),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cars.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildCarCard(_cars[index], index),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard(Map<String, dynamic> car, int index) {
    final isSelected = _selectedCarIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedCarIndex = index),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['model'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryNavy,
                          ),
                        ),
                        Text(
                          car['company'],
                          style: AppThemePremium.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppThemePremium.primaryNavy.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      car['category'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppThemePremium.primaryNavy,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildFeature(Icons.people, '${car['seats']} lugares'),
                  _buildFeature(Icons.settings, car['transmission']),
                  _buildFeature(Icons.luggage, '${car['bags']} mala${car['bags'] > 1 ? 's' : ''}'),
                  if (car['ac']) _buildFeature(Icons.ac_unit, 'A/C'),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${car['pricePerDay']}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppThemePremium.accentOrange,
                        ),
                      ),
                      Text('/dia', style: AppThemePremium.bodySmall),
                    ],
                  ),
                  if (isSelected)
                    ElevatedButton(
                      onPressed: () => context.push('/checkout'),
                      child: Text('Alugar', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppThemePremium.textTertiary),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppThemePremium.textSecondary)),
      ],
    );
  }
}
