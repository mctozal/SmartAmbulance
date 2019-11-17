import 'package:get_it/get_it.dart';
import 'core/services/smartAmbulanceApi.dart';
import 'core/viewmodels/crudModel.dart';
import 'states/authenticationState.dart';
import 'states/managerState.dart';
import 'states/mapState.dart';
import 'ui/Authentication/landingPage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseApi('users'));
  locator.registerLazySingleton(() => CRUDModel());
  locator.registerLazySingleton(() => LandingPage());
  locator.registerLazySingleton(() => MapState());
  locator.registerLazySingleton(() => AuthenticationState());
  locator.registerLazySingleton(() => ManagerState());
}
