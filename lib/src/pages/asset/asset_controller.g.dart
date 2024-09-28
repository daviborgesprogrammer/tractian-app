// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetController on AssetControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'AssetControllerBase._status', context: context);

  AssetStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  AssetStateStatus get _status => status;

  @override
  set _status(AssetStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: 'AssetControllerBase._errorMessage', context: context);

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_locationsAtom =
      Atom(name: 'AssetControllerBase._locations', context: context);

  List<Location> get locations {
    _$_locationsAtom.reportRead();
    return super._locations;
  }

  @override
  List<Location> get _locations => locations;

  @override
  set _locations(List<Location> value) {
    _$_locationsAtom.reportWrite(value, super._locations, () {
      super._locations = value;
    });
  }

  late final _$_assetsAtom =
      Atom(name: 'AssetControllerBase._assets', context: context);

  List<Asset> get assets {
    _$_assetsAtom.reportRead();
    return super._assets;
  }

  @override
  List<Asset> get _assets => assets;

  @override
  set _assets(List<Asset> value) {
    _$_assetsAtom.reportWrite(value, super._assets, () {
      super._assets = value;
    });
  }

  late final _$_locationsFilterAtom =
      Atom(name: 'AssetControllerBase._locationsFilter', context: context);

  List<Location> get locationsFilter {
    _$_locationsFilterAtom.reportRead();
    return super._locationsFilter;
  }

  @override
  List<Location> get _locationsFilter => locationsFilter;

  @override
  set _locationsFilter(List<Location> value) {
    _$_locationsFilterAtom.reportWrite(value, super._locationsFilter, () {
      super._locationsFilter = value;
    });
  }

  late final _$_assetsFilterAtom =
      Atom(name: 'AssetControllerBase._assetsFilter', context: context);

  List<Asset> get assetsFilter {
    _$_assetsFilterAtom.reportRead();
    return super._assetsFilter;
  }

  @override
  List<Asset> get _assetsFilter => assetsFilter;

  @override
  set _assetsFilter(List<Asset> value) {
    _$_assetsFilterAtom.reportWrite(value, super._assetsFilter, () {
      super._assetsFilter = value;
    });
  }

  late final _$_listTreeAtom =
      Atom(name: 'AssetControllerBase._listTree', context: context);

  List<Map<dynamic, dynamic>> get listTree {
    _$_listTreeAtom.reportRead();
    return super._listTree;
  }

  @override
  List<Map<dynamic, dynamic>> get _listTree => listTree;

  @override
  set _listTree(List<Map<dynamic, dynamic>> value) {
    _$_listTreeAtom.reportWrite(value, super._listTree, () {
      super._listTree = value;
    });
  }

  late final _$_treeAtom =
      Atom(name: 'AssetControllerBase._tree', context: context);

  List<Tree> get tree {
    _$_treeAtom.reportRead();
    return super._tree;
  }

  @override
  List<Tree> get _tree => tree;

  @override
  set _tree(List<Tree> value) {
    _$_treeAtom.reportWrite(value, super._tree, () {
      super._tree = value;
    });
  }

  late final _$queryAtom =
      Atom(name: 'AssetControllerBase.query', context: context);

  @override
  String? get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String? value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  late final _$assetStatusAtom =
      Atom(name: 'AssetControllerBase.assetStatus', context: context);

  @override
  AssetStatus get assetStatus {
    _$assetStatusAtom.reportRead();
    return super.assetStatus;
  }

  @override
  set assetStatus(AssetStatus value) {
    _$assetStatusAtom.reportWrite(value, super.assetStatus, () {
      super.assetStatus = value;
    });
  }

  late final _$fetchAsyncAction =
      AsyncAction('AssetControllerBase.fetch', context: context);

  @override
  Future<void> fetch(String id) {
    return _$fetchAsyncAction.run(() => super.fetch(id));
  }

  late final _$fetchLocationsAsyncAction =
      AsyncAction('AssetControllerBase.fetchLocations', context: context);

  @override
  Future<void> fetchLocations(String id) {
    return _$fetchLocationsAsyncAction.run(() => super.fetchLocations(id));
  }

  late final _$fetchAssetsAsyncAction =
      AsyncAction('AssetControllerBase.fetchAssets', context: context);

  @override
  Future<void> fetchAssets(String id) {
    return _$fetchAssetsAsyncAction.run(() => super.fetchAssets(id));
  }

  late final _$buildTreeAsyncAction =
      AsyncAction('AssetControllerBase.buildTree', context: context);

  @override
  Future<void> buildTree() {
    return _$buildTreeAsyncAction.run(() => super.buildTree());
  }

  late final _$setQueryAsyncAction =
      AsyncAction('AssetControllerBase.setQuery', context: context);

  @override
  Future<void> setQuery(String value) {
    return _$setQueryAsyncAction.run(() => super.setQuery(value));
  }

  late final _$setAssetStatusAsyncAction =
      AsyncAction('AssetControllerBase.setAssetStatus', context: context);

  @override
  Future<void> setAssetStatus(AssetStatus value) {
    return _$setAssetStatusAsyncAction.run(() => super.setAssetStatus(value));
  }

  @override
  String toString() {
    return '''
query: ${query},
assetStatus: ${assetStatus}
    ''';
  }
}
