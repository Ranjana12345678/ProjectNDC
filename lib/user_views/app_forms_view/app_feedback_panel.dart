import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_components/device_configuration.dart';
import '../../app_config/loading.dart';
import '../../app_controllers/app_feedback_form_controller.dart';
import '../../app_models/app_feedback_form_response_model.dart';
import '../../widgets/Custom_Button.dart';
import '../../widgets/FrostedGlass.dart';
import '../../widgets/custom_msg_snackbar.dart';

class FeedBackForm extends StatefulWidget {
  const FeedBackForm({super.key});

  @override
  State<FeedBackForm> createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {

  var loadingObj = Loading();

  TextEditingController feedBackMessageController = TextEditingController();

  submitFeedBackForm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FeedBackFormController feedBackFormController = FeedBackFormController();
    FeedBackFormResponseModel feedBackFormResponse = await
    feedBackFormController.submitFeedBackForm(feedBackMessageController.text.toString(), sharedPreferences.getString("Id")??'');
    if(feedBackFormResponse.status == true){
      loadingObj.showLoadingDialog(context);
      Future.delayed(const Duration(seconds: 1),(){
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomSnackMessage(
              messageIcon: Icons.emoji_emotions,
              messageTitle: "Thanks",
              messageBody: "Thank you for your valuable feedback",
              color: Colors.greenAccent),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: Duration( milliseconds: 2000),
        ));
        Future.delayed(const Duration(seconds: 3),(){
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    feedBackMessageController.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/b3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: FrostedGlass(
          glassWidth: 80*SizeConfig.widthmultiplier,
          glassHeight: 59*SizeConfig.heightmultiplier,
          glassRadius: 2*SizeConfig.heightmultiplier,
          glassChild: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2*SizeConfig.heightmultiplier,),
                  Center(child: Text("Feedback", style: TextStyle(fontSize: 4*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),)),
                  SizedBox(height: 2*SizeConfig.heightmultiplier,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      //keyboardType: TextInputType.multiline,
                      controller: feedBackMessageController,
                      maxLines: 10,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      decoration: InputDecoration(

                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: "Write your opinion",
                          hintStyle: const TextStyle(color: Colors.white),                        //prefix: const Icon(Icons.message_outlined),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide())),

                    ),
                  ),
                  SizedBox(height: 4*SizeConfig.heightmultiplier,),
                  CustomButton(
                      button_text: "SUBMIT",
                      button_width: 70*SizeConfig.widthmultiplier, 
                      onClick:(){
                        if(feedBackMessageController.text.isNotEmpty){
                          submitFeedBackForm();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: CustomSnackMessage(
                                messageIcon: Icons.error_outline,
                                messageTitle: "Error",
                                messageBody: "Feed Back message is required",
                                color: Colors.redAccent),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            duration: Duration( milliseconds: 2000),
                          ));
                        }

                    
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

