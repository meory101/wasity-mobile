import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import 'app_text_widget.dart';

class PriceText extends StatelessWidget {
  final num? price;
  final TextStyle? priceStyle;
  final TextStyle? style;

  PriceText({required this.price, this.style, this.priceStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          AppTextWidget(
            text: price == null ? "" : price.toString(),
            style: priceStyle ??
                TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSizeManager.fs18),
          ),
          Visibility(
            visible: price != null,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: ' S.P',
                      style: style ??
                          TextStyle(
                              color: AppColorManager.white,
                              fontSize: FontSizeManager.fs10,
                              fontFeatures: const [
                                FontFeature.superscripts()
                              ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
