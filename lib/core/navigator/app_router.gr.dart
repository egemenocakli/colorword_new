// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ClassicExamRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ClassicExamView(),
      );
    },
    ExamRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExamView(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    LoginRoute2.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView2(),
      );
    },
    NewWordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewWordView(),
      );
    },
  };
}

/// generated route for
/// [ClassicExamView]
class ClassicExamRoute extends PageRouteInfo<void> {
  const ClassicExamRoute({List<PageRouteInfo>? children})
      : super(
          ClassicExamRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClassicExamRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExamView]
class ExamRoute extends PageRouteInfo<void> {
  const ExamRoute({List<PageRouteInfo>? children})
      : super(
          ExamRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExamRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView2]
class LoginRoute2 extends PageRouteInfo<void> {
  const LoginRoute2({List<PageRouteInfo>? children})
      : super(
          LoginRoute2.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute2';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewWordView]
class NewWordRoute extends PageRouteInfo<void> {
  const NewWordRoute({List<PageRouteInfo>? children})
      : super(
          NewWordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewWordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
