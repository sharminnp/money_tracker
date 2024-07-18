part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeFailed extends HomeState {
  final Failure failure;
  const HomeFailed(this.failure);
}

final class HomeSuccess extends HomeState {
  final List<Expense> expenses;
  const HomeSuccess(this.expenses);
}
