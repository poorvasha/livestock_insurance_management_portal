import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/state_model.dart';
import 'package:lsi_management_portal/services/app_helper.dart';
import 'package:lsi_management_portal/services/master_data_service.dart';

import '../../models/InputFieldModel.dart';
import '../DropdownWidget.dart';
import '../TextFieldWidget.dart';

class ProgrammeEntryItem extends StatefulWidget {
  const ProgrammeEntryItem({super.key});

  @override
  State<ProgrammeEntryItem> createState() => _ProgrammeEntryItemState();
}

class _ProgrammeEntryItemState extends State<ProgrammeEntryItem> {
  late InputFieldData programmeNameInput;
  late InputFieldData programmeCodeInput;

  List<States> states = [States(name: "")];
  States? selectedState;

  @override
  void initState() {
    programmeNameInput = InputFieldData(
        labelName: "Programme Name",
        errMessage: "Please enter a programme name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    programmeCodeInput = InputFieldData(
        labelName: "Programme Code",
        errMessage: "Please enter a programme code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});

    getDependentData();
    super.initState();
  }

  resetInputs() {
    programmeNameInput.myController.text = "";
    programmeCodeInput.myController.text = "";
    selectedState = states.first;
  }

  getDependentData() async {
    try {
      List<States> response = await MasterDataService.getStates();
      setState(() {
        states = response;
        if (response.isNotEmpty) {
          selectedState = response.first;
        }
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  createProgramme() async {
    try {
      if (programmeNameInput.myController.text.isEmpty ||
          programmeCodeInput.myController.text.isEmpty ||
          selectedState == null) {
        return AppHelper.showSnackbar(
            "Any fields should not be empty", context);
      }

      await MasterDataService.createProgramme(
          programmeNameInput.myController.text,
          programmeCodeInput.myController.text,
          selectedState!.sId!);
      AppHelper.showSnackbar("Programme created successfully", context);
      resetInputs();
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              width: 400,
              child: TextFieldWidget(inputData: programmeNameInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: 400,
              child: TextFieldWidget(inputData: programmeCodeInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 400,
            child: DropDown(
              value: selectedState == null ? null : selectedState?.sId,
              hint: Text("State"),
              items: states.map((States value) {
                return DropdownMenuItem<String>(
                  value: value.sId,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                States selected =
                    states.firstWhere((element) => element.sId == value);
                setState(() {
                  selectedState = selected;
                });
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: createProgramme,
                child: Text("Submit"),
              )),
        ],
      ),
    );
  }
}
