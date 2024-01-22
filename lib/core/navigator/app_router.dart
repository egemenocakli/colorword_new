import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/auth/view/auth_view.dart';
import 'package:colorword_new/app/pages/profile/view/profile_view.dart';
import 'package:colorword_new/app/pages/written_exam/view/written_exam_view.dart';
import 'package:colorword_new/app/pages/multipleChoiceExam/view/mchoice_exam_view.dart';
import 'package:colorword_new/app/pages/home/view/home_view.dart';
import 'package:colorword_new/app/pages/new_word/view/new_word_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, path: '/'),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: NewWordRoute.page),
        AutoRoute(page: MChoiceExamRoute.page),
        AutoRoute(page: WrittenExamRoute.page),
        AutoRoute(page: ProfileRoute.page)
      ];
}
