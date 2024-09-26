import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'src/core/restClient/rest_client.dart';
import 'src/repositories/asset/asset_repository.dart';
import 'src/repositories/company/company_repository.dart';
import 'src/repositories/location/location_repository.dart';
import 'src/services/assets/assets_service.dart';
import 'src/services/company/company_service.dart';
import 'src/services/location/location_service.dart';
import 'src/tractian_app.dart';

Future<void> buildSetups() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await setWindowSize();
  await setupLocators();
  runApp(const TractianApp());
}

Future<void> setWindowSize() async {
  await DesktopWindow.setWindowSize(const Size(380 * 1.25, 800 * 1.25));
}

Future<void> setupLocators() async {
  GetIt.I.registerLazySingleton(() => RestClient());

  GetIt.I.registerLazySingleton(() => CompanyService());
  GetIt.I.registerLazySingleton(() => CompanyRepository());

  GetIt.I.registerLazySingleton(() => LocationService());
  GetIt.I.registerLazySingleton(() => LocationRepository());

  GetIt.I.registerLazySingleton(() => AssetsService());
  GetIt.I.registerLazySingleton(() => AssetRepository());
}
