import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import 'dart:ui' as ui;

class HomeScreenPremium extends StatefulWidget {
  const HomeScreenPremium({Key? key}) : super(key: key);

  @override
  State<HomeScreenPremium> createState() => _HomeScreenPremiumState();
}

class _HomeScreenPremiumState extends State<HomeScreenPremium> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemePremium.surfaceLight,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Hero Section
          SliverAppBar(
            expandedHeight: 420,
            floating: false,
            pinned: true,
            backgroundColor: AppThemePremium.primaryNavy,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(),
            ),
          ),

          // Search Box
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -40),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _buildSearchBox(),
              ),
            ),
          ),

          // Tabs
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: _buildTabs(),
            ),
          ),

          // Featured Flights
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voos em Destaque',
                    style: AppThemePremium.headingMedium,
                  ),
                  SizedBox(height: 16),
                  _buildFeaturedFlights(),
                ],
              ),
            ),
          ),

          // Why Choose Us
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    'Por que escolher Turistar?',
                    style: AppThemePremium.headingMedium,
                  ),
                  SizedBox(height: 16),
                  _buildWhyChooseUs(),
                ],
              ),
            ),
          ),

          // CTA Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _buildCTASection(),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppThemePremium.gradientPrimaryOrange,
      ),
      child: Stack(
        children: [
          // Decorative background keeps the hero visual rich without requiring
          // image assets in a fresh Android Studio checkout.
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.flight_takeoff,
                  size: 220,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Explore o Mundo',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'com Confiança e Segurança',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppThemePremium.accentOrange,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        _buildStat('500K+', 'Viajantes'),
                        SizedBox(width: 32),
                        _buildStat('150+', 'Destinos'),
                        SizedBox(width: 32),
                        _buildStat('24/7', 'Suporte'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppThemePremium.accentOrange,
          ),
        ),
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

  Widget _buildSearchBox() {
    return GlassCard(
      borderRadius: 20,
      blur: 15,
      backgroundColor: Colors.white.withOpacity(0.15),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buscar Voos',
            style: AppThemePremium.headingSmall,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSearchInput('De', 'GRU'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildSearchInput('Para', 'MIA'),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSearchInput('Ida', '15 Jun'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildSearchInput('Volta', '22 Jun'),
              ),
            ],
          ),
          SizedBox(height: 16),
          GradientButton(
            label: 'Buscar Voos',
            onPressed: () {
              Navigator.pushNamed(context, '/flights');
            },
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppThemePremium.labelSmall,
        ),
        SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: AppThemePremium.textTertiary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final tabs = ['Voos', 'Hotéis', 'Carros', 'Pacotes'];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == index
                      ? AppThemePremium.accentOrange
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _selectedTab == index
                        ? AppThemePremium.accentOrange
                        : AppThemePremium.borderColor,
                  ),
                  boxShadow: _selectedTab == index
                      ? AppThemePremium.shadowGlowOrange
                      : [],
                ),
                child: Text(
                  tabs[index],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _selectedTab == index
                        ? Colors.white
                        : AppThemePremium.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedFlights() {
    final flights = [
      {
        'airline': 'LATAM',
        'from': 'GRU',
        'to': 'MIA',
        'price': 'R\$ 1.200',
        'duration': '7h 30m',
      },
      {
        'airline': 'Gol',
        'from': 'GRU',
        'to': 'NYC',
        'price': 'R\$ 1.500',
        'duration': '9h 15m',
      },
    ];

    return Column(
      children: flights.map((flight) => _buildFlightCard(flight)).toList(),
    );
  }

  Widget _buildFlightCard(Map<String, String> flight) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderRadius: 16,
        blur: 10,
        backgroundColor: Colors.white.withOpacity(0.8),
        onTap: () {
          Navigator.pushNamed(context, '/flights');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flight['airline']!,
                    style: AppThemePremium.labelLarge,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${flight['from']} → ${flight['to']}',
                    style: AppThemePremium.bodySmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    flight['duration']!,
                    style: AppThemePremium.bodySmall.copyWith(
                      color: AppThemePremium.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  flight['price']!,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppThemePremium.accentOrange,
                  ),
                ),
                SizedBox(height: 8),
                Icon(
                  Icons.arrow_forward,
                  color: AppThemePremium.accentOrange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    final features = [
      {
        'icon': Icons.verified_user,
        'title': '100% Seguro',
        'desc': 'Transações protegidas',
      },
      {
        'icon': Icons.price_check,
        'title': 'Melhor Preço',
        'desc': 'Garantido',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Suporte 24/7',
        'desc': 'Sempre disponível',
      },
      {
        'icon': Icons.flash_on,
        'title': 'Rápido',
        'desc': 'Busca em segundos',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return GlassCard(
          borderRadius: 16,
          blur: 10,
          backgroundColor: Colors.white.withOpacity(0.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppThemePremium.accentOrange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: AppThemePremium.accentOrange,
                  size: 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                feature['title'] as String,
                style: AppThemePremium.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                feature['desc'] as String,
                style: AppThemePremium.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppThemePremium.gradientOrangePrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppThemePremium.shadowGlowOrange,
      ),
      child: Column(
        children: [
          Text(
            'Pronto para Viajar?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Encontre os melhores preços em voos, hotéis e carros',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GradientButton(
            label: 'Começar Busca',
            onPressed: () {
              Navigator.pushNamed(context, '/flights');
            },
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.9)],
            ),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
