import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_controllers/login_controller.dart';
import 'package:nibirNdcV2/widgets/FrostedGlass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_components/app_constants.dart' as constants;
import '../app_config/loading.dart';
import '../app_models/login_result_model.dart';
import '../widgets/Custom_Button.dart';
import '../widgets/Custom_Textfield.dart';
import '../widgets/Cutsom_Password_Textfield.dart';
import '../widgets/custom_msg_snackbar.dart';
import 'bodypage.dart';
import 'enterCID.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var loadingObj = Loading();

  final collegeidController = TextEditingController();
  final passwordController = TextEditingController();
  SharedPreferences? sharedPreferences;

  void sharedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // checking the login status
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences?.getString("stoken") !=  null ){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const Bodypage()), (Route<dynamic> route) => false);
    }

  }

  getLoginData(String userEmail, String userPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LoginController loginController = LoginController();
    LoginResultModel response =
        await loginController.tryLogging(userEmail, userPassword);
    if (response.status == true) {
      sharedPreferences.setString("token", response.data?.userToken ?? '');
      sharedPreferences.setString("userId", response.data?.userId ?? '');
      sharedPreferences.setString("Id", response.data?.id ?? '');

      if (_isChecked) {
        sharedPreferences.setString("stoken", response.data?.userToken ?? '');
      }
      Future.delayed(const Duration(microseconds: 92), () {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Bodypage()));
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.verified_outlined,
            messageTitle: "Successful",
            messageBody: "Successfully logged in",
            color: Colors.green),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: 3000),
      ));
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.error_outline,
            messageTitle: "Failed",
            messageBody: "Wrong Userid or Password",
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(milliseconds: 3000),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    sharedData();
    checkLoginStatus();
    super.initState();
    // getRemeberMeEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    collegeidController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                image: AssetImage('assets/b2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: FrostedGlass(
              glassWidth: 90 * SizeConfig.widthmultiplier,
              glassHeight: 75 * SizeConfig.heightmultiplier,
              glassRadius: 2 * SizeConfig.heightmultiplier,
              glassChild: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2 * SizeConfig.heightmultiplier,
                        ),
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
                        //2 texts
                        Text(
                          constants.Texts.text2,
                          style: TextStyle(
                              fontSize: 2.5 * SizeConfig.heightmultiplier,
                              fontFamily: 'Kanit'),
                        ),
                        Text(
                          constants.Texts.text3,
                          style: TextStyle(
                              fontSize: 3 * SizeConfig.heightmultiplier,
                              fontFamily: 'Kanit'),
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightmultiplier,
                        ),
                        //to get input of CID
                        CustomTextfield(
                          textfield_width: 70 * SizeConfig.widthmultiplier,
                          textfield_isdigits: true,
                          opacity: 0.4,
                          textfield_text: constants.Texts.text4,
                          icon_details: Icons.account_circle_outlined,
                          textController: collegeidController,
                          textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightmultiplier,
                        ),
                        //to get input of Password
                        CustomPasswordTextfield(
                          textfield_width: 70 * SizeConfig.widthmultiplier,
                          passwordController: passwordController,
                          textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                          opacity: 0.4,
                        ),
                        SizedBox(
                          height: 0.5 * SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Row(
                              children: [
                                Checkbox(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: _isChecked,
                                    onChanged: (bool? value){
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    }
                                ),
                                Text("Remember Me" , style: TextStyle(fontFamily: 'Kanit',fontSize: 2 * SizeConfig.textMultiplier),),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EnterCid(
                                            buttonName: 'forgotPassword')));
                              },
                              child: Text(
                                constants.Texts.FORGOR_PASS_TEXT,
                                style: TextStyle(
                                    fontSize: 2 * SizeConfig.heightmultiplier,
                                    color: Colour.BLUE_TEXT2,
                                    fontFamily: 'Kanit'),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 1 * SizeConfig.heightmultiplier,
                        ),
                        CustomButton(
                          button_text: constants.Texts.text1,
                          onClick: () {
                            if (collegeidController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              loadingObj.showLoadingDialog(context);
                              getLoginData(collegeidController.text.toString(),
                                  passwordController.text.toString());
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.warning_amber_outlined,
                                    messageTitle: "Required",
                                    messageBody:
                                        "College Id and Password required",
                                    color: Colors.orangeAccent),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration(milliseconds: 3000),
                              ));
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.5 * SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              constants.Texts.text7,
                              style: TextStyle(
                                  fontSize: 2 * SizeConfig.heightmultiplier,
                                  color: Colour.PRIMARY_COLOR,
                                  fontFamily: 'Kanit'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EnterCid(
                                            buttonName: 'signUp')));
                              },
                              child: Text(
                                constants.Texts.text8,
                                style: TextStyle(
                                    fontSize: 2 * SizeConfig.heightmultiplier,
                                    color: Colour.BLUE_TEXT,
                                    fontFamily: 'Kanit'),
                              ),
                            ),
                          ],
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
