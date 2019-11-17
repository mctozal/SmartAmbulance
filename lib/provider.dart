import 'package:provider/provider.dart';
import 'states/authenticationState.dart';
import 'states/hospitalState.dart';
import 'states/managerState.dart';
import 'states/mapState.dart';
import 'states/settingState.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  // Registered our independent states.
  ChangeNotifierProvider.value(value: AuthenticationState()),
  ChangeNotifierProvider.value(value: MapState()),
  ChangeNotifierProvider.value(value: ManagerState()),
  ChangeNotifierProvider.value(value: HospitalState()),
  ChangeNotifierProvider.value(value: SettingState()),
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> uiConsumableProviders = [
// Register stream providers.
// StreamProvider<User>(
//     builder: (context) =>
//         Provider.of<AuthenticationService>(context, listen: false).user,
//   ),
];
