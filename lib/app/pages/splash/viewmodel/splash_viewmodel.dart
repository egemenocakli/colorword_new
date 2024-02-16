import 'dart:async';
import 'package:colorword_new/app/pages/splash/service/splash_interface.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';

class SplashViewModel extends BaseViewModel implements ISplashService {
  @override
  FutureOr<void> init() {}

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }
}
