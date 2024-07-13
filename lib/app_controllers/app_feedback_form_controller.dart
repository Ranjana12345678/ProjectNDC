import 'dart:convert';
import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_feedback_form_response_model.dart';


class FeedBackFormController{
  Future<FeedBackFormResponseModel> submitFeedBackForm(String feedBackMessage, String id) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userFeedBackForm),
        body: jsonEncode({
          "id": id,
          "feedback_message": feedBackMessage
        })
    );
    if(response.statusCode == 200){
      return FeedBackFormResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Error in Feedback');
    }
  }
}