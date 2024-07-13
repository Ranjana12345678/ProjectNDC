import 'package:flutter/cupertino.dart';

class SizeConfig{
  static late double _screenWidth;
  static late double _screenHeight;

  static late double textMultiplier;
  static late double imageSizeMultiplier;

  static double w=0;
  static double h=0;

  static late double widthmultiplier=0;
  static late double heightmultiplier=0;

  static bool isPortrait = true;

  void init (BoxConstraints constraints, Orientation orientation){
    if (orientation == Orientation.portrait){
      _screenHeight = constraints.maxHeight;
      _screenWidth = constraints.maxWidth;
      isPortrait = true;
    }
    else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
    }
    h = _screenHeight/100;
    w = _screenWidth/100;

    heightmultiplier = h;
    widthmultiplier = w;
    textMultiplier = h;
    imageSizeMultiplier = w;

    print(heightmultiplier);
    print(widthmultiplier);
  }


}