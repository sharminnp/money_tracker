import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/data/data_source/home_data_source.dart';
import 'package:msa_money_tracker/data/mappers/expense_mapper.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/repository/home_repo.dart';

@LazySingleton(as: IHomeRepo)
class HomeRepoImpl implements IHomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Expense>>> getExpense() async {
    final result = await dataSource.getExpense();
    return result.fold(
      (failure) => Left(failure),
      (expenses) => Right(expenses.map(ExpenseMapper.fromModel).toList()),
    );
  }
}
