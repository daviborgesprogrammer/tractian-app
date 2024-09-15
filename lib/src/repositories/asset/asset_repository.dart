import '../../models/asset.dart';
import 'asset_repository_impl.dart';

abstract interface class AssetRepository {
  Future<List<Asset>> fetchAssets(String id);

  factory AssetRepository() => AssetRepositoryImpl();
}
