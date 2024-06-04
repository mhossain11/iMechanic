import 'dart:convert';

import '../../../core/util/apiUrl.dart';
import '../models/userregisterModel.dart';
import 'package:http/http.dart'as http;

class UserRegisterRepository{

  late UserRegisterModel userRegisterModel;

  Future<UserRegisterModel>userCreateAccount({
    emailAddressController,
    passwordController,
    conformPasswordController,
    fullNameController,
    userNameController,
    numberController,
    profileImage}
      ) async{


    print('start');
    var uri =Uri.parse(ApiUrl.userRegisterPostUrl);
    var request =http.MultipartRequest('POST',uri );
    request.headers.addAll({'Content-Type': 'application/json',
      'Accept': 'application/json',});
    request.fields.addAll(
        {
          'email':emailAddressController.text.toString(),
          'password':passwordController.text.toString(),
          'confirm_password':conformPasswordController.text.toString(),
          'name':fullNameController.text.toString(),
          'mobile':numberController.text.toString() ,
          'userName':userNameController.text.toString(),
        }
    );

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'userImage',profileImage.path.toString(),
        /*filename: proofImage.path.split('/').last,)*/ ));
    }

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var result =await json.decode(response.body) ;
    // final result = jsonDecode(utf8.decode(response.bodyBytes));
    print('medal');
    print('experienceImage:${profileImage.path.toString()}');
    print('email:${emailAddressController.text.toString()}');
    print('password:${passwordController.text.toString()}');
    print('conformPassword:${conformPasswordController.text.toString()}');
    print('fullName:${fullNameController.text.toString()}');
    print('userName:${userNameController.text.toString()}');
    print('number:${numberController.text.toString()}');
    print(response.statusCode);

    print('End');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Upload');
      return userRegisterModel =UserRegisterModel.fromJson(result);
    } else {
      throw Exception(userRegisterModel.message.toString());
    }
  }

}