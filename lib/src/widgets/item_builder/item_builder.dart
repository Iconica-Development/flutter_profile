import 'package:flutter/material.dart';
import 'package:profile/src/widgets/item_builder/item_builder_options.dart';

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
      if (options.inputDecorationField != null &&
          options.inputDecorationField![key] != null) {
        inputDecoration = options.inputDecorationField![key]!;
      } else {
        inputDecoration = options.inputDecoration;
      }

      final formKey = GlobalKey<FormState>();

      return Form(
        key: formKey,
        child: TextFormField(
          key: Key(key),
          controller: controller,
          decoration: inputDecoration,
          readOnly: options.readOnly,
          onFieldSubmitted: (value) {
            if (formKey.currentState!.validate()) {
              updateItem(value);
            }
          },
          validator: (value) {
            if (options.validators != null &&
                options.validators![key] != null) {
              return options.validators![key]!(value);
            }
            return null;
          },
        ),
      );
    }
    return widget;
  }
}
