// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      uid: json['uid'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      dateTime:
          const TimeStampConverter().fromJson(json['dateTime'] as Timestamp),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'type': instance.type,
      'amount': instance.amount,
      'dateTime': const TimeStampConverter().toJson(instance.dateTime),
    };
