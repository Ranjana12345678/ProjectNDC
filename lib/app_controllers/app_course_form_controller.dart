

import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_job_course_exam_from_response_model.dart';

class AppCourseFormController {

  Future<AppExamCourseJobResponseModel> submitCourseForm(
      String? token,
      String? userId,
      String courseCompletionYear,
      String courseDescription,
      String courseDegree,
      String courseInstitute
      ) async{
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userTimeline),
      headers: {'Authorization' : token??''},
      body: jsonEncode({
        "user_id": userId,
        "event_date": courseCompletionYear,
        "event_type": "Course",
        "event_description": courseDescription,
        "event_name" : courseDegree,
        "event_salary": 0,
        "event_field" : courseInstitute
      })
    );

    if(response.statusCode == 200){
      return AppExamCourseJobResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Failed to submit Data');
    }
  }

}