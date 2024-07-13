import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_controllers/app_get_course_list_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_components/colour.dart';
import '../../app_config/loading.dart';
import '../../app_controllers/app_course_form_controller.dart';
import '../../app_models/app_job_course_exam_from_response_model.dart';
import '../../widgets/Custom_Button.dart';
import '../../widgets/Custom_Textfield.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
import '../../widgets/custom_msg_snackbar.dart';
import '../../app_models/app_course_list_model.dart';


class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  final coursetypecontroller = TextEditingController();
  final courseinsticontroller = TextEditingController();
  final courseyearcontroller = TextEditingController();

  var loadingObj = Loading();

  submitExamForm(
      String courseCompletionYear,
      String courseDescription,
      String courseDegree,
      String courseInstitute
      ) async {

    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      AppCourseFormController appCourseFormController = AppCourseFormController();
      AppExamCourseJobResponseModel result = await appCourseFormController.submitCourseForm(
          sharedPreferences.getString("token"),
          sharedPreferences.getString("userId"),
          courseCompletionYear,
          courseDescription,
          courseDegree,
          courseInstitute
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
            coursetypecontroller.clear();
            courseinsticontroller.clear();
            courseyearcontroller.clear();
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.warning_amber_outlined,
            messageTitle: "Failed",
            messageBody: e.toString(),
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration( milliseconds: 3000),
      ));

    }

  }

  String? _selectedValue;
  List<Data> courses = [];

  getCoursesList() async{
    GetCourseListController getCourseListController= GetCourseListController();
    CourseListModel courseList =  await getCourseListController.getCourseList();
    setState(() {
      courses = courseList.data!;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoursesList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    coursetypecontroller.clear();
    courseinsticontroller.clear();
    courseyearcontroller.clear();
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
          glassWidth: 80 * SizeConfig.widthmultiplier,
          glassHeight: 59 * SizeConfig.heightmultiplier,
          glassRadius: 2 * SizeConfig.heightmultiplier,
          glassChild: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                Center(child: Text("Course", style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 4 * SizeConfig.heightmultiplier),)),
                SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colour.SUPER_BACKGROUND_COLOR.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
                    ),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      validator: (value) => value == null ? 'required' : null,
                      decoration:InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
                          prefixIcon: const Icon(Icons.school_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
                              borderSide: const BorderSide(
                                color:Colors.red
                              ),
                          ),

                      ) ,
                      hint: const Text('Select Degree'),
                      value: _selectedValue,
                      items: courses.map((e){
                        return DropdownMenuItem(
                            value: e.courseName,
                            child: Text(e.courseName??"",style: TextStyle(color: Colour.BLUE_TEXT2, fontFamily: 'JosefinSans', fontSize: 2.5*SizeConfig.heightmultiplier)));
                      }).toList(),
                      onChanged: (val){
                        setState(() {
                          //
                          coursetypecontroller.text = val!;
                          //print(dropDownSubjectController.text);
                        });


                      },
                    ),
                  ),
                ),
                // CustomTextfield(
                //   textfield_width: 70* SizeConfig.widthmultiplier,
                //   icon_details: Icons.school_outlined,
                //   textfield_text_colour: Colour.BLUE_TEXT2,
                //   opacity: 0.4,
                //   textfield_text: "Name of the degree",
                //   textController: coursetypecontroller,
                //   textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                // ),
                //SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                CustomTextfield(
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  icon_details: Icons.business,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  opacity: 0.4,
                  textfield_text: "Name of Institution",
                  textController: courseinsticontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                ),
                SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                CustomTextfield(
                  maxLength: 4,
                  textfield_isdigits: true,
                  textfield_width: 70* SizeConfig.widthmultiplier,
                  icon_details: Icons.calendar_month,
                  textfield_text_colour: Colour.BLUE_TEXT2,
                  opacity: 0.4,
                  textfield_text: "Year of completion",
                  textController: courseyearcontroller,
                  textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                  onTap: () async{
                    DateTime _selectedDate =DateTime.now();
                    showDialog(context: context, builder:(BuildContext context){
                      return AlertDialog(
                        content: SizedBox(
                          width: 300,
                          height: 300,
                          child: YearPicker(
                            firstDate: DateTime(DateTime.now().year - 100, 1),
                            lastDate: DateTime(DateTime.now().year + 100, 1),
                            initialDate: DateTime.now(),
                            // save the selected date to _selectedDate DateTime variable.
                            // It's used to set the previous selected date when
                            // re-showing the dialog.
                            selectedDate: _selectedDate,
                            onChanged: (DateTime dateTime) {
                              // close the dialog when year is selected.
                              setState(() {
                                courseyearcontroller.text = DateFormat('yyyy').format(dateTime);
                              });
                              Navigator.pop(context);

                              // Do something with the dateTime selected.
                              // Remember that you need to use dateTime.year to get the year
                            },
                          ),
                        ),
                      );
                    });

                  },
                ),
                SizedBox(height: 4 * SizeConfig.heightmultiplier,),
                CustomButton(button_text: "SUBMIT",
                    button_width: 70 * SizeConfig.widthmultiplier,
                    onClick: () {
                      if (courseinsticontroller.text == '' || coursetypecontroller.text == '' || courseyearcontroller.text == ''){
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
                      }
                      else{
                        submitExamForm(
                            courseyearcontroller.text.toString(),
                            "Compeleted",
                            coursetypecontroller.text.toString(),
                            courseinsticontroller.text.toString()
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
