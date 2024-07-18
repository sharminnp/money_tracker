import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/data/data_source/expense_data_source.dart';
import 'package:msa_money_tracker/data/mappers/expense_mapper.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/repository/expense_repo.dart';

@LazySingleton(as: IExpenseRepo)
class ExpenseRepoImpl implements IExpenseRepo {
  final ExpenseDataSource dataSource;

  ExpenseRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, Unit>> addExpense(Expense expense) async {
    return await dataSource.addExpense(ExpenseMapper.toModel(expense));
  }

  @override
  Future<Either<Failure, Unit>> editExpense(Expense expense) async {
    return await dataSource.editExpense(ExpenseMapper.toModel(expense));
  }

  @override
  Future<Either<Failure, Unit>> deleteExpense(String id) async {
    return await dataSource.deleteExpense(id);
  }
}
