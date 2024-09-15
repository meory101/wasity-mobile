import 'package:flutter/material.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class ViewAllBar extends StatefulWidget {
  final String title;
  final VoidCallback? onViewAllPressed;

  const ViewAllBar({
    required this.title,
     this.onViewAllPressed,
    super.key,
  });

  @override
  State<ViewAllBar> createState() => _ViewAllBarState();
}

class _ViewAllBarState extends State<ViewAllBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: widget.title,
              style: theme.textTheme.displayLarge?.copyWith(
                color: textColor,
              ),
            ),
            GestureDetector(
              onTap: widget.onViewAllPressed,
              child: AppTextWidget(
                text: "View All",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
