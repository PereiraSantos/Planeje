import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planeje/credentials/datasources/database/sqlite_last_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_user.dart';
import 'package:planeje/credentials/page/login/login_page.dart';
import 'package:planeje/credentials/page/register/register_page.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';
import 'package:planeje/dashboard/pages/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initSession();
  }

  Future<void> initSession() async {
    final SessionManager sessionManager = SessionManager();

    sessionManager.setUserDatabase(SqliteUser());
    sessionManager.setSessionDatabase(SqliteSession());
    sessionManager.setLastSessionDatabase(SqliteLastSession());

    bool? isInitSession = await sessionManager.initSession();

    if (isInitSession == null) {
      _goTo(RegisterPage());
      return;
    }

    _goTo(isInitSession ? const Home() : LoginPage());
  }

  void _goTo(dynamic page) {
    Timer(const Duration(seconds: 1), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => page)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/icon.png')),
    );
  }
}
