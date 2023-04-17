## Flutter Demo App for My Package
This repository contains a demo Flutter app that showcases the functionalities of "xtravision_flutter_sdk", a Flutter library for provide integration with Xtravision SAAS Platform.

## Getting Started
To run the demo app, you will need to have 
- Flutter SDK 
- VS Code 
- Android Studio (optional)

Once you have installed the requirements, you can clone this repository and run the following commands:

```sh
$ cd flutter-demo
$ flutter pub get
$ flutter run
```
This will start the demo app on your device.

Kindly change below code as per your need:
- Change Camera: front/back in `main.dart`
    ```dart
    // 0 for back camera, and one for front camera
    MyAssessmentView(camera: cameras[1]);
    ```
- Update `assessment name` and `auth-token` in file `my_assessment_view.dart`.

    ```dart
    connectionData.assessmentName = 'SQUATS';
    connectionData.authToken ='__AUTH-TOKEN__';
    ```

For detailed information of API, kindly check out API documentation. 

## Contributing
If you find any issues or have suggestions for improving "xtravision_flutter_sdk" or the demo app, please feel free to create an issue or pull request. We welcome contributions from the community.

## License
This repository is licensed under the [insert the license of your choice, such as MIT, Apache 2.0, etc.]. See the LICENSE file for details.

