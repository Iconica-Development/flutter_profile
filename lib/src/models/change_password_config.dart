import 'package:flutter/material.dart';

/// Configuration to enable to user to change his password in the profilescreen.
class ChangePasswordConfig {
  const ChangePasswordConfig({
    required this.enablePasswordChange,
    this.title = 'Change password',
    this.titleStyle,
    this.underTitle =
        'You van make the password more secure using upper and lower case '
            'letter, numbers and special characters.',
    this.underTitleStyle,
    this.saveButtonBuilder,
    this.fieldRequiredErrorText = 'Field required',
    this.notEqualErrorText = 'Password have to be equal',
  });

  /// Enables the textfields for the user to provide a new password.
  final bool enablePasswordChange;

  /// Text for the title above the textfields.
  final String title;

  /// Textstyle of the title.
  final TextStyle? titleStyle;

  /// Text for the undertitle just above the textfields.
  final String underTitle;

  /// Textstyle for the undertitle
  final TextStyle? underTitleStyle;

  /// Ability to override the standard 'save password' button.
  final Widget Function(
    BuildContext context,
    void Function() onTap,
  )? saveButtonBuilder;

  /// Error text to be shown when either of the textfields is empty.
  final String fieldRequiredErrorText;

  /// Error text to be shown when the second password isn't equal to the first password.
  final String notEqualErrorText;
}
