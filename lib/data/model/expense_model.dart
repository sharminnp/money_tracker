import 'package:hive_flutter/hive_flutter.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late String? description;

  @HiveField(4)
  late DateTime dateTime;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.description,
    required this.dateTime,
  });
}
