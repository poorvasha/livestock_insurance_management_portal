import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/programme_model.dart';
import 'package:lsi_management_portal/models/data/state_model.dart';
import 'package:lsi_management_portal/services/app_helper.dart';
import 'package:lsi_management_portal/services/master_data_service.dart';
import 'package:collection/collection.dart';

import '../../configs/Resources.dart';
import '../../models/InputFieldModel.dart';
import '../../utils/dialog_helper.dart';
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

  List<Programme> programs = [];
  Programme? selectedProgramme;

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
    selectedState = null;
    selectedProgramme = null;
  }

  getDependentData() async {
    try {
      List<States> response = await MasterDataService.getStates();
      List<Programme> programsResponse = await MasterDataService.getPrograms();
      setState(() {
        states = response;
        programs = programsResponse;
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

      if (selectedProgramme != null) {
        await MasterDataService.editProgramme(
            programmeNameInput.myController.text,
            programmeCodeInput.myController.text,
            selectedState!.sId!,
            selectedProgramme!.sId!);
        resetInputs();
        getDependentData();
        return;
      }

      await MasterDataService.createProgramme(
          programmeNameInput.myController.text,
          programmeCodeInput.myController.text,
          selectedState!.sId!);
      AppHelper.showSnackbar("Programme created successfully", context);
      resetInputs();
      getDependentData();
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    onItemEdit(Programme item) {
      programmeNameInput.myController.text = item.name!;
      programmeCodeInput.myController.text = item.code!;
      setState(() {
        selectedState =
            states.firstWhereOrNull((element) => element.sId == item.state);
        selectedProgramme = item;
      });
    }

    onDeleteSuccess(Programme item) async {
      try {
        await MasterDataService.deleteProgramme(item.sId!);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
      resetInputs();
      getDependentData();
    }

    onItemDelete(Programme item) {
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
                    DataColumn(label: Text("State")),
                    DataColumn(label: Text("Actions"))
                  ],
                  rows: programs
                      .map(
                        (value) => DataRow(cells: [
                          DataCell(
                            Text(value.name!),
                          ),
                          DataCell(
                            Text(value.code!),
                          ),
                          DataCell(
                            Text(states
                                .firstWhere(
                                  (element) => element.sId == value.state!,
                                  orElse: () => States(name: ""),
                                )
                                .name!),
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
