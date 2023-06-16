import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:xtravision_flutter_sdk/xtravision_flutter_sdk.dart';
import 'package:flutter_tts/flutter_tts.dart';


class MyAssessmentView extends StatefulWidget {
  final CameraDescription camera;
  final String assessmentName;
  final bool isSkeletonEnable;


  
  const MyAssessmentView(
      {super.key,
      required this.camera,
      required this.assessmentName,
      required this.isSkeletonEnable
      });

  @override
  State<MyAssessmentView> createState() => _MyAssessmentViewState();
}

class _MyAssessmentViewState extends State<MyAssessmentView> {
  late XtraVisionConnectionData connectionData = XtraVisionConnectionData();
  late XtraVisionLibData libData = XtraVisionLibData();
  FlutterTts flutterTts = FlutterTts();


  dynamic _displayText = '-';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

 
Future _speak() async{
    var result = await flutterTts.speak("Helllllo world");
}
  XtraVisionConnectionData _getConnectionData() {
    connectionData.assessmentName = widget.assessmentName;
    connectionData.authToken = "__AUTH-TOKEN__"

    return connectionData;
  }

  XtraVisionLibData _getLibData() {
    // Get a specific camera from the list of available cameras.
    libData.camera = widget.camera;
    libData.onServerResponse = onServerResponse;
    libData.enableSkeletonView = widget.isSkeletonEnable;

    return libData;
  }

  void _updateDisplayText(String value) {
    setState(() {
      _displayText = value;
    });
  }

  onServerResponse(xtraServerResponse) {
    //Imp: wrap below code in try catch block.
    try {
      _speak();

      // ignore: avoid_print
      print(
          "\x1B[36m XtraServer Response ========> ${xtraServerResponse!} \x1B[0m");

      var serverResponse = json.decode(xtraServerResponse);

      dynamic displayText;

      // have any error
      if (serverResponse['errors'].length > 0) {
        displayText = serverResponse['errors'][0]['message'];
        _updateDisplayText(displayText);
        return;
      }
      // data handling
      if (serverResponse['data']['category'] == 'POSE_BASED_REPS') {
        var additionalResponse = serverResponse['data']['additional_response'];
        dynamic reps = additionalResponse['reps']['total'];
        // dynamic inPose = additionalResponse['in_pose'];
        // // displayText = " In-Pose: $inPose \n Reps: $reps";

        displayText = "$reps";

        _updateDisplayText(displayText);
        return;
      }
    } catch (exception, stackTrace) {
      // ignore: avoid_print
      print("Error ======>>$exception");
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    //   return XtraVisionAssessmentWidget(
    //     connectionData: _getConnectionData(),
    //     libData: _getLibData(),
    //   );
    // }

    return Stack(
      // fit: StackFit.expand,
      children: [
        XtraVisionAssessmentWidget(
          connectionData: _getConnectionData(),
          libData: _getLibData(),
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Align(
            alignment: Alignment.topLeft,

            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  _displayText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),

            // Text(
            //   _displayText,
            //   style: const TextStyle(
            //     fontSize: 30, // set font size
            //     fontWeight: FontWeight.bold, // set font weight
            //     color: Colors.black, // set text color
            //     decoration: TextDecoration.none, // remove underline
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
