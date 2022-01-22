
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');

  
}
