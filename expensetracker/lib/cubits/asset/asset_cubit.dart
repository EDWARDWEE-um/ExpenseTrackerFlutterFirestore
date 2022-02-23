import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/models/asset/asset.dart';
import 'package:expensetracker/services/repositories/asset_service_repository.dart';
part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  final AssetServiceRepository assetServiceRepository;
  final List<Asset> assets = [];
  final List documentID = [];

  AssetCubit({required this.assetServiceRepository})
      : super(AssetInitial()) {
    getAssets();
  }

  void getAssets() async {
    emit(AssetLoading());
    QuerySnapshot assetList = await assetServiceRepository.getAsset();
    for (int i = 0; i < assetList.docs.length; i++) {
      Map<String, dynamic> assetMap =
          assetList.docs[i].data() as Map<String, dynamic>;
      if (!documentID.contains(assetList.docs[i].id)) {
        assets.add(Asset.fromJson(assetMap));
        documentID.add(assetList.docs[i].id);
      }
    }
    emit(AssetUpdated(asset: assets, documentID: documentID));
  }

  void addAssets(Asset asset) async {
    emit(AssetLoading());
    String docID = await assetServiceRepository.addNewAsset(asset);
    assets.add(asset);
    documentID.add(docID);
    emit(AssetUpdated(asset: assets, documentID: documentID));
  }

  void deleteAssets(String id) async {
    emit(AssetLoading());
    assetServiceRepository.deleteAsset(docId: id);
    final int index = documentID.indexWhere((element) => element == id);
    assets.remove(assets.elementAt(index));
    documentID.remove(id);
    emit(AssetUpdated(asset: assets, documentID: documentID));
  }

  void updateAssets({
    required String id,
    required Asset asset,
  }) async {
    emit(AssetLoading());

    assetServiceRepository.updateAsset(docId: id, asset: asset);
    for (int i = 0; i < documentID.length; i++) {
      if (documentID[i] == id) {
        assets.elementAt(i).name = asset.name;
        assets.elementAt(i).amount = asset.amount;
      }
    }
    emit(AssetUpdated(asset: assets, documentID: documentID));
  }
}
