import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseServiceRepository {
  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');

  Future<String> addNewExpense(Expense expense) async {
    DocumentReference ref = await expenseCollection.add({
      'uid': expense.uid,
      'name': expense.name,
      'type': expense.type,
      'amount': expense.amount,
      'dateTime': expense.dateTime,
    });
    return ref.id;
  }

  Future<QuerySnapshot> getExpenses() async{
    return await expenseCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> deleteExpenses({required String docId}) async {
    DocumentReference documentReference = expenseCollection.doc(docId);
    await documentReference
        .delete()
        .whenComplete(() => {})
        .catchError((onError) => debugPrint(onError));
  }

  Future<void> updateExpenses({required String docId}) async {
    DocumentReference documentReference = expenseCollection.doc(docId);
    await documentReference.update({'name': 'netzam'});
  }
}
