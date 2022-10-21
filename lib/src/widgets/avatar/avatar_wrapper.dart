import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar_style.dart';

class AvaterWrapper extends StatelessWidget {
  const AvaterWrapper({
    Key? key,
    required this.user,
    this.avatar,
    this.style = const AvatarStyle(),
  }) : super(key: key);

  final User user;
  final Widget? avatar;
  final AvatarStyle style;

  @override
  Widget build(BuildContext context) {
    var avatar = this.avatar ??
        Avatar(
          user: user,
          style: style,
        );

    if (!style.displayName) {
      return avatar;
    }

    return Column(
      children: [
        avatar,
        if (user.firstName != null || user.firstName != null)
          Padding(
            padding: style.displayNamePadding,
            child: Text(
              user.displayName,
              style: style.displayNameStyle,
            ),
          )
      ],
    );
  }
}
