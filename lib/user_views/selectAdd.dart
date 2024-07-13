import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/widgets/Custom_Button.dart';
import 'package:nibirNdcV2/widgets/Custom_DropList.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
import 'dart:core';

class Selection extends StatefulWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {

  late String valuechoose = '';
  List selectlist = ["Exam", "Course", "Job"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: FrostedGlass(
          glassRadius: 5*SizeConfig.heightmultiplier,
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
                  fontSize: 4*SizeConfig.heightmultiplier,
                  color: Colour.PRIMARY_COLOR,
                ),),
              SizedBox(
                height: 2*SizeConfig.heightmultiplier,
              ),
              // CustomDroplist(listItem: selectlist, boxColor: Colour.SUPER_BACKGROUND_COLOR,),
              SizedBox(
                height: 2*SizeConfig.heightmultiplier,
              ),

              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Select an item',
                  border: OutlineInputBorder(),
                ),

                // items: selectlist
                //     .map(
                //       (item) => DropdownMenuItem(
                //     value: item,
                //     child: Text(item),
                //   ),
                // ).toList(),

                items: selectlist.map<DropdownMenuItem<String>>((valueItem){
                  return DropdownMenuItem<String>(
                    value: valueItem,
                    child: Text(valueItem,
                      // style: TextStyle(color: widget.optionColor ?? Colors.black),
                    ),
                  );
                },).toList(),

                onChanged: (value) {
                  setState(() {
                    valuechoose = value as String;
                  });
                },

                value: valuechoose,

              ),
              SizedBox(height: 16),
              Text('Selected item: ' + valuechoose),

              CustomButton(button_text: 'Submit', onClick: () {
                print(valuechoose);
              }, button_width: 30*SizeConfig.widthmultiplier),
            ],
          ),
        ),
      ),
    );
  }
}
