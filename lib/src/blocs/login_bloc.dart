import 'dart:async';

import 'package:vinacar/src/validators/validations.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidLoginInfo(String username, String pass) {
    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("username không hợp lệ!");
      return false;
    }
    _userController.sink.add("OK");
    if (!Validations.isValidPass(pass)) {
      _passController.sink.addError("mật khẩu không hợp lệ!");
      return false;
    }
    _passController.sink.add("OK");

    return true;
  }

  void dispose(){
    _userController.close();
    _passController.close();
  }
}
