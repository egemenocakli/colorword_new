import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/home/home_screen_view.dart';
import 'package:colorword_new/login/login_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //AutoRoute(page: LoginView.page),
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: HomeScreenRoute.page),
      ];
}
