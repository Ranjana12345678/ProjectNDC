import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nibirNdcV2/app_components/colour.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:nibirNdcV2/app_controllers/user_profile_controller.dart';
import 'package:nibirNdcV2/app_models/app_user_profile_model.dart';
import 'package:nibirNdcV2/user_views/app_forms_view/app_feedback_panel.dart';
import 'package:nibirNdcV2/user_views/selectOption.dart';
import 'package:nibirNdcV2/user_views/app_loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/FrostedGlass.dart';
import '../widgets/custom_msg_snackbar.dart';
import '../widgets/dialogs.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;
  bool hasData = true;
  String name   = "";
  String cid    = "";
  String degree = "";
  String email  = "";
  String phone  = "";
  String gender = "";
  String caste  = "";
  SharedPreferences? sharedPreferences;

  void getSharedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  clearValues() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
    sharedPreferences?.clear();

  }

  getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserProfileResultController userProfileResultController = UserProfileResultController();
    UserProfileResultModel result = await userProfileResultController.getUserProfileResult(sharedPreferences.getString("token")??'');
    if(result.status == true){
      setState(() {
        name     = result.data!.userName??'';
        cid      = result.data!.userId??'';
        degree   = result.data!.userDegree??'';
        email    = (result.data?.userEmail == ''?'No Email Found':result.data?.userEmail)!;
        phone    = result.data!.userPhonenumber??'';
        gender   = result.data!.userGender??'';
        caste    = result.data!.userCaste??'';
        isLoading = false;        
      });
    }else{
      setState(() {
        isLoading = false;
        hasData = false;
      });
    }
    
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    // TODO: implement initState

    getSharedData();
    getUserProfile();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawerScrimColor: Colors.transparent,

        drawer: Theme(
            data: Theme.of(context).copyWith(
              // Set the transparency here
              canvasColor: Colors.transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
            ),
          child: SizedBox(
            height: 25* SizeConfig.heightmultiplier,
            child: Drawer(
              width:  43*SizeConfig.widthmultiplier,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15)
                ),
                child:ListView(
                  children: [
                    SizedBox(height: 1 * SizeConfig.heightmultiplier,),
                    ListTile(
                      leading: Icon(
                          Icons.logout_outlined,
                          color: Colors.redAccent,
                          size: 10 * SizeConfig.imageSizeMultiplier
                      ),
                      title: Text("Log Out", style: TextStyle(fontSize: 1.5*SizeConfig.textMultiplier,)),
                      onTap: () async {
                        _scaffoldKey.currentState?.closeDrawer();
                        final action = await Dialogs.yesNoDialog(context, "Logging Out", "Are you sure ?");
                        if(action == DilogAction.yes){
                          clearValues();
                        }else{
                          _scaffoldKey.currentState?.openDrawer();
                        }

                      },
                    ),
                    SizedBox(height: 1 * SizeConfig.heightmultiplier,),
                    ListTile(
                      leading: Icon(
                          Icons.edit_note_outlined,
                          color: Colors.blue,
                          size: 10 * SizeConfig.imageSizeMultiplier
                      ),
                      title: Text("Edit Request",style: TextStyle(fontSize: 1.5*SizeConfig.textMultiplier,)),
                        onTap: () async {
                          _scaffoldKey.currentState?.closeDrawer();
                          final action = await Dialogs.yesNoDialog(context, "Request Edit",
                              "On tap Yes you will be Redirect\nto your Gmail app.Request that data you want to update or edit."

                          );
                          if(action == DilogAction.yes){
                            const url = "mailto:ndccollege@yahoo.com";
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.warning_amber_outlined,
                                    messageTitle: "Failed",
                                    messageBody: 'No Email App is found. Install Gmail or other email application',
                                    color: Colors.redAccent),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: const Duration( milliseconds: 3000),
                              ));
                            }
                          }else{
                            _scaffoldKey.currentState?.openDrawer();
                          }

                        },
                    ),
                    SizedBox(height: 1 * SizeConfig.heightmultiplier,),
                    // ListTile(
                    //   leading: Icon(
                    //       Icons.help_outline_sharp,
                    //       color: Colors.greenAccent,
                    //       size: 10 * SizeConfig.imageSizeMultiplier
                    //   ),
                    //   title: Text("Ask Help"),
                    // ),
                    ListTile(
                      leading: Icon(
                          Icons.message_outlined,
                          color: Colors.greenAccent,
                          size: 10 * SizeConfig.imageSizeMultiplier
                      ),
                      title: Text("Feedback" ,style: TextStyle(fontSize: 1.5*SizeConfig.textMultiplier,)),
                      onTap: () async {
                        _scaffoldKey.currentState?.closeDrawer();
                        final action = await Dialogs.yesNoDialog(context, "Feedback", "Continue to feedback form");
                        if(action == DilogAction.yes){
                          _scaffoldKey.currentState?.closeDrawer();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBackForm()));
                        }else{
                          _scaffoldKey.currentState?.openDrawer();
                        }

                      },
                    ),
                  ],
                  
                )
              ),
            ),
          ),

        ),
        body: Container(
          //padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/b5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child:Column(
            children: [
              FrostedGlass(
                glassWidth: 100*SizeConfig.widthmultiplier,
                glassHeight: 8.5*SizeConfig.heightmultiplier,
                glassRadius: 0*SizeConfig.heightmultiplier,
                glassChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 11*SizeConfig.heightmultiplier,
                    //   width: 11*SizeConfig.heightmultiplier,
                    //   child: const Image(
                    //     color: Colors.blueAccent,
                    //     image: AssetImage('assets/ndc_logo.png'),
                    //   ),
                    // ),
                    // const SizedBox.shrink(),
                    // const SizedBox.shrink(),
                    // const SizedBox.shrink(),
                    // const SizedBox.shrink(),
                    // const SizedBox.shrink(),
                    IconButton(
                        onPressed: (){
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                            Icons.menu,
                            color: Colors.white,size: 10 * SizeConfig.imageSizeMultiplier
                        )
                    ),
                    SizedBox.shrink(),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 4.5*SizeConfig.heightmultiplier,
                          fontFamily: 'JosefinSans',
                          color:Colors.white),
                    ),
                    SizedBox.shrink(),


                    SizedBox(
                      height: 11*SizeConfig.heightmultiplier,
                      width: 11*SizeConfig.heightmultiplier,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Image(
                          color: Colors.white,
                          image: AssetImage('assets/ndc_logo.png'),
                        ),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () async {
                    //       final action = await Dialogs.yesNoDialog(context, "Logging Out", "Are you sure ?");
                    //       if(action == DilogAction.yes){
                    //         clearValues();
                    //       }
                    //
                    //     },
                    //     icon: Icon(
                    //         Icons.logout_outlined,
                    //         color: Colors.white,size: 10 * SizeConfig.imageSizeMultiplier
                    //     )
                    // ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     GestureDetector(
                    //       // onTap: (){
                    //       //
                    //       //   },
                    //       onTap: () async{
                    //         final action = await Dialogs.yesNoDialog(context, "Logging Out", "Are you sure ?");
                    //         if(action == DilogAction.yes){
                    //           clearValues();
                    //         }
                    //
                    //       },
                    //       child: Column(
                    //         children: [
                    //           Icon(Icons.logout_rounded, color: Colors.white,size: 10 * SizeConfig.imageSizeMultiplier,),
                    //           const Text("Log Out", style: TextStyle(fontFamily: 'Kanit', fontSize: 15,color: Colors.white),),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 5*SizeConfig.widthmultiplier,)
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 1*SizeConfig.heightmultiplier,
              ),
              Flexible(
                child: FrostedGlass(
                  glassWidth: 90*SizeConfig.widthmultiplier,
                  glassHeight: 70*SizeConfig.heightmultiplier,
                  glassRadius: 2*SizeConfig.heightmultiplier,
                  glassChild: Container(
                    margin: EdgeInsets.all(2 * SizeConfig.widthmultiplier),
                    child:isLoading?const Center(child: CircularProgressIndicator(),) : hasData? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.account_circle_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                                  ),
                                  Text(name,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier, fontFamily: 'JosefinSans', color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.badge_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("College ID: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                                  ),
                                  Text(cid,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier, fontFamily: 'JosefinSans', color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.school_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Degree: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                  ),
                                  Text(degree,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.people_alt_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Gender: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                  ),
                                  Text(gender,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.insert_chart_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Caste: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                  ),
                                  Text(caste,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.call,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Phone number: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                  ),
                                  Text(phone,
                                    style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Icon(Icons.email_outlined,size: 4.5*SizeConfig.heightmultiplier),
                              SizedBox(width: 3*SizeConfig.widthmultiplier),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email: ",
                                      style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                    ),
                                    Text(
                                      email,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 2.2*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3*SizeConfig.heightmultiplier,
                          ),
                          Center(child: Text("Add Information",textAlign: TextAlign.center, style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),)),

                          Center(
                            child: TextButton(
                              style: ButtonStyle(

                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              onPressed: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => const SelectOption()));
                              }, child: Icon(Icons.add_circle,size: 8*SizeConfig.heightmultiplier, color: Colors.black26,),
                              ),
                          ),
                        ],
                      ),
                    ):const Text("Unauthorized"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






