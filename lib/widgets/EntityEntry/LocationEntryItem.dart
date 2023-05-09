import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/region_model.dart';
import 'package:lsi_management_portal/utils/extensions.dart';

import '../../models/InputFieldModel.dart';
import '../../models/data/programme_model.dart';
import '../../models/data/state_model.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../DropdownWidget.dart';
import '../TextFieldWidget.dart';

class LocationEntryItem extends StatefulWidget {
  const LocationEntryItem({super.key});

  @override
  State<LocationEntryItem> createState() => _LocationEntryItemState();
}

class _LocationEntryItemState extends State<LocationEntryItem> {
  late InputFieldData locationNameInput;
  late InputFieldData locationCodeInput;
  List<States> states = [States(name: "")];
  States? selectedState;

  List<Programme> programs = [Programme(name: "")];
  Programme? selectedProgramme;

  List<Region> regions = [Region(name: "")];
  Region? selectedRegion;

  @override
  void initState() {
    locationNameInput = InputFieldData(
        labelName: "Location Name",
        errMessage: "Please enter a Location name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    locationCodeInput = InputFieldData(
        labelName: "Location Code",
        errMessage: "Please enter a Location code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    getDependentData();
    super.initState();
  }

  resetInputs() {
    locationNameInput.myController.text = "";
    locationCodeInput.myController.text = "";
    setState(() {
      selectedState = null;
      selectedProgramme = null;
      selectedRegion = null;
    });
  }

  getDependentData() async {
    try {
      List<States> statesResponse = await MasterDataService.getStates();
      List<Programme> programsResponse = await MasterDataService.getPrograms();
      List<Region> regionResponse = await MasterDataService.getRegions();
      setState(() {
        states = statesResponse;
        programs = programsResponse;
        regions = regionResponse;
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  createLocation() async {
    try {
      if (locationNameInput.myController.text.isEmpty ||
          locationCodeInput.myController.text.isEmpty ||
          selectedState == null ||
          selectedProgramme == null ||
          selectedRegion == null) {
        return AppHelper.showSnackbar(
            "Any fields should not be empty", context);
      }

      await MasterDataService.createLocation(
          locationNameInput.myController.text,
          locationCodeInput.myController.text,
          selectedState!.sId!,
          selectedProgramme!.sId!,
          selectedRegion!.sId!);
      AppHelper.showSnackbar("Location created successfully", context);
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
              width: 400, child: TextFieldWidget(inputData: locationNameInput)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: 400, child: TextFieldWidget(inputData: locationCodeInput)),
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
                  selectedRegion = null;
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
                  selectedRegion = null;
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
              value: selectedRegion == null ? null : selectedRegion?.sId,
              hint: Text("region"),
              items: regions
                  .where(
                      (element) => element.programme == selectedProgramme?.sId)
                  .handleEmpty(Region(name: ""))
                  .map((Region value) {
                return DropdownMenuItem<String>(
                  value: value.sId,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                Region selected =
                    regions.firstWhere((element) => element.sId == value);
                setState(() {
                  selectedRegion = selected;
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
                onPressed: createLocation,
                child: Text("Submit"),
              )),
        ],
      ),
    );
  }
}
