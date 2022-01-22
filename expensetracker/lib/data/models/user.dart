
class User {
  final String id;
  final String displayName;
  final int avatar;

  User ({
    required this.id,
    required this.displayName,
    required this.avatar,
  });

  // factory UserData.fromJson(Map<String, dynamic> json){
  //   return UserData(
  //     id: json['UID'].toString(),
  //     displayName: json['DisplayName'].toString(),
  //     avatar: json['Avatar'] as int,
  //   );
  // }
}