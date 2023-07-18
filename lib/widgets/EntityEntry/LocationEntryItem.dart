import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/location_model.dart';
import 'package:lsi_management_portal/models/data/region_model.dart';
import 'package:lsi_management_portal/utils/extensions.dart';
import 'package:collection/collection.dart';

import '../../configs/Resources.dart';
import '../../models/InputFieldModel.dart';
import '../../models/data/programme_model.dart';
import '../../models/data/state_model.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../../utils/dialog_helper.dart';
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

  List<Location> locations = [Location(name: "")];
  Location? selectedLocation;

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
      List<Location> locationResponse = await MasterDataService.getLocations();
      setState(() {
        states = statesResponse;
        programs = programsResponse;
        regions = regionResponse;
        locations = locationResponse;
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

      if (selectedLocation != null) {
        await MasterDataService.editLocation(
            locationNameInput.myController.text,
            locationCodeInput.myController.text,
            selectedState!.sId!,
            selectedProgramme!.sId!,
            selectedRegion!.sId!,
            selectedLocation!.sId!);
        resetInputs();
        getDependentData();
        return;
      }

      await MasterDataService.createLocation(
          locationNameInput.myController.text,
          locationCodeInput.myController.text,
          selectedState!.sId!,
          selectedProgramme!.sId!,
          selectedRegion!.sId!);
      AppHelper.showSnackbar("Location created successfully", context);
      resetInputs();
      getDependentData();
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    onItemEdit(Location item) {
      locationNameInput.myController.text = item.name!;
      locationCodeInput.myController.text = item.code!;
      setState(() {
        selectedState =
            states.firstWhereOrNull((element) => element.sId == item.state);
        selectedProgramme = programs
            .firstWhereOrNull((element) => element.sId == item.programme);
        selectedRegion =
            regions.firstWhereOrNull((element) => element.sId == item.region);
        selectedLocation = item;
      });
    }

    onDeleteSuccess(Location item) async {
      try {
        await MasterDataService.deleteLocation(item.sId!);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
      resetInputs();
      getDependentData();
    }

    onItemDelete(Location item) {
      DialogHelper().showDeleteConfirmation(context, () {
        onDeleteSuccess(item);
      });
    }

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                    width: 400,
                    child: TextFieldWidget(inputData: locationNameInput)),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 400,
                    child: TextFieldWidget(inputData: locationCodeInput)),
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
                    value: selectedProgramme == null
                        ? null
                        : selectedProgramme?.sId,
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
                      Programme selected = programs
                          .firstWhere((element) => element.sId == value);
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
                        .where((element) =>
                            element.programme == selectedProgramme?.sId)
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
                    DataColumn(label: Text("Password")),
                    DataColumn(label: Text("State")),
                    DataColumn(label: Text("Programme")),
                    DataColumn(label: Text("Region")),
                    DataColumn(label: Text("Actions"))
                  ],
                  rows: locations
                      .map(
                        (value) => DataRow(cells: [
                          DataCell(
                            Text(value.name!),
                          ),
                          DataCell(
                            Text(value.code!),
                          ),
                          DataCell(
                            Text(value.password!),
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
                            Text(programs
                                .firstWhere(
                                  (element) => element.sId == value.programme!,
                                  orElse: () => Programme(name: ""),
                                )
                                .name!),
                          ),
                          DataCell(
                            Text(regions
                                .firstWhere(
                                  (element) => element.sId == value.region!,
                                  orElse: () => Region(name: ""),
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
