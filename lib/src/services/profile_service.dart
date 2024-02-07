// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';

/// ProfileService can be extended and set for the profilePage. The following method can be overriden.
///
/// BottompageAction is called when the [InkWell] at the bottom of the page is tapped.
///
/// EditProfile is called when a user changes and submits a standard textfields.
///
/// UploadImage is called when te user presses the avatar.
///
/// changePassword is called when the user requests to change his password. Return true to clear the inputfields.
abstract class ProfileService {
  const ProfileService();

  FutureOr<void> pageBottomAction();

  FutureOr<void> editProfile(User user, String key, String? value);

  FutureOr<void> uploadImage(
    BuildContext context, {
    required Function(bool isUploading) onUploadStateChanged,
  });

  FutureOr<bool> changePassword(
      BuildContext context, String currentPassword, String newPassword);
}
