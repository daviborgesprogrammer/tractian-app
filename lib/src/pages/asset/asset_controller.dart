import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/asset.dart';
import '../../models/location.dart';
import '../../models/tree.dart';
import '../../services/tree/tree_service.dart';
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
  final _treeService = GetIt.I<TreeService>();
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
    var locations = <Location>[];
    var assets = <Asset>[];
    _status = AssetStateStatus.loading;
    await Future.wait([fetchLocations(id), fetchAssets(id)]);

    (locations, assets) = await _treeService.setPath(_locations, _assets);
    _locations = locations;
    _assets = assets;
    _locationsFilter = [..._locations];
    _assetsFilter = [..._assets];

    await buildTree();

    _status = AssetStateStatus.loaded;
  }

  @action
  Future<void> fetchLocations(String id) async {
    _locations = await _treeService.fetchLocations(id, offline: true);
  }

  @action
  Future<void> fetchAssets(String id) async {
    _assets = await _treeService.fetchAssets(id, offline: true);
  }

  @action
  Future<void> buildTree() async {
    _tree = await _treeService.buildTree(
        locations: _locationsFilter, assets: _assetsFilter);
  }

  @action
  Future<void> setAssetStatus(AssetStatus value) async {
    assetStatus = assetStatus == value ? AssetStatus.none : value;

    //  final String? query = switch (assetStatus) {
    //   AssetStatus.critical => 'vibration',
    //   AssetStatus.energy => 'energy',
    //   _ => null
    // };
    List<Asset> filters = [];
    if (assetStatus != AssetStatus.none) {
      if (assetStatus == AssetStatus.energy) {
        filters =
            _assetsFilter.where((af) => af.sensorType == 'energy').toList();
      } else {
        filters = _assetsFilter.where((af) => af.status == 'alert').toList();
      }

      for (var filter in filters) {
        print(filter.path);
        if (filter.path != null) {
          // for (var path in filter.path!) {
          //   if(filter.path!.length == 1){

          //   }
          // }
        }

        // _assetsFilter
        //     .where(
        //       (asset) => filter.path!.any((f) {
        //         if (f == asset.id) {
        //           return true;
        //         }
        //         return false;
        //       }),
        //     )
        //     .toList();
        // _assetsFilter.where((asset)=>filter.path!.any((f)=>f == asset.id)).toList();
      }

      // _assetsFilter = _assets
      //     .where((asset) => filters.any((filter) => filter.id == asset.id))
      //     .toList();
      //     _locationsFilter = _locations.where((location)=> filters.any((filter)=>filter.id == location)).toList();
    } else {
      _assetsFilter = [..._assets];
      _locationsFilter = [..._locations];
    }

    // final String? removeQuery = switch (assetStatus) {
    //   AssetStatus.critical => 'vibration',
    //   AssetStatus.energy => 'energy',
    //   _ => null
    // };

    // if (assetStatus != AssetStatus.none) {
    // final toRemove =
    //     _assetsFilter.where((i) => i.sensorType == removeQuery).toList();
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
    // }

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
