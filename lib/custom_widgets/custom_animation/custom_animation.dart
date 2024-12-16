import 'package:flutter/material.dart';

void navigateToNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start position (right side)
        const end = Offset.zero;        // End position (center)
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}


/// Navigate back with a slide-to-right animation
void navigateBackWithAnimation(BuildContext context) {
  Navigator.of(context).pop(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset.zero;      // Start position (center)
        const end = Offset(1.0, 0.0);   // End position (right side)
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

