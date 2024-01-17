import 'package:colorword_new/app/pages/profile/service/profile_interface.dart';
import 'package:colorword_new/app/pages/profile/service/profile_service.dart';

class ProfileRepository implements IProfileService {
  final ProfileService _profileService = ProfileService();

  @override
  Future<bool> updateName(String? displayName) async {
    return await _profileService.updateName(displayName);
  }

  @override
  Future<bool> deleteAccount() async {
    return await _profileService.deleteAccount();
  }

  @override
  Future<bool> updateEmail(String? email) async {
    return await _profileService.updateEmail(email);
  }
}
