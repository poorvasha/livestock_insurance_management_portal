import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/cluster_model.dart';
import 'package:lsi_management_portal/utils/extensions.dart';
import 'package:collection/collection.dart';

import '../../configs/Resources.dart';
import '../../models/InputFieldModel.dart';
import '../../models/data/programme_model.dart';
import '../../models/data/region_model.dart';
import '../../models/data/state_model.dart';
import '../../models/data/location_model.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../../utils/dialog_helper.dart';
import '../DropdownWidget.dart';
import '../TextFieldWidget.dart';

class ClusterEntryItem extends StatefulWidget {
  const ClusterEntryItem({super.key});

  @override
  State<ClusterEntryItem> createState() => _ClusterEntryItemState();
}

class _ClusterEntryItemState extends State<ClusterEntryItem> {
  late InputFieldData clusterNameInput;
  late InputFieldData clusterCodeInput;
  List<States> states = [States(name: "")];
  States? selectedState;

  List<Programme> programs = [Programme(name: "")];
  Programme? selectedProgramme;

  List<Region> regions = [Region(name: "")];
  Region? selectedRegion;

  List<Location> locations = [Location(name: "")];
  Location? selectedLocation;

  List<Cluster> clusters = [];
  Cluster? selectedCluster;

  @override
  void initState() {
    clusterNameInput = InputFieldData(
        labelName: "Cluster Name",
        errMessage: "Please enter a Cluster name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    clusterCodeInput = InputFieldData(
        labelName: "Cluster Code",
        errMessage: "Please enter a Cluster code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    getDependentData();
    super.initState();
  }

  resetInputs() {
    clusterNameInput.myController.text = "";
    clusterCodeInput.myController.text = "";
    setState(() {
      selectedState = null;
      selectedProgramme = null;
      selectedRegion = null;
      selectedLocation = null;
      selectedCluster = null;
    });
  }

  getDependentData() async {
    try {
      List<States> statesResponse = await MasterDataService.getStates();
      List<Programme> programsResponse = await MasterDataService.getPrograms();
      List<Region> regionResponse = await MasterDataService.getRegions();
      List<Location> locationResponse = await MasterDataService.getLocations();
      List<Cluster> clusterResponse = await MasterDataService.getClusters();
      setState(() {
        states = statesResponse;
        programs = programsResponse;
        regions = regionResponse;
        locations = locationResponse;
        clusters = clusterResponse;
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  createCluster() async {
    try {
      if (clusterNameInput.myController.text.isEmpty ||
          clusterCodeInput.myController.text.isEmpty ||
          selectedState == null ||
          selectedProgramme == null ||
          selectedRegion == null ||
          selectedLocation == null) {
        return AppHelper.showSnackbar(
            "Any fields should not be empty", context);
      }

      if (selectedCluster != null) {
        await MasterDataService.editCluster(
            clusterNameInput.myController.text,
            clusterCodeInput.myController.text,
            selectedState!.sId!,
            selectedProgramme!.sId!,
            selectedRegion!.sId!,
            selectedLocation!.sId!,
            selectedCluster!.sId!);
        resetInputs();
        getDependentData();
        return;
      }

      await MasterDataService.createCluster(
          clusterNameInput.myController.text,
          clusterCodeInput.myController.text,
          selectedState!.sId!,
          selectedProgramme!.sId!,
          selectedRegion!.sId!,
          selectedLocation!.sId!);
      AppHelper.showSnackbar("Cluster created successfully", context);
      resetInputs();
      getDependentData();
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    onItemEdit(Cluster item) {
      clusterNameInput.myController.text = item.name!;
      clusterCodeInput.myController.text = item.code!;
      setState(() {
        selectedState =
            states.firstWhereOrNull((element) => element.sId == item.state);
        selectedProgramme = programs
            .firstWhereOrNull((element) => element.sId == item.programme);
        selectedRegion =
            regions.firstWhereOrNull((element) => element.sId == item.region);
        selectedLocation = locations
            .firstWhereOrNull((element) => element.sId == item.location);
        selectedCluster = item;
      });
    }

    onDeleteSuccess(Cluster item) async {
      try {
        await MasterDataService.deleteCluster(item.sId!);
      } catch (e) {
        AppHelper.showSnackbar("Something went wrong!", context);
      }
      resetInputs();
      getDependentData();
    }

    onItemDelete(Cluster item) {
      DialogHelper().showDeleteConfirmation(context, () {
        onDeleteSuccess(item);
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                  width: 400,
                  child: TextFieldWidget(inputData: clusterNameInput)),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: 400,
                  child: TextFieldWidget(inputData: clusterCodeInput)),
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
                      selectedLocation = null;
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
                  value:
                      selectedProgramme == null ? null : selectedProgramme?.sId,
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
                      selectedLocation = null;
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
                      selectedLocation = null;
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
                  value:
                      selectedLocation == null ? null : selectedLocation?.sId,
                  hint: Text("Locations"),
                  items: locations
                      .where((element) => element.region == selectedRegion?.sId)
                      .handleEmpty(Location(name: ""))
                      .map((Location value) {
                    return DropdownMenuItem<String>(
                      value: value.sId,
                      child: Text(value.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    Location selected =
                        locations.firstWhere((element) => element.sId == value);
                    setState(() {
                      selectedLocation = selected;
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
                    onPressed: createCluster,
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
                  DataColumn(label: Text("Programme")),
                  DataColumn(label: Text("Region")),
                  DataColumn(label: Text("Location")),
                  DataColumn(label: Text("Actions"))
                ],
                rows: clusters
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
                          Text(locations
                              .firstWhere(
                                (element) => element.sId == value.location!,
                                orElse: () => Location(name: ""),
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
    );
  }
}
