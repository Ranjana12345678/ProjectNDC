import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import '../app_components/app_constants.dart';
import 'dart:ui';
import '../app_components/colour.dart';

class CustomTextfield extends StatelessWidget {
  double? textfield_width;
  double textfeild_height = 6*SizeConfig.heightmultiplier;
  final String textfield_text;
  late TextEditingController textController;
  Color textfield_colour;
  Color? textfield_text_colour;
  IconData? icon_details;
  double opacity;
  bool? textfield_isdigits;
  int? maxLength;
  VoidCallback? onTap;


  CustomTextfield({
    required this.opacity,
    required this.textfield_text,
    required this.textController,
    this.textfield_isdigits,
    this.icon_details,
    this.textfield_width,
    required this.textfield_colour,
    this.textfield_text_colour,
    this.maxLength,
    this.onTap,
    Key? key, }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // clipBehavior: Clip.hardEdge,
        //height: textfeild_height,
        width: textfield_width ?? 60*SizeConfig.widthmultiplier,

        decoration: BoxDecoration(
          color: textfield_colour.withOpacity(opacity),
          borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
        ),

        child: Material(  //we can also remove the material widget if we want
          color: Colors.transparent,
          child: TextFormField(
            keyboardType: textfield_isdigits??false ? TextInputType.number: null,
            inputFormatters: textfield_isdigits??false ?[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxLength??null)
            ]: null,
            controller: textController,
            style: TextStyle(color: textfield_text_colour??Colour.BLUE_BACKGROUND, fontFamily: 'JosefinSans', fontSize: 2.5*SizeConfig.heightmultiplier),
            decoration: InputDecoration(
              labelText: textfield_text,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
                borderSide: BorderSide(
                  color: Colour.BLUE_BACKGROUND,
                  width: 2,
                ),
              ),


              prefixIcon: icon_details != null? Icon(icon_details,): null,

            ),
            onTap: onTap,

          ),
        ),
      ),
    );
  }
}
