// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';



// class HomePage extends StatefulWidget {
//  // const HomePage({ Key? key }) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   CameraImage cameraImage;
//   CameraController cameraController;
//   String result = "";
// List<CameraDescription> cameras;
//   initCamera() {
//     cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//     cameraController.initialize().then((value) {
//       if (!mounted) return;
//       setState(() {
//         cameraController.startImageStream((imageStream) {
//             cameraImage = imageStream;
//             runModel();
//         });
//       });
//     });
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite", labels: "assets/labels.txt");
//   }

//   runModel() async {
//     if (cameraImage != null) {
//       var recognitions = await Tflite.runModelOnFrame(
//           bytesList: cameraImage.planes.map((plane) {
//             return plane.bytes;
//           }).toList(),
//           imageHeight: cameraImage.height,
//           imageWidth: cameraImage.width,
//           imageMean: 127.5,
//           imageStd: 127.5,
//           rotation: 90,
//           numResults: 2,
//           threshold: 0.1,
//           asynch: true);
//       recognitions.forEach((element) {
//         setState(() {
//           result = element["label"];
//           print(result);
//         });
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
    
//     initCamera();
//     loadModel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Face Mask Detector"),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Container(
//                 height: MediaQuery.of(context).size.height - 170,
//                 width: MediaQuery.of(context).size.width,
//                 child: !cameraController.value.isInitialized
//                     ? Container()
//                     : AspectRatio(
//                         aspectRatio: cameraController.value.aspectRatio,
//                         child: CameraPreview(cameraController),
//                       ),
//               ),
//             ),
//             Text(
//               result,
//               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }