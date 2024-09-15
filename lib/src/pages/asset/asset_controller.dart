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
  var _locationsFilter = <Location>[];

  @readonly
  var _locations = <Location>[];

  @readonly
  var _assetsFilter = <Asset>[];

  @readonly
  var _assets = <Asset>[];

  @readonly
  var _listTree = <Map>[];

  @readonly
  var _tree = <Tree>[];

  Future<void> fetch(String id) async {
    _status = AssetStateStatus.loading;
    await fetchLocations(id);
    await fetchAssets(id);
    await buildTree();
    _status = AssetStateStatus.loaded;
  }

  Future<void> fetchLocations(String id) async {
    _locations = await _locationService.fetchLocations(id);
    _locationsFilter = [..._locations];
  }

  Future<void> fetchAssets(String id) async {
    _assets = await _assetService.fetchAssets(id);
    _assetsFilter = [..._assets];
  }

  @observable
  AssetStatus assetStatus = AssetStatus.none;

  @action
  Future<void> setAssetStatus(AssetStatus value) async {
    assetStatus = assetStatus == value ? AssetStatus.none : value;

    final String? removeQuery = switch (assetStatus) {
      AssetStatus.critical => 'operating',
      AssetStatus.energy => 'alert',
      _ => null
    };
    _assetsFilter = [..._assets];
    _locationsFilter = [..._locations];

    if (assetStatus != AssetStatus.none) {
      final toRemove =
          _assetsFilter.where((i) => i.status == removeQuery).toList();
      for (var rm in toRemove) {
        await removeParentTree(rm);
      }
      for (var t in _tree) {
        if (t.subTree == null) {
          final rmLoc = _locationsFilter.where((l) => l.id == t.id);

          if (rmLoc.isNotEmpty) {
            _locationsFilter.remove(rmLoc.first);
          }
        }
      }
    }

    buildTree();
  }

  Future<void> removeParentTree(Asset item) async {
    _assetsFilter.remove(item);
    _removeParents(item);
  }

  void _removeParents(Asset child) {
    final parent =
        _assetsFilter.where((asset) => asset.id == child.parentId).firstOrNull;

    if (parent != null) {
      _assetsFilter.remove(parent);
      _removeParents(parent);
      if (parent.parentId == null && parent.locationId != null) {
        final parentLocation = _locationsFilter
            .where((location) => location.id == parent.locationId)
            .firstOrNull;
        if (parentLocation != null) {
          _locationsFilter.remove(parentLocation);
          if (parentLocation.parentId != null) {
            final paParentLocation = _locationsFilter
                .where((location) => location.id == parentLocation.parentId)
                .firstOrNull;
            if (paParentLocation != null) {
              _locationsFilter.remove(paParentLocation);
            }
          }
        }
      }
    }
  }

  Future<void> buildTree() async {
    await buildLocation();
    await buildAsset();
  }

  Future<void> buildLocation2() async {}

  Future<void> buildLocation() async {
    final List<Tree> auxTree = [];
    for (var loc in _locationsFilter) {
      if (loc.parentId == null) {
        auxTree.add(Tree.fromLocation(loc));
      }
    }
    final hasParentItems = _locationsFilter.where((at) => at.parentId != null);

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
    final unlike = _assetsFilter
        .where((a) => a.parentId == null && a.locationId == null)
        .toList();
    _tree.addAll(unlike.map((c) => Tree.fromAsset(c)).toList());

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
