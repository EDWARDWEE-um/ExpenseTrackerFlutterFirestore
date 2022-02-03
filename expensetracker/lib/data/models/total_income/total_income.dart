import 'package:json_annotation/json_annotation.dart';

part 'total_income.g.dart';

@JsonSerializable()
class TotalIncome {
  double totalIncome;
  double totalDailyIncome;
  double totalWeeklyIncome;
  double totalMonthlyIncome;
  double totalYearlyIncome;

  TotalIncome({
    required this.totalIncome,
    required this.totalDailyIncome,
    required this.totalWeeklyIncome,
    required this.totalMonthlyIncome,
    required this.totalYearlyIncome,
  });

  factory TotalIncome.fromJson(Map<String, dynamic> json) =>
      _$TotalIncomeFromJson(json);
  Map<String, dynamic> toJson() => _$TotalIncomeToJson(this);
}
