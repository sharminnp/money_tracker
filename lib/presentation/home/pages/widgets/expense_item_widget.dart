import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';
import 'package:msa_money_tracker/core/extensions/time_extensions.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({
    super.key,
    required this.expense,
    required this.onTap,
    required this.onDeleteTap,
  });

  final Expense expense;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  void showDeleteDialog(
    BuildContext context,
    VoidCallback onDeleteTap,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: UiColors.ternary,
        titleTextStyle: const TextStyle(
          color: UiColors.primary,
          fontWeight: FontWeight.w600,
        ),
        title: const Text(
          "Do you want to delete",
        ),
        content: RichText(
          text: TextSpan(
            text: "Delete Expense",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: UiColors.secondary,
            ),
            children: [
              TextSpan(
                text: ' ${expense.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: UiColors.secondary,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: UiColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onDeleteTap();
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: UiColors.error,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onLongPress: () async {
        showDeleteDialog(context, onDeleteTap);
      },
      onTap: onTap,
      title: Text(
        expense.name,
        style: const TextStyle(
          color: UiColors.ternary,
        ),
      ),
      subtitle: Text(
        expense.description ?? "",
        style: TextStyle(
          color: UiColors.ternary,
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
        ),
      ),
      leading: const CircleAvatar(
        backgroundColor: UiColors.primary,
        child: Icon(
          Icons.abc,
          color: Colors.white,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            expense.amount.toString(),
            style: const TextStyle(
              color: UiColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            expense.time.toReadable,
            style: const TextStyle(
              color: UiColors.ternary,
            ),
          )
        ],
      ),
    );
  }
}
