
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:imechanic/core/util/apiUrl.dart';
import 'package:imechanic/features/data/models/userdataModel.dart';
import 'package:http/http.dart'as http;

class ViewOwnPostRepository{
  late UserdataModel userdataModel;

  Future<UserdataModel>getOrgDashboardData()async{

    var data = await http.get(Uri.parse(ApiUrl.userHomeGetUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 118|qtTBufTzwKH5va62GwoDP7n83q0Bse21DqXx2NEdca41a0fa',
          //'Authorization':'Bearer $token',
        });
    if (kDebugMode) {
      print(data.statusCode);
    }
    var datarespons =jsonDecode(data.body.toString());
    if(data.statusCode == 200){
      if (kDebugMode) {
        print('UserOwnPost Data Uploaded');
        print(datarespons.toString());
      }
        userdataModel =UserdataModel.fromJson(datarespons);
      return userdataModel;
    }else{
      throw Exception(userdataModel.message);

    }

  }

}