import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({Key? key}) : super(key: key);

  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {

  CameraController? cameraController;
  bool hasError = false;

  bool get isFrontCameraAvailable => cameraController != null;

  @override
  void initState() async {
    super.initState();

    CameraDescription? backCameraDescription;

    try {
      // Getting the first found front camera
      final cameraDescriptions = await availableCameras();
      for (CameraDescription cameraDescription in cameraDescriptions) {
        if (cameraDescription.lensDirection == CameraLensDirection.back) {
          backCameraDescription = cameraDescription;
          break;
        }
      }

      if (backCameraDescription == null) {
        throw Exception();
      }

      cameraController = CameraController(
          backCameraDescription,
          ResolutionPreset.high
      );

      await cameraController?.initialize();

    } catch (e) {
      hasError = true;
      setState(() {});
    }
  }
  //
  // @override
  // void dispose() {
  //   ca
  //   super.dispose();
  // }
  //


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calorie Tracker"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('Move back to home screen');
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("Search");
              },
            ),
          )
        ],
      ),
      body: hasError ? Center(child: Text("An unexpected error occurred while loading front camera")),

    );
  }
}
