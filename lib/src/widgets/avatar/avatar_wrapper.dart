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

  final User user;
  final Widget? customAvatar;
  final Color? avatarBackgroundColor;
  final bool showName;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final double size;

  @override
  Widget build(BuildContext context) {
    var avatar = customAvatar ??
        Avatar(
          user: user,
          size: size,
          avatarBackgroundColor: avatarBackgroundColor,
        );

    return showName
        ? Column(
            children: [
              avatar,
              Padding(
                padding: padding,
                child: Flexible(
                  child: Text(
                    style: textStyle,
                    user.displayName,
                  ),
                ),
              ),
            ],
          )
        : avatar;
  }
}
