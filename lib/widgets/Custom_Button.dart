import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import '../app_components/colour.dart';

class CustomButton extends StatefulWidget {
  double? button_width;
  double? button_height;
  final String button_text;
  final VoidCallback onClick;
  Color? button_colour;
  Color? button_text_colour;

  CustomButton(
      {required this.button_text,
      required this.onClick,
      this.button_width,
      this.button_height,
      this.button_colour,
      this.button_text_colour,
      Key? key})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.button_width ?? 60 * SizeConfig.widthmultiplier,
      height: widget.button_height ?? 6 * SizeConfig.heightmultiplier,

      clipBehavior: Clip.hardEdge, //to not let
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(
            widget.button_height ?? 6 * SizeConfig.heightmultiplier / 2)),
        color: widget.button_colour ?? Colour.BLUE_BACKGROUND,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onClick,
          child: Center(
            child: Text(
              widget.button_text,
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: widget.button_text_colour ?? Colour.BACKGROUND_COLOR),
            ),
          ),
        ),
      ),
    );
  }
}
