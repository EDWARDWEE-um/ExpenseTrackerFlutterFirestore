import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

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
class Goal {
  late final String uid;
  String name;
  String type;
  double currentAmount;
  double targetAmount;
  @TimeStampConverter()
  late final DateTime dateTime;

  Goal(
      {required this.uid,
      required this.name,
      required this.type,
      required this.currentAmount,
      required this.targetAmount,
      required this.dateTime,
      });
  
  factory Goal.fromJson(Map<String,dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
  
}
