import 'package:flutter/material.dart';

/// ItemBuilderOptions is a class to store all settings for a field in the profile page.
///
/// InputDecoration sets the decoration for all standard textfields. This is overridden if a field specific decoration is set by inputDecorationField.
///
/// inputDecorationField sets the inputdecoration by key of the user data field. So a field can have its own specific decoration.
///
/// Validator can be used to set a validator for the standard textfield.
class ItemBuilderOptions {
  ItemBuilderOptions({
    this.inputDecoration = const InputDecoration(),
    this.inputDecorationField,
    this.readOnly = false,
    this.validators,
  });

  final InputDecoration inputDecoration;
  final Map<String, InputDecoration>? inputDecorationField;
  final bool readOnly;
  final Map<String, String? Function(String?)>? validators;
}
