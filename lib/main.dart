import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/screens/splash%20screen.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_beep/flutter_beep.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplahsScreen(),
    );
  }
}







class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraImage cameraImage;
  CameraController cameraController;
  String result = "";

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) return;
     
      setState(() {
        cameraController.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
        });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
        
  }

  runModel() async {
    if (cameraImage != null) {
           
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      recognitions.forEach((element) {
        setState(() {
          result = element["label"];
          print(result);
     
        });
      });
    }
  }


void callBeepSound(){
  FlutterBeep.beep();
}


  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Face Mask Detector"),
        // ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height/1.04,
                width: MediaQuery.of(context).size.width,
                child: 
                    !cameraController.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController,
                        
                        child:Container(
                           height: MediaQuery.of(context).size.height/1.04,
                           alignment:Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            result=='With Mask'?   Icon(Icons.check,size:80,color:Colors.yellow):
                              Icon(Icons.warning_outlined,size:80,color:Colors.red)
                            ,
                              
                              SizedBox(height:20),
                              
                                Text(
                                              result,
                                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
                                              color:result=='With Mask'?Colors.yellow:Colors.red
                                              
                                              ),
                                            ),
                              ],
                            ),
                          ),
                        ),
                        ),
                      ),
                     
                    // Text(
                    //                   result,
                    //                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                    //                 ),
                              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
