import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class ExampleProfileService extends ProfileService {
  ExampleProfileService();

  @override
  void deleteProfile() {
    super.deleteProfile();

    debugPrint('Deleting profile');
  }

  @override
  void editProfile<T extends ProfileData>(
    User<ProfileData> user,
    String key,
    String value,
  ) {
    super.editProfile(user, key, value);

    debugPrint('Editing key: $key with $value');
  }

  @override
  Future<void> uploadImage(BuildContext context) async {
    debugPrint('Updating avatar');
  }
}
