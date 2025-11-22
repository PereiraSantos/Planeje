import 'package:flutter/material.dart';
import 'package:planeje/credentials/page/login/login_controller.dart';
import 'package:planeje/credentials/page/register/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key}) {
    _loginController.findUser(_email, _password);
  }

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(false);

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                SizedBox(width: 100, height: 100, child: Image.asset('assets/icon.png')),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Login obrigatório';
                    return null;
                  },
                ),

                ValueListenableBuilder(
                  valueListenable: _obscureText,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: IconButton(
                            onPressed: () => _obscureText.value = !_obscureText.value,
                            icon: Icon(_obscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          ),
                        ),
                        obscureText: _obscureText.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Senha obrigatória';
                          return null;
                        },
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        _loginController.context = context;
                        _loginController.login(_formKeyLogin, _email, _password);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(221, 33, 149, 243)),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
                    child: const Text('Cadastre-se'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(onTap: () {}, child: const Text('Esqueci minha senha')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
