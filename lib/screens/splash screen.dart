import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/main.dart';
import 'package:flutter_tflite/screens/homePage.dart';
import 'package:get/get.dart';

class SplahsScreen extends StatefulWidget {
  //const SplahsScreen({ Key? key }) : super(key: key);

  @override
  _SplahsScreenState createState() => _SplahsScreenState();
}

class _SplahsScreenState extends State<SplahsScreen> {


  @override
  void initState() {
    super.initState();
   
    Timer(
       Duration(seconds: 3),
         (){
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );
   print("ram");
         }
      );
  
          
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F2FF),
      
      body:Column(
        children: [
          Container(
            height:MediaQuery.of(context).size.height/1.1,
            alignment:Alignment.center,
            child:Image.asset("assets/man with mask pic.png",
            height:MediaQuery.of(context).size.height/3

            )
          ),
          Expanded(
            child:Text("Mask Detector",
            style:TextStyle(color:Colors.black,fontSize:25,fontWeight:FontWeight.bold))
          )
        ],
      )
      
    );
  }
}