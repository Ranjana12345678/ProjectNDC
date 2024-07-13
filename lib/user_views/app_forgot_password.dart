import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_controllers/app_password_reset_controller.dart';
import 'package:nibirNdcV2/app_models/app_password_reset_response_model.dart';
import 'package:nibirNdcV2/user_views/app_loginpage.dart';
import 'package:nibirNdcV2/widgets/Custom_Button.dart';
import 'package:nibirNdcV2/widgets/Cutsom_Password_Textfield.dart';
import 'package:nibirNdcV2/widgets/custom_msg_snackbar.dart';
import '../app_config/loading.dart';
import '../widgets/FrostedGlass.dart';


class ForgotPasswordForm extends StatefulWidget {
  final String userId;
  const ForgotPasswordForm({Key? key, required this.userId}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {



  final pass1 = TextEditingController();
  final pass2 = TextEditingController();

  var loadingObj = Loading();

  resetPassword(String userId, String newPassword, String confirmPassword) async {
    try{
      PasswordResetController passwordResetController = PasswordResetController();
      PasswordResetResponseModel passResetResponse = await passwordResetController.resetPassword(userId, newPassword, confirmPassword);
      if(passResetResponse.status == true){
        Future.delayed(const Duration(microseconds: 92),(){
          Navigator.of(context).pop();
          Future.delayed(const Duration(microseconds: 30),(){
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPfield(email: result.data!.email??'', buttonId: widget.buttonName, userId: collegeidController.text.toString(),)));
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackMessage(
              messageIcon: Icons.verified_outlined,
              messageTitle: "Successful",
              messageBody: passResetResponse.message??'',
              color: Colors.green),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration( milliseconds: 3000),
        ));

      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomSnackMessage(
              messageIcon: Icons.error_outline_rounded,
              messageTitle: "Error",
              messageBody: passResetResponse.message??'',
              color: Colors.redAccent),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: const Duration( milliseconds: 3000),
        ));
      }

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.error_outline_rounded,
            messageTitle: "Error",
            messageBody: 'Unknown Error',
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration( milliseconds: 3000),
      ));

    }
  }



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/b4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: FrostedGlass(
              glassWidth: 80*SizeConfig.widthmultiplier,
              glassHeight: 65*SizeConfig.heightmultiplier,
              glassRadius: 2*SizeConfig.heightmultiplier,
              glassChild: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: const Image(
                                image: AssetImage('assets/ndc_logo.png'),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(
                          height: 2.5*SizeConfig.heightmultiplier,
                        ),
                        Text("Reset Password", style: TextStyle(fontSize: 3*SizeConfig.heightmultiplier, fontFamily: 'JosefinSans'),),
                        SizedBox(
                          height: 2.5*SizeConfig.heightmultiplier,
                        ),
                        CustomPasswordTextfield(passwordController: pass1, textfield_colour: Colour.BLUE_BACKGROUND, opacity: 0.2, icon_hidden: true,),
                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),
                        CustomPasswordTextfield(passwordController: pass2, textfield_colour: Colour.BLUE_BACKGROUND, opacity: 0.2, textfield_text: "Confirm Password", icon_hidden: true,),
                        SizedBox(
                          height: 6*SizeConfig.heightmultiplier,
                        ),
                        //to get input of otp
                        CustomButton(button_text: "SUBMIT", onClick: (){

                          if (pass1.text != '' && pass2.text != ''){
                            if (pass1.text == pass2.text){
                              loadingObj.showLoadingDialog(context);
                              resetPassword(widget.userId, pass1.text.toString(), pass2.text.toString());
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.lock_clock_outlined,
                                    messageTitle: "Different Passwords",
                                    messageBody: "Enter the same Passwords",
                                    color: Colors.red),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration( milliseconds: 2500),
                              ));
                            }
                          }

                          else if (pass1.text == '' || pass2.text == ''){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: CustomSnackMessage(
                                  messageIcon: Icons.error_outline,
                                  messageTitle: "Password not entered",
                                  messageBody: "Enter the same Passwords inside both the fields",
                                  color: Colors.purple),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              duration: Duration( milliseconds: 2500),
                            ));
                          }


                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

