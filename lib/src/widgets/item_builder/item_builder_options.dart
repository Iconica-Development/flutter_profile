import 'package:flutter/material.dart';

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
