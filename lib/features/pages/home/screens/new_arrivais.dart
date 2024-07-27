import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/pages/home/containers/new_arrivais_container.dart';
import 'package:wasity/features/pages/home/form_field/search_form_field.dart';

//?All product هي نفسا
class NewArrivais extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const NewArrivais({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: "NewArrivais",
      ),
     
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchFormField(),
            SizedBox(height: AppHeightManager.h3),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppWidthManager.w3,
                  childAspectRatio:
                      (AppWidthManager.w25 / AppHeightManager.h23),
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return NewArrivalsContainer(themeNotifier: themeNotifier);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
