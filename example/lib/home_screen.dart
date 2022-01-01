import 'package:flutter/material.dart';

import 'camera_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: TextButton(

              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CameraScreen()));
              }, child: Text('Ir para Camera')),
          ),
        ),
        );
  }
}