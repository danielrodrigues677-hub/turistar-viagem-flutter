import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme_premium.dart';
import '../../utils/responsive.dart';
import '../gradient_button.dart';

class PackageSearchForm extends StatefulWidget {
  final VoidCallback onSearch;

  const PackageSearchForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<PackageSearchForm> createState() => _PackageSearchFormState();
}

class _PackageSearchFormState extends State<PackageSearchForm> {
  final _destinationController = TextEditingController(text: 'Cancún');
  String _type = 'Todos';
  int _travelers = 2;

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = !Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buscar Pacotes', style: AppThemePremium.headingSmall),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            children: [
              Expanded(flex: 2, child: _buildInput('Destino', 'Para onde deseja ir?', _destinationController, Icons.beach_access)),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Ida', '15 Jun')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField('Volta', '22 Jun')),
            ],
          )
        else ...[
          _buildInput('Destino', 'Para onde deseja ir?', _destinationController, Icons.beach_access),
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
              Expanded(child: _buildTypeDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildTravelersDropdown()),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GradientButton(
                    label: 'Buscar Pacotes',
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
              Expanded(child: _buildTypeDropdown()),
              const SizedBox(width: 12),
              Expanded(child: _buildTravelersDropdown()),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Buscar Pacotes',
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

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _type,
              isExpanded: true,
              items: ['Todos', 'Lazer', 'Aventura', 'Romântico', 'Família', 'Corporativo'].map((v) {
                return DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 14)));
              }).toList(),
              onChanged: (v) => setState(() => _type = v ?? 'Todos'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTravelersDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Viajantes', style: AppThemePremium.labelSmall),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _travelers,
              isExpanded: true,
              items: List.generate(8, (i) => i + 1).map((v) {
                return DropdownMenuItem(value: v, child: Text('$v Viajante${v > 1 ? 's' : ''}'));
              }).toList(),
              onChanged: (v) => setState(() => _travelers = v ?? 2),
            ),
          ),
        ),
      ],
    );
  }
}
