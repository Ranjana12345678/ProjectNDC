// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nibirNdcV2/app_components/device_configuration.dart';
// import 'package:nibirNdcV2/app_components/app_constants.dart';
// import 'package:nibirNdcV2/user_views/bodypage.dart';
// import 'package:nibirNdcV2/user_views/profile.dart';
// import 'package:nibirNdcV2/widgets/Custom_Textfield.dart';
// import 'package:nibirNdcV2/widgets/Cutsom_Password_Textfield.dart';
// import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
// import '../app_components/colour.dart';
// import '../widgets/Custom_Button.dart';
// import 'enterCID.dart';
//
//
// class Login extends StatefulWidget{
//   const Login ({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login>{
//   final collegeidController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context){
//     return WillPopScope(
//       onWillPop: ()async{
//         return false;
//       },
//       child: Scaffold(
//         // resizeToAvoidBottomInset: false, //WOW
//         backgroundColor: Colour.SUPER_BACKGROUND_COLOR,
//         body: Center(
//               child: Container(
//                 height: 100*SizeConfig.heightmultiplier,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/b.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 alignment: Alignment.center,
//
//                 child: FrostedGlass(
//                   glassHeight: 90*SizeConfig.widthmultiplier,
//                   glassWidth: 90*SizeConfig.widthmultiplier,
//                   glassChild: Container( //to store the inner body
//
//                     // width: 80*SizeConfig.widthmultiplier,  //change
//                     // height: 80*SizeConfig.heightmultiplier,  //change
//
//                     decoration: BoxDecoration(
//                       color: Colour.SUPER_BACKGROUND_COLOR,
//                       borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.heightmultiplier)),
//
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colour.SUPER_GREY,
//                           blurRadius: 10,
//                           offset: const Offset(10.0, 10.0,),
//                         ),
//                         BoxShadow(
//                           color: Colour.BACKGROUND_COLOR,
//                           blurRadius: 10,
//                           offset: const Offset(-10.0, -10.0,),
//                         ),],
//
//                     ),
//
//                     child: SingleChildScrollView(
//                       child: Column(
//
//                         children: [
//                           Padding(  //to keep container for icon
//                             padding: EdgeInsets.only(top: 10*SizeConfig.heightmultiplier),
//                             child: Container(
//                               height: 12*SizeConfig.heightmultiplier,
//                               width: 12*SizeConfig.heightmultiplier,
//
//                               decoration: BoxDecoration(
//                                 color: Colour.SUPER_BACKGROUND_COLOR,
//                                 borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier)),
//
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colour.SUPER_GREY,
//                                     blurRadius: 10,
//                                     offset: const Offset(10.0, 10.0,),
//                                   ),
//                                   BoxShadow(
//                                     color: Colour.BACKGROUND_COLOR,
//                                     blurRadius: 10,
//                                     offset: const Offset(-10.0, -10.0,),
//                                   ),],
//                               ),
//
//                               child: Center(
//                                 child: Container(
//                                   height: 25*SizeConfig.heightmultiplier,
//                                   width: 25*SizeConfig.widthmultiplier,
//                                   child: Image(
//                                     image: AssetImage('assets/ndc_logo.png'),
//                                   ),
//                                 ),
//                               ),
//
//                             ),
//                           ),//to keep container for icon
//
//                           Column(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(top: 0.5*SizeConfig.heightmultiplier),
//                                 child: Text(Texts.text2,
//                                   style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier),
//                                 ),
//                               ),
//                               Container(
//                                 child: Text(Texts.text3,
//                                   style: TextStyle(fontSize: 3*SizeConfig.heightmultiplier),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(top: 4*SizeConfig.heightmultiplier),
//                             child: CustomTextfield(
//
//                               opacity: 1.0,
//                               textfield_text: Texts.text4,
//                               icon_details: Icons.account_circle_outlined,
//                               textController: collegeidController, textfield_colour: Colour.BACKGROUND_COLOR,
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                             child: CustomPasswordTextfield(passwordController: passwordController, textfield_colour: Colour.SUPER_BACKGROUND_COLOR, opacity: 0.2,),
//                           ),
//
//                           Container(
//                             width: 58*SizeConfig.widthmultiplier,
//                             alignment: Alignment.centerRight,
//
//                             child: TextButton(
//                               onPressed: (){
//                               },
//                               child: Text(Texts.text6,
//                                 style: TextStyle(
//                                     fontSize: 1.8*SizeConfig.heightmultiplier,
//                                     color: Colors.indigoAccent,
//                                 ),
//                               ),
//                             ),
//
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(top: 5*SizeConfig.heightmultiplier),
//                             child: CustomButton(button_text: Texts.text1, onClick: (){
//                               print(collegeidController.text);
//                               print(passwordController.text);
//                               if (collegeidController.text == "20200785" && passwordController.text == "ranjana1234"){
//                                 Navigator.push(context, CupertinoPageRoute(builder: (context) => const Bodypage()));
//                               }
//                               },),
//                           ),
//
//                           Center(
//                             child: Container(
//                               padding: EdgeInsets.only(top: 8*SizeConfig.heightmultiplier),
//                               width: 60*SizeConfig.widthmultiplier,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(Texts.text7,
//                                     style: TextStyle(
//                                       fontSize: 1.8*SizeConfig.heightmultiplier,
//                                       color: Colour.PRIMARY_COLOR,
//                                     ),
//                                   ),
//
//                                   TextButton(
//                                     onPressed: (){
//                                       Navigator.push(context, CupertinoPageRoute(builder: (context) => const EnterCid()));
//                                     },
//                                     child: Text(Texts.text8,
//                                       style: TextStyle(
//                                         fontSize: 1.8*SizeConfig.heightmultiplier,
//                                         color: Colour.BLUE_TEXT,
//                                       ),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//             ), glassRadius: 5*SizeConfig.heightmultiplier,
//                 ),
//               ),//to store the inner body
//           ),
//       ),
//     );
//   }
//
// }