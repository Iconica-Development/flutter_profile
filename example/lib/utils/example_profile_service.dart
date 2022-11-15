// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

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
    String? value,
  ) {
    debugPrint('Editing key: $key with $value');
  }

  @override
  Future<void> uploadImage(BuildContext context) async {
    debugPrint('Updating avatar');
  }
}
