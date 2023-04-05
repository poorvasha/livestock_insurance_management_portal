import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldData {
  String? labelName;
  String errMessage;
  bool isValid;
  TextEditingController myController;
  TextInputType keyboardType;
  TextInputFormatter textInputType;
  Function onTextChange;
  bool obscureText;
  bool showErrMessage;
  bool? isEnabled;
  Color? disabledBGColor;
  bool readOnly;

  InputFieldData(
      {this.labelName,
      required this.errMessage,
      this.isValid = false,
      required this.myController,
      required this.keyboardType,
      required this.textInputType,
      required this.onTextChange,
      this.obscureText = false,
      this.showErrMessage = false,
      this.isEnabled = true,
      this.readOnly = false});
}
