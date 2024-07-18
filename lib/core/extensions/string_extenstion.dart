import 'package:msa_money_tracker/core/enums/filter_expense.dart';

extension Filter on String {
  FilterExpense toFilterExpense() {
    if (this == FilterExpense.yearly.name) {
      return FilterExpense.yearly;
    } else if (this == FilterExpense.daily.name) {
      return FilterExpense.daily;
    } else if (this == FilterExpense.weekly.name) {
      return FilterExpense.weekly;
    } else if (this == FilterExpense.monthly.name) {
      return FilterExpense.monthly;
    } else {
      return FilterExpense.all;
    }
  }
}
