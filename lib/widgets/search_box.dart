import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_theme.dart';

class SearchBox extends StatefulWidget {
  final String? fromCity;
  final String? toCity;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final int passengers;
  final String travelClass;
  final VoidCallback onSearch;
  final Function(String) onFromCityChanged;
  final Function(String) onToCityChanged;
  final Function(DateTime) onDepartureDateChanged;
  final Function(DateTime) onReturnDateChanged;
  final Function(int) onPassengersChanged;
  final Function(String) onClassChanged;

  const SearchBox({
    Key? key,
    this.fromCity,
    this.toCity,
    this.departureDate,
    this.returnDate,
    this.passengers = 1,
    this.travelClass = 'Econômica',
    required this.onSearch,
    required this.onFromCityChanged,
    required this.onToCityChanged,
    required this.onDepartureDateChanged,
    required this.onReturnDateChanged,
    required this.onPassengersChanged,
    required this.onClassChanged,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late TextEditingController _fromController;
  late TextEditingController _toController;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController(text: widget.fromCity);
    _toController = TextEditingController(text: widget.toCity);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppTheme.accentOrange.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Buscar Voos',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 20),

            // From & To
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromController,
                    onChanged: widget.onFromCityChanged,
                    decoration: InputDecoration(
                      hintText: 'De',
                      prefixIcon:
                          Icon(Icons.location_on, color: AppTheme.accentOrange),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    onChanged: widget.onToCityChanged,
                    decoration: InputDecoration(
                      hintText: 'Para',
                      prefixIcon:
                          Icon(Icons.location_on, color: AppTheme.accentOrange),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dates
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: widget.departureDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        widget.onDepartureDateChanged(date);
                      }
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Saída',
                        prefixIcon: Icon(Icons.calendar_today,
                            color: AppTheme.accentOrange),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: widget.returnDate ??
                            DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        widget.onReturnDateChanged(date);
                      }
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Retorno',
                        prefixIcon: Icon(Icons.calendar_today,
                            color: AppTheme.accentOrange),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Passengers & Class
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: widget.passengers,
                    onChanged: (value) {
                      if (value != null) {
                        widget.onPassengersChanged(value);
                      }
                    },
                    items: [1, 2, 3, 4, 5, 6].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value Passageiro${value > 1 ? 's' : ''}'),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Passageiros',
                      prefixIcon:
                          Icon(Icons.people, color: AppTheme.accentOrange),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: widget.travelClass,
                    onChanged: (value) {
                      if (value != null) {
                        widget.onClassChanged(value);
                      }
                    },
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
                      hintText: 'Classe',
                      prefixIcon: Icon(Icons.airplanemode_active,
                          color: AppTheme.accentOrange),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onSearch,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
        ),
      ),
    );
  }
}
