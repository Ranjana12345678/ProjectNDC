import 'package:flutter/material.dart';

class Abc extends StatefulWidget {
  const Abc({Key? key}) : super(key: key);
  static const BACKGROUND_COLOR = Color(0xFFFEFFFF);
  static const  PRIMARY_COLOR = Color(0xFF2B7A78);
  static const  SECONDARY_COLOR = Color(0xFF3AAFA9);
  static const  SUPER_BACKGROUND_COLOR = Color(0xFFE3E9E9);
  static const  SUPER_GREY = Color(0xFFC4C7C7);

  @override
  State<Abc> createState() => _AbcState();
}

class _AbcState extends State<Abc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Abc.SUPER_BACKGROUND_COLOR,

      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),

      body: Center(
        child: Container(
          width: 600,
          height: 700,

          decoration: BoxDecoration(
            color: Abc.SUPER_BACKGROUND_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(50)),

              boxShadow: [
                BoxShadow(
                  color: Abc.SUPER_GREY,
                  blurRadius: 10,
                  offset: const Offset(10.0, 10.0,),
                ),
                BoxShadow(
                  color: Abc.BACKGROUND_COLOR,
                  blurRadius: 10,
                  offset: const Offset(-10.0, -10.0,),
                ),
              ],

          ),

          child: Column(
            children: [

              Container(   //or Padding/ to assign size and box shadow below logo
                padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular (100),
                      color: Abc.SUPER_BACKGROUND_COLOR,
                      
                      boxShadow: [
                        BoxShadow(
                          color: Abc.SUPER_GREY,
                          blurRadius: 10,
                          offset: const Offset(10.0, 10.0,),
                        ),
                        BoxShadow(
                          color: Abc.BACKGROUND_COLOR,
                          blurRadius: 10,
                          offset: const Offset(-10.0, -10.0,),
                        ),
                      ]
                    ),
                    
                    child: Center(  //center
                      child: Container(  //to store the image
                        width: 140,
                        height: 140,
                        child: Image(
                          image: AssetImage('ndc_logo.png'),
                        ),
                      ),
                    ),
                  ),
              ),

              Container(
                padding: EdgeInsets.only(top: 40),
                child: Text('Welcome To',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                child: Text('Narasinha Dutt College',
                  style: TextStyle(fontSize: 25),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 45),
                child: Container(

                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Abc.SUPER_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(25)),

                    boxShadow: [
                      BoxShadow(
                        color: Abc.SUPER_GREY,
                        blurRadius: 10,
                        offset: const Offset(10.0, 10.0,),
                      ),
                      BoxShadow(
                        color: Abc.BACKGROUND_COLOR,
                        blurRadius: 10,
                        offset: const Offset(-10.0, -10.0,),
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Abc.SUPER_GREY,
                        Abc.SUPER_BACKGROUND_COLOR,
                        Abc.BACKGROUND_COLOR,
                      ],

                    ),

                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: '        Username',
                      // hintText: 'Enter your username'
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 15),
                child: Container(

                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Abc.SUPER_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(25)),

                    boxShadow: [
                      BoxShadow(
                        color: Abc.SUPER_GREY,
                        blurRadius: 10,
                        offset: const Offset(10.0, 10.0,),
                      ),
                      BoxShadow(
                        color: Abc.BACKGROUND_COLOR,
                        blurRadius: 10,
                        offset: const Offset(-10.0, -10.0,),
                      ),
                    ],

                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Abc.SUPER_GREY,
                        Abc.SUPER_BACKGROUND_COLOR,
                        Abc.BACKGROUND_COLOR,
                      ],

                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,  //to remove underline
                      labelText: '        Password',
                      // hintText: 'Enter your password'
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10),
                width: 380,
                alignment: Alignment.centerRight,
                child: Text('forgot password?',
                  style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 45),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.all(Radius.circular(25)),

                    boxShadow: [
                      BoxShadow(
                        color: Abc.SUPER_GREY,
                        blurRadius: 10,
                        offset: const Offset(10.0, 10.0,),
                      ),
                      BoxShadow(
                        color: Abc.BACKGROUND_COLOR,
                        blurRadius: 10,
                        offset: const Offset(-10.0, -10.0,),
                      ),
                    ],

                  ),
                  child: ElevatedButton(
                    onPressed : (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shadowColor: Abc.SUPER_GREY,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(400, 50),
                      ),
                      child: Text('Log In',
                          style: TextStyle(fontSize: 22, color: Colors.white)
                      ),
                ),
              ),
              ),

              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 100),
                  width: 400,
                  child: Row(
                    children: [

                      Container(
                        width: 200,
                        alignment: Alignment.centerLeft,
                        child: Text(" Don't have an account?",
                          style: TextStyle(fontSize: 18,),
                        ),
                      ),

                      Container(
                        width: 190,
                        alignment: Alignment.centerRight,
                        child: Text("Sign up Here",
                          style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
                        ),
                      )
                    ],

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Fill extends StatefulWidget {
  const Fill({Key? key}) : super(key: key);
  static const BACKGROUND_COLOR = Color(0xFFFEFFFF);
  static const  PRIMARY_COLOR = Color(0xFF2B7A78);
  static const  SECONDARY_COLOR = Color(0xFF3AAFA9);
  static const  SUPER_BACKGROUND_COLOR = Color(0xFFE3E9E9);
  static const  SUPER_GREY = Color(0xFFC4C7C7);
  @override
  State<Fill> createState() => _FillState();
}

class _FillState extends State<Fill>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Fill.SUPER_BACKGROUND_COLOR,
    );
  }
}