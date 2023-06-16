## Flutter Demo App for XtraVision Flutter SDK
This repository contains a demo Flutter app that showcases the functionalities of "xtravision_flutter_sdk", a Flutter library for provide integration with Xtravision SAAS Platform.

## Getting Started
To run the demo app, you will need to have 
- Flutter SDK 
- VS Code 
- Android Studio / XCode

Once you have installed the requirements, you can clone this repository and run the following commands:

```sh
$ flutter pub get
$ flutter run
```
This will start the demo app on your device.

Kindly put user specific auth token in below code in `my_assessment_view.dart`. (Get token from your server or put hardcoded for manual testing)
    ```dart
    connectionData.assessmentName = 'SQUATS'; // assessment name
    connectionData.authToken ='__AUTH-TOKEN__'; // user specific token
    ```

For detailed information of API, kindly check out API documentation. 

## Contributing
If you find any issues or have suggestions for improving "xtravision_flutter_sdk" or the demo app, please feel free to create an issue or pull request. We welcome contributions from the community.

## License
This repository is licensed under the [insert the license of your choice, such as MIT, Apache 2.0, etc.]. See the LICENSE file for details.

