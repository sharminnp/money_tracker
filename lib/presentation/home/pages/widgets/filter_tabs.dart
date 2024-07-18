import 'package:flutter/material.dart';
import 'package:msa_money_tracker/core/enums/filter_expense.dart';
import 'package:msa_money_tracker/core/extensions/string_extenstion.dart';
import 'package:msa_money_tracker/core/widgets/chip_card.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({
    super.key,
    required this.valueNotifier,
  });

  final ValueNotifier<FilterExpense> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterExpense>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return SelectionTabWidget(
          tabs: FilterExpense.values.map((e) => e.name).toList(),
          onSelected: (value) {
            valueNotifier.value = value.toFilterExpense();
          },
          selected: value.name,
        );
      },
    );
  }
}

class FilterSecondaryTabsWidget extends StatelessWidget {
  const FilterSecondaryTabsWidget({
    super.key,
    required this.dates,
    required this.valueNotifier,
  });

  final List<String> dates;
  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: valueNotifier,
      builder: (context, snapshot, child) {
        return SelectionTabWidget(
          tabs: dates,
          onSelected: (value) {
            valueNotifier.value = value;
          },
          selected: valueNotifier.value,
        );
      },
    );
  }
}

class SelectionTabWidget extends StatelessWidget {
  const SelectionTabWidget({
    super.key,
    required this.tabs,
    required this.onSelected,
    required this.selected,
  });

  final Function(String value) onSelected;
  final String selected;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 4),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final e = tabs[index];
          return ChipCard(
            title: e,
            onPressed: () {
              onSelected(e);
            },
            isSelected: e == selected,
          );
        },
      ),
    );
  }
}
