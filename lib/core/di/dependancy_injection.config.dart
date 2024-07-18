// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:msa_money_tracker/core/local_storage/local_storage.dart' as _i3;
import 'package:msa_money_tracker/data/data_source/expense_data_source.dart'
    as _i7;
import 'package:msa_money_tracker/data/data_source/home_data_source.dart'
    as _i4;
import 'package:msa_money_tracker/data/repository/expense_repo_impl.dart'
    as _i9;
import 'package:msa_money_tracker/data/repository/home_repo_impl.dart' as _i6;
import 'package:msa_money_tracker/domain/repository/expense_repo.dart' as _i8;
import 'package:msa_money_tracker/domain/repository/home_repo.dart' as _i5;
import 'package:msa_money_tracker/domain/use_case/get_expense.dart' as _i11;
import 'package:msa_money_tracker/domain/use_case/get_home.dart' as _i10;
import 'package:msa_money_tracker/presentation/expense/bloc/expense_bloc/expense_bloc.dart'
    as _i13;
import 'package:msa_money_tracker/presentation/home/bloc/home_bloc/home_bloc.dart'
    as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LocalStorage>(() => _i3.LocalStorage());
    gh.lazySingleton<_i4.HomeDataSource>(
        () => _i4.HomeDataSourceImpl(gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i5.IHomeRepo>(
        () => _i6.HomeRepoImpl(gh<_i4.HomeDataSource>()));
    gh.lazySingleton<_i7.ExpenseDataSource>(
        () => _i7.ExpenseDataSourceImpl(gh<_i3.LocalStorage>()));
    gh.lazySingleton<_i8.IExpenseRepo>(
        () => _i9.ExpenseRepoImpl(gh<_i7.ExpenseDataSource>()));
    gh.lazySingleton<_i10.GetHome>(() => _i10.GetHomeImpl(gh<_i5.IHomeRepo>()));
    gh.lazySingleton<_i11.GetExpense>(
        () => _i11.GetExpenseImpl(gh<_i8.IExpenseRepo>()));
    gh.factory<_i12.HomeBloc>(() => _i12.HomeBloc(gh<_i10.GetHome>()));
    gh.factory<_i13.ExpenseBloc>(
        () => _i13.ExpenseBloc(getExpense: gh<_i11.GetExpense>()));
    return this;
  }
}
