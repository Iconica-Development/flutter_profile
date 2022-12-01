// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/services/profile_service.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar_wrapper.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_list.dart';
import 'package:flutter_profile/src/widgets/profile/profile_page.dart';
import 'package:flutter_profile/src/widgets/profile/profile_style.dart';

class ProfileWrapper extends StatefulWidget {
  const ProfileWrapper({
    required this.user,
    required this.service,
    required this.rebuild,
    this.style = const ProfileStyle(),
    this.customAvatar,
    this.showAvatar = true,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.wrapViewOptions,
    this.bottomActionText,
    this.prioritizedItems = const [],
    this.showDefaultItems = true,
    this.wrapItemsBuilder,
    super.key,
  });

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final String? bottomActionText;
  final ItemBuilder? itemBuilder;
  final WrapViewOptions? wrapViewOptions;
  final Function rebuild;
  final ItemBuilderOptions? itemBuilderOptions;
  final bool showDefaultItems;
  final Widget Function(BuildContext context, Widget child)? wrapItemsBuilder;

  /// Map keys of items that should be shown first before the default items and the rest of the items.
  final List<String> prioritizedItems;

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  List<Widget> defaultItems = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic> formValues = {};
  bool _isUploadingImage = false;
  late final Widget child;

  @override
  void initState() {
    super.initState();
    if (widget.itemBuilder == null) {
      ItemBuilder builder = ItemBuilder(
        options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
      );
      defaultItems.add(
        builder.build(
          'first_name',
          widget.user.firstName,
          null,
          (value) {
            submitAllChangedFields();
          },
          (v) {
            if (widget.user.firstName != v) {
              widget.user.firstName = v;
              widget.service.editProfile(widget.user, 'first_name', v);
            }
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems.add(
        builder.build(
          'last_name',
          widget.user.lastName,
          null,
          (value) {
            submitAllChangedFields();
          },
          (v) {
            if (widget.user.lastName != v) {
              widget.user.lastName = v;
              widget.service.editProfile(widget.user, 'last_name', v);
            }
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
    } else {
      defaultItems.add(
        widget.itemBuilder!.build(
          'first_name',
          widget.user.firstName,
          null,
          (value) {
            submitAllChangedFields();
          },
          (v) {
            if (widget.user.firstName != v) {
              widget.user.firstName = v;
              widget.service.editProfile(widget.user, 'first_name', v);
            }
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems.add(
        widget.itemBuilder!.build(
          'last_name',
          widget.user.lastName,
          null,
          (value) {
            submitAllChangedFields();
          },
          (v) {
            if (widget.user.lastName != v) {
              widget.user.lastName = v;
              widget.service.editProfile(widget.user, 'last_name', v);
            }
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
    }
    var items = Wrap(
      direction: widget.wrapViewOptions?.direction ?? Axis.vertical,
      spacing: widget.wrapViewOptions?.spacing ?? 0,
      runSpacing: widget.wrapViewOptions?.runSpacing ?? 0,
      clipBehavior: widget.wrapViewOptions?.clipBehavior ?? Clip.none,
      children: [
        ItemList(
          Map.fromEntries(widget.user.profileData!.toMap().entries.where(
              (element) => widget.prioritizedItems.contains(element.key))),
          widget.user.profileData!.mapWidget(
            () {
              widget.rebuild();
            },
            context,
          ),
          widget.style.betweenDefaultItemPadding,
          (key, value) {
            if (widget.user.toMap()['profile_data'][key] == null) {
              widget.service.editProfile(widget.user, key, value);
            } else if (widget.user.toMap()['profile_data'][key] != value) {
              widget.service.editProfile(widget.user, key, value);
            }
          },
          () {
            submitAllChangedFields();
          },
          itemBuilder: widget.itemBuilder,
          itemBuilderOptions: widget.itemBuilderOptions,
          formKey: formKey,
        ),
        if (widget.showDefaultItems) ...defaultItems,
        // remove all the items that have priority from the widget.user.profileData!.toMap()
        ItemList(
          Map.fromEntries(widget.user.profileData!.toMap().entries.where(
              (element) => !widget.prioritizedItems.contains(element.key))),
          widget.user.profileData!.mapWidget(
            () {
              widget.rebuild();
            },
            context,
          ),
          widget.style.betweenDefaultItemPadding,
          (key, value) {
            if (widget.user.toMap()['profile_data'][key] == null) {
              widget.service.editProfile(widget.user, key, value);
            } else if (widget.user.toMap()['profile_data'][key] != value) {
              widget.service.editProfile(widget.user, key, value);
            }
          },
          () {
            submitAllChangedFields();
          },
          itemBuilder: widget.itemBuilder,
          itemBuilderOptions: widget.itemBuilderOptions,
          formKey: formKey,
        ),
      ],
    );

    child = widget.wrapItemsBuilder?.call(context, items) ?? items;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: widget.style.pagePadding,
        child: Column(
          children: [
            if (widget.showAvatar) ...[
              InkWell(
                onTap: () => widget.service.uploadImage(
                  context,
                  onUploadStateChanged: (isUploading) => setState(
                    () {
                      _isUploadingImage = isUploading;
                    },
                  ),
                ),
                child: AvatarWrapper(
                  user: widget.user,
                  textStyle: widget.style.avatarTextStyle,
                  customAvatar: _isUploadingImage
                      ? Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const CircularProgressIndicator(),
                        )
                      : widget.customAvatar,
                ),
              ),
              SizedBox(
                height: widget.style.betweenDefaultItemPadding,
              ),
            ],
            // all the items that have priority above the default items
            Form(key: formKey, child: child),
            if (widget.bottomActionText != null) ...[
              SizedBox(
                height: widget.style.betweenDefaultItemPadding,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  widget.service.pageBottomAction();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.bottomActionText!,
                    style: widget.style.bottomActionTextStyle,
                  ),
                ),
              ),
            ] else ...[
              const Spacer(),
            ],
          ],
        ),
      ),
    );
  }

  /// This calls onSaved on all the fiels which check if they have a new value
  void submitAllChangedFields() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }
}
