import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:profile/src/widgets/avatar/avatar_style.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.image,
    this.firstName,
    this.lastName,
    this.avatar,
    this.style = const AvatarStyle(),
  }) : super(key: key);

  final Uint8List? image;
  final String? firstName;
  final String? lastName;
  final Widget? avatar;
  final AvatarStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _avatar(),
        const SizedBox(
          height: 16,
        ),
        if (firstName != null || lastName != null)
          Text(
            '${firstName ?? ''} ${lastName ?? ''}',
            style: style.displayNameStyle,
          )
      ],
    );
  }

  Widget _avatar() {
    if (avatar != null) {
      return avatar!;
    }
    if (image != null && image!.isNotEmpty) {
      return Container(
        width: style.width,
        height: style.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: MemoryImage(image!),
            fit: BoxFit.fill,
          ),
        ),
      );
    } else if (firstName != null || lastName != null) {
      return Container(
        width: style.width,
        height: style.height,
        decoration: BoxDecoration(
          color: _generateColorWithIntials(firstName, lastName),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            style: const TextStyle(fontSize: 40),
            _getInitials(firstName, lastName),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: style.width,
        height: style.height,
        // TODO(anyone) child fallback image
      );
    }
  }

  String _getInitials(String? firstName, String? lastName) {
    return (firstName?[0] ?? '') + (lastName?[0] ?? '');
  }

  Color _generateColorWithIntials(String? firstName, String? lastName) {
    var uniqueInitialId = (firstName?.toLowerCase().codeUnitAt(0) ?? 0) +
        (lastName?.toLowerCase().codeUnitAt(0) ?? 0);

    return Colors.primaries[uniqueInitialId % Colors.primaries.length];
  }
}
