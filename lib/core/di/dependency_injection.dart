import 'package:get_it/get_it.dart';
import 'package:my_template/core/networking/api_service.dart';

import '../helpers/shared_prefrences.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  // Dio & ApiServices
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // shared prefences
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
}
