
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_models/app_user_profile_model.dart';

class UserProfileResultController{
  Future<dynamic> getUserProfileResult(String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("Profile function:$token");
    print(sharedPreferences.getString("token"));
    Response response = await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userProfileData),
      headers: {'Authorization' : token}
    );
    if(response.statusCode == 200){
      UserProfileResultModel result = UserProfileResultModel.fromJson(jsonDecode(response.body.toString()));
      return result;
    } else{
      throw Exception("Failed to get User Data");
    }
    // print(response.body);

  }


}