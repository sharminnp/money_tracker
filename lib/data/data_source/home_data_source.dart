import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/core/local_storage/local_storage.dart';
import 'package:msa_money_tracker/data/model/expense_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, List<ExpenseModel>>> getExpense();
}

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl extends HomeDataSource {
  final LocalStorage _localStorage;

  HomeDataSourceImpl(this._localStorage);

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpense() async {
    try {
      final expenses = await _localStorage.readAllData<ExpenseModel>(
        boxName: HiveBox.expense,
      );
      return right(expenses);
    } catch (e) {
      debugPrint(e.toString());
      return left(const UnexpectedFailure());
    }
  }
}
