// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:msa_money_tracker/core/constants/ui_colors.dart';
import 'package:msa_money_tracker/core/extensions/time_extensions.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.onDatePicked,
    required this.initialDate,
  });
  final ValueChanged<DateTime> onDatePicked;
  final DateTime initialDate;
  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() => selectedDate = widget.initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () async {
              final DateTime? dateTime = await _showDatePicker(
                context,
                selectedDateTime: DateTime.now(),
              );
              if (dateTime != null) {
                setState(() => selectedDate = dateTime);
                widget.onDatePicked(dateTime);
              }
            },
            leading: const Icon(
              Icons.today_rounded,
              color: UiColors.ternary,
            ),
            title: Text(
              selectedDate.shortDayString,
              style: const TextStyle(
                color: UiColors.ternary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> _showDatePicker(
    BuildContext context, {
    required DateTime selectedDateTime,
  }) {
    return showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
