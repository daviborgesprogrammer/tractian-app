import 'package:get_it/get_it.dart';

import '../../core/restClient/local_client.dart';
import '../../models/asset.dart';
import '../../models/location.dart';
import '../../models/tree.dart';
import '../../repositories/tree/tree_repository.dart';
import './tree_service.dart';

class TreeServiceImpl implements TreeService {
  final _treeService = GetIt.I<TreeRepository>();
  @override
  Future<List<Location>> fetchLocations(
    String id, {
    bool offline = false,
  }) async =>
      offline
          ? await fetchLocalLocations(id)
          : await _treeService.fetchLocations(id);

  @override
  Future<List<Asset>> fetchAssets(String id, {bool offline = false}) async =>
      offline ? await fetchLocalAssets(id) : await _treeService.fetchAssets(id);

  Future<List<Location>> fetchLocalLocations(String id) async {
    final data = await LocalClient().get(id, 'locations');
    return data.map<Location>((d) => Location.fromJson(d)).toList();
  }

  Future<List<Asset>> fetchLocalAssets(String id) async {
    final data = await LocalClient().get(id, 'assets');
    return data.map<Asset>((d) => Asset.fromJson(d)).toList();
  }

  @override
  Future<(List<Location>, List<Asset>)> setPath(
    List<Location> locations,
    List<Asset> assets,
  ) async {
    return (
      await setPathLocations(locations),
      await setPathAssets(assets, locations)
    );
  }

  Future<List<Location>> setPathLocations(List<Location> locations) async {
    final Map<String?, Location> locationMap = {
      for (var loc in locations) loc.id: loc,
    };
    for (var loc in locations) {
      loc.path = buildLocationPath(loc, locationMap);
    }

    return locations.toSet().toList();
  }

  Future<List<Asset>> setPathAssets(
    List<Asset> assets,
    List<Location> locations,
  ) async {
    for (var asset in assets) {
      if (asset.parentId == null && asset.locationId == null) {
        asset.path = [asset.id ?? 'root'];
      }
    }
    for (var asset in assets) {
      if (asset.locationId != null && asset.sensorId == null) {
        final loc = locations.where((l) => l.id == asset.locationId);
        if (loc.isNotEmpty) {
          asset.path = [...loc.first.path!, loc.first.id!];
        }
      }
    }
    for (var asset in assets) {
      if (asset.parentId != null && asset.sensorId == null) {
        final sst = assets.where((l) => l.id == asset.parentId);
        if (sst.isNotEmpty) {
          asset.path = [...sst.first.path!, sst.first.id!];
        }
      }
    }

    for (var asset in assets) {
      if (asset.sensorId != null) {
        final sst = assets.where((l) => l.id == asset.parentId);
        if (sst.isNotEmpty) {
          asset.path = [...sst.first.path!, sst.first.id!];
        }
      }
    }

    return assets.toSet().toList();
  }

  List<String> buildLocationPath(
    Location loc,
    Map<String?, Location> locationMap,
  ) {
    if (loc.parentId == null) {
      return [loc.id ?? 'root'];
    } else {
      final parentLocation = locationMap[loc.parentId];
      if (parentLocation != null) {
        return [
          ...buildLocationPath(parentLocation, locationMap),
          parentLocation.id!,
        ];
      } else {
        return ['root'];
      }
    }
  }

  @override
  Future<List<Tree>> buildTree({
    required List<Location> locations,
    required List<Asset> assets,
  }) async {
    List<Tree> tree = <Tree>[];
    tree = buildLocation(locations);
    tree = buildAsset(tree, assets, locations);
    return tree;
  }

  List<Tree> buildLocation(List<Location> locations) {
    final List<Tree> auxTree = [];

    for (var loc in locations.where((loc) => loc.parentId == null)) {
      final tree = Tree.fromLocation(loc);

      auxTree.add(tree);

      final List<Tree> stack = [tree];

      while (stack.isNotEmpty) {
        final currentParent = stack.removeLast();
        final children = <Tree>[];
        for (var loc in locations) {
          if (loc.parentId == currentParent.id) {
            final Tree tr = Tree.fromLocation(
              loc,
            );
            children.add(
              tr,
            );
          }
        }

        if (children.isNotEmpty) {
          currentParent.child ??= [];
          currentParent.child!.addAll(children);
          stack.addAll(children);
        }
      }
    }

    return [...auxTree];
  }

  List<Tree> buildAsset(
    List<Tree> tree,
    List<Asset> assets,
    List<Location> location,
  ) {
    for (var asset in assets) {
      if (asset.parentId == null && asset.locationId == null) {
        tree.add(Tree.fromAsset(asset));
      }
    }

    final hasLocation = assets
        .where((a) => a.locationId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();
    for (var hl in hasLocation) {
      seekTreeAssetLocation(
        hl,
        tree: tree,
      );
    }

    final hasParent = assets
        .where((a) => a.parentId != null && a.sensorId == null)
        .map((m) => Tree.fromAsset(m))
        .toList();

    for (var hp in hasParent) {
      seekTreeAsset(hp, tree: tree);
    }

    final getComponent = assets
        .where((a) => a.sensorType != null)
        .map((m) => Tree.fromAsset(m))
        .toList();
    for (var gC in getComponent) {
      seekTreeAsset(gC, tree: tree);
    }

    return tree;
  }

  void seekTreeAsset(Tree item, {required List<Tree> tree}) {
    for (var treeNode in tree) {
      if (treeNode.treeType == TreeType.asset && treeNode.id == item.parentId) {
        treeNode.child ??= [];
        treeNode.child!.add(item);
        return;
      }

      if (treeNode.child != null && treeNode.child!.isNotEmpty) {
        seekTreeAsset(item, tree: treeNode.child!);
      }
    }
  }

  void seekTreeAssetLocation(Tree item, {required List<Tree> tree}) {
    final int treeIndex = tree.indexWhere((t) => t.id == item.locationId);

    if (treeIndex != -1) {
      tree[treeIndex].child ??= [];
      tree[treeIndex].child!.add(item);
      return;
    }

    for (var parent in tree) {
      if (parent.child != null && parent.child!.isNotEmpty) {
        final int subTreeIndex =
            parent.child!.indexWhere((t) => t.id == item.locationId);

        if (subTreeIndex != -1) {
          parent.child![subTreeIndex].child ??= [];
          parent.child![subTreeIndex].child!.add(item);
          return;
        }
      }
    }
  }
}
