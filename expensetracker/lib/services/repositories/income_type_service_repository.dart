import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IncomeTypeServiceRepository {
  final CollectionReference expenseTypeCollection =
      FirebaseFirestore.instance.collection('incomeType');

  Future<QuerySnapshot> getIncomeType() async {
    return await expenseTypeCollection.where('uid',
        whereIn: [FirebaseAuth.instance.currentUser!.uid, 'all']).get();
  }

}
