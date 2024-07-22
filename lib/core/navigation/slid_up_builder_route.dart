import 'package:flutter/cupertino.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/16/2024.
 */

class SlidUpBuilderRoute extends PageRouteBuilder {
  final Widget page;
  final Duration? duration;

  SlidUpBuilderRoute({
    required this.page,
       this.duration,
  }) : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              const Offset begin = Offset(0.0, 1.0); // from bottom to up
              const Offset end = Offset.zero;
              const Cubic curve = Curves.ease;

              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: duration ?? const Duration(milliseconds: 300));
}
