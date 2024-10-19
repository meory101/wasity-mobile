import 'package:flutter/material.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/pages/profile/container/wallet_card.dart';

class Wallet extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final int type;

  const Wallet({super.key, this.themeNotifier, required this.type});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  double? balance;
  int? points;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    double? fetchedBalance = await WalletService.fetchAccountData(widget.type);
    int? fetchedPoints = await WalletService.fetchPoints();

    setState(() {
      balance = fetchedBalance;
      points = fetchedPoints;
    });
  }

  Future<void> _refreshPage() async {
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppbar(
        titleText: "Your Wallet",
        onBack: () {
          Navigator.pushNamed(context, '/ProfileInfo');
        },
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), 
          child: WalletCard(balance: balance, points: points ),
        ),
      ),
    );
  }
}
