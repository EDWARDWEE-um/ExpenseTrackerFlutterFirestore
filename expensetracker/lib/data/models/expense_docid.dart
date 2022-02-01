import 'package:expensetracker/data/models/expense.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_docid.g.dart';

@JsonSerializable()
class ExpenseDocID {
  late final String docID;
  late final Expense expense;

  ExpenseDocID({
    required this.docID,
    required this.expense,
  });

  factory ExpenseDocID.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDocIDFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseDocIDToJson(this);
}
