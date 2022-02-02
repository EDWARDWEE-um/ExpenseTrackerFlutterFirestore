// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_docid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDocID _$TransactionDocIDFromJson(Map<String, dynamic> json) =>
    TransactionDocID(
      docID: json['docID'] as String,
      expense: json['expense'] == null
          ? null
          : Expense.fromJson(json['expense'] as Map<String, dynamic>),
      income: json['income'] == null
          ? null
          : Income.fromJson(json['income'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionDocIDToJson(TransactionDocID instance) =>
    <String, dynamic>{
      'docID': instance.docID,
      'expense': instance.expense,
      'income': instance.income,
    };
