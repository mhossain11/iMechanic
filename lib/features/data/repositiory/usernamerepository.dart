import 'dart:convert';

import 'package:imechanic/core/util/apiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usernameModel.dart';
import 'package:http/http.dart'as http;

class UserNameRepository{
 late UsernameModel usernameModel;
  Future<UsernameModel>userNameList() async {
    SharedPreferences sp =await SharedPreferences.getInstance();
    var userToken  = sp.getString('spToken');
    var response = await http.get(Uri.parse(ApiUrl.usernameGetUrl),

        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        });
    // print('Token : $token');
    print('Data show');
    var datas = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(response.body.toString());


     // print('lenth:${nameList.length}');
        usernameModel  = UsernameModel.fromJson(datas);
     /* nameList.clear();
      for(int i=0;i<usernameModel.data!.userName!.length;i++){
        var name = usernameModel.data!.userName![i].name;
        nameList.add(name.toString());
      }*/
      print('Data Uploaded');


      print('nameEnd');
      return usernameModel;

    }else{

      throw Exception(usernameModel.message);

    }
  }
}