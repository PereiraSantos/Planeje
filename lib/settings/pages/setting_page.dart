import 'package:flutter/material.dart';
import 'package:planeje/backup/page/backup_page.dart';
import 'package:planeje/credentials/page/login/login_page.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';
import 'package:planeje/settings/utils/config_host_api.dart';

import 'package:planeje/settings/utils/sync.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/widgets/button_custom.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/privacy_policy.dart';

import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController host = TextEditingController();
  final TextEditingController port = TextEditingController();
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
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(TransitionsBuilder.createRoute(BackupPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 25, right: 10, top: 15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Backup',
                          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
                ),
                Padding(padding: const EdgeInsets.only(left: 20), child: Text('Api')),
                FutureBuilder(
                  future: ConfigHostApi().getHost(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 1));
                    }

                    host.text = snapshot.data.toString();

                    return TextFormFieldWidget(controller: host, hintText: 'Ip', valid: true);
                  },
                ),
                FutureBuilder(
                  future: ConfigHostApi().getPort(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 1));
                    }

                    port.text = snapshot.data.toString();

                    return TextFormFieldWidget(controller: port, hintText: 'Porta', valid: true, keyboardType: TextInputType.number);
                  },
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: 70,
                    child: GestureDetector(
                      onTap: () async {
                        if (!formKey.currentState!.validate()) return;

                        await ConfigHostApi().saveHost(host.text, int.parse(port.text));

                        MessageUser.success('Registrado com sucesso!!!');
                      },
                      child: ButtonCustom(
                        color: Colors.grey,
                        child: Text('Salvar', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 05),
                  child: Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
                ),
                Padding(padding: const EdgeInsets.only(left: 20), child: Text('Sincronização')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 05, bottom: 10),
                      width: 100,
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            await sync.receiveData();

                            if (context.mounted) MessageUser.success('Sincronização finalizada!!!');
                          } catch (e) {
                            if (context.mounted) MessageUser.error('Erro ao sincronização!!!');
                          }
                        },
                        child: ButtonCustom(
                          color: Colors.grey,
                          child: Text('Receber Dados', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ListenableBuilder(listenable: sync.syncNotifierGet, builder: (context, child) => sync.syncNotifierGet.status.build(context)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 05, bottom: 05),
                      width: 100,
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            await sync.postDataDisable();

                            await sync.postData();

                            if (context.mounted) MessageUser.success('Sincronização finalizada!!!');
                          } catch (e) {
                            if (context.mounted) MessageUser.error('Erro ao sincronização!!!');
                          }
                        },
                        child: ButtonCustom(
                          color: Colors.grey,
                          child: Text('Enviar Dados', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ListenableBuilder(listenable: sync.syncNotifierPost, builder: (context, child) => sync.syncNotifierPost.status.build(context)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget(
              label: 'ENCERRAR SESSÃO',
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
