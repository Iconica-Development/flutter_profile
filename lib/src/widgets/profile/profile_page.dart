import 'package:flutter/material.dart';
import 'package:profile/profile.dart';
import 'package:profile/src/widgets/profile/proifle_wrapper.dart';

/// The ProfilePage widget is able to show the data of a user. By default the user is able to change this data. The widget has a couple of parameters listed below:
///
/// User will contain the data of the user which atleast contain a first name, last name and an avatar/image. Besides this information the [ProfileData] can be used to set custom user fields.
///
/// With the use of the service set by a [ProfileService] some actions can be determined what should occur when the user does the following actions: Deleting/editing the profile or uploading an image.
///
/// The style can be used the set some style options regarding the whole form. This is done by setting a [ProfileStyle]. The following styling can be set: The style of the avatar, the padding of the page and default padding between items.
///
/// CustomAvatar can be set to override the standard avatar using any [Widget].
///
/// ShowAvatar can be set using a [bool] to determine whether the avatar should be shown and be able to be set by the user. Default set to true.
///
/// ShowDeleteProfile can be set using a [bool] set determine whether te user can delete the profile. Default set to true.
///
/// ItemBuilder is used to determine how the user data is represented.
///
/// ItemBuilderOptions can be used to just set the settings for fields instead of defining the field itself and how it is used. This field should not be used when the itemBuilder is set.
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

  /// User containing all the user data.
  final User user;

  /// The service the determine what should happen when the user takes action.
  final ProfileService service;

  /// Style to set some general styling parameters fot the whole page.
  final ProfileStyle style;

  /// The way to override the standard avatar is needed.
  final Widget? customAvatar;

  /// Whether to show the users avatar.
  final bool showAvatar;

  /// Whether to give the user the option to delete their own profile.
  final bool showDeleteProfile;

  /// Itembuilder is used the build each field in the user.
  final ItemBuilder? itemBuilder;

  /// Used to set settings of eacht field in user.
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
