import 'package:flutter/material.dart';


//Deafult Page If Routing Fail
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Page Not Found"),
    );
  }
}
