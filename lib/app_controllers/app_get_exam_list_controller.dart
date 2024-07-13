

import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_exam_list_model.dart';

class GetExamListController{
  Future<ExamListModel> getExamList() async{
    Response response = await get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getExamList),
    );
    if(response.statusCode == 200){
      ExamListModel examListModel = ExamListModel.fromJson(jsonDecode(response.body.toString()));
      return examListModel;
    }else{
      throw Exception("Failed to get ExamList");
    }
  }
}