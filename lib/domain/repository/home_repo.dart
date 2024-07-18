import 'package:dartz/dartz.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';

abstract class IHomeRepo {
  Future<Either<Failure, List<Expense>>> getExpense();
}
