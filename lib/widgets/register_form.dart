import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../api/authentication_api.dart';
import '../pages/home_page.dart';
import '../utils/dialogs.dart';
import '../utils/responsive.dart';
import 'input_text.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _user = '', _password = '', _email = '';
  final Logger _logger = Logger();

  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final authenticationApi = GetIt.instance<AuthenticationApi>();
      final response = await authenticationApi.register(
        user: _user,
        email: _email,
        password: _password,
      );
      // ignore: use_build_context_synchronously
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        _logger.i('Usuario registrado');
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context, HomePage.routeName as Route<Object?>, (_) => false);
      } else {
        _logger.e('Error al registrar usuario ${response.error}');
        String message = response.error!.message!;
        if (response.error!.statusCode == -1) {
          message = 'No hay conexion a internet';
        } else if (response.error!.statusCode == 409) {
          message =
              'El usuario ya existe ${jsonEncode(response.error!.data['message'])}}';
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
                if (text!.trim().length < 4) {
                  return 'Ingrese su usuario';
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(1.5)),
            InputText(
              keyboardType: TextInputType.text,
              label: 'CORREO ELECTRONICO',
              fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
              onChanged: (text) {
                _email = text;
              },
              validator: (text) {
                if (text!.contains("@")) {
                  return 'Ingrese su correo electronico';
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(1.5)),
            InputText(
              keyboardType: TextInputType.text,
              label: 'CONTRASEÑA',
              obscureText: true,
              fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
              onChanged: (text) {
                _password = text;
              },
              validator: (text) {
                if (text!.trim().length < 6) {
                  return 'Ingrese su contraseña';
                }
                return null;
              },
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
                child: Text('Registrarse',
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: responsive.dp(2)),
            Row(
              children: [
                const Text('Ya tienes una cuenta?'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(
                        fontSize: responsive.dp(1.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Inicia sesion',
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
