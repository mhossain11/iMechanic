import 'dart:convert';

import 'package:imechanic/core/util/apiUrl.dart';

import '../../presentationLayer/widget/other/snackbars.dart';
import '../models/usernameModel.dart';
import 'package:http/http.dart'as http;

class UserNameRepository{
 late UsernameModel usernameModel;
  Future<UsernameModel>userNameList() async {

    var response = await http.get(Uri.parse(ApiUrl.usernameGetUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection':'keep-alive',
          'Accept-Encoding':'gzip, deflate, br',
          'Authorization': 'Bearer 118|qtTBufTzwKH5va62GwoDP7n83q0Bse21DqXx2NEdca41a0fa',
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
      // nameList = jsonDecode(response.body.toString());
    //  print(nameList.length);

      print('nameEnd');
      return usernameModel;

    }else{

      throw Exception(usernameModel.message);

    }
  }
}