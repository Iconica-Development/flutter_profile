import 'package:profile/profile.dart';

abstract class ProfileService {
  const ProfileService();

  deleteProfile() {
    print("Request to delete profile");
    // TODO(anyone) project specific
  }

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

  uploadImage() {
    print('Request to change picture');
    // TODO(anyone) open image picker and update profile
  }
}
