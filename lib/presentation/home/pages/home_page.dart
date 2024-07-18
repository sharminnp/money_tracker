import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msa_money_tracker/core/animation/animation.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';
import 'package:msa_money_tracker/core/enums/filter_expense.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/core/extensions/time_extensions.dart';
import 'package:msa_money_tracker/core/widgets/app_divider.dart';
import 'package:msa_money_tracker/core/widgets/loading_view.dart';
import 'package:msa_money_tracker/core/widgets/silver_grouped_listview.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/presentation/expense/bloc/expense_bloc/expense_bloc.dart';
import 'package:msa_money_tracker/presentation/expense/pages/expense_page.dart';
import 'package:msa_money_tracker/presentation/home/bloc/home_bloc/home_bloc.dart';
import 'package:msa_money_tracker/presentation/home/pages/widgets/filter_tabs.dart';
import 'package:msa_money_tracker/presentation/home/pages/widgets/expense_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static final valueNotifier = ValueNotifier(FilterExpense.all);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => BlocProvider.of<HomeBloc>(context).add(GetExpenses()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UiColors.primary,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            child: AnimationBuildLogin(
              size: size,
              yOffset: size.height / 10.h,
              color: UiColors.secondary,
            ),
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 125.h,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: FilterTabs(valueNotifier: HomePage.valueNotifier),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: LoadingView(),
                      ),
                    );
                  } else if (state is HomeFailed) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(
                            state.failure.errorMsg,
                            style: const TextStyle(
                              color: UiColors.ternary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                GetExpenses(),
                              );
                            },
                            child: const Text("Try Again"),
                          )
                        ],
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    return BlocListener<ExpenseBloc, ExpenseState>(
                      listener: (context, state) {
                        if (state is ExpenseSuccess) {
                          BlocProvider.of<HomeBloc>(context).add(GetExpenses());
                        }
                      },
                      child: ValueListenableBuilder<FilterExpense>(
                        valueListenable: HomePage.valueNotifier,
                        builder: (context, value, child) {
                          return state.expenses.isEmpty
                              ? SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height / 2 - 150,
                                      ),
                                      const Text(
                                        "Add Expenses",
                                        style: TextStyle(
                                          color: UiColors.ternary,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SliverGroupedListView<Expense, String>(
                                  elements: state.expenses,
                                  groupBy: (element) =>
                                      element.time.formatted(value),
                                  separator: const AppDivider(),
                                  sort: true,
                                  groupSeparatorBuilder: (value, groupTotal) {
                                    return ListTile(
                                      title: Text(
                                        value,
                                        style: const TextStyle(
                                          color: UiColors.ternary,
                                        ),
                                      ),
                                      trailing: Text(
                                        groupTotal.toString(),
                                        style: const TextStyle(
                                          color: UiColors.ternary,
                                        ),
                                      ),
                                    );
                                  },
                                  groupTotalCalculator:
                                      (List<Expense> groupElements) {
                                    return groupElements.fold(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + (element.amount),
                                    );
                                  },
                                  itemBuilder: (context, expense) {
                                    return ExpenseItemWidget(
                                      expense: expense,
                                      onDeleteTap: () {
                                        BlocProvider.of<ExpenseBloc>(context)
                                            .add(
                                          DeleteExpense(expense.id),
                                        );
                                      },
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ExpensePage(
                                              expense: expense,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                        },
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: LoadingView(),
                  );
                },
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: UiColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExpensePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: UiColors.ternary,
        ),
      ),
    );
  }
}
