import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/repository/home_repo.dart';

abstract class GetHome {
  Future<Either<Failure, List<Expense>>> getExpense();
}

@LazySingleton(as: GetHome)
class GetHomeImpl extends GetHome {
  final IHomeRepo _homeRepo;

  GetHomeImpl(this._homeRepo);
  @override
  Future<Either<Failure, List<Expense>>> getExpense() {
    return _homeRepo.getExpense();
  }
}
