import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late User _user;
  MyProfileData profileData = const MyProfileData();

  @override
  void initState() {
    super.initState();
    _user = User(
      'displayName',
      'firstName',
      'lastName',
      Uint8List.fromList(
        [],
      ),
      profileData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(
        user: _user,
      ),
    );
  }
}

class MyProfileData extends ProfileData {
  const MyProfileData({
    this.justMyNumber = '1',
    this.justMyString = 2,
  });

  final String justMyNumber;
  final int justMyString;

  @override
  Map<String, dynamic> mapWidget() {
    return {
      'justMyNumber': Container(
        height: 100,
        width: 100,
        color: Colors.red,
      ),
      'justMyString': null,
    };
  }

  @override
  ProfileData fromMap(Map<String, dynamic> data) {
    return MyProfileData(
      justMyNumber: data['justMyNumber'],
      justMyString: int.parse(
        data['justMyString'].toString(),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'justMyNumber': justMyNumber,
      'justMyString': justMyString,
    };
  }

  @override
  ProfileData create() {
    return const MyProfileData();
  }
}
