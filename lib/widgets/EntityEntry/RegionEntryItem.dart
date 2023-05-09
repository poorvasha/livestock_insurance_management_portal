import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/programme_model.dart';

import '../../models/InputFieldModel.dart';
import '../../models/data/state_model.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../DropdownWidget.dart';
import '../TextFieldWidget.dart';
import '../../utils/extensions.dart';

class RegionEntryItem extends StatefulWidget {
  const RegionEntryItem({super.key});

  @override
  State<RegionEntryItem> createState() => _RegionEntryItemState();
}

class _RegionEntryItemState extends State<RegionEntryItem> {
  late InputFieldData regionNameInput;
  late InputFieldData regionCodeInput;

  List<States> states = [States(name: "")];
  States? selectedState;

  List<Programme> programs = [Programme(name: "")];
  Programme? selectedProgramme;

  @override
  void initState() {
    regionNameInput = InputFieldData(
        labelName: "Region Name",
        errMessage: "Please enter a Region name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    regionCodeInput = InputFieldData(
        labelName: "Region Code",
        errMessage: "Please enter a Region code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    getDependentData();
    super.initState();
  }

  resetInputs() {
    regionNameInput.myController.text = "";
    regionCodeInput.myController.text = "";
    selectedState = null;
    selectedProgramme = null;
  }

  getDependentData() async {
    try {
      List<States> statesResponse = await MasterDataService.getStates();
      List<Programme> programsResponse = await MasterDataService.getPrograms();
      setState(() {
        states = statesResponse;
        programs = programsResponse;
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  createRegion() async {
    try {
      if (regionNameInput.myController.text.isEmpty ||
          regionCodeInput.myController.text.isEmpty ||
          selectedState == null ||
          selectedProgramme == null) {
        return AppHelper.showSnackbar(
            "Any fields should not be empty", context);
      }

      await MasterDataService.createRegion(
        regionNameInput.myController.text,
        regionNameInput.myController.text,
        selectedState!.sId!,
        selectedProgramme!.sId!,
      );
      AppHelper.showSnackbar("Region created successfully", context);
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
              width: 400, child: TextFieldWidget(inputData: regionNameInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: 400, child: TextFieldWidget(inputData: regionCodeInput)),
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
                  selectedProgramme = null;
                });
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 400,
            child: DropDown(
              value: selectedProgramme == null ? null : selectedProgramme?.sId,
              hint: Text("Programme"),
              items: programs
                  .where((element) => element.state == selectedState?.sId)
                  .handleEmpty(Programme(name: ""))
                  .map((Programme value) {
                return DropdownMenuItem<String>(
                  value: value.sId,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                Programme selected =
                    programs.firstWhere((element) => element.sId == value);
                setState(() {
                  selectedProgramme = selected;
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
                onPressed: createRegion,
                child: Text("Submit"),
              )),
        ],
      ),
    );
  }
}
