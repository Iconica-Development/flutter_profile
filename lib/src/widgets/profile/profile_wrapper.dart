// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/change_password_config.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/services/profile_service.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar_wrapper.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_list.dart';
import 'package:flutter_profile/src/widgets/profile/change_password_widget.dart';
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
    this.avatarBackgroundColor,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.wrapViewOptions,
    this.bottomActionText,
    this.prioritizedItems = const [],
    this.showDefaultItems = true,
    this.showItems = true,
    this.wrapItemsBuilder,
    this.formKey,
    this.extraWidgets,
    this.changePasswordConfig =
        const ChangePasswordConfig(enablePasswordChange: false),
    super.key,
  });

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final Color? avatarBackgroundColor;
  final String? bottomActionText;
  final ItemBuilder? itemBuilder;
  final WrapViewOptions? wrapViewOptions;
  final Function() rebuild;
  final ItemBuilderOptions? itemBuilderOptions;
  final bool showDefaultItems;
  final bool showItems;
  final Widget Function(BuildContext context, Widget child)? wrapItemsBuilder;
  final Map<String, Widget>? extraWidgets;
  final GlobalKey<FormState>? formKey;
  final ChangePasswordConfig changePasswordConfig;

  /// Map keys of items that should be shown first before the default items and
  /// the rest of the items.
  final List<String> prioritizedItems;

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  late Map<String, Widget> widgets = {};
  Map<String, Widget> defaultItems = {};
  late GlobalKey<FormState> _formKey;
  Map<String, dynamic> formValues = {};
  bool _isUploadingImage = false;
  late final Widget child;

  @override
  void initState() {
    _formKey = widget.formKey ?? GlobalKey<FormState>();

    super.initState();
    if (widget.showDefaultItems) {
      if (widget.itemBuilder == null) {
        var builder = ItemBuilder(
          options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
        );
        defaultItems.addAll({
          'first_name': builder.build(
            'first_name',
            widget.user.firstName,
            null,
            (value) {
              submitAllChangedFields();
            },
            (v) async {
              if (widget.user.firstName != v) {
                widget.user.firstName = v;
                widget.service.editProfile(widget.user, 'first_name', v);
              }
            },
          ),
          'last_name': builder.build(
            'last_name',
            widget.user.lastName,
            null,
            (value) {
              submitAllChangedFields();
            },
            (v) async {
              if (widget.user.lastName != v) {
                widget.user.lastName = v;
                widget.service.editProfile(widget.user, 'last_name', v);
              }
            },
          ),
        });
      } else {
        defaultItems.addAll({
          'first_name': widget.itemBuilder!.build(
            'first_name',
            widget.user.firstName,
            null,
            (value) {
              submitAllChangedFields();
            },
            (v) async {
              if (widget.user.firstName != v) {
                widget.user.firstName = v;
                widget.service.editProfile(widget.user, 'first_name', v);
              }
            },
          ),
          'last_name': widget.itemBuilder!.build(
            'last_name',
            widget.user.lastName,
            null,
            (value) {
              submitAllChangedFields();
            },
            (v) async {
              if (widget.user.lastName != v) {
                widget.user.lastName = v;
                widget.service.editProfile(widget.user, 'last_name', v);
              }
            },
          ),
        });
      }
    }
    widgets.addAll(widget.extraWidgets ?? {});
    widgets.addAll(defaultItems);
    if (widget.user.profileData != null) {
      widgets.addAll(
        ItemList(
          Map.fromEntries(widget.user.profileData!.toMap().entries),
          widget.user.profileData!.mapWidget(
            () {
              widget.rebuild();
            },
            context,
          ),
          (key, value) async {
            if (widget.user.profileData?.toMap()[key] == null) {
              widget.service.editProfile(widget.user, key, value);
            } else if (widget.user.profileData?.toMap()[key] != value) {
              widget.service.editProfile(widget.user, key, value);
            }
          },
          submitAllChangedFields,
          itemBuilder: widget.itemBuilder,
          itemBuilderOptions: widget.itemBuilderOptions,
          formKey: _formKey,
        ).getItemList(),
      );
    }

    var items = Wrap(
      alignment: widget.wrapViewOptions?.wrapAlignment ?? WrapAlignment.start,
      direction: widget.wrapViewOptions?.direction ?? Axis.vertical,
      spacing: widget.wrapViewOptions?.spacing ?? 0,
      runSpacing: widget.wrapViewOptions?.runSpacing ?? 0,
      clipBehavior: widget.wrapViewOptions?.clipBehavior ?? Clip.none,
      children: [
        //add all items with prio then those without
        for (var key in widget.prioritizedItems)
          // get values from widgets with this key
          ...widgets.entries
              .where((element) => element.key == key)
              .map((e) => e.value),

        ...widgets.entries
            .where((element) => !widget.prioritizedItems.contains(element.key))
            .map((e) => e.value),
      ],
    );

    child = widget.wrapItemsBuilder?.call(context, items) ?? items;
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: widget.style.pagePadding,
              child: Column(
                children: [
                  if (widget.showAvatar) ...[
                    InkWell(
                      onTap: () async => widget.service.uploadImage(
                        context,
                        onUploadStateChanged: (bool isUploading) => setState(
                          () {
                            _isUploadingImage = isUploading;
                          },
                        ),
                      ),
                      child: AvatarWrapper(
                        avatarBackgroundColor: widget.avatarBackgroundColor,
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
                  if (widget.showItems) Form(key: _formKey, child: child),
                  if (widget.changePasswordConfig.enablePasswordChange) ...[
                    Expanded(
                      child: ChangePassword(
                        config: widget.changePasswordConfig,
                        service: widget.service,
                        wrapViewOptions: widget.wrapViewOptions,
                        wrapItemsBuilder: widget.wrapItemsBuilder,
                        itemBuilder: widget.itemBuilder,
                        itemBuilderOptions: widget.itemBuilderOptions,
                        style: widget.style,
                      ),
                    ),
                  ],
                  if (widget.bottomActionText != null) ...[
                    SizedBox(
                      height: widget.style.betweenDefaultItemPadding,
                    ),
                    if (!widget.changePasswordConfig.enablePasswordChange) ...[
                      const Spacer(),
                    ],
                    InkWell(
                      onTap: () async {
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
                  ],
                  if (widget.bottomActionText == null &&
                      !widget.changePasswordConfig.enablePasswordChange) ...[
                    const Spacer(),
                  ],
                ],
              ),
            ),
          ),
        ),
      );

  /// This calls onSaved on all the fiels which check if they have a new value
  void submitAllChangedFields() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
