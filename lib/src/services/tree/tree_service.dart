import '../../models/asset.dart';
import '../../models/location.dart';
import '../../models/tree.dart';
import '../../pages/asset/asset_controller.dart';
import 'tree_service_impl.dart';

abstract interface class TreeService {
  Future<List<Asset>> fetchAssets(String id, {bool offline = false});

  Future<List<Location>> fetchLocations(String id, {bool offline = false});

  Future<(List<Location>, List<Asset>)> setPath(
    List<Location> locations,
    List<Asset> assets,
  );

  Future<void> applySearch({
    String? textQuery,
    required AssetStatus optionQuery,
  });

  Future<List<Tree>> buildTree({
    required List<Location> locations,
    required List<Asset> assets,
  });

  factory TreeService() => TreeServiceImpl();
}
