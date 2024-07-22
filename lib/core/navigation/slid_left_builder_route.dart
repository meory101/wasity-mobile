import 'package:flutter/cupertino.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/16/2024.
 */

class SlidLeftBuilderRoute extends PageRouteBuilder {
  final Widget page;
  SlidLeftBuilderRoute({required this.page})
      : super(
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
              const Offset begin = Offset(-1.0, 0.0); // Slide from the left
              const Offset end = Offset.zero;
              const Cubic curve = Curves.ease;

              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(

                position: animation.drive(tween),
                child: child,
              );
            });
}
