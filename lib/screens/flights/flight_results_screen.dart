import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightResultsScreen extends StatefulWidget {
  const FlightResultsScreen({Key? key}) : super(key: key);

  @override
  State<FlightResultsScreen> createState() => _FlightResultsScreenState();
}

class _FlightResultsScreenState extends State<FlightResultsScreen> {
  String _sortBy = 'price'; // price, duration, departure
  RangeValues _priceRange = const RangeValues(0, 5000);
  List<String> _selectedAirlines = [];
  List<String> _selectedStops = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de Voos'),
        elevation: 0,
      ),
      body: Row(
        children: [
          // Sidebar Filters
          Container(
            width: 280,
            color: Colors.grey[50],
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filtros',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1e3a8a),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Price Range
                  _buildFilterSection(
                    title: 'Preço',
                    child: Column(
                      children: [
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 5000,
                          divisions: 50,
                          labels: RangeLabels(
                            'R\$ ${_priceRange.start.toStringAsFixed(0)}',
                            'R\$ ${_priceRange.end.toStringAsFixed(0)}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() => _priceRange = values);
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'R\$ ${_priceRange.start.toStringAsFixed(0)} - R\$ ${_priceRange.end.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Airlines
                  _buildFilterSection(
                    title: 'Companhias',
                    child: Column(
                      children: [
                        _buildCheckbox('LATAM', 'latam'),
                        _buildCheckbox('Gol', 'gol'),
                        _buildCheckbox('Azul', 'azul'),
                        _buildCheckbox('Avianca', 'avianca'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stops
                  _buildFilterSection(
                    title: 'Paradas',
                    child: Column(
                      children: [
                        _buildCheckbox('Direto', 'direct'),
                        _buildCheckbox('1 parada', '1stop'),
                        _buildCheckbox('2+ paradas', '2stops'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Results
          Expanded(
            child: Column(
              children: [
                // Sort Bar
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Encontrados 24 voos',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _sortBy,
                        onChanged: (value) {
                          setState(() => _sortBy = value!);
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'price',
                            child: Text('Menor Preço'),
                          ),
                          DropdownMenuItem(
                            value: 'duration',
                            child: Text('Menor Duração'),
                          ),
                          DropdownMenuItem(
                            value: 'departure',
                            child: Text('Mais Cedo'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Flight List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return _buildFlightCard(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1e3a8a),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildCheckbox(String label, String value) {
    final isSelected = _selectedAirlines.contains(value) || _selectedStops.contains(value);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedAirlines.remove(value);
            _selectedStops.remove(value);
          } else {
            if (label.contains('Companhia') || label == 'LATAM' || label == 'Gol' || label == 'Azul' || label == 'Avianca') {
              _selectedAirlines.add(value);
            } else {
              _selectedStops.add(value);
            }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) {},
              activeColor: const Color(0xFFF59E0B),
            ),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flight Info
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LATAM LA ${1000 + index}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1e3a8a),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '06:00',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 2,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '2h 30m',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '08:30',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Direto • Boeing 737',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Price and Button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$ ${450 + (index * 50)}',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'por pessoa',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                      ),
                      child: Text(
                        'Selecionar',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
