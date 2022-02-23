import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/data/models/asset/asset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssetServiceRepository {
  final CollectionReference assetCollection =
      FirebaseFirestore.instance.collection('assets');

  Future<String> addNewAsset(Asset asset) async {
    DocumentReference ref = await assetCollection.add(asset.toJson());
    return ref.id;
  }

  Future<QuerySnapshot> getAsset() async {
    return await assetCollection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> deleteAsset({required String docId}) async {
    DocumentReference documentReference = assetCollection.doc(docId);
    await documentReference
        .delete()
        .whenComplete(() => {})
        .catchError((onError) => debugPrint(onError));
  }

  Future<void> updateAsset(
      {required String docId, required Asset asset}) async {
    DocumentReference documentReference = assetCollection.doc(docId);
    await documentReference.update(asset.toJson());
  }
}
