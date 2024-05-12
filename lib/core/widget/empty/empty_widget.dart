import 'package:flutter/material.dart';

import '../../resource/font_manager.dart';
import '../text/app_text_widget.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AppTextWidget(
        text: "Empty item",
        fontSize: FontSizeManager.fs15,
      ),
    );
  }
}
