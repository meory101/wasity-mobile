import 'package:flutter/material.dart';


//Deafult Page If Routing Fail
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Page Not Found"),
    );
  }
}
