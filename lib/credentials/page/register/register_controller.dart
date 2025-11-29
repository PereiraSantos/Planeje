import 'package:flutter/material.dart';
import 'package:planeje/credentials/datasources/database/sqlite_last_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_user.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';
import 'package:planeje/credentials/usercases/user_credentials.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/utils/message_user.dart';

class RegisterController {
  late BuildContext _context;

  set context(BuildContext value) => _context = value;

  Future<void> register(GlobalKey<FormState> formKeyRegister, TextEditingController email, TextEditingController password) async {
    try {
      if (!formKeyRegister.currentState!.validate()) return;

      _closeKeyboard();

      await UserCredentials(SqliteUser()).register(email.text, password.text);

      final SessionManager sessionManager = SessionManager();

      sessionManager.setUserDatabase(SqliteUser());
      sessionManager.setSessionDatabase(SqliteSession());
      sessionManager.setLastSessionDatabase(SqliteLastSession());

      sessionManager.createSession(User(email.text, password.text));

      _goTo();
    } catch (e) {
      _messageError();
    }
  }

  void _closeKeyboard() => FocusScope.of(_context).requestFocus(FocusNode());

  void _messageError() => MessageUser.error(_context, 'Erro ao cadastrar!!!');

  void _goTo() {
    MessageUser.success(_context, 'Cadastro realizado!!!');
    Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Home()));
  }
}
