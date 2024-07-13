
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/user_timeline_data_model.dart';

class UserTimeLineDataController{
  Future<UserTimeLineDataModel> getUserTimeLineData(String userId, String? token) async {
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userTimeLineData ),
      body: jsonEncode({
        'user_id' : userId
      }),
      headers: {'Authorization': token??''}
    );
    if(response.statusCode == 200){
      UserTimeLineDataModel result = UserTimeLineDataModel.fromJson(jsonDecode(response.body.toString()));
      return result;
    }else{
      throw Exception('Failed to get TimeLine Data');
    }
  }
}