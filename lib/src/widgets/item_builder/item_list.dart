import 'package:flutter/material.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';

class ItemList extends StatefulWidget {
  const ItemList(
    this.items,
    this.typeMap,
    this.spacing,
    this.updateProfile, {
    this.itemBuilder,
    this.itemBuilderOptions,
    super.key,
  });

  final Map<String, dynamic> items;
  final Map<String, dynamic> typeMap;
  final double spacing;
  final Function(String, String) updateProfile;
  final ItemBuilder? itemBuilder;
  final ItemBuilderOptions? itemBuilderOptions;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Map<String, GlobalKey<FormState>> formKeys = {};

  @override
  void initState() {
    super.initState();

    for (var item in widget.items.entries) {
      formKeys.addAll(
        {item.key: GlobalKey<FormState>()},
      );
    }
  }

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
                formKeys['item.key'] ?? GlobalKey<FormState>(),
                item.value,
                widget.typeMap[item.key],
                (value) {
                  widget.updateProfile(item.key, value);
                },
              ),
            )
          : widgets.add(
              widget.itemBuilder!.build(
                item.key,
                formKeys['item.key'] ?? GlobalKey<FormState>(),
                item.value,
                widget.typeMap[item.key],
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
