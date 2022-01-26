import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IncomeServiceRepository {
  final CollectionReference incomeCollection =
      FirebaseFirestore.instance.collection('income');

  Future<String> addNewIncome(Income income) async {
    DocumentReference ref = await incomeCollection.add({
      'uid': income.uid,
      'name': income.name,
      'type': income.type,
      'amount': income.amount,
      'dateTime': income.dateTime,
    });
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
        .whenComplete(() => debugPrint('deleted'))
        .catchError((onError) => debugPrint(onError));
  }

  Future<void> updateIncome({required String docId}) async {
    DocumentReference documentReference = incomeCollection.doc(docId);
    await documentReference.update({'name': 'netzam'});
  }
}