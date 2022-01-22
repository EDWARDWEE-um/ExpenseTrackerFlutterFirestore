import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseServiceRepository {
  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('expenses');

  Future addNewExpense(Expense expense) {
    return expenseCollection.add({
      'uid': expense.uid,
      'name': expense.name,
      'type': expense.type,
      'amount': expense.amount,
      'dateTime': expense.dateTime,
    });
  }

  Future getExpense() async {
    return Expense(
        name: 'am3sdasdasd',
        type: 'nasd',
        amount: 500,
        dateTime: DateTime.now(),
        uid: FirebaseAuth.instance.currentUser!.uid);
  }

  Future getExpensez() async {
    return expenseCollection
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // Future updateUserData(
  //     {required String name,
  //     required String type,
  //     required double amount,
  //     required DateTime dateTime}) async {
  //   return await expenseCollection.doc(uid).set({
  //     'name': name,
  //     'type': type,
  //     'amount': amount,
  //     'dateTime': dateTime,
  //   });
  // }

  Future<void> deleteTodo(Expense expense) async {
    return expenseCollection.doc(expense.name).delete();
  }

  List<Expense> _expenseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Expense(
            name: doc.get('name'),
            type: doc.get('type'),
            amount: doc.get('amount'),
            dateTime: doc.get('dateTime'),
            uid: FirebaseAuth.instance.currentUser!.uid))
        .toList();
  }

  Stream<List<Expense>> expenses() {
    return expenseCollection.snapshots().map(_expenseListFromSnapshot);
  }

  //@override
  // Future<void> updateTodo(Todo update) {
  //   return todoCollection
  //       .document(update.id)
  //       .updateData(update.toEntity().toDocument());
  // }
}
