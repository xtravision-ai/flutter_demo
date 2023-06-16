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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'XtraVision Demo App';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title, //'XtraVision Flutter App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final ScrollController _controllerOne = ScrollController();

  String _selectedAssessment = 'SQUATS_T2';
  String _selectedRadio = 'front';
  bool _isSkeletonEnable = true;
  CameraDescription _selectedCamera = cameras[1]; // default camera: front
  // List of All Assessments
  final List<String> _options = [
    'PUSH_UPS_T2',
    'PUSH_UPS_T3',
    'SIT_AND_REACH_T2',
    'SIT_UPS_T2',
    'SQUATS_T2'
  ];

  void _handleOptionChanged(String value) {
    debugPrint("_MyHomePage: Selected Assessment is $value");

    setState(() {
      _selectedAssessment = value;
    });
  }

  void _handleSkeletonValue(bool value) {
    debugPrint("_MyHomePage: Selected 2D Skeleton value is $value");

    setState(() {
      _isSkeletonEnable = value;
    });
  }

  void _handleRadioChanged(String value) {
    debugPrint("_MyHomePage: Selected Camera is `$value` ");
    _selectedRadio = value;

    setState(() {
      if (value == 'front') {
        _selectedCamera = cameras[1];
      } else {
        _selectedCamera = cameras[0]; // back camera
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // reference: https://api.flutter.dev/flutter/material/Scrollbar-class.html
    return Scrollbar(
        controller: _controllerOne,
        thumbVisibility: true,
        thickness: 10,
        interactive: true,
        trackVisibility: true,
        child: ListView.builder(
          controller: _controllerOne,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Choose Assessment",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  DropdownButton<String>(
                    value: _selectedAssessment,
                    items: _options
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (v) => _handleOptionChanged(v!),
                  ),
                  // const SizedBox(height: 16),
                  const Text("Choose Camera",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'front',
                        groupValue: _selectedRadio,
                        onChanged: (v) => _handleRadioChanged(v!),
                      ),
                      const Text('Front'),
                      Radio(
                        value: 'back',
                        groupValue: _selectedRadio,
                        onChanged: (v) => _handleRadioChanged(v!),
                      ),
                      const Text('Back'),
                    ],
                  ),
                  // const SizedBox(height: 16),
                  const Text("Enable 2D Skeleton",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: true,
                        groupValue: _isSkeletonEnable,
                        onChanged: (v) => _handleSkeletonValue(v as bool),
                      ),
                      const Text('True'),
                      Radio(
                        value: false,
                        groupValue: _isSkeletonEnable,
                        onChanged: (v) => _handleSkeletonValue(v as bool),
                      ),
                      const Text('False'),
                    ],
                  ),
                  ElevatedButton(
                    child: Text("Let's Start $_selectedAssessment"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAssessmentView(
                                camera: _selectedCamera,
                                assessmentName: _selectedAssessment,
                                isSkeletonEnable: _isSkeletonEnable)),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
