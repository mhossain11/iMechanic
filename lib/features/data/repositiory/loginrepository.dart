
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:imechanic/core/util/apiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/loginModel.dart';

class LoginRepository{
  late LoginModel model;
  late String token;

  Future<LoginModel>getUser(TextEditingController emailController,TextEditingController passwordController) async{
    //emailController.text = "user2@gmail.com";
    // emailController.text = "mohamed@imechanic.com";
    emailController.text = "technician1@gmail.com";
   // emailController.text = "ismail@gmail.com";
    passwordController.text = "12345678";
    Response response = await http.post(Uri.parse(ApiUrl.loginPostUrl),
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        });
    print(response.statusCode);
    var mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences sp =await SharedPreferences.getInstance();
      sp.setString('spToken',token);
      print(token.toString());
      model =LoginModel.fromJson(mapResponse);
      return model;
    }else {
      throw Exception(model.message);
    }

  }
}
