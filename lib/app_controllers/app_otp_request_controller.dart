
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_otp_request_response_model.dart';

class RequestOtpController{
  Future<RequestOtpResponseModel> requestOtp(String email) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.requestOtp),
      body: jsonEncode({
        'user_email' : email
      })
    );
    if(response.statusCode == 200){
      return RequestOtpResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Failed to Request Otp');
    }
  }
}