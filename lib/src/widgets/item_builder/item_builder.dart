// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';

/// ItemBuilder is used to set the standard textfield for each undefined users data item.
///
/// Options sets options for the textfield.
class ItemBuilder {
  ItemBuilder({
    required this.options,
  });

  final ItemBuilderOptions options;

  Widget build(String key, dynamic value, Widget? widget,
      Function(String) updateItem, Function(String?) saveItem) {
    if (widget == null) {
      var controller = TextEditingController(
        text: '${value ?? ''}',
      );

      var inputDecoration =
          options.inputDecorationField?[key] ?? options.inputDecoration;

      var formFieldKey = GlobalKey<FormFieldState>();
      return TextFormField(
        style: options.inputTextStyle,
        keyboardType: options.keyboardType?[key],
        key: formFieldKey,
        controller: controller,
        decoration: inputDecoration,
        readOnly: options.readOnly,
        onFieldSubmitted: (value) {
          updateItem(value);
        },
        onSaved: (newValue) {
          saveItem(newValue);
        },
        validator: (value) {
          return options.validators?[key]?.call(value);
        },
      );
    }
    return widget;
  }

  Widget buildPassword(
    String key,
    Function(String?) onChanged,
    String? Function(String?) validator,
  ) {
    var inputDecoration =
        options.inputDecorationField?[key] ?? options.inputDecoration;

    return FlutterFormInputPassword(
      style: options.inputTextStyle,
      decoration: inputDecoration,
      onChanged: onChanged,
      enabled: !options.readOnly,
      validator: (value) =>
          validator(value) ?? options.validators?[key]?.call(value),
    );
  }
}
