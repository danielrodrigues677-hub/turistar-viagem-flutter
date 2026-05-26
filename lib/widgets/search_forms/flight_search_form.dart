import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';
import '../gradient_button.dart';

class FlightSearchForm extends StatefulWidget {
  final VoidCallback onSearch;

  const FlightSearchForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<FlightSearchForm> createState() => _FlightSearchFormState();
}

class _FlightSearchFormState extends State<FlightSearchForm> {
  final _fromController = TextEditingController(text: 'GRU');
  final _toController = TextEditingController(text: 'MIA');
  int _passengers = 1;
  String _travelClass = 'Econômica';

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = !Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buscar Voos', style: AppThemePremium.headingSmall),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            children: [
              Expanded(child: _buildInput('De', 'Origem (ex: GRU)', _fromController, Icons.flight_takeoff)),
              const SizedBox(width: 12),
              Expanded(child: _buildInput('Para', 'Destino (ex: MIA)', _toController, Icons.flight_land)),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Ida', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Volta', '22 Jun')),
            ],
          )
        else ...[
          Row(
            children: [
              Expanded(child: _buildInput('De', 'GRU', _fromController, Icons.flight_takeoff)),
              const SizedBox(width: 12),
              Expanded(child: _buildInput('Para', 'MIA', _toController, Icons.flight_land)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDateField('Ida', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Volta', '22 Jun')),
            ],
          ),
        ],
        const SizedBox(height: 12),
        if (isWide)
          Row(
            children: [
              Expanded(child: _buildPassengersDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildClassDropdown()),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GradientButton(
                    label: 'Buscar Voos',
                    icon: Icons.search,
                    onPressed: widget.onSearch,
                    fullWidth: true,
                  ),
                ),
              ),
            ],
          )
        else ...[
          Row(
            children: [
              Expanded(child: _buildPassengersDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildClassDropdown()),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Buscar Voos',
            icon: Icons.search,
            onPressed: widget.onSearch,
            fullWidth: true,
          ),
        ],
      ],
    );
  }

  Widget _buildInput(String label, String hint, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppThemePremium.accentOrange, size: 20),
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(Icons.calendar_today, color: AppThemePremium.accentOrange, size: 18),
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 7)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPassengersDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Passageiros', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _passengers,
              isExpanded: true,
              items: List.generate(6, (i) => i + 1).map((v) {
                return DropdownMenuItem(value: v, child: Text('$v Passageiro${v > 1 ? 's' : ''}'));
              }).toList(),
              onChanged: (v) => setState(() => _passengers = v ?? 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Classe', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _travelClass,
              isExpanded: true,
              items: ['Econômica', 'Premium', 'Executiva', 'Primeira'].map((v) {
                return DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 14)));
              }).toList(),
              onChanged: (v) => setState(() => _travelClass = v ?? 'Econômica'),
            ),
          ),
        ),
      ],
    );
  }
}
