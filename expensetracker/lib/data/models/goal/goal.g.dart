// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      uid: json['uid'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      currentAmount: (json['currentAmount'] as num).toDouble(),
      targetAmount: (json['targetAmount'] as num).toDouble(),
      dateTime:
          const TimeStampConverter().fromJson(json['dateTime'] as Timestamp),
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'type': instance.type,
      'currentAmount': instance.currentAmount,
      'targetAmount': instance.targetAmount,
      'dateTime': const TimeStampConverter().toJson(instance.dateTime),
    };
