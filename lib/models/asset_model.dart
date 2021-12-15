import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/asset.dart';

@immutable
class AssetModel<T> {
  final Asset asset;
  final String path;
  final T data;

  const AssetModel(this.asset, this.path, this.data);
}

FutureProvider<AssetModel<String>> Function(Asset asset, Widget child)
    buildTextAssetProvider =
    _createBuildAssetProvider('', (bundle, path) => bundle.loadString(path));

FutureProvider<AssetModel<ByteData>> Function(Asset asset, Widget child)
    buildBinaryAssetProvider =
    _createBuildAssetProvider(ByteData(0), (bundle, path) => bundle.load(path));

FutureProvider<AssetModel<T>> Function(Asset asset, Widget child)
    _createBuildAssetProvider<T>(T initData,
        Future<T> Function(AssetBundle bundle, String path) loadFunc) {
  return (Asset asset, Widget child) => FutureProvider<AssetModel<T>>(
        initialData: AssetModel<T>(asset, assetPaths[asset]!, initData),
        create: (context) async {
          final assetData = await loadFunc(
              DefaultAssetBundle.of(context), assetPaths[asset]!);
          return AssetModel<T>(asset, assetPaths[asset]!, assetData);
        },
        child: child,
      );
}
