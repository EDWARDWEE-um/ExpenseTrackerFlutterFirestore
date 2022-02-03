import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/total_expense/total_expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TotalExpenseServiceRepository {
  final CollectionReference totalExpenseCollection =
      FirebaseFirestore.instance.collection('totalExpense');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> upsertTotalExpense(TotalExpense totalExpense) async {
    await totalExpenseCollection.doc(uid).set(totalExpense.toJson());
  }

  Future<DocumentSnapshot> getTotalExpense() async {
    return await totalExpenseCollection.doc(uid).get();
  }

}
