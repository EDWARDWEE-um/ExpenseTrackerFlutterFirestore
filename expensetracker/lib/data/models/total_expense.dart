import 'package:json_annotation/json_annotation.dart';

part 'total_expense.g.dart';

@JsonSerializable()
class TotalExpense {
  double totalExpense;
  double totalDailyExpense;
  double totalWeeklyExpense;
  double totalMonthlyExpense;
  double totalYearlyExpense;

  TotalExpense({
    required this.totalExpense,
    required this.totalDailyExpense,
    required this.totalWeeklyExpense,
    required this.totalMonthlyExpense,
    required this.totalYearlyExpense,
  });

  factory TotalExpense.fromJson(Map<String, dynamic> json) =>
      _$TotalExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$TotalExpenseToJson(this);
}
