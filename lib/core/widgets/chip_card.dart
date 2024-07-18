import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';

class ChipCard extends StatelessWidget {
  const ChipCard({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: UiColors.primary,
              border: Border.all(
                width: 1.5,
                color: isSelected ? UiColors.ternary : UiColors.primary,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: UiColors.ternary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
