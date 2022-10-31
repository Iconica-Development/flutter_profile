// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

class TestProfileService extends ProfileService {
  TestProfileService();

  @override
  void pageBottomAction() {}

  @override
  void editProfile(
    User user,
    String key,
    String value,
  ) {}

  @override
  Future<void> uploadImage(BuildContext context) async {}
}
