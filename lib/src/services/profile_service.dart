import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

/// ProfileService can be extended and set for the profilePage. The following method can be overriden.
///
/// DeleteProfile is called when the user want to delete their profile.
///
/// EditProfile is called when a user changes and submits a standard textfields.
///
/// UploadImage is called when te user presses the avatar.
abstract class ProfileService {
  const ProfileService();

  deleteProfile() async {}

  editProfile<T extends ProfileData>(
      User user, String key, String value) async {
    if (user.profileData != null) {
      var map = user.profileData!.toMap();
      if (map.containsKey(key)) {
        map[key] = value;
        var profile = user.profileData!.create();
        user.profileData = profile.fromMap(map);
      }
    }
  }

  uploadImage(BuildContext context) async {}
}
