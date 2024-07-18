import 'package:msa_money_tracker/data/model/expense_model.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';

class ExpenseMapper {
  static Expense fromModel(ExpenseModel expense) {
    return Expense(
      id: expense.id,
      name: expense.name,
      amount: expense.amount,
      description: expense.description,
      time: expense.dateTime,
    );
  }

  static ExpenseModel toModel(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      name: expense.name,
      amount: expense.amount,
      description: expense.description,
      dateTime: expense.time,
    );
  }
}
