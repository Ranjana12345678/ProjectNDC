
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_course_list_model.dart';

class GetCourseListController{
  Future<CourseListModel> getCourseList() async{

    Response response = await get(
      Uri.parse(ApiConstants.baseUrl+ApiConstants.getCourseList),
    );
    if(response.statusCode == 200){
      CourseListModel courseListModel = CourseListModel.fromJson(jsonDecode(response.body.toString()));
      return courseListModel;
    }else{
      throw Exception("Failed to get data");
    }



  }
}