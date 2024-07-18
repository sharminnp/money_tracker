part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

final class AddExpense extends ExpenseEvent {
  final Expense expense;
  const AddExpense(this.expense);

  @override
  List<Object> get props => [expense];
}

final class EditExpense extends ExpenseEvent {
  final Expense expense;
  const EditExpense(this.expense);

  @override
  List<Object> get props => [expense];
}

final class DeleteExpense extends ExpenseEvent {
  final String id;
  const DeleteExpense(this.id);

  @override
  List<Object> get props => [id];
}
