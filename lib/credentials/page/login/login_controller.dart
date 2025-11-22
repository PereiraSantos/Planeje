import 'package:flutter/material.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/usercases/login_usercases.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/utils/message_user.dart';

class LoginController {
  late BuildContext _context;
  final LoginUsercases _loginUsercases = LoginUsercases();

  set context(BuildContext value) => _context = value;

  Future<void> login(GlobalKey<FormState> formKeyLogin, TextEditingController email, TextEditingController password) async {
    if (!formKeyLogin.currentState!.validate()) return;

    _closeKeyboard();

    _loginUsercases.setEmail(email.text);
    _loginUsercases.setPassword(password.text);

    bool isRegister = await _loginUsercases.register();
    isRegister ? _goTo() : _messageError();
  }

  Future<void> findUser(TextEditingController email, TextEditingController password) async {
    User? user = await _loginUsercases.findUser();

    email.text = user?.email ?? '';
    password.text = user?.password ?? '';

    _loginUsercases.setUserDatabase();
  }

  void _messageError() => MessageUser.alert(_context, 'Login incorreto!!!');

  void _closeKeyboard() => FocusScope.of(_context).requestFocus(FocusNode());

  void _goTo() {
    Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Home()));
  }
}
