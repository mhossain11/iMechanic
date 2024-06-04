import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers{

  //documents,video,image
  selectFile(File? documentsImage) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      documentsImage = File(result.files.single.path!);
      if (kDebugMode) {
        print(documentsImage.path.toString());
      }
    } else {
      // User canceled the picker
    }
  }

//camera
  selectFileByCamera(File? documentsImage) async{
    final result = await ImagePicker().pickImage(source: ImageSource.camera);

    if (result != null) {
      documentsImage = File(result.path);
      if (kDebugMode) {
        print(documentsImage.path.toString());
      }
    } else {
      // User canceled the picker
    }
  }

  //gallery
   imageGallery(XFile? image) async{
     final XFile?  result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(result != null) {
         image = result;
         if (kDebugMode) {
           print(image.path.toString());
         }
      }else{
      // User canceled the picker
  }
}

}