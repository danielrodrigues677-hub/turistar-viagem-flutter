import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_theme_premium.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final LinearGradient? gradient;
  final double borderRadius;
  final EdgeInsets padding;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = widget.gradient ?? AppThemePremium.gradientPrimaryOrange;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (!widget.isLoading) widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.fullWidth ? double.infinity : null,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: AppThemePremium.shadowGlowOrange,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Padding(
                padding: widget.padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null && !widget.isLoading) ...[
                      Icon(widget.icon, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                    ],
                    if (widget.isLoading)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Text(
                        widget.label,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
