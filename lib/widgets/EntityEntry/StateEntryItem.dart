import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/services/app_helper.dart';
import 'package:lsi_management_portal/services/master_data_service.dart';
import 'package:lsi_management_portal/utils/dialog_helper.dart';

import '../../configs/Resources.dart';
import '../../models/InputFieldModel.dart';
import '../../models/data/state_model.dart';
import '../TextFieldWidget.dart';

class StateEntryItem extends StatefulWidget {
  const StateEntryItem({super.key});

  @override
  State<StateEntryItem> createState() => _StateEntryItemState();
}

class _StateEntryItemState extends State<StateEntryItem> {
  late InputFieldData stateNameInput;
  late InputFieldData stateCodeInput;

  List<States> states = [];
  States? selectedState;

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

    getDependentData();
    super.initState();
  }

  resetInputs() {
    stateNameInput.myController.text = "";
    stateCodeInput.myController.text = "";
    setState(() {
      selectedState = null;
    });
  }

  getDependentData() async {
    try {
      List<States> response = await MasterDataService.getStates();
      setState(() {
        states = response;
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    createState() async {
      if (stateNameInput.myController.text.isEmpty ||
          stateCodeInput.myController.text.isEmpty) {
        return AppHelper.showSnackbar(
            "State and code should not be empty", context);
      }

      try {
        if (selectedState != null) {
          await MasterDataService.editState(stateNameInput.myController.text,
              stateCodeInput.myController.text, selectedState!.sId!);
          resetInputs();
          getDependentData();
          return;
        }

        await MasterDataService.createState(
            stateNameInput.myController.text, stateCodeInput.myController.text);
        resetInputs();
        getDependentData();
        AppHelper.showSnackbar("State created successfully", context);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
    }

    onItemEdit(States item) {
      stateNameInput.myController.text = item.name!;
      stateCodeInput.myController.text = item.code!;
      setState(() {
        selectedState = item;
      });
    }

    onDeleteSuccess(States item) async {
      try {
        await MasterDataService.deleteState(item.sId!);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
      resetInputs();
      getDependentData();
    }

    onItemDelete(States item) {
      DialogHelper().showDeleteConfirmation(context, () {
        onDeleteSuccess(item);
      });
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                    width: 400,
                    child: TextFieldWidget(inputData: stateNameInput)),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 400,
                    child: TextFieldWidget(inputData: stateCodeInput)),
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
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  dividerThickness: 4,
                  headingTextStyle:
                      const TextStyle(color: Resources.white, fontSize: 14),
                  dataRowColor: MaterialStateProperty.resolveWith(
                      (states) => Resources.primaryColor.withOpacity(0.1)),
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Resources.primaryColor),
                  columnSpacing: 40,
                  columns: const [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Code")),
                    DataColumn(label: Text("Actions"))
                  ],
                  rows: states
                      .map(
                        (value) => DataRow(cells: [
                          DataCell(
                            Text(value.name!),
                          ),
                          DataCell(
                            Text(value.code!),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      onItemEdit(value);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Resources.gray,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      onItemDelete(value);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 15,
                                      color: Resources.gray,
                                    ))
                              ],
                            ),
                          ),
                        ]),
                      )
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }
}
