import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/pages/auth/view/login_view.dart';
import 'package:colorword_new/pages/auth/view/login_view2.dart';
import 'package:colorword_new/pages/classic_exam/view/classic_exam.dart';
import 'package:colorword_new/pages/exam/view/exam_view.dart';
import 'package:colorword_new/pages/home/view/home_view.dart';
import 'package:colorword_new/pages/new_word/view/new_word_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: NewWordRoute.page),
        AutoRoute(page: ExamRoute.page),
        AutoRoute(page: ClassicExamRoute.page)
      ];
}
