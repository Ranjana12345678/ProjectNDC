import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_password_reset_response_model.dart';

class PasswordResetController {
  Future<PasswordResetResponseModel> resetPassword(String userId, String newPassword, String confirmPassword) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.forgotPassword),
      body: jsonEncode({
        "user_id":userId,
        "new_password":newPassword,
        "confirm_password":confirmPassword
      })
    );
    if(response.statusCode == 200){
      return PasswordResetResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Password Reset Error');
    }

  }
}