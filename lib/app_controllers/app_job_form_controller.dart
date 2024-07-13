
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_job_course_exam_from_response_model.dart';

class AppJobController {
  Future<AppExamCourseJobResponseModel> insertJobData(
      String? token,
      String? userId,
      String companyJoiningDate,
      String companyDesignation,
      String companySalary,
      String companyName
      ) async {
    Response response = await post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userTimeline),
      headers: {'Authorization': token??''},
      body: jsonEncode({
        "user_id": userId,
        "event_date": companyJoiningDate,
        "event_type": "Job",
        "event_description": "Joined",
        "event_name" : companyDesignation,
        "event_salary": companySalary,
        "event_field" : companyName
      })
    );

    if(response.statusCode == 200){
      return AppExamCourseJobResponseModel.fromJson(jsonDecode(response.body.toString()));
    } else{
      throw Exception("Failed to submit Job Form");
    }


  }
}