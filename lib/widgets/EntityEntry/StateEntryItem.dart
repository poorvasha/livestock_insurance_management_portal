import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/services/app_helper.dart';
import 'package:lsi_management_portal/services/master_data_service.dart';

import '../../models/InputFieldModel.dart';
import '../TextFieldWidget.dart';

class StateEntryItem extends StatefulWidget {
  const StateEntryItem({super.key});

  @override
  State<StateEntryItem> createState() => _StateEntryItemState();
}

class _StateEntryItemState extends State<StateEntryItem> {
  late InputFieldData stateNameInput;
  late InputFieldData stateCodeInput;

  @override
  void initState() {
    stateNameInput = InputFieldData(
        labelName: "State Name",
        errMessage: "Please enter a state name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    stateCodeInput = InputFieldData(
        labelName: "State Code",
        errMessage: "Please enter a state code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    super.initState();
  }

  resetInputs() {
    stateNameInput.myController.text = "";
    stateCodeInput.myController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    createState() async {
      if (stateNameInput.myController.text.isEmpty ||
          stateCodeInput.myController.text.isEmpty) {
        return AppHelper.showSnackbar(
            "State and code should not be empty", context);
        ;
      }

      try {
        dynamic response = await MasterDataService.createState(
            stateNameInput.myController.text, stateCodeInput.myController.text);
        resetInputs();
        AppHelper.showSnackbar("State created successfully", context);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
    }

    return Container(
      child: Column(
        children: [
          SizedBox(
              width: 400, child: TextFieldWidget(inputData: stateNameInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: 400, child: TextFieldWidget(inputData: stateCodeInput)),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: createState,
                child: Text("Submit"),
              )),
        ],
      ),
    );
  }
}
