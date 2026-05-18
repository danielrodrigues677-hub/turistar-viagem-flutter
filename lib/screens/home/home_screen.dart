import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  String _tripType = 'roundtrip'; // roundtrip, oneway, multicity
  String _origin = '';
  String _destination = '';
  DateTime _departureDate = DateTime.now().add(const Duration(days: 1));
  DateTime? _returnDate;
  int _passengers = 1;
  String _seatClass = 'economy';

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
                    const Color(0xFF1e3a8a),
                    const Color(0xFF3b82f6),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Text(
                    'Turistar',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Viagem',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Main Title
                  Text(
                    'Viva Experiências\nInesquecíveis',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Encontre os melhores voos, hotéis e pacotes de viagem',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Search Tabs
            Container(
              color: const Color(0xFF1e3a8a),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFFF59E0B),
                unselectedLabelColor: Colors.white70,
                indicatorColor: const Color(0xFFF59E0B),
                tabs: const [
                  Tab(text: 'Voos'),
                  Tab(text: 'Hotéis'),
                  Tab(text: 'Carros'),
                  Tab(text: 'Seguros'),
                ],
              ),
            ),

            // Search Form
            Container(
              color: const Color(0xFF1e3a8a),
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFlightSearchForm(),
                  _buildHotelSearchForm(),
                  _buildCarSearchForm(),
                  _buildInsuranceSearchForm(),
                ],
              ),
            ),

            // Highlights Section
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
                      color: const Color(0xFF1e3a8a),
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
                      _buildHighlightCard(
                        icon: Icons.local_offer,
                        title: 'Melhores Preços',
                        description: 'Tarifas negociadas direto com consolidadoras',
                      ),
                      _buildHighlightCard(
                        icon: Icons.support_agent,
                        title: 'Suporte 24/7',
                        description: 'Atendimento em português sempre disponível',
                      ),
                      _buildHighlightCard(
                        icon: Icons.verified_user,
                        title: 'Segurança',
                        description: 'Plataforma 100% segura e confiável',
                      ),
                      _buildHighlightCard(
                        icon: Icons.flash_on,
                        title: 'Rápido',
                        description: 'Busca e reserva em segundos',
                      ),
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

  Widget _buildFlightSearchForm() {
    return Column(
      children: [
        // Trip Type Selection
        Row(
          children: [
            Expanded(
              child: _buildTripTypeButton('Ida e Volta', 'roundtrip'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTripTypeButton('Só Ida', 'oneway'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTripTypeButton('Multi-cidade', 'multicity'),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Origin and Destination
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'De',
                value: _origin,
                onChanged: (value) => setState(() => _origin = value),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTextField(
                label: 'Para',
                value: _destination,
                onChanged: (value) => setState(() => _destination = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Dates
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                label: 'Ida',
                date: _departureDate,
                onTap: () => _selectDate(context, true),
              ),
            ),
            const SizedBox(width: 10),
            if (_tripType == 'roundtrip')
              Expanded(
                child: _buildDateField(
                  label: 'Volta',
                  date: _returnDate,
                  onTap: () => _selectDate(context, false),
                ),
              ),
          ],
        ),
        const SizedBox(height: 15),

        // Passengers and Class
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Passageiros',
                value: _passengers.toString(),
                items: List.generate(9, (i) => (i + 1).toString()),
                onChanged: (value) => setState(() => _passengers = int.parse(value!)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdown(
                label: 'Classe',
                value: _seatClass,
                items: const ['economy', 'premium', 'business', 'first'],
                onChanged: (value) => setState(() => _seatClass = value!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Search Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to results
              Navigator.pushNamed(context, '/flights/results');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Buscar Voos',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
        style: GoogleFonts.inter(color: Colors.white),
      ),
    );
  }

  Widget _buildCarSearchForm() {
    return Center(
      child: Text(
        'Busca de Carros em desenvolvimento',
        style: GoogleFonts.inter(color: Colors.white),
      ),
    );
  }

  Widget _buildInsuranceSearchForm() {
    return Center(
      child: Text(
        'Busca de Seguros em desenvolvimento',
        style: GoogleFonts.inter(color: Colors.white),
      ),
    );
  }

  Widget _buildTripTypeButton(String label, String value) {
    final isSelected = _tripType == value;
    return GestureDetector(
      onTap: () => setState(() => _tripType = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF59E0B) : Colors.white10,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFF59E0B) : Colors.white30,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFF1e3a8a) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white30),
            ),
            hintText: 'Ex: São Paulo (GRU)',
            hintStyle: GoogleFonts.inter(color: Colors.white30),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white30),
            ),
            child: Text(
              date != null ? DateFormat('dd/MM/yyyy').format(date) : 'Selecionar',
              style: GoogleFonts.inter(
                color: date != null ? Colors.white : Colors.white30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          dropdownColor: const Color(0xFF1e3a8a),
          style: GoogleFonts.inter(color: Colors.white),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHighlightCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1e3a8a),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _departureDate : (_returnDate ?? _departureDate),
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
