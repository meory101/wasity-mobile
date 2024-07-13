import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/home/widgets/home/container/new_arrivais_container.dart';
import 'package:wasity/features/home/widgets/home/form_field/search_form_field.dart';

//?All product هي نفسا
class NewArrivais extends StatelessWidget {
  const NewArrivais({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: "NewArrivais",
      ),
      backgroundColor: AppColorManager.navyBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchFormField(),
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
                  return const NewArrivaisContainer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
