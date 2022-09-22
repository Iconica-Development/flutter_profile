import 'package:flutter/material.dart';

/// AvatarStyle is used to set the style of the avatar displayed at the top of the [ProfilePage].
///
/// Width is used to set the width of the avatar. Defaults to 100.
///
/// Height is used to set the height of the avatar. Defaults to 100.
///
/// InitialStyle sets the [TextStyle] of the initial which are shown when no image is provided.
///
/// DisplayNameStyle sets the [TextStyle] for the displayname underneath the avatar.
class AvatarStyle {
  const AvatarStyle({
    this.width = 100,
    this.height = 100,
    this.initialStyle = const TextStyle(),
    this.displayNameStyle = const TextStyle(),
  });

  final double width;
  final double height;
  final TextStyle initialStyle;
  final TextStyle displayNameStyle;
}
