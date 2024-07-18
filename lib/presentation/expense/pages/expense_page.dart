import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';
import 'package:msa_money_tracker/core/error/failure.dart';
import 'package:msa_money_tracker/core/widgets/app_textfield.dart';
import 'package:msa_money_tracker/core/widgets/date_time_picker.dart';
import 'package:msa_money_tracker/domain/entity/expense.dart';
import 'package:msa_money_tracker/presentation/expense/bloc/expense_bloc/expense_bloc.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({
    super.key,
    this.expense,
  });

  final Expense? expense;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController descController;
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.expense?.name);
    amountController =
        TextEditingController(text: widget.expense?.amount.toString());
    descController = TextEditingController(text: widget.expense?.description);
    selectedDate = widget.expense?.time ?? DateTime.now();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseFailed) {
          var snackBar = SnackBar(
            content: Text(state.failure.errorMsg),
            backgroundColor: UiColors.error,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ExpenseSuccess) {
          var snackBar = const SnackBar(
            content: Text("succsss"),
            backgroundColor: UiColors.primary,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pop(context),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _globalKey,
          backgroundColor: UiColors.secondary,
          extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: UiColors.ternary,
              ),
            ),
            scrolledUnderElevation: 0,
            backgroundColor: UiColors.primary,
            title: Text(
              "${widget.expense != null ? "Edit" : "Add"} Expense",
              style: const TextStyle(
                color: UiColors.ternary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  AppTextfield(
                    hintText: "Expense Name",
                    keyboardType: TextInputType.emailAddress,
                    controller: nameController,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Expense name is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  AppTextfield(
                    hintText: "Amount",
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (amount) {
                      if (amount == null || amount.isEmpty) {
                        return "Amount is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  AppTextfield(
                    hintText: "Description",
                    keyboardType: TextInputType.emailAddress,
                    controller: descController,
                  ),
                  SizedBox(height: 10.h),
                  DateTimePicker(
                    initialDate: selectedDate,
                    onDatePicked: (value) {
                      selectedDate = value;
                    },
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UiColors.primary,
                      ),
                      onPressed: () => onAddExpense(),
                      child: Text(
                        widget.expense != null ? "Edit" : "Add",
                        style: const TextStyle(
                          color: UiColors.ternary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> onAddExpense() async {
    if (formKey.currentState?.validate() ?? false) {
      final name = nameController.text.trim();
      final amount = amountController.text.trim();
      final description = descController.text.trim();

      final expense = Expense(
        id: widget.expense != null
            ? widget.expense!.id
            : DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        amount: double.tryParse(amount) ?? 0,
        description: description,
        time: selectedDate,
      );
      nameController.clear();
      amountController.clear();
      descController.clear();
      if (widget.expense != null) {
        BlocProvider.of<ExpenseBloc>(context).add(EditExpense(expense));
      } else {
        BlocProvider.of<ExpenseBloc>(context).add(AddExpense(expense));
      }
    }
  }
}
