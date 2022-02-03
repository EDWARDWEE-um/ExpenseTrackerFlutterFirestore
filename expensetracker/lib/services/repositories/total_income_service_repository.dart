import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/total_income/total_income.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TotalIncomeServiceRepository {
  final CollectionReference totalIncomeCollection =
      FirebaseFirestore.instance.collection('totalIncome');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> upsertTotalIncome(TotalIncome totalIncome) async {
    await totalIncomeCollection.doc(uid).set(totalIncome.toJson());
  }

  Future<DocumentSnapshot> getTotalIncome() async {
    return await totalIncomeCollection.doc(uid).get();
  }

}
