import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

abstract class ProfileService {
  const ProfileService();

  deleteProfile() {}

  editProfile<T extends ProfileData>(User user, String key, String value) {
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
