import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/income/income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncomeServiceRepository {
  final CollectionReference incomeCollection =
      FirebaseFirestore.instance.collection('income');

  Future<String> addNewIncome(Income income) async {
    DocumentReference ref = await incomeCollection.add(income.toJson());
    return ref.id;
  }

  Future<QuerySnapshot> getIncome() {
    return incomeCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> deleteIncome({required String docId}) async {
    DocumentReference documentReference = incomeCollection.doc(docId);
    await documentReference
        .delete()
        .whenComplete(() => {})
        .catchError((onError) => debugPrint(onError));
  }

  Future<void> updateIncome({required String docId, required Income income}) async {
    DocumentReference documentReference = incomeCollection.doc(docId);
    await documentReference.update(income.toJson());
  }
}
