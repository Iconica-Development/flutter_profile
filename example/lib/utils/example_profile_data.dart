// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

class ExampleProfileData extends ProfileData {
  ExampleProfileData({
    this.email,
  });

  String? email;

  @override
  Map<String, dynamic> mapWidget(
    VoidCallback update,
    BuildContext context,
  ) {
    return {
      'email': null,
    };
  }

  @override
  ProfileData fromMap(Map<String, dynamic> data) {
    return ExampleProfileData(
      email: data['email'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  @override
  ProfileData create() {
    return ExampleProfileData();
  }
}
