part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

final class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

final class ExpenseFailed extends ExpenseState {
  final Failure failure;
  const ExpenseFailed(this.failure);
  @override
  List<Object> get props => [...super.props, failure];
}

final class ExpenseSuccess extends ExpenseState {
  const ExpenseSuccess();
}
