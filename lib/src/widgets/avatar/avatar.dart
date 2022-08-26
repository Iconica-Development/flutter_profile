import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:profile/src/widgets/avatar/avatar_style.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.image,
    this.name,
    this.avatar,
    this.displayName,
    this.style = const AvatarStyle(),
  }) : super(key: key);

  final Uint8List? image;
  final String? name;
  final String? displayName;
  final Widget? avatar;
  final AvatarStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _avatar(),
        if (displayName != null)
          Text(
            displayName!,
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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.memory(image!),
      );
    } else if (name != null && name!.isNotEmpty) {
      return Container(
        width: style.width,
        height: style.height,
        decoration: BoxDecoration(
          color: _generateColorWithIntials(name!),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            _getInitials(name!),
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

  String _getInitials(String name) {
    var nameList = name.split(' ');
    return nameList.first[0] + nameList.last[0];
  }

  Color _generateColorWithIntials(String name) {
    var nameList = name.split(' ');
    var uniqueInitialId = nameList.first.toLowerCase().codeUnitAt(0) +
        nameList.last.toLowerCase().codeUnitAt(0);

    return Colors.primaries[uniqueInitialId % Colors.primaries.length];
  }
}
