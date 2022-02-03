import 'package:expensetracker/data/models/expense/expense.dart';
import 'package:expensetracker/data/models/income/income.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_docid.g.dart';

@JsonSerializable()
class TransactionDocID {
  late final String docID;
  late final Expense? expense;
  late final Income? income;

  TransactionDocID({
    required this.docID,
    this.expense,
    this.income,
  });

  factory TransactionDocID.fromJson(Map<String, dynamic> json) =>
      _$TransactionDocIDFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDocIDToJson(this);
}
