import 'package:get_it/get_it.dart';
import 'package:smart_ambulance/services/smartAmbulanceApi.dart';

import 'model/crudModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}