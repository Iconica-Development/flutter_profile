import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/widgets/item_builder/item_builder.dart';
import 'package:profile/src/widgets/item_builder/item_builder_options.dart';

class User<T extends ProfileData> {
  String? firstName;
  String? lastName;
  Uint8List? image;
  T? profileData;

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

abstract class ProfileData {
  const ProfileData();

  ProfileData fromMap(Map<String, dynamic> data);

  Map<String, dynamic> toMap();

  Map<String, dynamic> mapWidget(Function update);

  ProfileData create();

  List<Widget> buildItems(
    Map<String, dynamic> items,
    Map<String, dynamic> typeMap,
    double spacing,
    Function(String, String) updateProfile, {
    ItemBuilder? itemBuilder,
    ItemBuilderOptions? itemBuilderOptions,
  }) {
    var widgets = <Widget>[];
    ItemBuilder builder = ItemBuilder(
      options: itemBuilderOptions ?? const ItemBuilderOptions(),
    );
    for (var item in items.entries) {
      itemBuilder == null
          ? widgets.add(
              builder.build(
                item.value,
                typeMap[item.key],
                (value) {
                  updateProfile(item.key, value);
                },
              ),
            )
          : widgets.add(
              itemBuilder.build(
                item.value,
                typeMap[item.key],
                (value) {
                  updateProfile(item.key, value);
                },
              ),
            );
      widgets.add(SizedBox(
        height: spacing,
      ));
    }
    return widgets;
  }
}
