import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            label: const Text('Email', style: TextStyle(color: Colors.white)),
                            filled: true,
                            fillColor: const Color(0xff100708).withOpacity(0.2),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xff100708)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            label: const Text('Senha', style: TextStyle(color: Colors.white)),
                            filled: true,
                            fillColor: const Color(0xff100708).withOpacity(0.2),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xff100708)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.pushReplacement('/');
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
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
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
