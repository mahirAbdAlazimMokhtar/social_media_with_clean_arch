import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';



class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
            onPressed: () async{
              await _handleVideo();
            },
            child: Text(
              'Select a Video',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
      ),
    );
  }
  
  _handleVideo()async {
    XFile? uploadedVideo  = await ImagePicker().pickVideo(source: ImageSource.gallery); 
    if(uploadedVideo == null){
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadedVideo.path);
    final savedVideo = await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    print(savedVideo);
  }
}
