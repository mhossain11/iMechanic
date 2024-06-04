
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:imechanic/core/util/apiUrl.dart';
import 'package:imechanic/features/data/models/mechanicregisterModel.dart';
import 'package:http/http.dart' as http;

class MechanicRegisterRepository{
   MechanicRegisterModel model =MechanicRegisterModel();

  Future<MechanicRegisterModel>mechanicCreateAccount({
    emailAddressController,
    passwordController,
    conformPasswordController,
    fullNameController,
    userNameController,
    numberController,
    dropdownValue,
    proofImage,profileImage}
    ) async{


print('start');
var uri =Uri.parse(ApiUrl.mechanicRegisterPostUrl);
    var request =http.MultipartRequest('POST',uri );
    request.fields.addAll(
        {
          'emailAddress':emailAddressController.text.toString(),
          'password':passwordController.text.toString(),
          'confirmPassword':conformPasswordController.text.toString(),
          'mechanic_name':fullNameController.text.toString(),
          'experienceLevel':dropdownValue.toString(),
          'statusId':'0',
          'mobile':numberController.text.toString() ,
          'userName':userNameController.text.toString(),
        }
    );

    if (proofImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'evidenceexperience',proofImage.path.toString(),
        /*filename: proofImage.path.split('/').last,)*/ ));
    }
    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'userImage',profileImage.path.toString(), ));
    }

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var result =await json.decode(response.body) ;

    print(response.statusCode);
   /* print('dropdownValue3:${dropdownValue.toString()}');
    print('experienceImage:${proofImage.path.toString()}');
    print('profileImage:${profileImage.path.toString()}');
      print('email:${emailAddressController.text.toString()}');
      print('password:${passwordController.text.toString()}');
      print('conformPassword:${conformPasswordController.text.toString()}');
      print('fullName:${fullNameController.text.toString()}');
      print('userName:${userNameController.text.toString()}');
      print('number:${numberController.text.toString()}');*/

   // print('End');
    if (response.statusCode == 200 || response.statusCode == 201) {
    //  print('Upload');
     return model =MechanicRegisterModel.fromJson(result);
          } else {
  throw Exception(model.message.toString());
  }
}
}
