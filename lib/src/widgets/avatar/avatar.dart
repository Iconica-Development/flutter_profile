// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.user,
    this.size = 100,
    this.avatarBackgroundColor,
    this.boxfit = BoxFit.cover,
  });

  /// The user object containing user information.
  final User? user;

  /// Size of the avatar.
  final double size;

  /// Background color of the avatar.
  final Color? avatarBackgroundColor;

  final BoxFit boxfit;

  @override
  Widget build(BuildContext context) {
    var imageProvider = _getImageProvider(user);
    var hasImage = imageProvider != null;
    var hasNames =
        user != null && (user!.firstName != null || user!.lastName != null);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarBackgroundColor ??
            (!hasImage && hasNames
                ? _generateColorWithIntials(user!.firstName, user!.lastName)
                : null),
        image: hasImage
            ? DecorationImage(
                image: imageProvider,
                fit: boxfit,
              )
            : null,
      ),
      child: hasImage || !hasNames
          ? null
          : Center(
              child: Text(
                style: TextStyle(
                  fontSize: size * 0.4,
                ),
                user!.initials,
              ),
            ),
    );
  }

  /// Returns the image provider based on user's image or image URL.
  ImageProvider? _getImageProvider(User? user) {
    if (user?.image != null) {
      return MemoryImage(user!.image!);
    } else if (user?.imageUrl != null) {
      return CachedNetworkImageProvider(user!.imageUrl!);
    }
    return null;
  }

  /// Generates a color based on the initials of the user's
  /// first name and last name.
  Color _generateColorWithIntials(String? firstName, String? lastName) {
    var idFirstName = 0;
    var idLastName = 0;
    if (firstName?.isNotEmpty ?? false) {
      idFirstName = firstName!.toLowerCase().codeUnitAt(0);
    }
    if (lastName?.isNotEmpty ?? false) {
      idLastName = lastName!.toLowerCase().codeUnitAt(0);
    }

    return Colors
        .primaries[(idFirstName + idLastName) % Colors.primaries.length];
  }
}
