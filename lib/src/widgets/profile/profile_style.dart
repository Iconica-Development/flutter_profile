import 'package:flutter/material.dart';
import 'package:profile/src/widgets/avatar/avatar_style.dart';

class ProfileStyle {
  const ProfileStyle({
    this.avatarStyle = const AvatarStyle(),
    this.betweenDefaultItemPadding = 10,
    this.pagePadding = EdgeInsets.zero,
  });

  final AvatarStyle avatarStyle;
  final EdgeInsetsGeometry pagePadding;
  final double betweenDefaultItemPadding;
}
