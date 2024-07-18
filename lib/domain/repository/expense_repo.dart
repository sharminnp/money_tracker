import 'package:dartz/dartz.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';

abstract class IExpenseRepo {
  Future<Either<Failure, Unit>> addExpense(Expense expense);
  Future<Either<Failure, Unit>> editExpense(Expense expense);
  Future<Either<Failure, Unit>> deleteExpense(String id);
}
