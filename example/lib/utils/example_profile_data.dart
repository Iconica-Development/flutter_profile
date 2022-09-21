import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

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
