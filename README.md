# Flutter Profile
Flutter Profile is a package you can use to display any user data and let them alter it .

![Gif](example/gif/ImagePickerGif.gif)

## Features

With the Flutter Image Picker you can select an existing picture from the gallery of your device or make a picture with the camera to use in your app. This package is made for Android, iOS and Windows.

## Setup

To use this package, add `flutter_image_picker` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## How To Use

See the [Example Code](example/lib/main.dart) for an example on how to use this package.

You can add an optional `ImagePickerTheme()` to the `ImagePicker()` to change the layout of the Image Picker Dialog. You can add the following parameters to the `ImagePickerTheme`:
An example on how to add a parameter to the `ImagePickerTheme()` is: `ImagePickerTheme(imagePickerTheme: const ImagePickerTheme(title: "Image Picker"))`.
As a whole you get `ImagePicker(ImagePickerTheme(imagePickerTheme: const ImagePickerTheme(title: "Image Picker")))`

|     Parameter     |  Explaination  |
|-------------------|----------------|
|       font        | The font that is being used in the Image Picker Dialog. |
|       title       | The title displayed at the top of the Image Picker Dialog. |
|   titleTextSize   | The font size of the title mentioned above. |
|     titleColor    | The color of the title text. |
| titleBackgroundColor | The color of the title background. |
|   titleAlignment  | The alignment of the title text. |
|     textColor     | The color of the text that is displayed in the Image Picker Dialog. |
|     iconColor     | The color of the icons that are displayed in the Image Picker Dialog. |
|     iconSize      | The size of the icons that are visible in the Image Picker Dialog. |
|   iconTextSize    | The font size of the text underneath the icon buttons. |
| spaceBetweenIcons | The size of the space between the two icons in the Image Picker Dialog. |
|   makePhotoIcon   | The icon that is displayed for the 'Make Photo' functionality of the Image Picker Dialog. |
|   makePhotoText   | The text that is displayed underneath the 'Make Photo' icon. |
|  selectImageIcon  | The icon that is displayed for the 'Select Image From Gallery' functionality of the Image Picker Dialog. |
|  selectImageText  | The text that is displayed underneath the 'Select Image From Gallery' icon. |
|  closeButtonText  | The text that is shown on the 'Close Dialog' button at the bottom of the Image Picker Dialog. |
|  closeButtonTextSize  | The size of the text that is being displayed on the 'Close Dialog' button at the bottom of the Image Picker Dialog. |
|  closeButtonTextColor  | The color of the text that is being displayed on the 'Close Dialog' button at the bottom of the Image Picker Dialog. |
|  closeButtonWidth  | The width of the 'Close Dialog' button at the bottom of the Image Picker Dialog. |
|  closeButtonHeight  | The height of the 'Close Dialog' button at the bottom of the Image Picker Dialog. |
|  closeButtonBackgroundColor  | The background color of the 'Close Dialog' button at the bottom of the Image Picker Dialog. |


## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_image_picker/pulls) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](../CONTRIBUTING.md) and send us your [pull request](URL TO PULL REQUEST TAB IN REPO).

## Author

This `flutter-image-picker` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>