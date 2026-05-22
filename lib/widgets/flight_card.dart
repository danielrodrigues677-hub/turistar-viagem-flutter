import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_theme.dart';

class FlightCard extends StatefulWidget {
  final String airline;
  final String departure;
  final String arrival;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const FlightCard({
    Key? key,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isSelected) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: widget.isSelected ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: widget.isSelected
                  ? AppTheme.accentOrange
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: widget.isSelected
                  ? LinearGradient(
                      colors: [
                        AppTheme.accentOrange.withValues(alpha: 0.05),
                        AppTheme.accentOrange.withValues(alpha: 0.02),
                      ],
                    )
                  : null,
            ),
            child: Column(
              children: [
                // Airline Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.airline,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accentOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'R\$ ${widget.price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Flight Timeline
                Row(
                  children: [
                    // Departure
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.departureTime,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.departure,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Duration & Arrow
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            color: AppTheme.accentOrange,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.duration,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrival
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.arrivalTime,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.arrival,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Direto',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    if (widget.isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.accentOrange,
                        size: 20,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
