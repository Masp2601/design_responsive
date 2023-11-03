import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/avatar_button.dart';
import '../widgets/circle.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                top: pinkSize * 0.15,
                child: Column(
                  children: [
                    Text(
                      'Registrate...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.dp(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: responsive.dp(5)),
                    AvatarButton(
                      imageSize: responsive.wp(25),
                    ),
                  ],
                ),
              ),
              const RegisterForm(),
              Positioned(
                left: 15,
                right: 15,
                child: SafeArea(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black26,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
