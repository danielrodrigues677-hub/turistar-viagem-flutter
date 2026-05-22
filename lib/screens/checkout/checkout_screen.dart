import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'credit_card';
  bool _agreeTerms = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cardController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Finalizar Compra',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: AppTheme.primaryNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Progress Indicator
            Container(
              color: AppTheme.primaryNavy.withValues(alpha: 0.05),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProgressStep('1', 'Voo', true),
                  _buildProgressLine(),
                  _buildProgressStep('2', 'Passageiro', true),
                  _buildProgressLine(),
                  _buildProgressStep('3', 'Pagamento', true),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flight Summary
                  _buildSectionCard(
                    title: 'Resumo do Voo',
                    child: Column(
                      children: [
                        _buildSummaryRow('Companhia', 'LATAM Airlines'),
                        _buildSummaryRow(
                            'Rota', 'São Paulo (GRU) → Miami (MIA)'),
                        _buildSummaryRow('Data', '15 de Junho, 2024'),
                        _buildSummaryRow('Horário', '08:00 - 14:30'),
                        _buildSummaryRow('Duração', '7h 30m'),
                        const Divider(),
                        _buildSummaryRow('Preço', 'R\$ 1.200,00',
                            isPrice: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Passenger Information
                  _buildSectionCard(
                    title: 'Dados do Passageiro',
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Nome Completo',
                            prefixIcon: Icon(Icons.person,
                                color: AppTheme.accentOrange),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon:
                                Icon(Icons.email, color: AppTheme.accentOrange),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: 'Telefone',
                            prefixIcon:
                                Icon(Icons.phone, color: AppTheme.accentOrange),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _cpfController,
                          decoration: InputDecoration(
                            hintText: 'CPF',
                            prefixIcon:
                                Icon(Icons.badge, color: AppTheme.accentOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Payment Method
                  _buildSectionCard(
                    title: 'Método de Pagamento',
                    child: Column(
                      children: [
                        _buildPaymentOption(
                          'credit_card',
                          'Cartão de Crédito',
                          Icons.credit_card,
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentOption(
                          'debit_card',
                          'Cartão de Débito',
                          Icons.credit_card,
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentOption(
                          'pix',
                          'PIX',
                          Icons.qr_code,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Card Details
                  if (_paymentMethod == 'credit_card' ||
                      _paymentMethod == 'debit_card')
                    _buildSectionCard(
                      title: 'Dados do Cartão',
                      child: Column(
                        children: [
                          TextField(
                            controller: _cardController,
                            decoration: InputDecoration(
                              hintText: 'Número do Cartão',
                              prefixIcon: Icon(Icons.credit_card,
                                  color: AppTheme.accentOrange),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'MM/AA',
                                    prefixIcon: Icon(Icons.calendar_today,
                                        color: AppTheme.accentOrange),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'CVV',
                                    prefixIcon: Icon(Icons.lock,
                                        color: AppTheme.accentOrange),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Terms & Conditions
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _agreeTerms,
                            onChanged: (value) {
                              setState(() => _agreeTerms = value ?? false);
                            },
                            activeColor: AppTheme.accentOrange,
                          ),
                          Expanded(
                            child: Text(
                              'Concordo com os termos e condições',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Total Price
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.accentOrange.withValues(alpha: 0.1),
                          AppTheme.accentOrange.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppTheme.accentOrange.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total a Pagar:',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryNavy,
                          ),
                        ),
                        Text(
                          'R\$ 1.200,00',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _agreeTerms
                          ? () {
                              Navigator.pushNamed(context, '/confirmation');
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Confirmar Compra',
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
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String number, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.accentOrange : Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Color(0xFF9CA3AF),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProgressLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: AppTheme.accentOrange,
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isPrice ? FontWeight.bold : FontWeight.w600,
              color: isPrice ? AppTheme.accentOrange : AppTheme.primaryNavy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, String label, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: _paymentMethod == value
                ? AppTheme.accentOrange
                : Color(0xFFE5E7EB),
            width: _paymentMethod == value ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: _paymentMethod == value
              ? AppTheme.accentOrange.withValues(alpha: 0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              _paymentMethod == value
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: _paymentMethod == value
                  ? AppTheme.accentOrange
                  : Color(0xFFE5E7EB),
            ),
            const SizedBox(width: 12),
            Icon(icon, color: AppTheme.primaryNavy),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
