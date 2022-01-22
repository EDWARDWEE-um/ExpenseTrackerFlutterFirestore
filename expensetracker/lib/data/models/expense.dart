class Expense {
  final String uid;
  final String name;
  final String type;
  final double amount;
  final DateTime dateTime;

  Expense(
      {required this.uid,
      required this.name,
      required this.type,
      required this.amount,
      required this.dateTime});
}
