// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar.dart';

class AvatarWrapper extends StatelessWidget {
  const AvatarWrapper({
    required this.user,
    super.key,
    this.showName = false,
    this.padding = const EdgeInsets.only(top: 16),
    this.size = 100,
    this.textStyle,
    this.customAvatar,
    this.avatarBackgroundColor,
  });

  /// The user object containing user information.
  final User user;

  /// Custom widget to be used as an avatar.
  final Widget? customAvatar;

  /// Background color of the avatar.
  final Color? avatarBackgroundColor;

  /// Whether to show the user's name beneath the avatar.
  final bool showName;

  /// Padding around the avatar and the name.
  final EdgeInsets padding;

  /// Size of the avatar.
  final double size;

  /// Style for the user's name.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    var avatar = customAvatar ??
        Avatar(
          user: user,
          size: size,
          avatarBackgroundColor: avatarBackgroundColor,
          boxfit: BoxFit.cover,
        );

    return showName
        ? Column(
            children: [
              avatar,
              Padding(
                padding: padding,
                child: Flexible(
                  child: Text(
                    user.displayName,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          )
        : avatar;
  }
}
