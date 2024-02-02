// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/change_password_config.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/services/profile_service.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder.dart';
import 'package:flutter_profile/src/widgets/item_builder/item_builder_options.dart';
import 'package:flutter_profile/src/widgets/profile/profile_style.dart';
import 'package:flutter_profile/src/widgets/profile/profile_wrapper.dart';

/// The ProfilePage widget is able to show the data of a user. By default the
/// user is able to change this data. The widget has a couple of
/// parameters listed below:
///
/// User will contain the data of the user which atleast contain a first name, last name and an avatar/image. Besides this information the [ProfileData] can be used to set custom user fields.
///
/// With the use of the service set by a [ProfileService] some actions can be determined what should occur when the user does the following actions: Deleting/editing the profile or uploading an image.
///
/// The style can be used the set some style options regarding the whole form.
/// This is done by setting a [ProfileStyle]. The following styling can be set:
/// The style of the avatar, the padding of the page and default
/// padding between items.
///
/// CustomAvatar can be set to override the standard avatar using any [Widget].
///
/// ShowAvatar can be set using a [bool] to determine whether the avatar should
/// be shown and be able to be set by the user. Default set to true.
///
/// BottomActionText sets the text for the inkwell at the bottom of the page.
/// If this is set the null then the [InkWell] is disabled.
///
/// ItemBuilder is used to determine how the user data is represented.
///
/// ItemBuilderOptions can be used to just set the settings for fields instead
/// of defining the field itself and how it is used. This field should not
/// be used when the itemBuilder is set.
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    required this.user,
    required this.service,
    super.key,
    this.style = const ProfileStyle(),
    this.customAvatar,
    this.showAvatar = true,
    this.avatarBackgroundColor,
    this.showItems = true,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.bottomActionText,
    this.prioritizedItems = const [],
    this.showDefaultItems = true,
    this.wrapItemsBuilder,
    this.wrapViewOptions,
    this.extraWidgets,
    this.formKey,
    this.changePasswordConfig =
        const ChangePasswordConfig(enablePasswordChange: false),
  });

  /// User containing all the user data.
  final User user;

  /// The service the determine what should happen when the user takes action.
  final ProfileService service;

  /// Style to set some general styling parameters fot the whole page.
  final ProfileStyle style;

  /// The way to override the standard avatar is needed.
  final Widget? customAvatar;

  /// Whether to show the users avatar.
  final bool showAvatar;

  ///The background color of the avatar when no image is available.
  final Color? avatarBackgroundColor;

  /// Whether you want to show the input fields, sometimes you just want
  /// to edit the avatar.
  final bool showItems;

  /// Sets the text for the [InkWell] at the bottom of the profile page.
  /// The [InkWell] is disabled when null.
  final String? bottomActionText;

  /// Itembuilder is used the build each field in the user.
  final ItemBuilder? itemBuilder;

  /// Used to set settings of each field in user.
  final ItemBuilderOptions? itemBuilderOptions;

  /// Customize the parent widget for all fields
  final Widget Function(BuildContext context, Widget child)? wrapItemsBuilder;

  /// Map keys of items that should be shown first before the default
  /// items and the rest of the items.
  final List<String> prioritizedItems;

  /// Shows textfields for firstname and lastname if is set to true
  final bool showDefaultItems;

  /// Edit the direction and spacing between every item
  final WrapViewOptions? wrapViewOptions;

  /// The map of extra widgets that might want to be added like empty
  /// SizedBoxes for styling.
  final Map<String, Widget>? extraWidgets;

  /// Use the form key to save on any custom callback
  final GlobalKey<FormState>? formKey;

  /// Configuration to give the user the option to change his/her password.
  final ChangePasswordConfig changePasswordConfig;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => ProfileWrapper(
        service: widget.service,
        user: widget.user,
        rebuild: () {
          setState(() {});
        },
        style: widget.style,
        customAvatar: widget.customAvatar,
        showAvatar: widget.showAvatar,
        showItems: widget.showItems,
        bottomActionText: widget.bottomActionText,
        itemBuilder: widget.itemBuilder,
        itemBuilderOptions: widget.itemBuilderOptions,
        prioritizedItems: widget.prioritizedItems,
        showDefaultItems: widget.showDefaultItems,
        wrapItemsBuilder: widget.wrapItemsBuilder,
        wrapViewOptions: widget.wrapViewOptions,
        extraWidgets: widget.extraWidgets,
        formKey: widget.formKey,
        avatarBackgroundColor: widget.avatarBackgroundColor,
        changePasswordConfig: widget.changePasswordConfig,
      );
}

class WrapViewOptions {
  WrapViewOptions({
    this.direction,
    this.spacing,
    this.wrapAlignment,
    this.runSpacing,
    this.clipBehavior,
  });
  Axis? direction;
  double? spacing;
  double? runSpacing;
  Clip? clipBehavior;
  WrapAlignment? wrapAlignment;
}
