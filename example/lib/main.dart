// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:typed_data';

import 'package:example/utils/example_profile_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_profile/flutter_profile.dart';

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
      firstName: 'Firstname',
      lastName: 'Lastname',
      image: Uint8List.fromList(
        [],
      ),
      profileData: profileData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfilePage(
          wrapViewOptions:
              WrapViewOptions(direction: Axis.vertical, spacing: 16),
          bottomActionText: 'Log out',
          itemBuilderOptions: ItemBuilderOptions(
            inputDecorationField: {
              'first_name': const InputDecoration(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 200),
                label: Text('First name'),
              ),
              'last_name': const InputDecoration(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 150),
                label: Text('First name'),
              ),
            },
            validators: {
              'first_name': (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Field empty';
                }
                return null;
              },
              'last_name': (String? value) {
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
            avatarTextStyle: const TextStyle(fontSize: 20),
            pagePadding: EdgeInsets.only(
              top: 50,
              bottom: 50,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomItemBuilderExample extends ItemBuilder {
  CustomItemBuilderExample({
    required super.options,
  });

  @override
  Widget build(String key, dynamic value, Widget? widget,
      Function(String) updateItem, Function(String?) saveItem) {
    if (widget == null) {
      var controller = TextEditingController(
        text: '${value ?? ''}',
      );

      late InputDecoration inputDecoration;

      inputDecoration =
          options.inputDecorationField?[key] ?? options.inputDecoration;
      var formFieldKey = GlobalKey<FormFieldState>();
      return SizedBox(
        width: 300,
        child: TextFormField(
          keyboardType: options.keyboardType?[key],
          key: formFieldKey,
          controller: controller,
          decoration: inputDecoration,
          readOnly: options.readOnly,
          onFieldSubmitted: (value) {
            updateItem(value);
          },
          onSaved: (newValue) {
            saveItem(newValue);
          },
          validator: (value) {
            return options.validators?[key]?.call(value);
          },
        ),
      );
    }
    return widget;
  }
}
