import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar()
          ],
        ),
      ),
    );
  }
}
