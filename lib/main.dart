import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'my_assessment_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error in fetching the cameras: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'XtraVision Demo App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('XtraVision Demo App'),
          ),
          body: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // 0 for back camera, and one for front camera
    return MyAssessmentView(camera: cameras[1]);
  }
}
