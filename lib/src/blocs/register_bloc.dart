import 'dart:async';

import 'package:vinacar/src/validators/validations.dart';

class RegisterBloc {
  StreamController _userRegisterController = new StreamController();
  StreamController _passRegisterController = new StreamController();
  StreamController _fullnameRegisterController = new StreamController();
  StreamController _phoneRegisterController = new StreamController();
  Stream get userStream => _userRegisterController.stream;
  Stream get passStream => _passRegisterController.stream;
  Stream get fullnameStream => _fullnameRegisterController.stream;
  Stream get phoneStream => _phoneRegisterController.stream;

  bool isValidLoginInfo(String username, String pass) {
    if (!Validations.isValidUser(username)) {
      _userRegisterController.sink.addError("username không hợp lệ!");
      return false;
    }
    _userRegisterController.sink.add("OK");
    if (!Validations.isValidPass(pass)) {
      _passRegisterController.sink.addError("mật khẩu không hợp lệ!");
      return false;
    }
    _passRegisterController.sink.add("OK");

    return true;
  }

  void dispose() {
    _userRegisterController.close();
    _passRegisterController.close();
    _fullnameRegisterController.close();
    _phoneRegisterController.close();
  }
}
