import 'package:flutter/material.dart';
//import 'package:learnwidget/uihelper/util.dart';

void main(){
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:"FlutterApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        // ignore: prefer_const_constructors

      ),
      home: DashBoardScreen(),
    );
  }
}

class DashBoardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var emailText=TextEditingController();
    var passText= TextEditingController();
    //var arrName=['Ram','Sham','pavan','Ramesh','Sai'];
    return Scaffold(
        appBar: AppBar(
          title: Text("Farmers_Guide"),
          //color:Colors.purpleAccent,
        ),
        body:Center(
          child: Container(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailText,
                    //enabled: false,
                    decoration:InputDecoration(
                        hintText: 'Enter email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color:Colors.orangeAccent,
                            width: 2,
                          ),

                        ) ,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color:Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color:Colors.green,
                            )
                        ),
                        suffixText:"Username",
                        suffixIcon: IconButton(
                          icon:Icon(Icons.remove_red_eye,color: Colors.blueAccent,),
                          onPressed: () {
                            print("eye");
                          },
                        ),
                        prefixIcon: Icon(Icons.email,color: Colors.purpleAccent,)

                    ),
                  ),
                  Container(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: passText,
                    obscureText: true,
                    decoration:InputDecoration(
                        hintText: 'Enter Pass',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(
                              color:Colors.orangeAccent,
                            )
                        )
                    ) ,
                  ),
                  ElevatedButton(onPressed: (){
                    String uEmail=emailText.text.toString();
                    String uPass=passText.text.toString();

                    print("Email: $uEmail, Pass:$uPass");
                  }, child: Text('Login')
                  )

                ],
              )),
        )
    );
  }
}
