import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_theme.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';

class PackageResultsScreen extends StatefulWidget {
  const PackageResultsScreen({Key? key}) : super(key: key);

  @override
  State<PackageResultsScreen> createState() => _PackageResultsScreenState();
}

class _PackageResultsScreenState extends State<PackageResultsScreen> {
  String _sortBy = 'price';
  int? _selectedPackageIndex;

  final List<Map<String, dynamic>> _packages = [
    {
      'title': 'Cancún All-Inclusive',
      'destination': 'Cancún, México',
      'nights': 7,
      'price': 4500,
      'rating': 4.9,
      'type': 'Lazer',
      'includes': ['Voo + Hotel', 'All-Inclusive', 'Traslado', 'Seguro'],
      'description': 'Resort 5 estrelas frente ao mar com tudo incluído.',
    },
    {
      'title': 'Orlando em Família',
      'destination': 'Orlando, FL',
      'nights': 5,
      'price': 3200,
      'rating': 4.7,
      'type': 'Família',
      'includes': ['Voo + Hotel', 'Ingressos Disney', 'Carro'],
      'description': 'Pacote completo com ingressos para parques temáticos.',
    },
    {
      'title': 'Paris Romântico',
      'destination': 'Paris, França',
      'nights': 6,
      'price': 6800,
      'rating': 4.8,
      'type': 'Romântico',
      'includes': ['Voo + Hotel', 'Passeios', 'Jantar especial'],
      'description': 'Experiência inesquecível na cidade do amor.',
    },
    {
      'title': 'Aventura na Patagônia',
      'destination': 'El Calafate, Argentina',
      'nights': 4,
      'price': 2800,
      'rating': 4.6,
      'type': 'Aventura',
      'includes': ['Voo + Hotel', 'Trekking', 'Guia local'],
      'description': 'Explore geleiras e paisagens impressionantes.',
    },
    {
      'title': 'Maldivas Luxo',
      'destination': 'Maldivas',
      'nights': 5,
      'price': 12000,
      'rating': 5.0,
      'type': 'Luxo',
      'includes': ['Voo + Villa sobre a água', 'Spa', 'Mergulho'],
      'description': 'O paraíso na terra com villa privativa.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.gridCrossAxisCount(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pacotes de Viagem',
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
                  '${_packages.length} pacotes encontrados',
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
                    DropdownMenuItem(value: 'nights', child: Text('Mais Noites', style: GoogleFonts.inter())),
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
                      childAspectRatio: 1.1,
                    ),
                    itemCount: _packages.length,
                    itemBuilder: (context, index) => _buildPackageCard(_packages[index], index),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _packages.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPackageCard(_packages[index], index),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> pkg, int index) {
    final isSelected = _selectedPackageIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedPackageIndex = index),
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
                      pkg['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _typeColor(pkg['type']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pkg['type'],
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _typeColor(pkg['type']),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: AppThemePremium.textTertiary),
                  const SizedBox(width: 4),
                  Text(pkg['destination'], style: AppThemePremium.bodySmall),
                  const SizedBox(width: 12),
                  Icon(Icons.nights_stay, size: 14, color: AppThemePremium.textTertiary),
                  const SizedBox(width: 4),
                  Text('${pkg['nights']} noites', style: AppThemePremium.bodySmall),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pkg['description'],
                style: GoogleFonts.inter(fontSize: 13, color: AppThemePremium.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: (pkg['includes'] as List<String>).map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppThemePremium.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 12, color: AppThemePremium.successColor),
                        const SizedBox(width: 4),
                        Text(
                          item,
                          style: GoogleFonts.inter(fontSize: 11, color: AppThemePremium.successColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${pkg['price'].toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppThemePremium.accentOrange,
                        ),
                      ),
                      Text('/por pessoa', style: AppThemePremium.bodySmall),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: AppThemePremium.accentOrange),
                      const SizedBox(width: 4),
                      Text(
                        '${pkg['rating']}',
                        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              if (isSelected) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.push('/checkout'),
                    child: Text('Reservar Pacote', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Lazer':
        return Colors.blue;
      case 'Família':
        return Colors.green;
      case 'Romântico':
        return Colors.pink;
      case 'Aventura':
        return Colors.orange;
      case 'Luxo':
        return Colors.purple;
      default:
        return AppThemePremium.primaryNavy;
    }
  }
}
