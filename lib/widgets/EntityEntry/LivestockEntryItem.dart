import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/InputFieldModel.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../TextFieldWidget.dart';

class LivestockEntryItem extends StatefulWidget {
  const LivestockEntryItem({super.key});

  @override
  State<LivestockEntryItem> createState() => _LivestockEntryItemState();
}

class _LivestockEntryItemState extends State<LivestockEntryItem> {
  late InputFieldData livestockNameInput;
  late InputFieldData livestockCodeInput;

  @override
  void initState() {
    livestockNameInput = InputFieldData(
        labelName: "Livestock Name",
        errMessage: "Please enter a Livestock name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    livestockCodeInput = InputFieldData(
        labelName: "Livestock Code",
        errMessage: "Please enter a Livestock code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    super.initState();
  }

  resetInputs() {
    livestockNameInput.myController.text = "";
    livestockCodeInput.myController.text = "";
  }

  createLivestock() async {
    if (livestockNameInput.myController.text.isEmpty ||
        livestockCodeInput.myController.text.isEmpty) {
      return AppHelper.showSnackbar(
          "State and code should not be empty", context);
      ;
    }

    try {
      dynamic response = await MasterDataService.createLivestock(
          livestockNameInput.myController.text,
          livestockCodeInput.myController.text);
      resetInputs();
      AppHelper.showSnackbar("Livestock created successfully", context);
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong!", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              width: 400,
              child: TextFieldWidget(inputData: livestockNameInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: 400,
              child: TextFieldWidget(inputData: livestockCodeInput)),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: createLivestock,
                child: Text("Submit"),
              )),
        ],
      ),
    );
  }
}
