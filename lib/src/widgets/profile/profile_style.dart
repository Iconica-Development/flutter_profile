// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar_style.dart';

/// ProfielStyle is used to set a couple of style paramaters for the whole profile page.
///
/// AvatarStyle is used to set some styling for the avatar using [AvatarStyle].
///
/// PagePaddign is used to set the padding around the whole profile page with its parent.
///
/// BetweenDefaultitemPadding sets te padding between each user data item.
class ProfileStyle {
  const ProfileStyle({
    this.avatarStyle = const AvatarStyle(),
    this.betweenDefaultItemPadding = 10,
    this.pagePadding = EdgeInsets.zero,
    this.bottomActionTextStyle,
  });

  /// AvatarStyle can be used to set some avatar styling parameters.
  final AvatarStyle avatarStyle;

  /// PagePadding can be set to determine the padding of the whole page againt the profile page parent.
  final EdgeInsetsGeometry pagePadding;

  /// BetweenDefaultItemPadding sets the
  final double betweenDefaultItemPadding;

  /// Bottom action text style
  final TextStyle? bottomActionTextStyle;
}
