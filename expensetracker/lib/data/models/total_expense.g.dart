// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalExpense _$TotalExpenseFromJson(Map<String, dynamic> json) => TotalExpense(
      totalExpense: (json['totalExpense'] as num).toDouble(),
      totalDailyExpense: (json['totalDailyExpense'] as num).toDouble(),
      totalWeeklyExpense: (json['totalWeeklyExpense'] as num).toDouble(),
      totalMonthlyExpense: (json['totalMonthlyExpense'] as num).toDouble(),
      totalYearlyExpense: (json['totalYearlyExpense'] as num).toDouble(),
    );

Map<String, dynamic> _$TotalExpenseToJson(TotalExpense instance) =>
    <String, dynamic>{
      'totalExpense': instance.totalExpense,
      'totalDailyExpense': instance.totalDailyExpense,
      'totalWeeklyExpense': instance.totalWeeklyExpense,
      'totalMonthlyExpense': instance.totalMonthlyExpense,
      'totalYearlyExpense': instance.totalYearlyExpense,
    };
