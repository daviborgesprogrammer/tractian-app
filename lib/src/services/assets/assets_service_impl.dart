import 'package:get_it/get_it.dart';

import '../../models/asset.dart';
import '../../repositories/asset/asset_repository.dart';
import './assets_service.dart';

class AssetsServiceImpl implements AssetsService {
  final _assetRepository = GetIt.I<AssetRepository>();
  @override
  Future<List<Asset>> fetchAssets(String id) =>
      _assetRepository.fetchAssets(id);
}
