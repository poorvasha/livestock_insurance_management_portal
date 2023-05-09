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

  void showDeleteConfirmation(BuildContext context, Function onConfirmed) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        onConfirmed();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Would you like to delete this item?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
