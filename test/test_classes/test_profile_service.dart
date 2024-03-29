// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

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
    String? value,
  ) {}

  @override
  FutureOr<void> uploadImage(
    BuildContext context, {
    // ignore: avoid_positional_boolean_parameters
    required Function(bool isUploading) onUploadStateChanged,
  }) {}

  @override
  FutureOr<bool> changePassword(
    BuildContext context,
    String currentPassword,
    String newPassword,
  ) =>
      true;
}
