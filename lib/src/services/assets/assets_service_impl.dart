import 'package:get_it/get_it.dart';

import '../../core/restClient/local_client.dart';
import '../../models/asset.dart';
import '../../repositories/asset/asset_repository.dart';
import './assets_service.dart';

class AssetsServiceImpl implements AssetsService {
  final _assetRepository = GetIt.I<AssetRepository>();
  @override
  Future<List<Asset>> fetchAssets(String id, {bool offline = false}) =>
      offline ? fetchLocalAssets(id) : _assetRepository.fetchAssets(id);

  Future<List<Asset>> fetchLocalAssets(String id) async {
    final data = await LocalClient().get(id, 'assets');
    return data.map<Asset>((d) => Asset.fromJson(d)).toList();
  }
}
