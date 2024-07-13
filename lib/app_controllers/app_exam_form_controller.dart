import 'dart:convert';

import 'package:http/http.dart';
import 'package:nibirNdcV2/api_service/api_constants.dart';

import '../app_models/app_job_course_exam_from_response_model.dart';

class AppExamFormController {

  Future<AppExamCourseJobResponseModel> submitExamDetailsForm(
      String? token,
      String? userId,
      String examYearAppearing,
      String examDescription,
      String examName,
      String examRank
      ) async{
    Response response = await post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.userTimeline),
        headers: {'Authorization' : token??''},
        body: jsonEncode({
          "user_id": userId,
          "event_date": examYearAppearing,
          "event_type": "Exam",
          "event_description": examDescription,
          "event_name" : examName,
          "event_salary": 0,
          "event_field" : examRank
        })
    );

    if(response.statusCode == 200){
      return AppExamCourseJobResponseModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Failed to submit Data');
    }
  }

}