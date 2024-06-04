class MechanicRegisterModel {
  bool? success;
  Data? data;
  String? message;

  MechanicRegisterModel({this.success, this.data, this.message});

  MechanicRegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? mechanicName;
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? mobile;
  String? userName;
  String? experienceLevel;
  int? statusId;
  String? evidenceexperience;
  String? userImage;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Data(
      {this.mechanicName,
        this.emailAddress,
        this.password,
        this.confirmPassword,
        this.mobile,
        this.userName,
        this.experienceLevel,
        this.statusId,
        this.evidenceexperience,
        this.userImage,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    mechanicName = json['mechanic_name'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    mobile = json['mobile'];
    userName = json['userName'];
    experienceLevel = json['experienceLevel'];
    statusId = json['statusId'];
    evidenceexperience = json['evidenceexperience'];
    userImage = json['userImage'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanic_name'] = mechanicName;
    data['emailAddress'] = emailAddress;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['mobile'] = mobile;
    data['userName'] = userName;
    data['experienceLevel'] = experienceLevel;
    data['statusId'] = statusId;
    data['evidenceexperience'] = evidenceexperience;
    data['userImage'] = userImage;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
