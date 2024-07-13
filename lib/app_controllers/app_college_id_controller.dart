
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_userId_verify_response_model.dart';

class UserIdVerifyController{
  Future<UserIdVerfiyResponseModel> verifyId(String userId) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userIdVerify),
      body: jsonEncode({
        "college_id" : userId
      })
    );
    if(response.statusCode == 200){
      return UserIdVerfiyResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Failed to validate the userId');
    }

  }
}