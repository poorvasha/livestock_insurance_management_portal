import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lsi_management_portal/configs/Resources.dart';

import '../models/InputFieldModel.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({super.key, required this.inputData});
  InputFieldData inputData;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.inputData.labelName.toString(),
              textAlign: TextAlign.left,
            ),
          ),
          TextField(
            onChanged: (value) {
              widget.inputData.onTextChange(value);
            },
            keyboardType: widget.inputData.keyboardType,
            obscureText: widget.inputData.obscureText,
            inputFormatters: [widget.inputData.textInputType],
            cursorColor: Resources.primaryColor,
            decoration: const InputDecoration(
                focusColor: Resources.primaryColor,
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Resources.primaryColor, width: 2.0))),
          ),

          // #region Error Message

          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                  widget.inputData.showErrMessage
                      ? widget.inputData.errMessage
                      : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Resources.red)),
            ),
          ),
          // #endregion
        ],
      ),
    );
  }
}
