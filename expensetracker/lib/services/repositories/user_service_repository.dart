import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServiceRepository {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

}
