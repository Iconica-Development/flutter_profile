import 'package:flutter/material.dart';

class ItemBuilderOptions {
  const ItemBuilderOptions({
    this.inputDecoration = const InputDecoration(),
    this.readOnly = false,
  });

  final InputDecoration inputDecoration;
  final bool readOnly;
}
