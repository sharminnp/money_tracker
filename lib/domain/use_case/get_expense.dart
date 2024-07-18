import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/repository/expense_repo.dart';

abstract class GetExpense {
  Future<Either<Failure, Unit>> addExpense(Expense expense);
  Future<Either<Failure, Unit>> editExpense(Expense expense);
  Future<Either<Failure, Unit>> deleteExpense(String id);
}

@LazySingleton(as: GetExpense)
class GetExpenseImpl extends GetExpense {
  final IExpenseRepo _expenseRepo;

  GetExpenseImpl(this._expenseRepo);
  @override
  Future<Either<Failure, Unit>> addExpense(Expense expense) {
    return _expenseRepo.addExpense(expense);
  }

  @override
  Future<Either<Failure, Unit>> editExpense(Expense expense) {
    return _expenseRepo.editExpense(expense);
  }

  @override
  Future<Either<Failure, Unit>> deleteExpense(String id) {
    return _expenseRepo.deleteExpense(id);
  }
}
