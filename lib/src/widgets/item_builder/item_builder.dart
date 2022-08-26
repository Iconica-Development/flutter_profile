import 'package:flutter/material.dart';
import 'package:profile/src/widgets/item_builder/item_builder_options.dart';

class ItemBuilder {
  ItemBuilder({
    required this.options,
  });

  final ItemBuilderOptions options;

  Widget build(dynamic value, Widget? widget, Function(String) updateItem) {
    if (widget == null) {
      var controller = TextEditingController(
        text: '$value',
      );

      return TextField(
        controller: controller,
        decoration: options.inputDecoration,
        readOnly: options.readOnly,
        onSubmitted: (s) {
          updateItem(s);
        },
      );
    }
    return widget;
  }
}
