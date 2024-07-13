import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/user_views/app_forms_view/app_course_panel.dart';
import 'package:nibirNdcV2/user_views/app_forms_view/app_exams_panel.dart';
import 'package:nibirNdcV2/user_views/app_forms_view/app_job_panel.dart';
import 'package:nibirNdcV2/widgets/Custom_Button.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';

import '../widgets/custom_msg_snackbar.dart';


class SelectOption extends StatefulWidget {
  const SelectOption({Key? key}) : super(key: key);

  @override
  State<SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {

  late String valuechoose = '';
  List selectlist = ["Exam", "Course", "Job"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: FrostedGlass(
          glassRadius: 2*SizeConfig.heightmultiplier,
          glassWidth: 80*SizeConfig.widthmultiplier,
          glassHeight: 50*SizeConfig.heightmultiplier,
          glassChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //to keep icon
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 12*SizeConfig.heightmultiplier,
                  width: 12*SizeConfig.heightmultiplier,

                  decoration: BoxDecoration(
                    color: Colour.SUPER_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier)),
                  ),

                  child: SizedBox(
                    height: 11*SizeConfig.heightmultiplier,
                    width: 11*SizeConfig.heightmultiplier,
                    child: Image(
                      image: AssetImage('assets/ndc_logo.png'),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: 2*SizeConfig.heightmultiplier,
              ),
              Text("Choose an option",
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 4*SizeConfig.heightmultiplier,
                  color: Colour.PRIMARY_COLOR,
                ),),
              SizedBox(
                height: 2*SizeConfig.heightmultiplier,
              ),
              SizedBox(
                height: 2*SizeConfig.heightmultiplier,
              ),

              Container(
                width: 60*SizeConfig.widthmultiplier,
                child: DropdownButtonFormField(

                  hint: Text("Select an option", style: TextStyle(fontFamily: 'JosefinSans'),),
                  items: [
                    DropdownMenuItem(child: Text("Job", style: TextStyle(fontFamily: 'JosefinSans', fontSize: 2.8*SizeConfig.heightmultiplier),), value: "Job",),
                    DropdownMenuItem(child: Text("Course", style: TextStyle(fontFamily: 'JosefinSans', fontSize: 2.8*SizeConfig.heightmultiplier),), value: "Course"),
                    DropdownMenuItem(child: Text("Exam", style: TextStyle(fontFamily: 'JosefinSans', fontSize: 2.8*SizeConfig.heightmultiplier),), value: "Exam",),
                  ],
                  onChanged: (value) {
                    setState(() {
                      valuechoose = value as String;
                    });
                  },
                ),
              ),

              SizedBox(
                height: 4*SizeConfig.heightmultiplier,
              ),

              CustomButton(button_text: 'Submit', onClick: () {

                if (valuechoose.isNotEmpty){
                  if (valuechoose == "Job"){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const Job()));
                  }
                  else if (valuechoose == "Course"){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const Course()));
                  }
                  else{
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const Exam()));
                  }
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: CustomSnackMessage(
                        messageIcon: Icons.error_outline,
                        messageTitle: "Option not selected",
                        messageBody: "Choose an option from the dropdown list",
                        color: Colors.purple),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    duration: Duration( milliseconds: 2500),
                  ));
                }
              }, button_width: 60*SizeConfig.widthmultiplier),
            ],
          ),
        ),
      ),
    );
  }
}
