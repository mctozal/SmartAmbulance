import 'package:get_it/get_it.dart';
import 'core/services/smartAmbulanceApi.dart';
import 'core/viewmodels/crudModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseApi('users'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}