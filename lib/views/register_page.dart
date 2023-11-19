// ignore_for_file: use_build_context_synchronously

import 'package:coffe_ecom/controllers/register_controller.dart';
import 'package:coffe_ecom/models/register_model.dart';
import 'package:coffe_ecom/widgets/app_input.dart';
import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerController = RegisterController();
  late final void Function() listener;

  @override
  void initState() {
    listener = () async {
      if (_registerController.success) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Usuário cadastrado com sucesso!',
            style: TextStyle(fontSize: 20),
          ),
        ));
        await Future.delayed(const Duration(seconds: 1));
        context.pushReplacement('/login');
      }
      if (_registerController.errorMsg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            _registerController.errorMsg,
            style: const TextStyle(fontSize: 20),
          ),
        ));
      }
    };
    _registerController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _registerController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String user = '';
    String password = '';

    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/login_icon.png'),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Coffee',
                        style: TextStyle(fontSize: 40, color: Color(0xff8C4D21)),
                      ),
                      Text(
                        'Ecom',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppInput(
                          label: 'Login',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Login inválido';
                            }
                            user = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        AppInput(
                          label: 'Senha',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Senha inválida';
                            }
                            password = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        AppInput(
                          label: 'Seu nome',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains(RegExp(r'\s'))) {
                              return 'Nome inválido';
                            }
                            name = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        ListenableBuilder(
                          listenable: _registerController,
                          builder: (context, child) => Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _registerController.isLoading
                                      ? () {}
                                      : () {
                                          if (formKey.currentState!.validate()) {
                                            _registerController.register(
                                              RegisterModel(
                                                name: name,
                                                password: password,
                                                user: user,
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xffFFD79C),
                                    elevation: 9,
                                    fixedSize: const Size.fromHeight(55),
                                    backgroundColor: const Color(0xff854C1F),
                                    shadowColor: const Color.fromARGB(255, 240, 137, 59),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: _registerController.isLoading
                                      ? CircularProgressIndicator(color: Colors.brown[50])
                                      : const Text(
                                          'Cadastrar',
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
