import 'package:flutter/material.dart';
import 'package:planeje/credentials/page/login/login_page.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';

import 'package:planeje/settings/utils/sync.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/privacy_policy.dart';

import 'package:planeje/widgets/text_button_widget.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController realize = TextEditingController();
  final TextEditingController next = TextEditingController();
  final Sync sync = Sync();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Configuração',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 5.0), child: Text('Enviar dados')),
                    ListenableBuilder(listenable: sync.syncNotifierPost, builder: (context, child) => sync.syncNotifierPost.status.build(context)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 5.0), child: Text('Receber dados')),
                    ListenableBuilder(listenable: sync.syncNotifierGet, builder: (context, child) => sync.syncNotifierGet.status.build(context)),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(TransitionsBuilder.createRoute(const PrivacyPolicy()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 25, right: 10, top: 15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacidade de dados',
                          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget.sync(() async {
              try {
                await sync.postDataDisable();

                await sync.postData();

                await sync.receiveData();

                if (context.mounted) MessageUser.success(context, 'Sincronização finalizada!!!');
              } catch (e) {
                if (context.mounted) MessageUser.error(context, 'Erro ao sincronização!!!');
              }
            }),
            TextButtonWidget(
              label: 'DESLOGAR',
              onClick: () async {
                await SessionManager().logout();

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
