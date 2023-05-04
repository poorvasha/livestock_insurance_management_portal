import 'package:flutter/material.dart';

class DialogHelper {
  // Show Dialog
  showErrorDialog(BuildContext context,
      {String? title = 'Attention!',
      String? description = 'Something went wrong'}) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                title ?? '',
              ),
              content: Text(
                description ?? '',
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Okay',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  // Show toast
  // Show snack bar
  // Show loading
  Future<void> showLoading(BuildContext context, {String? message}) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 8,
                    ),
                    Text(
                      message ?? 'loading...',
                    )
                  ],
                ),
              ),
            ]));
  }

  // Hide loading
  void hideLoading(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
