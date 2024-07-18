import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/core/local_storage/local_storage.dart';
import 'package:msa_money_tracker/data/model/expense_model.dart';

abstract class ExpenseDataSource {
  Future<Either<Failure, Unit>> addExpense(ExpenseModel expense);
  Future<Either<Failure, Unit>> editExpense(ExpenseModel expense);
  Future<Either<Failure, Unit>> deleteExpense(String id);
}

@LazySingleton(as: ExpenseDataSource)
class ExpenseDataSourceImpl extends ExpenseDataSource {
  final LocalStorage _localStorage;

  ExpenseDataSourceImpl(this._localStorage);
  @override
  Future<Either<Failure, Unit>> addExpense(ExpenseModel expense) async {
    try {
      await _localStorage.putData<ExpenseModel>(
        boxName: HiveBox.expense,
        key: expense.id,
        value: expense,
      );
      return right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return left(const UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editExpense(ExpenseModel expense) async {
    try {
      await _localStorage.putData<ExpenseModel>(
        boxName: HiveBox.expense,
        key: expense.id,
        value: expense,
      );
      return right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return left(const UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExpense(String id) async {
    try {
      await _localStorage.deleteData<ExpenseModel>(
        boxName: HiveBox.expense,
        key: id,
      );
      return right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return left(const UnexpectedFailure());
    }
  }
}
