import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lsi_management_portal/configs/Resources.dart';
import 'package:lsi_management_portal/models/InputFieldModel.dart';
import 'package:lsi_management_portal/utils/Helpers.dart';
import 'package:provider/provider.dart';

import '../providers/AppModel.dart';
import '../widgets/TextFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late InputFieldData userNameInputData;
  late InputFieldData passwordInputData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameInputData = InputFieldData(
        labelName: "User Name",
        errMessage: "Please enter valid Username",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: onUserNameTextChange);

    passwordInputData = InputFieldData(
        labelName: "Password",
        errMessage: "password must be atleast 7 charaters",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: onPasswordTextChange,
        obscureText: true);
  }

  onUserNameTextChange(String value) {
    bool isValid = value.isNotEmpty;
    userNameInputData.isValid = isValid;
    userNameInputData.showErrMessage = !isValid;
    userNameInputData.myController = TextEditingController(text: value);
  }

  onPasswordTextChange(String value) {
    bool isValid = Helpers.validatePassword(value);
    passwordInputData.isValid = isValid;
    passwordInputData.showErrMessage = !isValid;
    passwordInputData.myController = TextEditingController(text: value);
  }

  onLogin() {
    if (userNameInputData.isValid && passwordInputData.isValid) {
      context.read<AppModel>().setInitialRoute = "HomeScreen";
    } else {
      userNameInputData.showErrMessage = true;
      passwordInputData.showErrMessage = true;
    }
    setState(() {
      userNameInputData;
      passwordInputData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 600,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                boxShadow: Resources.customShadow,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(60),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(children: [
                    SvgPicture.asset(
                      "../assets/images/secure_login.svg",
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldWidget(inputData: userNameInputData),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFieldWidget(
                            inputData: passwordInputData,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      iconSize: 60,
                      onPressed: onLogin,
                      icon: const Icon(
                        Icons.arrow_forward_outlined,
                        color: Resources.primaryColor,
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
