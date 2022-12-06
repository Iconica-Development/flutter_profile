// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

class ExampleProfileData extends ProfileData {
  ExampleProfileData({
    this.email,
    this.about,
    this.remarks,
  });

  String? email;
  String? about;
  String? remarks;

  @override
  Map<String, dynamic> mapWidget(
    VoidCallback update,
    BuildContext context,
  ) {
    return {
      'email': null,
      'about': null,
      'remarks': null,
    };
  }

  @override
  ProfileData fromMap(Map<String, dynamic> data) {
    return ExampleProfileData(
      email: data['email'],
      about: data['about'],
      remarks: data['remarks'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'email': email, 'about': about, 'remarks': remarks};
  }

  @override
  ProfileData create() {
    return ExampleProfileData();
  }
}
