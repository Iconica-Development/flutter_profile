import 'package:flutter/material.dart';
import 'package:flutter_profile/src/models/user.dart';
import 'package:flutter_profile/src/widgets/avatar/avatar_style.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.user,
    this.style = const AvatarStyle(),
  }) : super(key: key);

  final User user;
  final AvatarStyle style;

  @override
  Widget build(BuildContext context) {
    var imageProvider = _getImageProvider();

    if (imageProvider != null) {
      return Container(
        width: style.width,
        height: style.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (user.firstName != null || user.lastName != null) {
      return Container(
        width: style.width,
        height: style.height,
        decoration: BoxDecoration(
          color: _generateColorWithIntials(user.firstName, user.lastName),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            style: const TextStyle(fontSize: 40),
            user.initials,
          ),
        ),
      );
    }

    return Container();
  }

  ImageProvider? _getImageProvider() {
    if (user.image != null) {
      return MemoryImage(user.image!);
    } else if (user.imageUrl != null) {
      return NetworkImage(user.imageUrl!);
    }
    return null;
  }

  Color _generateColorWithIntials(String? firstName, String? lastName) {
    var uniqueInitialId = (firstName?.toLowerCase().codeUnitAt(0) ?? 0) +
        (lastName?.toLowerCase().codeUnitAt(0) ?? 0);

    return Colors.primaries[uniqueInitialId % Colors.primaries.length];
  }
}
