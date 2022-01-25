import 'package:cloud_firestore/cloud_firestore.dart';

class UserServiceRepository {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

}
