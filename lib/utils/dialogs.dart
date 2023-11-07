import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static alert(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Si'),
          ),
        ],
      ),
    );
  }
}

abstract class ProgressDialog {
  static show(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black26.withOpacity(0.5),
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              ));
        });
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }

  void hide();
}
