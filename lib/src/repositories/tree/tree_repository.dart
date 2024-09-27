import '../../models/asset.dart';
import '../../models/location.dart';
import 'tree_repository_impl.dart';

abstract interface class TreeRepository {
  Future<List<Location>> fetchLocations(String id);
  Future<List<Asset>> fetchAssets(String id);

  factory TreeRepository() => TreeRepositoryImpl();
}
