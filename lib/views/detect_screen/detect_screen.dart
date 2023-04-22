// import 'dart:io';

import 'dart:io';

// import 'package:color_xd/controller/home_controller.dart';
import 'package:color_xd/const/image.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class DetectScreen extends StatefulWidget {
 

  const DetectScreen({super.key});

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  bool isload=false;
  List? res;
  File? img;
  final pick=ImagePicker();
  void loadModel()async{
    await Tflite.loadModel(model: 'assets/model_unquant.tflite',labels: 'assets/labels.txt');
  }
  // var controller=Get.put(HomeController());
  @override
  void initState() {
    loadModel();
    super.initState();
    
  }
  @override
  void dispose() {
    Tflite.close();
    isload=false;
    super.dispose();
  }
  void pickCam() async{
        var image=await pick.pickImage(source: ImageSource.camera);
        if(image==null) return null;
        setState(() {
          img=File(image.path);
        });
        
        detectColr(img!);
    }
    void pickGam() async{
        var image=await pick.pickImage(source: ImageSource.gallery);
        if(image==null) return null;
        setState(() {
          img=File(image.path);
        });
        
        detectColr(img!);
    }
    void detectColr(final File image) async{
        var result=await Tflite.runModelOnImage(
          path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5
        );
        setState(() {
          res=result;
        isload=true;
        });
        
    }
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      
      
      body: SizedBox(
       width: context.screenWidth,
       height: context.screenHeight,
       child: Column(

        children: [
          30.heightBox,
          "color detection".text.size(32).color(Colors.redAccent).bold.make(),
          20.heightBox,
            isload? Column(
              children: [
               SizedBox(
                height: 300,
                width: context.screenWidth,
                child: Image.file(img!),
               ),
               20.heightBox,
               "${res![0]['label']}".text.color(Colors.black).size(32).make().box.make()
               
              ],
            ): Image.asset(icPro),
           20.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: pickCam, icon: const Icon(Icons.camera_alt,color: Colors.white,)).box.color(Colors.red).rounded.make(),
                   IconButton(onPressed: pickGam, icon: const Icon(Icons.file_copy_rounded,color: Colors.white,)).box.color(Colors.red).rounded.make(),
                ],
              ),
            )
            
        ],
       ),
      )
    );
  }
}


