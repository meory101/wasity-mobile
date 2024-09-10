import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/branch/sub_branch.dart';

class MainBranch extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MainBranch({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final MainBranches apiService = MainBranches();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: 'Main Branchs',
        onBack: () {
          Navigator.pushNamed(context, '/ButtonNavbar');
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppWidthManager.w4,
          right: AppWidthManager.w4,
          top: AppHeightManager.h4,
        ),
        child: FutureBuilder<List<MainBranchModel>>(
          future: apiService.fetchMainBranches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final branches = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppHeightManager.h2,
                  crossAxisSpacing: AppWidthManager.w2,
                  childAspectRatio:
                      (AppWidthManager.w25 / AppHeightManager.h14),
                ),
                itemCount: branches.length,
                itemBuilder: (context, index) {
                  final branch = branches[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubBranchPage(
                              mainBranchId:  branch.id,
                                themeNotifier: themeNotifier,
                              ),
                            ),
                          );
                        },
                        child: DecoratedContainer(
                          width: AppWidthManager.w25,
                          height: AppHeightManager.h11,
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r6),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${Config.imageUrl}/${branch.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppHeightManager.h1point5),
                      AppTextWidget(
                        text: branch.name,
                        height: AppHeightManager.h03,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('No branches available'));
            }
          },
        ),
      ),
    );
  }

  static fromJson(branch) {}
}
