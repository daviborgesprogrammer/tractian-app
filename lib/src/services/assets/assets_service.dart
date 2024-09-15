import '../../models/asset.dart';
import 'assets_service_impl.dart';

abstract interface class AssetsService {
  Future<List<Asset>> fetchAssets(String id);

  factory AssetsService() => AssetsServiceImpl();
}