// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_classes/test_profile_data.dart';
import 'test_classes/test_profile_service.dart';

void main() {
  testWidgets('Profile page with preset values', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ProfilePage(
            user: User(
              firstName: 'Firstname',
              lastName: 'Lastname',
              profileData: TestProfileData(email: 'test@email.com'),
            ),
            service: TestProfileService(),
          ),
        ),
      ),
    );

    var firstNameFinder = find.text('Firstname');
    var lastNameFinder = find.text('Lastname');
    var emailFinder = find.text('test@email.com');

    expect(firstNameFinder, findsOneWidget);
    expect(lastNameFinder, findsOneWidget);
    expect(emailFinder, findsOneWidget);
  });

  testWidgets('Profile page without preset value', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ProfilePage(
            user: User(
              profileData: TestProfileData(email: null),
            ),
            service: TestProfileService(),
          ),
        ),
      ),
    );
  });

  testWidgets('Profile page with preset value and changing them',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ProfilePage(
            user: User(
              firstName: 'Firstname',
              lastName: 'Lastname',
              profileData: TestProfileData(email: 'test@email.com'),
            ),
            service: TestProfileService(),
          ),
        ),
      ),
    );

    await tester.enterText(find.text('Firstname'), 'FirstEditedName');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();

    await tester.enterText(find.text('test@email.com'), 'edited@emial.com');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();

    var firstNameFinder = find.text('Firstname');
    var firstNameEditedFinder = find.text('FirstEditedName');

    var lastNameFinder = find.text('Lastname');

    var emailFinder = find.text('test@email.com');
    var emailEditedFinder = find.text('edited@emial.com');

    expect(firstNameFinder, findsNothing);
    expect(firstNameEditedFinder, findsOneWidget);
    expect(lastNameFinder, findsOneWidget);
    expect(emailFinder, findsNothing);
    expect(emailEditedFinder, findsOneWidget);
  });
}
