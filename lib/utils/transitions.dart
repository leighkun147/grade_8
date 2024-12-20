import 'package:flutter/material.dart';

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  SlidePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = _getBeginOffset(direction);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

  static Offset _getBeginOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.right:
        return const Offset(1.0, 0.0);
      case SlideDirection.left:
        return const Offset(-1.0, 0.0);
      case SlideDirection.up:
        return const Offset(0.0, -1.0);
      case SlideDirection.down:
        return const Offset(0.0, 1.0);
    }
  }
}

enum SlideDirection {
  right,
  left,
  up,
  down,
}

class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScalePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
}

class CustomNavigator {
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slide,
    SlideDirection direction = SlideDirection.right,
  }) {
    switch (type) {
      case TransitionType.fade:
        return Navigator.push(context, FadePageRoute(page: page));
      case TransitionType.slide:
        return Navigator.push(
          context,
          SlidePageRoute(page: page, direction: direction),
        );
      case TransitionType.scale:
        return Navigator.push(context, ScalePageRoute(page: page));
    }
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TransitionType type = TransitionType.slide,
    SlideDirection direction = SlideDirection.right,
  }) {
    switch (type) {
      case TransitionType.fade:
        return Navigator.pushReplacement(context, FadePageRoute(page: page));
      case TransitionType.slide:
        return Navigator.pushReplacement(
          context,
          SlidePageRoute(page: page, direction: direction),
        );
      case TransitionType.scale:
        return Navigator.pushReplacement(context, ScalePageRoute(page: page));
    }
  }
}

enum TransitionType {
  fade,
  slide,
  scale,
}
