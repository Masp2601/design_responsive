import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/circle.dart';
import '../widgets/icon_container.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);
    return Scaffold(
        body: GestureDetector(
      onDoubleTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: responsive.height,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -pinkSize * 0.4,
                right: -pinkSize * 0.2,
                child: Circle(
                  size: pinkSize,
                  colors: const [Colors.pinkAccent, Colors.pink],
                ),
              ),
              Positioned(
                top: -orangeSize * 0.55,
                left: -orangeSize * 0.15,
                child: Circle(
                  size: orangeSize,
                  colors: const [Colors.deepOrange, Colors.deepOrangeAccent],
                ),
              ),
              Positioned(
                top: pinkSize * 0.35,
                child: Column(
                  children: [
                    IconContainer(size: responsive.wp(17)),
                    SizedBox(height: responsive.dp(3)),
                    Text(
                      'Bienvenido...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.dp(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const LoginForm()
            ],
          ),
        ),
      ),
    ));
  }
}
