import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';
import '../gradient_button.dart';

class CarSearchForm extends StatefulWidget {
  final VoidCallback onSearch;

  const CarSearchForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<CarSearchForm> createState() => _CarSearchFormState();
}

class _CarSearchFormState extends State<CarSearchForm> {
  final _pickupController = TextEditingController(text: 'Miami International Airport');
  String _category = 'Todos';
  bool _returnSameLocation = true;

  @override
  void dispose() {
    _pickupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = !Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Alugar Carro', style: AppThemePremium.headingSmall),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            children: [
              Expanded(flex: 2, child: _buildInput('Retirada', 'Cidade ou aeroporto', _pickupController, Icons.location_on)),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Data Retirada', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Data Devolução', '22 Jun')),
            ],
          )
        else ...[
          _buildInput('Retirada', 'Cidade ou aeroporto', _pickupController, Icons.location_on),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDateField('Data Retirada', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Data Devolução', '22 Jun')),
            ],
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: _returnSameLocation,
              onChanged: (v) => setState(() => _returnSameLocation = v ?? true),
              activeColor: AppThemePremium.accentOrange,
            ),
            Expanded(
              child: Text(
                'Devolver no mesmo local',
                style: GoogleFonts.inter(fontSize: 13, color: AppThemePremium.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (isWide)
          Row(
            children: [
              Expanded(child: _buildCategoryDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildTimeField('Hora Retirada', '10:00')),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GradientButton(
                    label: 'Buscar Carros',
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
              Expanded(child: _buildCategoryDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildTimeField('Hora Retirada', '10:00')),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Buscar Carros',
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

  Widget _buildTimeField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(Icons.access_time, color: AppThemePremium.accentOrange, size: 18),
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          onTap: () async {
            await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 10, minute: 0));
          },
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categoria', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _category,
              isExpanded: true,
              items: ['Todos', 'Econômico', 'Compacto', 'SUV', 'Luxo'].map((v) {
                return DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 14)));
              }).toList(),
              onChanged: (v) => setState(() => _category = v ?? 'Todos'),
            ),
          ),
        ),
      ],
    );
  }
}
