import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

class TimeStampConverter implements JsonConverter<DateTime,Timestamp>{
  const TimeStampConverter();
  @override
  DateTime fromJson(Timestamp timestamp){
    return timestamp.toDate();
  }
  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class Expense {
  late final String uid;
  String name;
  String type;
  double amount;
  @TimeStampConverter()
  late final DateTime dateTime;

  Expense(
      {required this.uid,
      required this.name,
      required this.type,
      required this.amount,
      required this.dateTime,
      });
  
  factory Expense.fromJson(Map<String,dynamic> json) => _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
  
}
