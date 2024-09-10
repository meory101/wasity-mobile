import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/branch/products_by_sub_branchId.dart';

class SubBranchPage extends StatelessWidget {
  final int mainBranchId;

  final ValueNotifier<ThemeMode>? themeNotifier;

  const SubBranchPage(
      {super.key, this.themeNotifier, required this.mainBranchId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Scaffold(
      appBar: SecondAppbar(
        titleText: "Branches",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: AppHeightManager.h4,
          left: AppWidthManager.w5,
          right: AppWidthManager.w5,
        ),
        child: FutureBuilder<List<SubBranch>>(
          future: fetchSubBranches(mainBranchId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: AppTextWidget(text: 'Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: AppTextWidget(text: 'No branches available'));
            } else {
              final subBranches = snapshot.data!;

              return ListView.builder(
                itemCount: subBranches.length,
                itemBuilder: (context, index) {
                  final subBranch = subBranches[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppHeightManager.h2),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: DecoratedContainer(
                            color: isDarkMode
                                ? AppColorManager.lightGrey
                                : AppColorManager.hint,
                            height: AppHeightManager.h20,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: AppHeightManager.h16,
                                  width: AppWidthManager.w100,
                                  child: DecoratedContainer(
                                    color: AppColorManager.black,
                                    child: Image.network(
                                      '${Config.imageUrl}/${subBranch.image}',
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                            'assets/images/placeholder.png');
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppWidthManager.w4,
                                    top: AppHeightManager.h1,
                                  ),
                                  child: Row(
                                    children: [
                                      AppTextWidget(
                                        text: "Status: ",
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          color: isDarkMode
                                              ? AppColorManager.navyLightBlue
                                              : AppColorManager.black,
                                        ),
                                      ),
                                      AppTextWidget(
                                        text: subBranch.status,
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          color: subBranch.statusColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: AppHeightManager.h9,
                          left: AppWidthManager.w6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsBySubBranchid(
                                        subBranchId: subBranch.id,
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                  );
                                },
                                child: AppTextWidget(
                                  text: subBranch.name,
                                  style:
                                      theme.textTheme.headlineLarge?.copyWith(
                                    color: isDarkMode
                                        ? AppColorManager.whiteBlue
                                        : AppColorManager.navyBlue,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_sharp,
                                  color: isDarkMode
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                  size: AppRadiusManager.r30,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsBySubBranchid(
                                        subBranchId: subBranch.id,
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
