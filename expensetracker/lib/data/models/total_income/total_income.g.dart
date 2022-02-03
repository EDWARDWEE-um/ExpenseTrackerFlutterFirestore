// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalIncome _$TotalIncomeFromJson(Map<String, dynamic> json) => TotalIncome(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalDailyIncome: (json['totalDailyIncome'] as num).toDouble(),
      totalWeeklyIncome: (json['totalWeeklyIncome'] as num).toDouble(),
      totalMonthlyIncome: (json['totalMonthlyIncome'] as num).toDouble(),
      totalYearlyIncome: (json['totalYearlyIncome'] as num).toDouble(),
    );

Map<String, dynamic> _$TotalIncomeToJson(TotalIncome instance) =>
    <String, dynamic>{
      'totalIncome': instance.totalIncome,
      'totalDailyIncome': instance.totalDailyIncome,
      'totalWeeklyIncome': instance.totalWeeklyIncome,
      'totalMonthlyIncome': instance.totalMonthlyIncome,
      'totalYearlyIncome': instance.totalYearlyIncome,
    };
