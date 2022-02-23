// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      uid: json['uid'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      dateTime:
          const TimeStampConverter().fromJson(json['dateTime'] as Timestamp),
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'amount': instance.amount,
      'dateTime': const TimeStampConverter().toJson(instance.dateTime),
    };
