import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool expanded;
  final Duration duration;
  final Curve curve;
  final double elevation;
  final Color? color;
  final BorderRadius? borderRadius;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.expanded = false,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.elevation = 1.0,
    this.color,
    this.borderRadius,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap!();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: AnimatedContainer(
                duration: widget.duration,
                curve: widget.curve,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).cardColor,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(widget.expanded ? 0 : 12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: widget.elevation * 4,
                      offset: Offset(0, widget.elevation * 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(widget.expanded ? 0 : 12),
                  child: child,
                ),
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
