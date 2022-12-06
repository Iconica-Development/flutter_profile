// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';

class ItemList {
  ItemList(
    this.items,
    this.typeMap,
    this.updateProfile,
    this.saveProfile, {
    required this.formKey,
    this.itemBuilder,
    this.itemBuilderOptions,
  }) {
    for (var item in items.entries) {
      widgets.addAll({
        item.key: itemBuilder == null
            ? builder.build(
                item.key,
                item.value,
                typeMap[item.key],
                (value) {
                  saveProfile();
                },
                (value) {
                  updateProfile(item.key, value);
                },
              )
            : itemBuilder!.build(
                item.key,
                item.value,
                typeMap[item.key],
                (value) {
                  saveProfile();
                },
                (value) {
                  updateProfile(item.key, value);
                },
              )
      });
    }
  }
  Map<String, Widget> getItemList() => widgets;

  final Map<String, dynamic> items;
  final Map<String, dynamic> typeMap;
  final Function(String, String?) updateProfile;
  final Function() saveProfile;
  final ItemBuilder? itemBuilder;
  final ItemBuilderOptions? itemBuilderOptions;
  final GlobalKey<FormState> formKey;

  Map<String, Widget> widgets = {};

  late ItemBuilder builder = ItemBuilder(
    options: itemBuilderOptions ?? ItemBuilderOptions(),
  );
}
