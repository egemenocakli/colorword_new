/*

@RoutePage()
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<HomeScreenViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, HomeScreenViewModel homeScreenViewModel) {
    {
      return Container();
    }
  }
}

get
  int get unreadMessagesCount => _unreadMessagesCount;
set
  set unreadMessagesCount(int value) {
    _unreadMessagesCount = value;
    notifyListeners();
  }

*/









//VİEW

/* import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/app/pages/profile/viewmodel/profile_viewmodel.dart';
import 'package:colorword_new/core/base/view/base_view.dart';
import 'package:colorword_new/locator.dart';
import 'package:flutter/material.dart';


@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<ProfileViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, ProfileViewModel viewModel) {

    {
      return Scaffold(
        
      );
    }
  }
} */



//VİEWMODEL

/* import 'dart:async';
import 'package:colorword_new/app/pages/profile/service/profile_interface.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class SampleViewModel extends BaseViewModel implements ISampleService {

  @override
  FutureOr<void> init() {
  }

  @override
  Future<void> refreshData() {
    // TODO: implement refreshData
    throw UnimplementedError();
  }


}
 */


//Repository
/* class SampleRepository implements ISampleService {
  final ProfileService _profileService = ProfileService();

  @override
  Future<bool> updateName(String? displayName) async {
    return await _profileService.updateName(displayName);
  }


} */

//Service
/* class SampleService implements ISampleService {
  //final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Future<bool> updateName(String? displayName) async {
    return await _authService.updateName(displayName);
  }

} */

//Interface
/* abstract class ISampleService {
  Future<bool> updateName(String? displayName);
  Future<bool> updateEmail(String? email);
  Future<bool> deleteAccount();
}
 */



