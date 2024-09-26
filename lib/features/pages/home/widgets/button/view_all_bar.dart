import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class ViewAllBar extends StatefulWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final String? viewAllText;
  final bool showViewAll;

  const ViewAllBar({
    required this.title,
    this.onViewAllPressed,
    this.viewAllText,
    this.showViewAll = true,
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

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h1point5),
      child: Column(
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
              if (widget.showViewAll &&
                  widget.viewAllText != null) 
                GestureDetector(
                  onTap: widget.onViewAllPressed,
                  child: AppTextWidget(
                    text: widget.viewAllText!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
