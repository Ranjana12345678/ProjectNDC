class UserProfileResultModel {
  bool? status;
  String? message;
  Data? data;

  UserProfileResultModel({this.status, this.message, this.data});

  UserProfileResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? userGender;
  String? userDegree;
  String? userCaste;
  String? userPhonenumber;
  String? userEmail;

  Data(
      {this.userId,
        this.userName,
        this.userGender,
        this.userDegree,
        this.userCaste,
        this.userPhonenumber,
        this.userEmail});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userGender = json['user_gender'];
    userDegree = json['user_degree'];
    userCaste = json['user_caste'];
    userPhonenumber = json['user_phonenumber'];
    userEmail = json['user_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_gender'] = this.userGender;
    data['user_degree'] = this.userDegree;
    data['user_caste'] = this.userCaste;
    data['user_phonenumber'] = this.userPhonenumber;
    data['user_email'] = this.userEmail;
    return data;
  }
}
