class UserRegisterModel {
  bool? success;
  Data? data;
  String? message;

  UserRegisterModel({this.success, this.data, this.message});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? userImage;
  String? mobile;
  String? userName;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.name,
        this.email,
        this.userImage,
        this.mobile,
        this.userName,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userImage = json['userImage'];
    mobile = json['mobile'];
    userName = json['userName'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['userImage'] = this.userImage;
    data['mobile'] = this.mobile;
    data['userName'] = this.userName;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
