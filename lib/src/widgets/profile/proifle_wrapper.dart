import 'package:flutter/material.dart';
import 'package:profile/src/models/user.dart';
import 'package:profile/src/services/profile_service.dart';
import 'package:profile/src/widgets/avatar/avatar.dart';
import 'package:profile/src/widgets/item_builder/item_builder.dart';
import 'package:profile/src/widgets/item_builder/item_builder_options.dart';
import 'package:profile/src/widgets/item_builder/item_list.dart';
import 'package:profile/src/widgets/profile/profile_style.dart';

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
    this.bottomActionText,
  }) : super(key: key);

  final User user;
  final ProfileService service;
  final ProfileStyle style;
  final Widget? customAvatar;
  final bool showAvatar;
  final String? bottomActionText;
  final ItemBuilder? itemBuilder;
  final Function rebuild;
  final ItemBuilderOptions? itemBuilderOptions;

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  List<Widget> defaultItems = [];

  GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();

  GlobalKey<FormState> lastNameKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.itemBuilder == null) {
      ItemBuilder builder = ItemBuilder(
        options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
      );
      defaultItems.add(
        builder.build(
          'firstName',
          firstNameKey,
          widget.user.firstName,
          null,
          (v) {
            widget.user.firstName = v;

            widget.service.editProfile(widget.user, 'firstName', v);
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems.add(
        builder.build(
          'lastName',
          lastNameKey,
          widget.user.lastName,
          null,
          (v) {
            widget.user.lastName = v;

            widget.service.editProfile(widget.user, 'lastName', v);
          },
        ),
      );
    } else {
      defaultItems.add(
        widget.itemBuilder!.build(
          'firstName',
          firstNameKey,
          widget.user.firstName,
          null,
          (v) {
            widget.user.firstName = v;

            widget.service.editProfile(widget.user, 'firstname', v);
          },
        ),
      );
      defaultItems.add(
        SizedBox(
          height: widget.style.betweenDefaultItemPadding,
        ),
      );
      defaultItems.add(
        widget.itemBuilder!.build(
          'lastName',
          lastNameKey,
          widget.user.lastName,
          null,
          (v) {
            widget.user.lastName = v;

            widget.service.editProfile(widget.user, 'lastName', v);
          },
        ),
      );
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
            ItemList(
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
            if (widget.bottomActionText != null)
              SizedBox(
                height: widget.style.betweenDefaultItemPadding,
              ),
            const Spacer(),
            if (widget.bottomActionText != null)
              InkWell(
                onTap: () {
                  widget.service.pageBottomAction();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.bottomActionText!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
