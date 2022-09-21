import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class TestProfileService extends ProfileService {
  TestProfileService();

  @override
  void deleteProfile() {
    super.deleteProfile();
  }

  @override
  void editProfile<T extends ProfileData>(
    User<ProfileData> user,
    String key,
    String value,
  ) {
    super.editProfile(user, key, value);
  }

  @override
  Future<void> uploadImage(BuildContext context) async {
    super.uploadImage(context);
  }
}
