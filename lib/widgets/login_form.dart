import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../api/authentication_api.dart';
import '../pages/home_page.dart';
import '../utils/dialogs.dart';
import '../utils/responsive.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _user = '', _password = '';
  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final authenticationApi = GetIt.instance<AuthenticationApi>();
      final response = await authenticationApi.login(
        user: _user,
        password: _password,
      );
      // ignore: use_build_context_synchronously
      ProgressDialog.dissmiss(context);

      if (response.data != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context, HomePage.routeName as Route<Object?>, (_) => false);
      } else {
        String message = response.error!.message!;
        if (response.error!.statusCode == -1) {
          message = 'No hay conexion a internet';
        } else if (response.error!.statusCode == 403) {
          message =
              'Contraseña incorrecta ${jsonEncode(response.error!.data['message'])}}';
        } else if (response.error!.statusCode == 404) {
          message =
              'Usuario no encontrado ${jsonEncode(response.error!.data['message'])}}';
        }
        // ignore: use_build_context_synchronously
        Dialogs.alert(
          context,
          title: 'ERROR',
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(maxWidth: responsive.isTablet ? 430 : 360),
        child: Form(
          key: _formKey,
          child: Column(children: [
            InputText(
              keyboardType: TextInputType.text,
              label: 'USUARIO',
              fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
              onChanged: (text) {
                _user = text;
              },
              validator: (text) {
                if (text!.trim().isEmpty) {
                  return 'Ingrese su usuario';
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(1.5)),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black26),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InputText(
                      obscureText: true,
                      label: 'Contraseña',
                      borderEnabled: false,
                      fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                      onChanged: (text) {
                        _password = text;
                      },
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'Ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      textStyle: TextStyle(
                        fontSize: responsive.dp(1.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Olvidó su contraseña?',
                        style: TextStyle(
                            fontSize:
                                responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                            color: Colors.black26)),
                  )
                ],
              ),
            ),
            SizedBox(height: responsive.dp(5)),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
                onPressed: _submit,
                child: Text('Ingresar',
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: responsive.dp(2)),
            Row(
              children: [
                const Text('No tienes una cuenta?'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(
                        fontSize: responsive.dp(1.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: Text('Registrate',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: responsive.dp(1.5))),
                ),
              ],
            ),
            SizedBox(height: responsive.dp(10)),
          ]),
        ),
      ),
    );
  }
}
