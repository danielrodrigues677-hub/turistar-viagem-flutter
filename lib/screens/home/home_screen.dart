import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../config/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  DateTime _departureDate = DateTime.now().add(const Duration(days: 1));
  DateTime? _returnDate;
  int _passengers = 1;
  String _seatClass = 'Econômica';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryNavy,
                    AppTheme.navyLight,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Logo
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Turistar',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' Viagem',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Main Title
                  Text(
                    'Explore o Mundo com\nConfiança e Segurança',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Descubra destinos incríveis, reserve voos, hotéis e experiências únicas',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat('500K+', 'Viajantes'),
                      _buildStat('150+', 'Países'),
                      _buildStat('24/7', 'Suporte'),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // Search Tabs
            Container(
              color: AppTheme.primaryNavy,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: _tabController,
                labelColor: AppTheme.accentOrange,
                unselectedLabelColor: Colors.white70,
                indicatorColor: AppTheme.accentOrange,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Voos'),
                  Tab(text: 'Hotéis'),
                  Tab(text: 'Carros'),
                  Tab(text: 'Pacotes'),
                ],
              ),
            ),

            // Search Form
            Container(
              color: AppTheme.primaryNavy,
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFlightSearchForm(),
                  _buildHotelSearchForm(),
                  _buildCarSearchForm(),
                  _buildPackageSearchForm(),
                ],
              ),
            ),

            // Features Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Por que escolher Turistar?',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.local_offer,
                        title: 'Melhores Preços',
                        description: 'Tarifas negociadas',
                      ),
                      _buildFeatureCard(
                        icon: Icons.support_agent,
                        title: 'Suporte 24/7',
                        description: 'Sempre disponível',
                      ),
                      _buildFeatureCard(
                        icon: Icons.verified_user,
                        title: 'Segurança',
                        description: '100% confiável',
                      ),
                      _buildFeatureCard(
                        icon: Icons.flash_on,
                        title: 'Rápido',
                        description: 'Em segundos',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popular Destinations
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destinos em Alta',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildDestinationCard('Miami', 'R\$ 1.200'),
                      _buildDestinationCard('Paris', 'R\$ 2.500'),
                      _buildDestinationCard('Cancún', 'R\$ 1.800'),
                      _buildDestinationCard('Nova York', 'R\$ 2.200'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentOrange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFlightSearchForm() {
    return Column(
      children: [
        // Origin and Destination
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (_) {},
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'De',
                  hintStyle: GoogleFonts.inter(color: Colors.white30),
                  prefixIcon:
                      Icon(Icons.location_on, color: AppTheme.accentOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                onChanged: (_) {},
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'Para',
                  hintStyle: GoogleFonts.inter(color: Colors.white30),
                  prefixIcon:
                      Icon(Icons.location_on, color: AppTheme.accentOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Dates
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: AppTheme.accentOrange, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd/MM').format(_departureDate),
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: AppTheme.accentOrange, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        _returnDate != null
                            ? DateFormat('dd/MM').format(_returnDate!)
                            : 'Retorno',
                        style: GoogleFonts.inter(
                            color: _returnDate != null
                                ? Colors.white
                                : Colors.white30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Passengers and Class
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: _passengers,
                onChanged: (value) => setState(() => _passengers = value ?? 1),
                items: [1, 2, 3, 4, 5, 6].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Passageiro${value > 1 ? 's' : ''}'),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  prefixIcon: Icon(Icons.people, color: AppTheme.accentOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                ),
                dropdownColor: AppTheme.primaryNavy,
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _seatClass,
                onChanged: (value) =>
                    setState(() => _seatClass = value ?? 'Econômica'),
                items: [
                  'Econômica',
                  'Premium Economy',
                  'Executiva',
                  'Primeira Classe'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  prefixIcon: Icon(Icons.airplanemode_active,
                      color: AppTheme.accentOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                ),
                dropdownColor: AppTheme.primaryNavy,
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Search Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/flights/results');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Buscar Voos',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHotelSearchForm() {
    return Center(
      child: Text(
        'Busca de Hotéis em desenvolvimento',
        style: GoogleFonts.inter(color: Colors.white70),
      ),
    );
  }

  Widget _buildCarSearchForm() {
    return Center(
      child: Text(
        'Busca de Carros em desenvolvimento',
        style: GoogleFonts.inter(color: Colors.white70),
      ),
    );
  }

  Widget _buildPackageSearchForm() {
    return Center(
      child: Text(
        'Busca de Pacotes em desenvolvimento',
        style: GoogleFonts.inter(color: Colors.white70),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppTheme.accentOrange.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.accentOrange, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(String city, String price) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryNavy.withValues(alpha: 0.8),
              AppTheme.navyLight.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.location_on,
                size: 80,
                color: AppTheme.accentOrange.withValues(alpha: 0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture
          ? _departureDate
          : (_returnDate ?? DateTime.now().add(const Duration(days: 1))),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }
}
