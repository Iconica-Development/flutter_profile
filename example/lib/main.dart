import 'dart:typed_data';

import 'package:example/utils/example_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

import 'utils/example_profile_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileExample(),
    );
  }
}

class ProfileExample extends StatefulWidget {
  const ProfileExample({Key? key}) : super(key: key);

  @override
  State<ProfileExample> createState() => _ProfileExampleState();
}

class _ProfileExampleState extends State<ProfileExample> {
  late User _user;
  ProfileData profileData =
      ExampleProfileData().fromMap({'email': 'example@email.com'});

  @override
  void initState() {
    super.initState();
    _user = User(
      'Firstname',
      'Lastname',
      Uint8List.fromList(
        [],
      ),
      profileData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(
        itemBuilderOptions: ItemBuilderOptions(
          inputDecorationField: {
            'firstName': const InputDecoration(
              label: Text('First name'),
            ),
            'lastName': const InputDecoration(
              label: Text('Last name'),
            ),
            'email': const InputDecoration(
              label: Text('E-mail'),
            ),
          },
          validators: {
            'firstName': (String? value) {
              if (value == null || value.isEmpty) {
                return 'Field empty';
              }
              return null;
            },
            'lastName': (String? value) {
              if (value == null || value.isEmpty) {
                return 'Field empty';
              }
              return null;
            },
            'email': (String? value) {
              if (value == null || value.isEmpty) {
                return 'Field empty';
              }
              return null;
            },
          },
        ),
        user: _user,
        service: ExampleProfileService(),
        style: ProfileStyle(
          avatarStyle: const AvatarStyle(
            displayNameStyle: TextStyle(fontSize: 20),
          ),
          pagePadding: EdgeInsets.only(
            top: 50,
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.35,
            right: MediaQuery.of(context).size.width * 0.35,
          ),
        ),
      ),
    );
  }
}
