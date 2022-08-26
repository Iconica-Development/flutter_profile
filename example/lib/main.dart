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
  MyProfileData profileData = MyProfileData();

  @override
  void initState() {
    super.initState();
    _user = User(
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
        service: MyProfileService(),
        user: _user,
      ),
    );
  }
}

class MyProfileService extends ProfileService {
  @override
  deleteProfile() {
    return super.deleteProfile();
  }

  @override
  editProfile<T extends ProfileData>(
      User<ProfileData> user, String key, String value) {
    return super.editProfile(user, key, value);
  }

  @override
  uploadImage() {
    return super.uploadImage();
  }
}

class MyProfileData extends ProfileData {
  MyProfileData({
    this.justMyNumber = '1',
    this.justMyString = 2,
  });

  final String justMyNumber;
  int justMyString;

  @override
  Map<String, dynamic> mapWidget(Function update) {
    return {
      'justMyString': Container(
        height: 100,
        width: 300,
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: justMyString == 1 ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                justMyString = 1;
                update();
                print(justMyString);
              },
              child: const Text('1'),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: justMyString == 2 ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                justMyString = 2;
                update();
                print(justMyString);
              },
              child: const Text('2'),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: justMyString == 3 ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                justMyString = 3;
                update();
              },
              child: const Text('3'),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: justMyString == 4 ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                justMyString = 4;
                update();
              },
              child: const Text('4'),
            ),
          ],
        ),
      ),
      'justMyNumber': null,
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
    return MyProfileData();
  }
}
