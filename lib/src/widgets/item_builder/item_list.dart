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
              ),
      });
    }
  }

  /// Gets the map of item keys and their corresponding widgets.
  Map<String, Widget> getItemList() => widgets;

  /// Map containing item keys and their values.
  final Map<String, dynamic> items;

  /// Map containing item keys and their types.
  final Map<String, dynamic> typeMap;

  /// Function to update the profile with a specific item's value.
  final Function(String, String?) updateProfile;

  /// Function to save the profile after an item value is updated.
  final Function() saveProfile;

  /// Builder for custom item widgets.
  final ItemBuilder? itemBuilder;

  /// Options for the item builder.
  final ItemBuilderOptions? itemBuilderOptions;

  /// Global key for the form associated with the item list.
  final GlobalKey<FormState> formKey;

  /// Map containing item keys and their corresponding widgets.
  Map<String, Widget> widgets = {};

  /// `builder` is an instance of `ItemBuilder` which is used
  /// to build the items in the list.
  /// If `itemBuilderOptions` is not provided, a default
  /// `ItemBuilderOptions` instance is used.
  late ItemBuilder builder = ItemBuilder(
    options: itemBuilderOptions ?? ItemBuilderOptions(),
  );
}
