import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/total_expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TotalExpenseServiceRepository {
  final CollectionReference totalExpenseCollection =
      FirebaseFirestore.instance.collection('totalExpense');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addTotalExpense(TotalExpense totalExpense) async {
    await totalExpenseCollection.doc(uid).set(totalExpense.toJson());
  }

  // Future<QuerySnapshot> getExpenses() async {
  //   return await expenseCollection
  //       .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  // }

  // Future<void> deleteExpenses({required String docId}) async {
  //   DocumentReference documentReference = expenseCollection.doc(docId);
  //   await documentReference
  //       .delete()
  //       .whenComplete(() => {})
  //       .catchError((onError) => debugPrint(onError));
  // }

  // Future<void> updateExpenses(
  //     {required String docId, required Expense expense}) async {
  //   DocumentReference documentReference = expenseCollection.doc(docId);
  //   await documentReference.update(expense.toJson());
  // }
}
