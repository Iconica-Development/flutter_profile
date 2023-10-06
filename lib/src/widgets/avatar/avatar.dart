// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.user,
    this.size = 100,
    this.avatarBackgroundColor,
  }) : super(key: key);

  final User? user;
  final double size;
  final Color? avatarBackgroundColor;

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
                fit: BoxFit.cover,
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

  ImageProvider? _getImageProvider(User? user) {
    if (user?.image != null) {
      return MemoryImage(user!.image!);
    } else if (user?.imageUrl != null) {
      return CachedNetworkImageProvider(user!.imageUrl!);
    }
    return null;
  }

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
