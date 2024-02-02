// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

/// ItemBuilderOptions is a class to store all settings for a field in the 
/// profile page.
///
/// InputDecoration sets the decoration for all standard textfields. 
/// This is overridden if a field specific decoration is set by 
/// inputDecorationField.
///
/// inputDecorationField sets the inputdecoration by key of the user data field.
/// So a field can have its own specific decoration.
///
/// Validator can be used to set a validator for the standard textfield.
class ItemBuilderOptions {
  ItemBuilderOptions({
    this.inputDecoration = const InputDecoration(
      constraints: BoxConstraints(maxWidth: 200, maxHeight: 40),
    ),
    this.inputDecorationField,
    this.readOnly = false,
    this.validators,
    this.keyboardType,
    this.inputTextStyle,
  });
  final InputDecoration inputDecoration;

  /// TextStyle for the input fields
  final TextStyle? inputTextStyle;
  final Map<String, InputDecoration>? inputDecorationField;
  final bool readOnly;
  final Map<String, String? Function(String?)>? validators;
  final Map<String, TextInputType>? keyboardType;
}
