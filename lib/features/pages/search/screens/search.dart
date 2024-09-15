import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';
import 'package:http/http.dart' as http;

class SearchProducts extends StatefulWidget {
  const SearchProducts({
    super.key,
    required ValueNotifier<ThemeMode> themeNotifier,
  });

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  TextEditingController searchController = TextEditingController();
  onSearchClickedCallApi() async {
    http.Response response = await http.post(
        Uri.parse('http://192.168.1.104:6000/api/getMostReleventProducts'),
        body: {"searchQuery": searchController.text});

    var body = jsonDecode(response.body);
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchFormField(
                  searchController: searchController,
                  onSearchClicked: () {
                    onSearchClickedCallApi();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
