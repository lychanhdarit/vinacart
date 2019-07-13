import 'package:flutter/material.dart';
import 'package:vinacar/src/blocs/login_bloc.dart'; 
import 'package:vinacar/src/resources/map.dart'; 
import 'package:vinacar/src/resources/register_page.dart';

class LoginApp extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginApp> {
  LoginBloc bloc = new LoginBloc();
  bool _isShow = true;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        constraints: BoxConstraints.expand(), //Full man hinh
        color: Colors.white, //mau nen
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, //bat dau tu duoi
            crossAxisAlignment: CrossAxisAlignment.start, //canh trai
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: FlutterLogo()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text(
                  "Hello\nWelcome back",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: StreamBuilder(
                    stream: bloc.userStream,
                    builder: (context, snapsot) => TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              errorText: snapsot.hasError ? snapsot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 14)),
                        ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd, //Giua va cuoi
                  children: <Widget>[
                    StreamBuilder(
                        stream: bloc.passStream,
                        builder: (context, snapsot) => TextField(
                              controller: _passController,
                              obscureText: _isShow,
                              decoration: InputDecoration(
                                  labelText: "PASSWORD",
                                  errorText:
                                      snapsot.hasError ? snapsot.error : null,
                                  labelStyle: TextStyle(
                                      color: Color(0xff888888), fontSize: 14)),
                            )),
                    GestureDetector(
                      onTap: _onTapShowPass,
                      child: Text(!_isShow ? "HIDE" : "SHOW",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: _onclickSubmit,
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _gotoRegister,
                      child: Text(
                        "New User? Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    GestureDetector(
                      onTap: _gotoRegister,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onclickSubmit() {
    if (bloc.isValidLoginInfo(_userController.text, _passController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void _onTapShowPass() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  void _gotoRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterApp()));
  }
}
