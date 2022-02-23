part of 'asset_cubit.dart';

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitial extends AssetState {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class AssetLoading extends AssetInitial {
  @override
  List<Object?> get props => super.props..addAll([]);
}

class AssetUpdated extends AssetLoading {
  AssetUpdated({required this.asset, 
  required this.documentID
  });
  final List<Asset> asset;
  final List documentID;

  @override
  List<Object?> get props => super.props..addAll([]);
}