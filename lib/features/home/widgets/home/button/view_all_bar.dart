import 'package:flutter/cupertino.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class ViewAllBar extends StatefulWidget {
  final String title;
  final VoidCallback onViewAllPressed;

  const ViewAllBar({
    required this.title,
    required this.onViewAllPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewAllBar> createState() => _ViewAllBarState();
}

class _ViewAllBarState extends State<ViewAllBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppHeightManager.h2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                text: widget.title,
                fontSize: FontSizeManager.fs19,
                fontWeight: FontWeight.bold,
              ),
              GestureDetector(
                onTap: widget.onViewAllPressed,
                child: AppTextWidget(
                  text: "View All",
                  fontSize: FontSizeManager.fs16point5,
                  color: AppColorManager.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
