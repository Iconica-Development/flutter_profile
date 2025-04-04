// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

class TestProfileData extends ProfileData {
  TestProfileData({
    this.email,
  });

  String? email;

  @override
  Map<String, Widget?> mapWidget(
    VoidCallback update,
    BuildContext context,
  ) =>
      {
        'email': null,
      };

  @override
  ProfileData fromMap(Map<String, dynamic> data) => TestProfileData(
        email: data['email'],
      );

  @override
  Map<String, String?> toMap() => {
        'email': email,
      };

  @override
  ProfileData create() => TestProfileData();
}
