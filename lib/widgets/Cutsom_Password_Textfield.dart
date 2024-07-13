import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import '../app_components/app_constants.dart';
import '../app_components/colour.dart';

class CustomPasswordTextfield extends StatefulWidget {

  double? textfield_width;
  Color textfield_colour;
  Color? textfield_text_colour;
  double opacity;
  bool? icon_hidden;
  String? textfield_text;
  late TextEditingController passwordController;

  CustomPasswordTextfield({
    required this.opacity,
    required this.passwordController,
    this.textfield_width,
    required this.textfield_colour,
    this.textfield_text_colour,
    this.textfield_text,
    this.icon_hidden = false,
    Key? key, }) : super(key: key);

  @override
  State<CustomPasswordTextfield> createState() => _CustomPasswordTextfieldState();
}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool TEXTHIDE = true;
  double textfeild_height = 6*SizeConfig.heightmultiplier;
  IconData icon_details = Icons.lock_open_rounded;


  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      //setting variable for obscure
    return Center(
      child: Container(
        // clipBehavior: Clip.hardEdge,
        //height: textfeild_height,
        width: widget.textfield_width ?? 60*SizeConfig.widthmultiplier,

        decoration: BoxDecoration(
          color: widget.textfield_colour.withOpacity(widget.opacity),
          borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier/2)),
        ),

        child: Material(  //we can also remove the material widget if we want
          color: Colors.transparent,
          child: TextFormField(
            controller: widget.passwordController,
            obscureText: TEXTHIDE,  //to hide
            style: TextStyle(color: widget.textfield_text_colour??Colour.BLUE_BACKGROUND, fontFamily: 'JosefinSans', fontSize: 2.5*SizeConfig.heightmultiplier),
            decoration: InputDecoration(
              labelText: widget.textfield_text??Texts.text5,

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

              prefixIcon: widget.icon_hidden == false ? Icon(icon_details) : null,
              suffixIcon: GestureDetector(
                onTap: (){
                 setState(() {
                   TEXTHIDE = !TEXTHIDE;
                 });},
                child: Icon(TEXTHIDE ? Icons.visibility_off : Icons.visibility),
              ),
            ),

            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(" "),
            ],

          ),
        ),
      ),
    );
  }
}
