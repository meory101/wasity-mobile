import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/home/widgets/containers/new_arrivais_container.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';
import 'package:wasity/features/pages/status/not_found_page.dart';

class NewArrivais extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const NewArrivais({super.key, this.themeNotifier});

  @override
  // ignore: library_private_types_in_public_api
  _NewArrivaisState createState() => _NewArrivaisState();
}

class _NewArrivaisState extends State<NewArrivais> {
    late Future<List<Product>> _futureNewItems; 


  @override
  void initState() {
    super.initState();
    _futureNewItems = fetchNewItems();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: SecondAppbar(
          onBack: () {
            Navigator.pop(context);
          },
          titleText: "New Arrivals",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SearchFormField(),
              SizedBox(height: AppHeightManager.h3),
              Expanded(
                child: FutureBuilder<List<Product>>(
                  // تعديل النوع هنا
                  future: _futureNewItems,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const NotFoundScreen();
                    }

                    final allNewItems =
                        snapshot.data!; 

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppWidthManager.w3,
                        childAspectRatio:
                            AppWidthManager.w25 / AppHeightManager.h23,
                      ),
                      itemCount: allNewItems.length,
                      itemBuilder: (context, index) {
                        final product = allNewItems[index];
                        return NewArrivaisContainer(
                          themeNotifier: widget.themeNotifier,
                          product: product,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

