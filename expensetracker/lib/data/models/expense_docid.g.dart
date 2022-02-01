// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_docid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDocID _$ExpenseDocIDFromJson(Map<String, dynamic> json) => ExpenseDocID(
      docID: json['docID'] as String,
      expense: Expense.fromJson(json['expense'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpenseDocIDToJson(ExpenseDocID instance) =>
    <String, dynamic>{
      'docID': instance.docID,
      'expense': instance.expense,
    };
