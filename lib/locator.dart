import 'package:colorword_new/app/pages/auth/viewmodel/auth_viewmodel.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/viewmodel/mchoice_exam_viewmodel.dart';
import 'package:colorword_new/app/pages/home/viewmodel/home_viewmodel.dart';
import 'package:colorword_new/app/pages/new_word/viewmodel/new_word_viewmodel.dart';
import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/app/pages/written_exam/viewmodel/written_exam_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => NewWordViewModel());
  locator.registerLazySingleton(() => MChoiceExamViewModel());
  locator.registerLazySingleton(() => WrittenExamViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
}
