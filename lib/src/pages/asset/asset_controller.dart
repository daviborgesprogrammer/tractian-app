import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/asset.dart';
import '../../models/location.dart';
import '../../models/tree.dart';
import '../../services/assets/assets_service.dart';
import '../../services/location/location_service.dart';
part 'asset_controller.g.dart';

enum AssetStateStatus {
  initial,
  loading,
  loaded,
  error,
}

enum AssetStatus {
  critical,
  energy,
  none,
}

class AssetController = AssetControllerBase with _$AssetController;

abstract class AssetControllerBase with Store {
  final _locationService = GetIt.I<LocationService>();
  final _assetService = GetIt.I<AssetsService>();
  @readonly
  var _status = AssetStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  var _locations = <Location>[];

  @readonly
  var _assets = <Asset>[];

  //------Filters------

  @readonly
  var _locationsFilter = <Location>[];

  @readonly
  var _assetsFilter = <Asset>[];

  //-----Tree-----

  @readonly
  var _listTree = <Map>[];

  @readonly
  var _tree = <Tree>[];

  //-----Query-----

  @observable
  String? query;

  @action
  void setQuery(String value) {
    query = value;
  }

  @observable
  AssetStatus assetStatus = AssetStatus.none;

  @action
  Future<void> fetch(String id) async {
    _status = AssetStateStatus.loading;
    await fetchLocations(id);
    await fetchAssets(id);
    await buildTree();
    _status = AssetStateStatus.loaded;
  }

  @action
  Future<void> fetchLocations(String id) async {
    _locations = await _locationService.fetchLocations(id, offline: true);
    _locationsFilter = [..._locations];
  }

  @action
  Future<void> fetchAssets(String id) async {
    _assets = await _assetService.fetchAssets(id, offline: true);
    _assetsFilter = [..._assets];
  }

  @action
  Future<void> buildTree() async {
    await buildLocation();
    await buildAsset();
  }

  Future<void> buildLocation() async {
    final List<Tree> auxTree = [];

    for (var loc in _locationsFilter.where((loc) => loc.parentId == null)) {
      final tree = Tree.fromLocation(loc, paths: ['root']);
      auxTree.add(tree);

      final List<Tree> stack = [tree];

      while (stack.isNotEmpty) {
        final currentParent = stack.removeLast();

        final children = _locationsFilter
            .where((loc) => loc.parentId == currentParent.id)
            .map(
              (loc) => Tree.fromLocation(
                loc,
                paths: [...currentParent.path!, currentParent.id ?? ''],
              ),
            )
            .toList();

        if (children.isNotEmpty) {
          currentParent.child ??= [];
          currentParent.child!.addAll(children);
          stack.addAll(children);
        }
      }
    }

    _tree = [...auxTree];
  }

  Future<void> buildAsset() async {
    final unlike = _assetsFilter
        .where((a) => a.parentId == null && a.locationId == null)
        .toList();
    _tree
        .addAll(unlike.map((c) => Tree.fromAsset(c, paths: ['root'])).toList());

    final hasLocation = _assetsFilter
        .where((a) => a.locationId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();
    for (var hl in hasLocation) {
      seekTreeAssetLocation(hl, tree: _tree);
    }

    final hasParent = _assetsFilter
        .where((a) => a.parentId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();

    for (var hp in hasParent) {
      seekTreeAsset(hp, tree: _tree);
    }

    final getComponent = _assetsFilter
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

    final parentItem = tree.where((t) => t.id == item.locationId);
    if (parentItem.isNotEmpty) {
      item.path = [...?parentItem.first.path, parentItem.first.id ?? ''];
    }
    if (treeIndex != -1) {
      tree[treeIndex].child ??= [];
      tree[treeIndex].child!.add(item);
      return;
    }

    for (var parent in tree) {
      if (parent.child != null && parent.child!.isNotEmpty) {
        final int subTreeIndex =
            parent.child!.indexWhere((t) => t.id == item.locationId);
        final subParentItem =
            parent.child!.where((t) => t.id == item.locationId);

        if (subParentItem.isNotEmpty) {
          item.path = [
            ...?subParentItem.first.path,
            subParentItem.first.id ?? '',
          ];
        }
        if (subTreeIndex != -1) {
          parent.child![subTreeIndex].child ??= [];
          parent.child![subTreeIndex].child!.add(item);
          return;
        }
      }
    }
  }

  void seekTreeAsset(Tree item, {required List<Tree> tree}) {
    for (var treeNode in tree) {
      if (treeNode.treeType == TreeType.asset && treeNode.id == item.parentId) {
        treeNode.child ??= [];
        item.path = [...?treeNode.path, treeNode.id ?? ''];
        treeNode.child!.add(item);
        return;
      }

      if (treeNode.child != null && treeNode.child!.isNotEmpty) {
        seekTreeAsset(item, tree: treeNode.child!);
      }
    }
  }

  @action
  Future<void> setAssetStatus(AssetStatus value) async {
    assetStatus = assetStatus == value ? AssetStatus.none : value;

    final String? removeQuery = switch (assetStatus) {
      AssetStatus.critical => 'vibration',
      AssetStatus.energy => 'energy',
      _ => null
    };
    _assetsFilter = [..._assets];
    _locationsFilter = [..._locations];

    if (assetStatus != AssetStatus.none) {
      final toRemove =
          _assetsFilter.where((i) => i.sensorType == removeQuery).toList();
      print(toRemove);
      //   for (var rm in toRemove) {
      //     await removeParentTree(rm);
      //   }
      //   for (var t in _tree) {
      //     if (t.subTree == null) {
      //       final rmLoc = _locationsFilter.where((l) => l.id == t.id);

      //       if (rmLoc.isNotEmpty) {
      //         _locationsFilter.remove(rmLoc.first);
      //       }
      //     }
      //   }
    }

    buildTree();
  }

  // Future<void> removeParentTree(Asset item) async {
  //   _assetsFilter.remove(item);
  //   _removeParents(item);
  // }

  // void _removeParents(Asset child) {
  //   final parent =
  //       _assetsFilter.where((asset) => asset.id == child.parentId).firstOrNull;

  //   if (parent != null) {
  //     _assetsFilter.remove(parent);
  //     _removeParents(parent);
  //     if (parent.parentId == null && parent.locationId != null) {
  //       final parentLocation = _locationsFilter
  //           .where((location) => location.id == parent.locationId)
  //           .firstOrNull;
  //       if (parentLocation != null) {
  //         _locationsFilter.remove(parentLocation);
  //         if (parentLocation.parentId != null) {
  //           final paParentLocation = _locationsFilter
  //               .where((location) => location.id == parentLocation.parentId)
  //               .firstOrNull;
  //           if (paParentLocation != null) {
  //             _locationsFilter.remove(paParentLocation);
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
}
