import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_controllers/app_job_form_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_components/colour.dart';
import '../../app_config/loading.dart';
import '../../app_models/app_job_course_exam_from_response_model.dart';
import '../../widgets/Custom_Button.dart';
import '../../widgets/Custom_Textfield.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
import '../../widgets/custom_msg_snackbar.dart';
import 'package:intl/intl.dart';

class Job extends StatefulWidget {
  const Job({Key? key}) : super(key: key);

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  final jobcompanycontroller = TextEditingController();
  final jobpostcontroller = TextEditingController();
  final jobyearcontroller = TextEditingController();
  final jobpaycontroller = TextEditingController();

  var loadingObj = Loading();

  submitJobForm(
      String companyJoiningDate,
      String companyDesignation,
      String companySalary,
      String companyName
      ) async {

    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      AppJobController appJobController = AppJobController();
      AppExamCourseJobResponseModel result = await appJobController.insertJobData(
          sharedPreferences.getString("token"),
          sharedPreferences.getString("userId"),
          companyJoiningDate,
          companyDesignation,
          companySalary,
          companyName
      );
      loadingObj.showLoadingDialog(context);
      if(result.status == true){
        Future.delayed(const Duration(seconds: 2),(){
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomSnackMessage(
                messageIcon: Icons.verified,
                messageTitle: "Success",
                messageBody: result.message??'',
                color: const Color(0xFF3AAFA9)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: const Duration( milliseconds: 3000),
          ));
          setState(() {
            jobcompanycontroller.clear();
            jobpostcontroller.clear();
            jobyearcontroller.clear();
            jobpaycontroller.clear();
          });
          Future.delayed(const Duration(seconds: 2),(){
            Navigator.of(context).pop();
          });

        });


      }else{
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackMessage(
              messageIcon: Icons.warning_amber_outlined,
              messageTitle: "Failed",
              messageBody: result.message??'',
              color: Colors.redAccent),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration( milliseconds: 3000),
        ));

      }

    }catch (e){

    }

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: FrostedGlass(
          glassWidth: 80*SizeConfig.widthmultiplier,
          glassHeight: 65*SizeConfig.heightmultiplier,
          glassRadius: 2*SizeConfig.heightmultiplier,
          glassChild: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2*SizeConfig.heightmultiplier,),
                Center(child: Text("Job", style: TextStyle(fontSize: 4*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),)),
                SizedBox(height: 3*SizeConfig.heightmultiplier,),
                CustomTextfield(
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  icon_details: Icons.business,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  opacity: 0.4,
                  textfield_text: "Name of Company",
                  textController: jobcompanycontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                ),
                SizedBox(height: 2*SizeConfig.heightmultiplier,),
                CustomTextfield(
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  icon_details: Icons.work,
                  opacity: 0.4,
                  textfield_text: "Designation",
                  textController: jobpostcontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                ),
                SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                CustomTextfield(
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  icon_details: Icons.calendar_month,
                  opacity: 0.4,
                  textfield_text: "Date of joining",
                  textController: jobyearcontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                  onTap: () async{
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if(pickDate != null){
                      setState(() {
                        jobyearcontroller.text = DateFormat('yyyy-MM-dd').format(pickDate);
                      });
                    }

                  },

                ),
                SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                CustomTextfield(
                  textfield_isdigits: true,
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  icon_details: Icons.currency_rupee,
                  opacity: 0.4,
                  textfield_text: "Payscale per annum",
                  textController: jobpaycontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                ),
                SizedBox(height: 4*SizeConfig.heightmultiplier,),
                CustomButton(button_text: "SUBMIT",button_width: 70*SizeConfig.widthmultiplier, onClick: (){
                  if (jobcompanycontroller.text == '' || jobpaycontroller.text == '' || jobpostcontroller.text == '' || jobyearcontroller.text == ''){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: CustomSnackMessage(
                          messageIcon: Icons.error_outline,
                          messageTitle: "Submission rejected",
                          messageBody: "Enter data in all the fields",
                          color: Colors.red),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      duration: Duration( milliseconds: 1500),
                    ));
                  }else{
                    submitJobForm(
                        jobyearcontroller.text.toString(),
                        jobpostcontroller.text.toString(),
                        jobpaycontroller.text.toString(),
                        jobcompanycontroller.text.toString());
                  }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
