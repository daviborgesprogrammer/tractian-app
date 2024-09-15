// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetController on AssetControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'AssetControllerBase._status', context: context);

  AssetStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  AssetStatus get _status => status;

  @override
  set _status(AssetStatus value) {
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

  @override
  String toString() {
    return '''

    ''';
  }
}
