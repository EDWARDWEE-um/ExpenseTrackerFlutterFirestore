import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

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
class Asset {
  late final String uid;
  String name;
  double amount;
  @TimeStampConverter()
  late final DateTime dateTime;

  Asset(
      {required this.uid,
      required this.name,
      required this.amount,
      required this.dateTime,
      });
  
  factory Asset.fromJson(Map<String,dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
  
}
