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
      locations: _locationsFilter,
      assets: _assetsFilter,
    );
  }

  @action
  Future<void> setAssetStatus(AssetStatus value) async {
    assetStatus = assetStatus == value ? AssetStatus.none : value;

    List<Asset> filters = [];
    if (assetStatus != AssetStatus.none) {
      if (assetStatus == AssetStatus.energy) {
        filters = _assets.where((af) => af.sensorType == 'energy').toList();
      } else {
        filters = _assets.where((af) => af.status == 'alert').toList();
      }
      _locationsFilter.clear();
      _assetsFilter.clear();
      _assetsFilter.addAll(filters);
      for (var filter in filters) {
        if (filter.path != null) {}
        for (var path in filter.path!) {
          final locations = _locations.where((l) => l.id == path);
          final assets = _assets.where((l) => l.id == path);
          if (locations.isNotEmpty) {
            _locationsFilter.add(locations.first);
          }
          if (assets.isNotEmpty) {
            _assetsFilter.add(assets.first);
          }
        }
      }
    } else {
      _assetsFilter = [..._assets];
      _locationsFilter = [..._locations];
    }

    _assetsFilter = _assetsFilter.toSet().toList();
    _locationsFilter = _locationsFilter.toSet().toList();

    buildTree();
  }
}
