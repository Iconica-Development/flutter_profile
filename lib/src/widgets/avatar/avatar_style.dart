import 'package:flutter/material.dart';

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
