import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'credit_card';
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Compra'),
        elevation: 0,
      ),
      body: Row(
        children: [
          // Order Summary (Left)
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo da Compra',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1e3a8a),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Flight Summary
                  _buildSummarySection(
                    title: 'Voo Selecionado',
                    children: [
                      _buildSummaryRow('Companhia', 'LATAM'),
                      _buildSummaryRow('Voo', 'LA 1234'),
                      _buildSummaryRow('Data', '15 de Junho, 2024'),
                      _buildSummaryRow('Horário', '06:00 - 08:30'),
                      _buildSummaryRow('Duração', '2h 30m'),
                      _buildSummaryRow('Classe', 'Econômica'),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Passengers
                  _buildSummarySection(
                    title: 'Passageiros',
                    children: [
                      _buildPassengerCard('João Silva', 'CPF: 123.456.789-00'),
                      _buildPassengerCard('Maria Silva', 'CPF: 987.654.321-00'),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Add-ons
                  _buildSummarySection(
                    title: 'Serviços Adicionais',
                    children: [
                      _buildAddOnCheckbox('Seguro Viagem', 'R\$ 89,90', true),
                      _buildAddOnCheckbox('Bagagem Extra (23kg)', 'R\$ 120,00', false),
                      _buildAddOnCheckbox('Seleção de Assento', 'R\$ 50,00', false),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Price Breakdown
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildPriceRow('Subtotal', 'R\$ 900,00'),
                        _buildPriceRow('Taxas', 'R\$ 150,00'),
                        _buildPriceRow('Seguro', 'R\$ 89,90'),
                        const Divider(height: 20),
                        _buildPriceRow(
                          'Total',
                          'R\$ 1.139,90',
                          isBold: true,
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Payment Form (Right)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[50],
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados de Pagamento',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1e3a8a),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Payment Method Selection
                    _buildPaymentMethodOption(
                      'Cartão de Crédito',
                      'credit_card',
                      Icons.credit_card,
                    ),
                    _buildPaymentMethodOption(
                      'Cartão de Débito',
                      'debit_card',
                      Icons.credit_card,
                    ),
                    _buildPaymentMethodOption(
                      'PIX',
                      'pix',
                      Icons.qr_code,
                    ),
                    _buildPaymentMethodOption(
                      'Boleto',
                      'boleto',
                      Icons.receipt,
                    ),

                    const SizedBox(height: 25),

                    // Card Form
                    if (_paymentMethod == 'credit_card' || _paymentMethod == 'debit_card')
                      Column(
                        children: [
                          _buildTextField(
                            label: 'Nome do Titular',
                            hint: 'João Silva',
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Número do Cartão',
                            hint: '1234 5678 9012 3456',
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  label: 'Validade',
                                  hint: 'MM/AA',
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _buildTextField(
                                  label: 'CVV',
                                  hint: '123',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'CPF',
                            hint: '123.456.789-00',
                          ),
                        ],
                      ),

                    const SizedBox(height: 25),

                    // Terms and Conditions
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeTerms,
                          onChanged: (value) {
                            setState(() => _agreeTerms = value ?? false);
                          },
                          activeColor: const Color(0xFFF59E0B),
                        ),
                        Expanded(
                          child: Text(
                            'Concordo com os termos e condições',
                            style: GoogleFonts.inter(fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _agreeTerms
                            ? () {
                                Navigator.pushNamed(context, '/confirmation');
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF59E0B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Finalizar Compra',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildSummarySection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1e3a8a),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerCard(String name, String cpf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              cpf,
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnCheckbox(String label, String price, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (_) {},
            activeColor: const Color(0xFFF59E0B),
          ),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 13),
            ),
          ),
          Text(
            price,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isBold = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? const Color(0xFFF59E0B) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(String label, String value, IconData icon) {
    final isSelected = _paymentMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF59E0B).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFF59E0B) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFF59E0B) : Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFFF59E0B) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF1e3a8a),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}
