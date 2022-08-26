import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/widgets/avatar/avatar.dart';
import 'package:profile/src/widgets/item_builder/item_builder_options.dart';

import 'package:profile/src/widgets/profile/profile_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
    this.service = const ProfileService(),
    this.style = const ProfileStyle(),
    this.customAvatar,
    this.showAvatar = true,
    this.itemBuilder,
    this.itemBuilderOptions,
  }) : super(key: key);

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final ItemBuilder? itemBuilder;
  final ItemBuilderOptions? itemBuilderOptions;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<Widget> profileItems;
  @override
  void initState() {
    super.initState();
    profileItems = widget.user.profileData!.buildItems(
      widget.user.profileData!.toMap(),
      widget.user.profileData!.mapWidget(),
      (key, value) {
        const ProfileService().editProfile(widget.user, key, value);
      },
      itemBuilder: widget.itemBuilder,
      itemBuilderOptions: widget.itemBuilderOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            if (widget.showAvatar)
              Avatar(
                name: '${widget.user.firstName} ${widget.user.lastName}',
                style: widget.style.avatarStyle,
                displayName: widget.user.displayName,
                avatar: widget.customAvatar,
                image: widget.user.image,
              ),
            ...profileItems,
          ],
        ),
      ),
    );
  }
}
