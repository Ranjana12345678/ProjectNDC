import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_registartion_form_response_model.dart';

class AppRegistrationFromController {
  Future<RegistrationFormResponseModel> registerData(
      String passOutYear,
      String userEmail,
      String newPassword,
      String confirmPassword,
      String userId) async {
    Response response = await post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.userRegistration),
        body: jsonEncode({
          "user_passout_year": passOutYear,
          "user_email": userEmail,
          "user_password": newPassword,
          "confirm_password": confirmPassword,
          "user_type": "student",
          "user_id": userId
        })
    );
    if(response.statusCode == 200){
      return RegistrationFormResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Error in Registration');
    }
  }
}
