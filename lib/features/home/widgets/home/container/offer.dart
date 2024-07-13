import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Offer extends StatelessWidget {
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppHeightManager.h3Point5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadiusManager.r5),
            child: Container(
              height: AppHeightManager.h18,
              width: AppWidthManager.w110,
              child: Image.asset(
                AppImageManager.offerImage,
                fit: BoxFit.fill,
              ),
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
                  Navigator.pushNamed(context, '/offer');
                },
                child: AppTextWidget(
                  style: TextStyle(
                    color: AppColorManager.white,
                    fontSize: FontSizeManager.fs18,
                  ),
                  text: ' View More ',
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColorManager.white,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/offer');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
