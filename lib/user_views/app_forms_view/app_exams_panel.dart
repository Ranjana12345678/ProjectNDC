import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_controllers/app_get_exam_list_controller.dart';
import 'package:nibirNdcV2/widgets/Custom_Button.dart';
import 'package:nibirNdcV2/widgets/Custom_Textfield.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/loading.dart';
import '../../app_controllers/app_exam_form_controller.dart';
import '../../app_models/app_job_course_exam_from_response_model.dart';
import '../../widgets/custom_msg_snackbar.dart';
import '../../app_models/app_exam_list_model.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  final examnamecontroller = TextEditingController();
  final examrankcontroller = TextEditingController();
  final examyearcontroller = TextEditingController();

  var loadingObj = Loading();

  submitExamForm(
      String examAppearingYear,
      String examDescription,
      String examName,
      String examRank
      ) async {

    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      AppExamFormController appExamFormController = AppExamFormController();
      AppExamCourseJobResponseModel result = await appExamFormController.submitExamDetailsForm(
          sharedPreferences.getString("token"),
          sharedPreferences.getString("userId"),
          examAppearingYear,
          examDescription,
          examName,
          examRank
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
            examnamecontroller.clear();
            examrankcontroller.clear();
            examyearcontroller.clear();
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
  List<Data> exams = [];

  getExamList() async {
    GetExamListController getExamListController = GetExamListController();
    ExamListModel examListModel = await getExamListController.getExamList();
    setState(() {
      exams = examListModel.data!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getExamList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    exams.clear();
    examnamecontroller.clear();
    examrankcontroller.clear();
    examyearcontroller.clear();
    super.dispose();
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
            glassHeight: 59*SizeConfig.heightmultiplier,
            glassRadius: 2*SizeConfig.heightmultiplier,
            glassChild: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2*SizeConfig.heightmultiplier,),
                    Center(child: Text("Exam", style: TextStyle(fontSize: 4*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),)),
                    SizedBox(height: 2*SizeConfig.heightmultiplier,),
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
                            prefixIcon: const Icon(Icons.content_paste),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
                              borderSide: const BorderSide(
                                  color:Colors.red
                              ),
                            ),

                          ) ,
                          hint: const Text('Select Exam'),
                          value: _selectedValue,
                          items: exams.map((e){
                            return DropdownMenuItem(
                                value: e.examName,
                                child: Text(e.examName??"",style: TextStyle(color: Colour.BLUE_TEXT2, fontFamily: 'JosefinSans', fontSize: 2.5*SizeConfig.heightmultiplier)));
                          }).toList(),
                          onChanged: (val){
                            setState(() {
                              //
                              examnamecontroller.text = val!;
                              //print(dropDownSubjectController.text);
                            });


                          },
                        ),
                      ),
                    ),
                    // CustomTextfield(
                    //   textfield_width: 70* SizeConfig.widthmultiplier,
                    //   icon_details: Icons.content_paste,
                    //   textfield_text_colour: Colour.BLUE_TEXT2,
                    //   opacity: 0.4,
                    //   textfield_text: "Name of the exam",
                    //   textController: examnamecontroller,
                    //   textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                    // ),

                    CustomTextfield(
                      textfield_width: 70* SizeConfig.widthmultiplier,
                      textfield_text_colour: Colour.BLUE_TEXT2,
                      icon_details: Icons.check,
                      opacity: 0.4,
                      textfield_text: "Rank achieved",
                      textController: examrankcontroller,
                      textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                    ),
                    SizedBox(height: 2 * SizeConfig.heightmultiplier,),
                    CustomTextfield(
                      textfield_isdigits: true,
                      maxLength: 4,
                      textfield_width: 70* SizeConfig.widthmultiplier,
                      textfield_text_colour: Colour.BLUE_TEXT2,
                      icon_details: Icons.calendar_month,
                      opacity: 0.4,
                      textfield_text: "Year of appearing",
                      textController: examyearcontroller,
                      textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                      onTap: () async{
                        DateTime _selectedDate = DateTime.now();
                        showDialog(context: context, builder:(BuildContext context){
                          return AlertDialog(
                            content: SizedBox(
                              width: 300,
                              height: 300,
                              child: YearPicker(
                                firstDate: DateTime(DateTime.now().year - 100, 1),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                                // save the selected date to _selectedDate DateTime variable.
                                // It's used to set the previous selected date when
                                // re-showing the dialog.
                                selectedDate: _selectedDate,
                                onChanged: (DateTime dateTime) {
                                  // close the dialog when year is selected.
                                  setState(() {
                                    examyearcontroller.text = DateFormat('yyyy').format(dateTime);
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
                    SizedBox(height: 4*SizeConfig.heightmultiplier,),
                    CustomButton(button_text: "SUBMIT",button_width: 70*SizeConfig.widthmultiplier, onClick: (){
                      if (examnamecontroller.text == '' || examrankcontroller.text == '' || examyearcontroller.text == ''){
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
                        submitExamForm(
                            examyearcontroller.text.toString(),
                            "Appeared",
                            examnamecontroller.text.toString(),
                            examrankcontroller.text.toString()
                        );
                      }

                    })
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
