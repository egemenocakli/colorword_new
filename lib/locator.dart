import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/home/home_screen_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => HomeScreenViewModel());
}
