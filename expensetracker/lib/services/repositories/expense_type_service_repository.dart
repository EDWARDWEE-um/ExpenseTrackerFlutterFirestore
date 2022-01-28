import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseTypeServiceRepository {
  final CollectionReference expenseTypeCollection =
      FirebaseFirestore.instance.collection('expenseType');

  // Future<String> addNewExpense(Expense expense) async {
  //   DocumentReference ref = await expenseCollection.add({
  //     'uid': expense.uid,
  //     'name': expense.name,
  //     'type': expense.type,
  //     'amount': expense.amount,
  //     'dateTime': expense.dateTime,
  //   });
  //   return ref.id;
  // }

  Future<QuerySnapshot> getExpenseType() async {
    return await expenseTypeCollection.where('uid',whereIn: [
      FirebaseAuth.instance.currentUser!.uid,
      'all'
    ]).get();
  }

  // Future<void> deleteExpenses({required String docId}) async {
  //   DocumentReference documentReference = expenseCollection.doc(docId);
  //   await documentReference
  //       .delete()
  //       .whenComplete(() => debugPrint('deleted'))
  //       .catchError((onError) => debugPrint(onError));
  // }

  // Future<void> updateExpenses({required String docId}) async {
  //   DocumentReference documentReference = expenseCollection.doc(docId);
  //   await documentReference.update({'name': 'netzam'});
  // }
}
