import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class ExampleProfileService extends ProfileService {
  ExampleProfileService();

  @override
  void pageBottomAction() {
    debugPrint('Bottom page action');
  }

  @override
  void editProfile(
    User user,
    String key,
    String value,
  ) {
    debugPrint('Editing key: $key with $value');
  }

  @override
  Future<void> uploadImage(BuildContext context) async {
    debugPrint('Updating avatar');
  }
}
