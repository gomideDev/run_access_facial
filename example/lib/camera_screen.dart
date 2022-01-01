import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:run_access_facial_example/UtilsScanner.dart';
import 'package:run_access_facial/run_access_facial.dart';
import 'package:run_access_facial_example/face_detector_painter.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({ Key key }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController controller;
  List<Face> _faces;
  Size size;
  bool _isDetecting = false;
  CameraDescription _description;
  CameraLensDirection _direction = CameraLensDirection.front;


  Detector _currentDetector = Detector.face;
   final FaceDetector _faceDetector = GoogleVision.instance
      .faceDetector(FaceDetectorOptions(enableContours: true));


  @override
  void initState() {
    
    initCameraAsync();
    super.initState();
  }

  initCameraAsync()async{
    _description = await UtilsScanner.getCamera(_direction);
    controller = CameraController(_description, ResolutionPreset.medium);
    controller.initialize().then((value){
      if(!mounted){
        return;
      }

      controller.startImageStream(stream);

      setState(() {
        
      });
    });
  }

  stream(CameraImage image){
    if(_isDetecting)
      return;

    _isDetecting = true;
    GoogleVisionImage  conc = GoogleVisionImage.fromBytes(UtilsScanner.concatenatePlanes(image.planes), UtilsScanner.buildMetaData(image, UtilsScanner.rotationIntToImageRotation(_description.sensorOrientation)));
    
      _faceDetector.processImage(conc).then((faces){
        if(faces.length > 0){
           
              
              setState(() {
                this._faces = faces;
              });


         
        }else{
          print('não detectou');
        }
        
      }).whenComplete((){
        Future.delayed(Duration(milliseconds: 100), ()=> _isDetecting = false);
      });

    
  }

  Future<dynamic> Function(GoogleVisionImage image) _getDetectionMethod() {
      return _faceDetector.processImage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = Size(
      controller.value.previewSize.height,
      controller.value.previewSize.width,
    );
    if( controller == null || !controller.value.isInitialized){
      return Container();
    }
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(controller),
            _faces != null?
             CustomPaint(
                  painter: FaceDetectorPainter(size, _faces),
                
              ):
              SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}