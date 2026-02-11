import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/dashboard.dart';
import 'package:planeje/dashboard/utils/check_setting.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/goal/pages/list_goal/page/list_goal.dart';
import 'package:planeje/quiz_revision/pages/list_quiz/page/list_quiz.dart';
import 'package:planeje/revision_theme/pages/list_revision_theme/page/list_revision_theme.dart';
import 'package:planeje/settings/pages/setting_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  final ReviserNotifier reviserNotifier = ReviserNotifier();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screen = [const Dashboard(), const ListRevisionTheme(), ListGoal(), const ListQuiz(), SettingPage()];

  @override
  void initState() {
    super.initState();
    CheckSetting().checkRealize();
    CheckSetting().checkNext();

    GetDelayedRevision(reviserNotifier).getRevision();
    GetCompletedRevision(reviserNotifier).getRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Revisão'),
          BottomNavigationBarItem(icon: Icon(Icons.outlined_flag), label: 'Meta'),
          BottomNavigationBarItem(icon: Icon(Icons.ballot), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuração'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
