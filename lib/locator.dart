import 'package:get_it/get_it.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/states/managerState.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationState());
   locator.registerLazySingleton(() => ManagerState());
}