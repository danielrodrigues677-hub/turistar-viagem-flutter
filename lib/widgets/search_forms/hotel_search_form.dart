import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';
import '../gradient_button.dart';

class HotelSearchForm extends StatefulWidget {
  final VoidCallback onSearch;

  const HotelSearchForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<HotelSearchForm> createState() => _HotelSearchFormState();
}

class _HotelSearchFormState extends State<HotelSearchForm> {
  final _cityController = TextEditingController(text: 'Miami');
  int _guests = 2;
  int _rooms = 1;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = !Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buscar Hotéis', style: AppThemePremium.headingSmall),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            children: [
              Expanded(flex: 2, child: _buildInput('Destino', 'Cidade ou hotel', _cityController, Icons.location_city)),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Check-in', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Check-out', '22 Jun')),
            ],
          )
        else ...[
          _buildInput('Destino', 'Cidade ou hotel', _cityController, Icons.location_city),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDateField('Check-in', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Check-out', '22 Jun')),
            ],
          ),
        ],
        const SizedBox(height: 12),
        if (isWide)
          Row(
            children: [
              Expanded(child: _buildGuestsDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildRoomsDropdown()),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GradientButton(
                    label: 'Buscar Hotéis',
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
              Expanded(child: _buildGuestsDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildRoomsDropdown()),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Buscar Hotéis',
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

  Widget _buildGuestsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hóspedes', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _guests,
              isExpanded: true,
              items: List.generate(8, (i) => i + 1).map((v) {
                return DropdownMenuItem(value: v, child: Text('$v Hóspede${v > 1 ? 's' : ''}'));
              }).toList(),
              onChanged: (v) => setState(() => _guests = v ?? 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quartos', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _rooms,
              isExpanded: true,
              items: List.generate(5, (i) => i + 1).map((v) {
                return DropdownMenuItem(value: v, child: Text('$v Quarto${v > 1 ? 's' : ''}'));
              }).toList(),
              onChanged: (v) => setState(() => _rooms = v ?? 1),
            ),
          ),
        ),
      ],
    );
  }
}
