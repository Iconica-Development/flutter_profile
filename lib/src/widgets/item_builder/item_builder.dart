// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';

/// ItemBuilder is used to set the standard textfield for each undefined users data item.
///
/// Options sets options for the textfield.
class ItemBuilder {
  ItemBuilder({
    required this.options,
  });

  final ItemBuilderOptions options;

  Widget build(
      String key, dynamic value, Widget? widget, Function(String) updateItem) {
    if (widget == null) {
      var controller = TextEditingController(
        text: '${value ?? ''}',
      );

      late InputDecoration inputDecoration;

      inputDecoration =
          options.inputDecorationField?[key] ?? options.inputDecoration;
      var formFieldKey = GlobalKey<FormFieldState>();
      return TextFormField(
        keyboardType: options.keyboardType?[key],
        key: formFieldKey,
        controller: controller,
        decoration: inputDecoration,
        readOnly: options.readOnly,
        onFieldSubmitted: (value) {
          if (formFieldKey.currentState!.validate()) {
            updateItem(value);
          }
        },
        validator: (value) {
          return options.validators?[key]?.call(value);
        },
      );
    }
    return widget;
  }
}
