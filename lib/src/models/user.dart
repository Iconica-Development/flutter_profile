import 'dart:typed_data';

import 'package:flutter/material.dart';

/// User is used to contain all user data. It consists of three standard fields: firstName, lastName and image.
///
/// For additional data profileData can be used.
class User {
  String? firstName;
  String? lastName;
  Uint8List? image;
  ProfileData? profileData;

  User(
    this.firstName,
    this.lastName,
    this.image,
    this.profileData,
  );

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      data['firstName'],
      data['lastName'],
      data['image'],
      data['profileData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'profileData': profileData,
    };
  }
}

/// ProfileData is used to store custom/addintional data for a user.
///
/// The MapWidget method is used to bind a [Widget] to one of the keys. This will override the standard textfield.
///
/// The Builditems method is used to make the list of field to house the user data.
abstract class ProfileData {
  const ProfileData();

  ProfileData fromMap(Map<String, dynamic> data);

  Map<String, dynamic> toMap();

  Map<String, dynamic> mapWidget(VoidCallback update, BuildContext context);

  ProfileData create();
}
