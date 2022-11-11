// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';

class ItemList extends StatefulWidget {
  const ItemList(
    this.items,
    this.typeMap,
    this.spacing,
    this.updateProfile,
    this.saveProfile, {
    required this.formKey,
    this.itemBuilder,
    this.itemBuilderOptions,
    super.key,
  });

  final Map<String, dynamic> items;
  final Map<String, dynamic> typeMap;
  final double spacing;
  final Function(String, String) updateProfile;
  final Function() saveProfile;
  final ItemBuilder? itemBuilder;
  final ItemBuilderOptions? itemBuilderOptions;
  final GlobalKey<FormState> formKey;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    ItemBuilder builder = ItemBuilder(
      options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
    );
    for (var item in widget.items.entries) {
      widget.itemBuilder == null
          ? widgets.add(
              builder.build(
                item.key,
                item.value,
                widget.typeMap[item.key],
                (value) {
                  widget.saveProfile();
                },
                (value) {
                  widget.updateProfile(item.key, value);
                },
              ),
            )
          : widgets.add(
              widget.itemBuilder!.build(
                item.key,
                item.value,
                widget.typeMap[item.key],
                (value) {
                  widget.saveProfile();
                },
                (value) {
                  widget.updateProfile(item.key, value);
                },
              ),
            );
      widgets.add(SizedBox(
        height: widget.spacing,
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
