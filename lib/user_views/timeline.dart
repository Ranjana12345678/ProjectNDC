
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:intl/intl.dart';
import 'package:nibirNdcV2/app_components/device_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../app_controllers/user_profile_controller.dart';
import '../app_controllers/user_timeline_data_controller.dart';
import '../app_models/app_user_profile_model.dart';
import '../app_models/user_timeline_data_model.dart';
import '../widgets/FrostedGlass.dart';


class User_timeline extends StatefulWidget {
  const User_timeline({Key? key}) : super(key: key);

  @override
  State<User_timeline> createState() => _User_timelineState();
}

class _User_timelineState extends State<User_timeline>  with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool isLoading = true;
  bool hasData = true;
  String name   = "";
  String cid    = "";
  String degree = "";
  String email  = "";
  String phone  = "";
  String gender = "";
  String caste  = "";


  Future<UserTimeLineDataModel>? myFuture;
  Future<UserTimeLineDataModel> getTimeLineData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserTimeLineDataController userTimeLineDataController = UserTimeLineDataController();
    UserTimeLineDataModel model = await userTimeLineDataController.getUserTimeLineData(sharedPreferences.getString("userId")??'', sharedPreferences.getString("token"));
    return model;
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

  @override
  void initState() {
    // TODO: implement initState
    myFuture=getTimeLineData();
    super.initState();
    getUserProfile();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b14.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SafeArea(
          child:isLoading?const Center(child: CircularProgressIndicator(
            color: Colors.white,
          ),) : hasData? ListView(
            children: [Column(
              children: [
                // SizedBox(
                //   height: 5*SizeConfig.heightmultiplier,
                // ),
                SizedBox(
                  height: 5*SizeConfig.heightmultiplier,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10.5*SizeConfig.widthmultiplier,
                    ),
                    Stack(
                        children: [

                          Container(
                            height: 12*SizeConfig.heightmultiplier,
                            width: 12*SizeConfig.heightmultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9*SizeConfig.heightmultiplier),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  spreadRadius: 30,
                                  blurRadius: 30,

                                )
                              ]
                            ),
                            child: const AnalogClock(
                              dialBorderColor: Colors.black12,
                              hourHandColor: Colors.greenAccent,
                              secondHandColor: Colors.redAccent,
                              minuteHandColor: Colors.blueAccent,
                              hourNumbers: const ['', '', '3', '', '', '6', '', '', '9', '', '', '12'],
                              child: Align(
                                alignment: FractionalOffset(0.5, 0.75),
                                child: Text('GMT+5:30',style: TextStyle(fontSize: 10),),
                              ),
                            ),
                          ),
                          //Icon(Icons.access_time_rounded, size: 12*SizeConfig.heightmultiplier, color: Colors.greenAccent.withOpacity(0.5),)
                        ]
                    ),
                    SizedBox(
                      width: 1*SizeConfig.widthmultiplier,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Text(name,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 3*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),),
                            Text(cid,style: TextStyle(color:Colors.blueAccent,fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),),
                            Text("Timeline",style: TextStyle(color:Colors.cyanAccent.withOpacity(0.8),fontSize: 3.5*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),)

                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 1*SizeConfig.widthmultiplier,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2*SizeConfig.heightmultiplier,
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 60 * SizeConfig.heightmultiplier,
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                                stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: FutureBuilder<UserTimeLineDataModel>(
                              future:myFuture,
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  return ListView.builder(
                                      itemCount: snapshot.data?.data?.length,
                                      itemBuilder: (context, index){
                                        if(snapshot.data?.data?.length == 0){

                                        }else{
                                          _controller.forward(from: 0.0);
                                          final event = snapshot.data?.data?[index];
                                          return SlideTransition(
                                            position: _slideAnimation,
                                            child: FadeTransition(
                                              opacity: _fadeAnimation,
                                              child: SizedBox(
                                                width: 75*SizeConfig.widthmultiplier,
                                                height: 15*SizeConfig.heightmultiplier,
                                                child: TimelineTile(
                                                  // isFirst: index == 0,
                                                  // isLast: index == (abc.length -1),
                                                  beforeLineStyle: LineStyle(
                                                    color: Colors.white,
                                                    thickness: 0.2*SizeConfig.widthmultiplier,
                                                  ),
                                                  afterLineStyle: LineStyle(
                                                    color: Colors.white,
                                                    thickness: 0.2*SizeConfig.widthmultiplier,
                                                  ),
                                                  indicatorStyle: IndicatorStyle(
                                                    height: 5,
                                                    color: Colors.white.withOpacity(1),
                                                    padding: EdgeInsets.only(
                                                        left: 2*SizeConfig.widthmultiplier,
                                                        right: 2*SizeConfig.widthmultiplier,
                                                        top: 0*SizeConfig.heightmultiplier,
                                                        bottom: 0*SizeConfig.heightmultiplier
                                                    ),
                                                    width: 15,
                                                  ),
                                                  axis: TimelineAxis.vertical,
                                                  alignment: TimelineAlign.manual,
                                                  lineXY: 0.3,
                                                  startChild: FrostedGlass(
                                                    glassWidth: 6*SizeConfig.widthmultiplier,
                                                    glassHeight: 6*SizeConfig.heightmultiplier,
                                                    glassRadius: 1*SizeConfig.heightmultiplier,
                                                    glassChild: Center(
                                                      child: event?.eventType != "Job"?Text(event?.eventDate ?? '',style: const TextStyle(
                                                          fontFamily: 'JosefinSans',fontSize: 15, color: Colors.white
                                                      ),) :Text(DateFormat('MMM d, yyyy')
                                                          .format(DateTime.parse(
                                                          event?.eventDate ?? '')),style: TextStyle(
                                                          fontFamily: 'JosefinSans',fontSize: 1.5 * SizeConfig.textMultiplier, color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                  endChild: FrostedGlass(
                                                    glassWidth: 2*SizeConfig.widthmultiplier,
                                                    glassHeight: 10.5*SizeConfig.heightmultiplier,
                                                    glassRadius: 2*SizeConfig.heightmultiplier,
                                                    glassChild: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: event?.eventType == "Job"? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('${event?.eventType}: ${event?.eventName}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.white
                                                          ),),
                                                          const SizedBox(height: 2,),
                                                          Text('${event?.eventField}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.purple
                                                          ),),
                                                          const SizedBox(height: 2,),
                                                          Text('Salary: ${event?.eventSalary}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 15, color: Colors.purple
                                                          ),)

                                                        ],
                                                      ):
                                                      event?.eventType == "Course"?Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('${event?.eventType}: ${event?.eventName}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.white
                                                          ),),
                                                          Text('Institute: ${event?.eventField}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.purple
                                                          ),),

                                                        ],
                                                      ):Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text('${event?.eventType}: ${event?.eventName}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.white
                                                          ),),
                                                          Text('Rank: ${event?.eventField}',style: const TextStyle(
                                                              fontFamily: 'JosefinSans',fontSize: 20, color: Colors.purple
                                                          ),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return null;

                                      });
                                }
                                else if(snapshot.hasError){
                                  return Center(child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.09, // Adjust the height as needed
                                    child: Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.28,),
                                        const RotatedBox(
                                          quarterTurns: -1,
                                          child: LinearProgressIndicator(
                                          ),
                                        ),

                                      ],
                                    ),));
                                }
                                return const Center(child: CircularProgressIndicator());
                              },

                              // child: ListView.builder(
                              //     itemCount: abc.length,
                              //     itemBuilder: (context, index){
                              //       return SizedBox(
                              //         width: 75*SizeConfig.widthmultiplier,
                              //         height: 15*SizeConfig.heightmultiplier,
                              //         child: TimelineTile(
                              //           isFirst: index == 0,
                              //           isLast: index == (abc.length -1),
                              //           beforeLineStyle: LineStyle(
                              //             color: Colors.white.withOpacity(0.5),
                              //             thickness: 1.5*SizeConfig.widthmultiplier,
                              //           ),
                              //           afterLineStyle: LineStyle(
                              //             color: Colors.lightGreen,
                              //             thickness: 1.5*SizeConfig.widthmultiplier,
                              //           ),
                              //           indicatorStyle: IndicatorStyle(
                              //             color: Colors.deepPurple.withOpacity(0.5),
                              //             padding: EdgeInsets.only(
                              //                 left: 2*SizeConfig.widthmultiplier,
                              //                 right: 2*SizeConfig.widthmultiplier,
                              //                 top: 1*SizeConfig.heightmultiplier,
                              //                 bottom: 1*SizeConfig.heightmultiplier
                              //             ),
                              //             width: 3.5*SizeConfig.heightmultiplier,
                              //           ),
                              //           axis: TimelineAxis.vertical,
                              //           alignment: TimelineAlign.manual,
                              //           lineXY: 0.3,
                              //           startChild: FrostedGlass(
                              //             glassWidth: 3*SizeConfig.widthmultiplier,
                              //             glassHeight: 10*SizeConfig.heightmultiplier,
                              //             glassRadius: 2*SizeConfig.heightmultiplier,
                              //             glassChild: Center(
                              //               child: Text("Hello",style: TextStyle(
                              //                 fontFamily: 'JosefinSans',
                              //               ),),
                              //             ),
                              //           ),
                              //           endChild: FrostedGlass(
                              //             glassWidth: 2*SizeConfig.widthmultiplier,
                              //             glassHeight: 10*SizeConfig.heightmultiplier,
                              //             glassRadius: 2*SizeConfig.heightmultiplier,
                              //             glassChild: Center(
                              //               child: Text("Hello",style: TextStyle(
                              //                 fontFamily: 'JosefinSans',
                              //               ),),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2*SizeConfig.heightmultiplier,
                ),

              ],
            )],
          ):const Text("Unauthorized"),
        ),
      ),
    );
  }
}
