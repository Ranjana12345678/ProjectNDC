import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_controllers/app_validate_otp_controller.dart';
import 'package:nibirNdcV2/widgets/Custom_Button.dart';
import '../app_components/device_configuration.dart';
import '../app_config/loading.dart';
import '../app_controllers/app_otp_request_controller.dart';
import '../app_models/app_otp_request_response_model.dart';
import '../app_models/app_validate_otp_reposne_model.dart';
import '../widgets/FrostedGlass.dart';
import '../widgets/custom_msg_snackbar.dart';
import 'app_forgot_password.dart';
import 'enterCID.dart';
import 'registration_form_pass.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPfield extends StatefulWidget {
  final String email;
  final String userId;
  final String buttonId;
  const OTPfield(
      {Key? key,
      required this.email,
      required this.buttonId,
      required this.userId})
      : super(key: key);

  @override
  State<OTPfield> createState() => _OTPfieldState();
}

class _OTPfieldState extends State<OTPfield> {
  bool _isButtonAvailable = false;

  String email = "";
  String Otp = "";

  var loadingObj = Loading();

  String obFocusEmail(String email, int visibleCharacters) {
    int atIndex = email.indexOf("@");
    if (atIndex > 0) {
      String emailUsername = email.substring(0, atIndex);
      String obfocousPart = emailUsername
          .substring(0, visibleCharacters)
          .replaceAll(RegExp(r'.'), '*');
      String domain = email.substring(atIndex);
      return emailUsername.substring(0, visibleCharacters) +
          obfocousPart +
          domain;
    }

    return email;
  }

  verifyOtp(String userId, String otp) async {
    ValidateOtpController validateOtpController = ValidateOtpController();
    ValidateOtpResponseModel validationResponse =
        await validateOtpController.validateOtp(userId, otp);
    if (validationResponse.status == true) {
      if (widget.buttonId == "forgotPassword") {
        Future.delayed(const Duration(microseconds: 92), () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(microseconds: 30), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPasswordForm(
                      userId: widget.userId,
                    )));
          });
        });

      } else {
        Future.delayed(const Duration(microseconds: 92), () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(microseconds: 30), () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SignUpForm(
                          userEmail: widget.email,
                          userId: widget.userId,
                        )));
          });
        });
      }
    } else {
      Future.delayed(const Duration(microseconds: 92),(){
        Navigator.of(context).pop();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.error_outline_rounded,
            messageTitle: "Error",
            messageBody: validationResponse.message ?? '',
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 3000),
      ));
    }
  }

  resendOtp() async {
    RequestOtpController requestOtpController = RequestOtpController();
    RequestOtpResponseModel requestOtp = await requestOtpController.requestOtp(widget.email);
    if(requestOtp.status == true){
      Future.delayed(const Duration(microseconds: 92),(){
        Navigator.of(context).pop();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.verified_outlined,
            messageTitle: "Success",
            messageBody: "Otp Has been sent",
            color: Colors.green),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration( milliseconds: 3000),
      ));
      setState(() {
        _isButtonAvailable = false;
      });
    }else{
      Future.delayed(const Duration(microseconds: 92),(){
        Navigator.of(context).pop();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.person_off,
            messageTitle: "Error",
            messageBody: 'Failed to get otp',
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration( milliseconds: 3000),
      ));
    }
  }

  void _startTimer() {
    Timer(const Duration(minutes: 1), () {
      setState(() {
        _isButtonAvailable = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    final obemail = obFocusEmail(widget.email, 5);
    setState(() {
      email = obemail;
    });
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: SizedBox(
                  height: 15 * SizeConfig.heightmultiplier,
                  width: 60 * SizeConfig.widthmultiplier,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Are You Sure?",
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 2.5 * SizeConfig.heightmultiplier),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButton(
                              button_text: "Yes",
                              button_width: 18 * SizeConfig.widthmultiplier,
                              onClick: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => const EnterCid(
                                              buttonName: 'forgotPassword',
                                            )));
                              }),
                          CustomButton(
                              button_text: "No",
                              button_width: 18 * SizeConfig.widthmultiplier,
                              onClick: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
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
              glassWidth: 90 * SizeConfig.widthmultiplier,
              glassHeight: 65 * SizeConfig.heightmultiplier,
              glassRadius: 2 * SizeConfig.heightmultiplier,
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
                            height: 12 * SizeConfig.heightmultiplier,
                            width: 12 * SizeConfig.heightmultiplier,
                            decoration: BoxDecoration(
                              color: Colour.SUPER_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  6 * SizeConfig.heightmultiplier)),
                            ),
                            child: SizedBox(
                              height: 11 * SizeConfig.heightmultiplier,
                              width: 11 * SizeConfig.heightmultiplier,
                              child: const Image(
                                image: AssetImage('assets/ndc_logo.png'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightmultiplier,
                        ),
                        Text(
                          "OTP has been sent to : $email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 2.5 * SizeConfig.heightmultiplier),
                        ),
                        SizedBox(
                          height: 4 * SizeConfig.heightmultiplier,
                        ),
                        //to get input of otp
                        OtpTextField(
                          numberOfFields: 6,
                          borderColor: Colour.BLUE_BACKGROUND,
                          enabledBorderColor: Colour.BLUE_BACKGROUND,
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {},
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            Otp = verificationCode;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Verification Code"),
                                    content: Text(
                                        'Code entered is $verificationCode'),
                                  );
                                });
                          }, // end onSubmit
                        ),
                        SizedBox(
                          height: 5 * SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              button_colour: _isButtonAvailable? null :Colors.grey,
                              button_text: "Resend",
                              onClick: () {
                                if(_isButtonAvailable){
                                  loadingObj.showLoadingDialog(context);
                                  resendOtp();

                                }

                              },
                              button_width: 30 * SizeConfig.widthmultiplier,
                            ),
                            CustomButton(
                              button_text: "Confirm",
                              onClick: () {
                                if (Otp != "" && Otp.length == 6) {
                                  loadingObj.showLoadingDialog(context);
                                  verifyOtp(widget.userId, Otp);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: CustomSnackMessage(
                                        messageIcon:
                                            Icons.error_outline_rounded,
                                        messageTitle: "Error",
                                        messageBody: "Enter Valid Otp",
                                        color: Colors.redAccent),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    duration: Duration(milliseconds: 3000),
                                  ));
                                }
                              },
                              button_width: 30 * SizeConfig.widthmultiplier,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5 * SizeConfig.heightmultiplier,
                        ),
                        Text(
                          "*Before Resend,wait a while It may take time for otp to reach you,or check your spam folder",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 1.5 * SizeConfig.heightmultiplier,
                              color: Colors.redAccent),
                        ),
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
