import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/domain/use_case/get_home.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHome _getHome;
  HomeBloc(this._getHome) : super(const HomeInitial()) {
    on<GetExpenses>(_getExpense);
  }

  Future<void> _getExpense(
    GetExpenses event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final result = await _getHome.getExpense();
    result.fold(
      (failure) => emit(HomeFailed(failure)),
      (expenses) => emit(HomeSuccess(expenses)),
    );
  }
}
