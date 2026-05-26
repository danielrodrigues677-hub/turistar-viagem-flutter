import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/search_forms/flight_search_form.dart';
import '../../widgets/search_forms/hotel_search_form.dart';
import '../../widgets/search_forms/car_search_form.dart';
import '../../widgets/search_forms/package_search_form.dart';
import '../../utils/responsive.dart';

class HomeScreenPremium extends StatefulWidget {
  const HomeScreenPremium({Key? key}) : super(key: key);

  @override
  State<HomeScreenPremium> createState() => _HomeScreenPremiumState();
}

class _HomeScreenPremiumState extends State<HomeScreenPremium>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final _tabData = const [
    {'label': 'Voos', 'icon': Icons.flight},
    {'label': 'Hotéis', 'icon': Icons.hotel},
    {'label': 'Carros', 'icon': Icons.directions_car},
    {'label': 'Pacotes', 'icon': Icons.card_travel},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String get _resultsRoute {
    switch (_selectedTab) {
      case 0:
        return '/flights/results';
      case 1:
        return '/hotels/results';
      case 2:
        return '/cars/results';
      case 3:
        return '/packages/results';
      default:
        return '/flights/results';
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.screenPadding(context);
    final maxWidth = Responsive.contentMaxWidth(context);
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppThemePremium.surfaceLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 350 : 420,
            floating: false,
            pinned: true,
            backgroundColor: AppThemePremium.primaryNavy,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Padding(
                    padding: padding,
                    child: _buildSearchSection(),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: padding,
                  child: _buildFeaturedSection(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: padding.copyWith(top: 24, bottom: 16),
                  child: _buildWhyChooseUs(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: padding.copyWith(bottom: 40),
                  child: _buildCTASection(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppThemePremium.gradientPrimaryOrange,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/airplane_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
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
                    const SizedBox(height: 8),
                    Text(
                      'com Confiança e Segurança',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppThemePremium.accentOrange,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ResponsiveLayout(
                      mobile: _buildStatsRow(),
                      desktop: _buildStatsRow(),
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

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStat('500K+', 'Viajantes'),
        const SizedBox(width: 32),
        _buildStat('150+', 'Destinos'),
        const SizedBox(width: 32),
        _buildStat('24/7', 'Suporte'),
      ],
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
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return GlassCard(
      borderRadius: 20,
      blur: 15,
      backgroundColor: Colors.white.withOpacity(0.95),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabs(),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildCurrentForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final isWide = !Responsive.isMobile(context);

    if (isWide) {
      return Row(
        children: List.generate(
          _tabData.length,
          (index) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index < _tabData.length - 1 ? 8 : 0),
              child: _buildTabItem(index),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _tabData.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _buildTabItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final isActive = _selectedTab == index;
    final tab = _tabData[index];

    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppThemePremium.accentOrange : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive
                ? AppThemePremium.accentOrange
                : AppThemePremium.borderColor,
          ),
          boxShadow: isActive ? AppThemePremium.shadowGlowOrange : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tab['icon'] as IconData,
              size: 18,
              color: isActive ? Colors.white : AppThemePremium.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              tab['label'] as String,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppThemePremium.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentForm() {
    switch (_selectedTab) {
      case 0:
        return FlightSearchForm(
          key: const ValueKey('flights'),
          onSearch: () => context.push(_resultsRoute),
        );
      case 1:
        return HotelSearchForm(
          key: const ValueKey('hotels'),
          onSearch: () => context.push(_resultsRoute),
        );
      case 2:
        return CarSearchForm(
          key: const ValueKey('cars'),
          onSearch: () => context.push(_resultsRoute),
        );
      case 3:
        return PackageSearchForm(
          key: const ValueKey('packages'),
          onSearch: () => context.push(_resultsRoute),
        );
      default:
        return FlightSearchForm(
          key: const ValueKey('flights_default'),
          onSearch: () => context.push(_resultsRoute),
        );
    }
  }

  Widget _buildFeaturedSection() {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Voos em Destaque', style: AppThemePremium.headingMedium),
        const SizedBox(height: 16),
        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _buildFlightCard({
                  'airline': 'LATAM',
                  'from': 'GRU',
                  'to': 'MIA',
                  'price': 'R\$ 1.200',
                  'duration': '7h 30m',
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFlightCard({
                  'airline': 'Gol',
                  'from': 'GRU',
                  'to': 'NYC',
                  'price': 'R\$ 1.500',
                  'duration': '9h 15m',
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFlightCard({
                  'airline': 'Azul',
                  'from': 'GRU',
                  'to': 'LIS',
                  'price': 'R\$ 2.100',
                  'duration': '9h 45m',
                }),
              ),
            ],
          )
        else
          Column(
            children: [
              _buildFlightCard({
                'airline': 'LATAM',
                'from': 'GRU',
                'to': 'MIA',
                'price': 'R\$ 1.200',
                'duration': '7h 30m',
              }),
              _buildFlightCard({
                'airline': 'Gol',
                'from': 'GRU',
                'to': 'NYC',
                'price': 'R\$ 1.500',
                'duration': '9h 15m',
              }),
            ],
          ),
      ],
    );
  }

  Widget _buildFlightCard(Map<String, String> flight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        borderRadius: 16,
        blur: 10,
        backgroundColor: Colors.white.withOpacity(0.8),
        onTap: () => context.push('/flights/results'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(flight['airline']!, style: AppThemePremium.labelLarge),
                  const SizedBox(height: 4),
                  Text(
                    '${flight['from']} → ${flight['to']}',
                    style: AppThemePremium.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    flight['duration']!,
                    style: AppThemePremium.bodySmall
                        .copyWith(color: AppThemePremium.textTertiary),
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
                const SizedBox(height: 8),
                const Icon(Icons.arrow_forward,
                    color: AppThemePremium.accentOrange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    final features = [
      {'icon': Icons.verified_user, 'title': '100% Seguro', 'desc': 'Transações protegidas'},
      {'icon': Icons.price_check, 'title': 'Melhor Preço', 'desc': 'Garantido'},
      {'icon': Icons.support_agent, 'title': 'Suporte 24/7', 'desc': 'Sempre disponível'},
      {'icon': Icons.flash_on, 'title': 'Rápido', 'desc': 'Busca em segundos'},
    ];

    final crossAxisCount = Responsive.isMobile(context) ? 2 : 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Por que escolher Turistar?', style: AppThemePremium.headingMedium),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: crossAxisCount == 4 ? 1.3 : 1.1,
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
                    padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 12),
                  Text(
                    feature['title'] as String,
                    style: AppThemePremium.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    feature['desc'] as String,
                    style: AppThemePremium.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const SizedBox(height: 12),
          Text(
            'Encontre os melhores preços em voos, hotéis e carros',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Começar Busca',
            onPressed: () => context.push(_resultsRoute),
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
