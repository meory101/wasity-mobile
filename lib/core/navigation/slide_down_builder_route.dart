import 'package:flutter/cupertino.dart';


class SlidDownBuilderRoute extends PageRouteBuilder {
  final Widget page;
  SlidDownBuilderRoute({required this.page})
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
        const Offset begin = Offset(0.0, -1.0); // from up to bottom
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
