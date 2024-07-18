class Expense {
  final String id;
  final String name;
  final double amount;
  final String? description;
  final DateTime time;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.description,
    required this.time,
  });
}
