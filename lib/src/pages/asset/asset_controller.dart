import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/asset.dart';
import '../../models/location.dart';
import '../../models/tree.dart';
import '../../services/assets/assets_service.dart';
import '../../services/location/location_service.dart';
part 'asset_controller.g.dart';

enum AssetStatus {
  initial,
  loading,
  loaded,
  error,
}

class AssetController = AssetControllerBase with _$AssetController;

abstract class AssetControllerBase with Store {
  final _locationService = GetIt.I<LocationService>();
  final _assetService = GetIt.I<AssetsService>();
  @readonly
  var _status = AssetStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  var _locations = <Location>[];

  @readonly
  var _assets = <Asset>[];

  @readonly
  var _listTree = <Map>[];

  @readonly
  var _tree = <Tree>[];

  Future<void> fetch(String id) async {
    _status = AssetStatus.loading;
    await fetchLocations(id);
    await fetchAssets(id);
    await buildTree();
    _status = AssetStatus.loaded;
  }

  Future<void> fetchLocations(String id) async {
    _locations = await _locationService.fetchLocations(id);
  }

  Future<void> fetchAssets(String id) async {
    _assets = await _assetService.fetchAssets(id);
  }

  Future<void> buildTree() async {
    await buildLocation();
    await buildAsset();
    // for (var tree in _tree) {
    //   if (tree.subTree != null)
    //     for (var tree1 in tree.subTree!) {
    //       if (tree1.subTree != null)
    //         for (var tree2 in tree1.subTree!) {
    //         }
    //     }
    // }
  }

  Future<void> buildLocation() async {
    final List<Tree> auxTree = [];
    for (var loc in _locations) {
      if (loc.parentId == null) {
        auxTree.add(Tree.fromLocation(loc));
      }
    }
    final hasParentItems = _locations.where((at) => at.parentId != null);

    for (var at in auxTree) {
      final child = hasParentItems.where((hpi) => hpi.parentId == at.id);
      if (child.isNotEmpty) {
        at.subTree ??= [];
        at.subTree?.addAll(child.map((c) => Tree.fromLocation(c)).toList());
        break;
      }
    }
    _tree = [...auxTree];
  }

  Future<void> buildAsset() async {
    final unlike = _assets
        .where((a) => a.parentId == null && a.locationId == null)
        .toList();
    _tree.addAll(unlike.map((c) => Tree.fromAsset(c)).toList());

    final hasLocation = _assets
        .where((a) => a.locationId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();
    for (var hl in hasLocation) {
      seekTreeAssetLocation(hl, tree: _tree);
    }

    final hasParent = _assets
        .where((a) => a.parentId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();

    for (var hp in hasParent) {
      seekTreeAsset(hp, tree: _tree);
    }

    final getComponent = _assets
        .where((a) => a.sensorType != null)
        .map((m) => Tree.fromAsset(m))
        .toList();
    for (var gC in getComponent) {
      seekTreeAsset(gC, tree: _tree);
    }

    _tree = [..._tree];
  }

  void seekTreeAssetLocation(Tree item, {required List<Tree> tree}) {
    final int treeIndex = tree.indexWhere((t) => t.id == item.locationId);

    if (treeIndex != -1) {
      tree[treeIndex].subTree ??= [];
      tree[treeIndex].subTree!.add(item);
      return;
    }

    for (var parent in tree) {
      if (parent.subTree != null && parent.subTree!.isNotEmpty) {
        final int subTreeIndex =
            parent.subTree!.indexWhere((t) => t.id == item.locationId);

        if (subTreeIndex != -1) {
          parent.subTree![subTreeIndex].subTree ??= [];
          parent.subTree![subTreeIndex].subTree!.add(item);
          return;
        }
      }
    }
  }

  void seekTreeAsset(Tree item, {required List<Tree> tree}) {
    for (var treeNode in tree) {
      if (treeNode.treeType == TreeType.asset && treeNode.id == item.parentId) {
        treeNode.subTree ??= [];
        treeNode.subTree!.add(item);
        return; // Interrompe a busca após a inserção
      }

      if (treeNode.subTree != null && treeNode.subTree!.isNotEmpty) {
        seekTreeAsset(item, tree: treeNode.subTree!);
      }
    }
  }
}
