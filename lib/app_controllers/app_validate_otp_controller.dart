
import 'dart:convert';

import 'package:http/http.dart';
import '../api_service/api_constants.dart';

import '../app_models/app_validate_otp_reposne_model.dart';

class ValidateOtpController{
  Future<ValidateOtpResponseModel> validateOtp(String userId, String otp) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyOtp),
      body: jsonEncode({
        "user_otp":otp,
        "user_id":userId
      })
    );
    if(response.statusCode == 200){
      return ValidateOtpResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception(response.body.toString());
    }
  }
}