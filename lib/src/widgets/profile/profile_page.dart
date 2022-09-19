import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/widgets/avatar/avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
    required this.service,
    this.style = const ProfileStyle(),
    this.customAvatar,
    this.showAvatar = true,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.showDeleteProfile = true,
  }) : super(key: key);

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final bool showDeleteProfile;
  final ItemBuilder? itemBuilder;

  final ItemBuilderOptions? itemBuilderOptions;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ProfileWrapper(
      service: widget.service,
      user: widget.user,
      rebuild: () {
        setState(() {});
      },
      style: widget.style,
      customAvatar: widget.customAvatar,
      showAvatar: widget.showAvatar,
      showDeleteProfile: widget.showDeleteProfile,
      itemBuilder: widget.itemBuilder,
      itemBuilderOptions: widget.itemBuilderOptions,
      key: UniqueKey(),
    );
  }
}

class ProfileWrapper extends StatefulWidget {
  const ProfileWrapper({
    Key? key,
    required this.user,
    required this.service,
    required this.rebuild,
    this.style = const ProfileStyle(),
    this.customAvatar,
    this.showAvatar = true,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.showDeleteProfile = true,
  }) : super(key: key);

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final bool showDeleteProfile;
  final ItemBuilder? itemBuilder;
  final Function rebuild;
  final ItemBuilderOptions? itemBuilderOptions;

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  List<Widget> defaultItems = [];

  @override
  void initState() {
    super.initState();

    if (widget.itemBuilder == null) {
      ItemBuilder builder = ItemBuilder(
        options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
      );
      defaultItems
          .add(builder.build('firstName', widget.user.firstName, null, (v) {
        widget.user.firstName = v;

        widget.service.editProfile(widget.user, 'firstName', v);
      }));
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems
          .add(builder.build('lastName', widget.user.lastName, null, (v) {
        widget.user.lastName = v;

        widget.service.editProfile(widget.user, 'lastName', v);
      }));
    } else {
      defaultItems.add(widget.itemBuilder!
          .build('firstName', widget.user.firstName, null, (v) {
        widget.user.firstName = v;

        widget.service.editProfile(widget.user, 'firstname', v);
      }));
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems.add(widget.itemBuilder!
          .build('lastName', widget.user.lastName, null, (v) {
        widget.user.lastName = v;

        widget.service.editProfile(widget.user, 'lastName', v);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: widget.style.pagePadding,
        child: Column(
          children: [
            if (widget.showAvatar)
              InkWell(
                onTap: () async {
                  await widget.service.uploadImage(context);
                },
                child: Avatar(
                  firstName: widget.user.firstName,
                  lastName: widget.user.lastName,
                  style: widget.style.avatarStyle,
                  avatar: widget.customAvatar,
                  image: widget.user.image,
                ),
              ),
            if (widget.showAvatar)
              SizedBox(
                height: widget.style.betweenDefaultItemPadding,
              ),
            ...defaultItems,
            ...widget.user.profileData!.buildItems(
              widget.user.profileData!.toMap(),
              widget.user.profileData!.mapWidget(
                () {
                  widget.rebuild();
                },
                context,
              ),
              widget.style.betweenDefaultItemPadding,
              (key, value) {
                widget.service.editProfile(widget.user, key, value);
              },
              itemBuilder: widget.itemBuilder,
              itemBuilderOptions: widget.itemBuilderOptions,
            ),
            if (widget.showDeleteProfile)
              SizedBox(
                height: widget.style.betweenDefaultItemPadding,
              ),
            const Spacer(),
            if (widget.showDeleteProfile)
              InkWell(
                onTap: () {
                  widget.service.deleteProfile();
                },
                child: const Text('Profiel verwijderen'),
              ),
          ],
        ),
      ),
    );
  }
}
