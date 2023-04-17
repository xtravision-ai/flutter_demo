import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:xtravision_flutter_sdk/xtravision_flutter_sdk.dart';

class MyAssessmentView extends StatefulWidget {
  final CameraDescription camera;

  MyAssessmentView({required this.camera});

  @override
  State<MyAssessmentView> createState() => _MyAssessmentViewState();
}

class _MyAssessmentViewState extends State<MyAssessmentView> {
  late XtraVisionConnectionData connectionData = XtraVisionConnectionData();
  late XtraVisionLibData libData = XtraVisionLibData();

  dynamic _displayText = '-';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  XtraVisionConnectionData _getConnectionData() {
    connectionData.assessmentName = 'SQUATS';
    connectionData.authToken = '__AUTH-TOKEN__';

    return connectionData;
  }

  XtraVisionLibData _getLibData() {
    // Get a specific camera from the list of available cameras.
    libData.camera = widget.camera;
    libData.onServerResponse = onServerResponse;

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
      // ignore: avoid_print
      print("XtraVision Server Response =============> ${xtraServerResponse!}");

      var serverResponse = json.decode(xtraServerResponse);

      dynamic displayText;
      if (serverResponse['data']['category'] == 'POSE_BASED_REPS') {
        var additionalResponse = serverResponse['data']['additional_response'];
        dynamic reps = additionalResponse['reps']['total'];
        dynamic inPose = additionalResponse['in_pose'];

        displayText = " In-Pose: $inPose \n Reps: $reps";
        _updateDisplayText(displayText);
        return;
      }
    } catch (exception) {
      // ignore: avoid_print
      print(exception);
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
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
