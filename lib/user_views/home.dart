// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:nibirNdcV2/app_components/app_constants.dart';
// import 'package:nibirNdcV2/widgets/Custom_DropList.dart';
// import 'package:nibirNdcV2/widgets/Custom_Textfield.dart';
// import 'package:nibirNdcV2/widgets/Cutsom_Password_Textfield.dart';
// import '../app_components/colour.dart';
// import '../app_components/device_configuration.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colour.SUPER_BACKGROUND_COLOR,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(top: 4*SizeConfig.heightmultiplier),
//           child: Center(
//             child: Container( //to store the inner body
//               width: 80*SizeConfig.widthmultiplier,  //change
//               height: 120*SizeConfig.heightmultiplier,  //change
//
//               decoration: BoxDecoration(
//                 color: Colour.SUPER_BACKGROUND_COLOR,
//                 borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.heightmultiplier)),
//
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colour.SUPER_GREY,
//                     blurRadius: 10,
//                     offset: const Offset(10.0, 10.0,),
//                   ),
//                   BoxShadow(
//                     color: Colour.BACKGROUND_COLOR,
//                     blurRadius: 10,
//                     offset: const Offset(-10.0, -10.0,),
//                   ),],
//
//               ),
//
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 5*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 10*SizeConfig.heightmultiplier,
//                       width: 10*SizeConfig.heightmultiplier,
//
//                       decoration: BoxDecoration(
//                         color: Colour.SUPER_BACKGROUND_COLOR,
//                         borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.heightmultiplier)),
//
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colour.SUPER_GREY,
//                             blurRadius: 10,
//                             offset: const Offset(10.0, 10.0,),
//                           ),
//                           BoxShadow(
//                             color: Colour.BACKGROUND_COLOR,
//                             blurRadius: 10,
//                             offset: const Offset(-10.0, -10.0,),
//                           ),],
//
//                       ),
//                       child: Center(
//                         child: SizedBox(
//                           height: 15*SizeConfig.heightmultiplier,
//                           width: 15*SizeConfig.widthmultiplier,
//                           child: Image(
//                             image: AssetImage('assets/ndc_logo.png'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Text(Texts.text8,
//                       style: TextStyle(
//                           fontSize: 2.5*SizeConfig.heightmultiplier,
//                           fontWeight: FontWeight.bold,
//                           color: Colour.PRIMARY_COLOR,
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.account_circle_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           CustomTextfield(textfield_text: "Name", textfield_width: 60*SizeConfig.widthmultiplier-40,)
//                         ],
//                       ),
//                     ),
//
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           CustomTextfield(textfield_text: "College ID", textfield_width: 60*SizeConfig.widthmultiplier-40,)
//                         ],
//                       ),
//                     ),
//
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           Text(Texts.text10),
//                           CustomDroplist(listItem: Texts.listItem_Gender),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           Text(Texts.text11),
//                           CustomDroplist(listItem: Texts.listItem_Caste),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           CustomTextfield(textfield_text: "Degree", textfield_width: 60*SizeConfig.widthmultiplier-40,)
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           CustomTextfield(textfield_text: "Phone number.", textfield_width: 60*SizeConfig.widthmultiplier-40,)
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Container(
//                       height: 6*SizeConfig.heightmultiplier,
//                       width: 60*SizeConfig.widthmultiplier,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.badge_outlined, size: 4.5*SizeConfig.heightmultiplier,),
//                           CustomTextfield(textfield_text: "Email ID", textfield_width: 60*SizeConfig.widthmultiplier-40,)
//                         ],
//                       ),
//                     ),
//                   ),
//
//
//
//                 ],
//               ),
//
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
