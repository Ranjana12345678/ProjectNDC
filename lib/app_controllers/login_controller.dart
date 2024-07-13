

import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/login_result_model.dart';

class LoginController{
  Future<LoginResultModel> tryLogging(String userEmail, String userPassword) async {
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
      body: jsonEncode({
        'user_email':userEmail,
        'user_password': userPassword
      })
    );
    if(response.statusCode == 200){
      LoginResultModel result = LoginResultModel.fromJson(jsonDecode(response.body.toString()));
      return result;
    }else{
      throw Exception("Failed to Get Login result");
    }

  }
}