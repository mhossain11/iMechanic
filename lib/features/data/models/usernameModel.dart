/// success : true
/// data : {"userName":[{"name":"ruku1122"},{"name":"ismail"},{"name":"ratul"},{"name":"ratul"},{"name":"ratul"},{"name":"rana2"},{"name":"munna11"}]}
/// message : "Users shown successfully"

class UsernameModel {
  UsernameModel({
      bool? success, 
      Data? data, 
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  UsernameModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  String? _message;
UsernameModel copyWith({  bool? success,
  Data? data,
  String? message,
}) => UsernameModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// userName : [{"name":"ruku1122"},{"name":"ismail"},{"name":"ratul"},{"name":"ratul"},{"name":"ratul"},{"name":"rana2"},{"name":"munna11"}]

class Data {
  Data({
      List<UserName>? userName,}){
    _userName = userName;
}

  Data.fromJson(dynamic json) {
    if (json['userName'] != null) {
      _userName = [];
      json['userName'].forEach((v) {
        _userName?.add(UserName.fromJson(v));
      });
    }
  }
  List<UserName>? _userName;
Data copyWith({  List<UserName>? userName,
}) => Data(  userName: userName ?? _userName,
);
  List<UserName>? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userName != null) {
      map['userName'] = _userName?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "ruku1122"

class UserName {
  UserName({
      String? name,}){
    _name = name;
}

  UserName.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;
UserName copyWith({  String? name,
}) => UserName(  name: name ?? _name,
);
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}