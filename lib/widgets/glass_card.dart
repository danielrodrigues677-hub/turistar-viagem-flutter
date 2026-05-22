import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/theme/app_theme_premium.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool enableGlow;

  const GlassCard({
    Key? key,
    required this.child,
    this.borderRadius = 16,
    this.blur = 10,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.enableGlow = true,
  }) : super(key: key);

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: widget.enableGlow
                    ? [
                        BoxShadow(
                          color: AppThemePremium.accentOrange.withOpacity(0.1),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ]
                    : AppThemePremium.shadowElevation2,
              ),
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
