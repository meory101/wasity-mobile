import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/pages/home/screens/home_screen.dart';
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
  var data; // Map to hold product data

  onSearchClickedCallApi() async {
    http.Response response = await http.post(
        Uri.parse('http://192.168.134.84:5000/api/getMostReleventProducts'),
        body: {"searchQuery": irSearch.text});

    var body = jsonDecode(response.body);

    data = body['releventProducts'];

    setState(() {});
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
                data == null
                    ? const SizedBox() 
                    : Visibility(
                        visible: data != null,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              data.length, 
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                AppTextWidget(
                                  text: data![index]
                                      ['name'], // Accessing name by index
                                  color: AppColorManager.white,
                                ),
                                AppTextWidget(
                                  text: data![index]
                                      ['desc'], // Accessing description
                                  color: AppColorManager.white,
                                ),
                                Image.network(
                                  '${Config.imageUrl}/${data![index]['image']}', // Add your image base URL
                                  fit: BoxFit.cover,
                                ),
                                AppTextWidget(
                                  text: 'Price: ${data![index]['price']}',
                                  color: AppColorManager.white,
                                ),
                              ],
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
