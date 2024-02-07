// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:typed_data';

import 'package:flutter/material.dart';

/// User is used to contain all user data. It consists of three standard fields: firstName, lastName and image/imageUrl.
///
/// For additional data profileData can be used.
class User {
  User({
    this.firstName,
    this.lastName,
    this.image,
    this.imageUrl,
    this.profileData,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        firstName: data['first_name'],
        lastName: data['last_name'],
        image: data['image'],
        imageUrl: data['image_url'],
        profileData: data['profile_data'],
      );
  String? firstName;
  String? lastName;
  Uint8List? image;
  String? imageUrl;
  ProfileData? profileData;

  String get displayName => '${firstName ?? ''} ${lastName ?? ''}';
  String get initials =>
      '${(firstName?.isNotEmpty ?? false) ? firstName![0] : ''}'
      '${(lastName?.isNotEmpty ?? false) ? lastName![0] : ''}';

  Map<String, dynamic> toMap() => {
        'first_name': firstName,
        'last_name': lastName,
        'image': image,
        'image_url': image,
        'profile_data': profileData?.toMap(),
      };
}

/// ProfileData is used to store custom/addintional data for a user.
///
/// The MapWidget method is used to bind a [Widget] to one of the keys.
/// This will override the standard textfield.
///
/// The Builditems method is used to make the list of
/// field to house the user data.
abstract class ProfileData {
  const ProfileData();

  ProfileData fromMap(Map<String, dynamic> data);

  Map<String, dynamic> toMap();

  Map<String, dynamic> mapWidget(VoidCallback update, BuildContext context);

  ProfileData create();
}
