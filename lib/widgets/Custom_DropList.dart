import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_components/app_constants.dart';

class CustomDroplist extends StatefulWidget {
  double boxheight = 5.5*SizeConfig.heightmultiplier;
  double boxwidth = 40*SizeConfig.widthmultiplier;
  Color boxColor;
  Color? optionColor;
  final List listItem;

  CustomDroplist({
    required this.boxColor,
    this.optionColor,
    required this.listItem,
    Key? key}) : super(key: key);

  @override
  State<CustomDroplist> createState() => _CustomDroplistState();
}

class _CustomDroplistState extends State<CustomDroplist> {
  String? valueChoose;
  // TextEditingController dropDownSubjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.boxheight,
        width: widget.boxwidth,

        decoration: BoxDecoration(
          color: widget.boxColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
        ),

        child: Material(
          color: Colors.transparent,

          child: Form(
            child: DropdownButtonHideUnderline(//to hide underline
              child: DropdownButton<String>(
                dropdownColor: widget.boxColor,
                hint: const Text(Texts.text9),
                items: widget.listItem.map<DropdownMenuItem<String>>((valueItem){
                  return DropdownMenuItem<String>(
                      value: valueItem,
                      child: Text(valueItem,
                        style: TextStyle(color: widget.optionColor ?? Colors.black),
                      ),);
                },).toList(),

                onChanged: (String? newValue){
                  setState(() {
                    valueChoose = newValue;
                    // dropDownSubjectController.text = selectedData.subject!;

                  });
                },

                value: valueChoose,



              ),
            ),
          ),
        ),
      ),

    );
  }
}
