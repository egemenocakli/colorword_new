import 'package:colorword_new/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/pages/exam/viewmodel/exam_viewmodel.dart';
import 'package:colorword_new/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => NewWordViewModel());
  locator.registerLazySingleton(() => ExamViewModel());
}
