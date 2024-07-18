import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/use_case/get_expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpense _getExpense;
  ExpenseBloc({required GetExpense getExpense})
      : _getExpense = getExpense,
        super(const ExpenseInitial()) {
    on<AddExpense>(_addExpense);
    on<EditExpense>(_editExpense);
    on<DeleteExpense>(_deleteExpense);
  }

  Future<void> _addExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseLoading());
    final result = await _getExpense.addExpense(event.expense);
    result.fold(
      (failure) => emit(ExpenseFailed(failure)),
      (_) => emit(const ExpenseSuccess()),
    );
  }

  Future<void> _editExpense(
    EditExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseLoading());
    final result = await _getExpense.editExpense(event.expense);
    result.fold(
      (failure) => emit(ExpenseFailed(failure)),
      (_) => emit(const ExpenseSuccess()),
    );
  }

  Future<void> _deleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(const ExpenseLoading());
    final result = await _getExpense.deleteExpense(event.id);
    result.fold(
      (failure) => emit(ExpenseFailed(failure)),
      (_) => emit(const ExpenseSuccess()),
    );
  }
}
