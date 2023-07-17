import 'package:flutter/material.dart';
import 'package:lsi_management_portal/configs/Resources.dart';
import 'package:lsi_management_portal/models/data/insurance_model.dart';
import 'package:lsi_management_portal/screens/InsuranceDetailScreen.dart';
import 'package:lsi_management_portal/services/insurance_service.dart';
import 'package:lsi_management_portal/utils/Helpers.dart';
import 'package:lsi_management_portal/utils/excel_exporter.dart';

import '../widgets/HeaderWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Insurance> insurances = [];
  List<Insurance> rawInsurances = [];
  TextEditingController controller = TextEditingController();

  bool _sortNameAsc = true;
  bool _sortAgeAsc = true;
  bool _sortHightAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  var searchOptions = [
    "State",
    "Programme",
    "Region",
    "Location",
    "Tag No",
    "Renewal Days",
    "Clear"
  ];

  Map<String, bool> filterOptions = {
    "State": false,
    "Programme": false,
    "Region": false,
    "Location": false,
    "Tag No": false,
    "Renewal Days": false,
    "Clear": false
  };

  @override
  void initState() {
    fetchInsurances();
    super.initState();
  }

  void fetchInsurances() async {
    try {
      List<Insurance> _insurances = await InsuranceService.getInsurances();
      setState(() {
        insurances = _insurances;
        rawInsurances = _insurances;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void onSort(columnIndex, ascending, action) {
    setState(() {
      if (columnIndex == _sortColumnIndex) {
        _sortAsc = _sortNameAsc = ascending;
      } else {
        _sortColumnIndex = columnIndex;
        _sortAsc = _sortNameAsc;
      }
      action();
      if (!_sortAsc) {
        insurances = insurances.reversed.toList();
      }
    });
  }

  void navigateToInsuranceDetailScreen(Insurance insurance) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InsuranceDetailScreen(
                  insurance: insurance,
                )));
  }

  void onFilterTapped(String searchOption) {
    if (searchOption == "Clear") {
      setState(() {
        for (String key in filterOptions.keys) {
          filterOptions[key] = false;
        }
        insurances = rawInsurances;
      });
      return;
    }

    setState(() {
      filterOptions[searchOption] = !filterOptions[searchOption]!;
    });
  }

  void searchTapped(String value) {
    List<Insurance> filteredInsuances = List<Insurance>.from(rawInsurances);

    if (filterOptions["State"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.member?.state?.name
                  ?.toLowerCase()
                  .contains(value.toLowerCase()) ??
              false)
          .toList();
    }

    if (filterOptions["Programme"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.member?.programme?.name
                  ?.toLowerCase()
                  .contains(value.toLowerCase()) ??
              false)
          .toList();
    }

    if (filterOptions["Region"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.member?.region?.name
                  ?.toLowerCase()
                  .contains(value.toLowerCase()) ??
              false)
          .toList();
    }

    if (filterOptions["Tag No"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.tagNumber?.toLowerCase().contains(value.toLowerCase()) ??
              false)
          .toList();
    }

    if (filterOptions["Tag No"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.tagNumber?.toLowerCase().contains(value.toLowerCase()) ??
              false)
          .toList();
    }

    if (filterOptions["Renewal Days"]!) {
      filteredInsuances = filteredInsuances
          .where((element) =>
              element.renewalDays.toString() == value.toLowerCase())
          .toList();
    }
    setState(() {
      insurances = filteredInsuances;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(
            screenType: ScreenType.homeScreen,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                        boxShadow: Resources.customShadow,
                        borderRadius: BorderRadius.circular(10),
                        color: Resources.white),
                    child: Center(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Choose options to start searching ',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchTapped(controller.text);
                              },
                              icon: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: searchOptions.length,
                    itemBuilder: (context, index) {
                      bool isEnabled = filterOptions[searchOptions[index]]!;
                      return InkWell(
                        onTap: () {
                          onFilterTapped(searchOptions[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              boxShadow: Resources.customShadow,
                              borderRadius: BorderRadius.circular(20),
                              color: isEnabled
                                  ? Resources.primaryColor
                                  : Resources.white),
                          height: 30,
                          child: Center(
                              child: Text(
                            searchOptions[index],
                            style: TextStyle(
                                color: isEnabled
                                    ? Resources.white
                                    : Resources.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        ExcelExporter.exportInsurances(insurances);
                      },
                      icon: Icon(Icons.import_export_rounded),
                      label: Text("Export to Excel"))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Resources.white,
                        iconTheme: Theme.of(context)
                            .iconTheme
                            .copyWith(size: 20, color: Colors.white)),
                    child: DataTable(
                        dividerThickness: 4,
                        headingTextStyle: const TextStyle(
                            color: Resources.white, fontSize: 14),
                        dataRowColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                Resources.primaryColor.withOpacity(0.1)),
                        headingRowColor: MaterialStateProperty.resolveWith(
                            (states) => Resources.primaryColor),
                        columnSpacing: 40,
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAsc,
                        columns: [
                          DataColumn(
                              label: Text("State"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a
                                      .member!.state!.name!
                                      .compareTo(b.member!.state!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Programme"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a
                                      .member!.programme!.name!
                                      .compareTo(b.member!.programme!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Region"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a
                                      .member!.region!.name!
                                      .compareTo(b.member!.region!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Location"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a
                                      .member!.location!.name!
                                      .compareTo(b.member!.location!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Cluster"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a.cluster!.name!
                                      .compareTo(b.cluster!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Group"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) =>
                                      a.group!.name!.compareTo(b.group!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("Member"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a.member!.name!
                                      .compareTo(b.member!.name!));
                                });
                              }),
                          DataColumn(
                              label: Text("LiveStock"),
                              onSort: (columnIndex, ascending) {
                                onSort(columnIndex, ascending, () {
                                  insurances.sort((a, b) => a.livestock!.name!
                                      .compareTo(b.livestock!.name!));
                                });
                              }),
                          DataColumn(
                            label: Text("Renewal Days"),
                            onSort: (columnIndex, ascending) {
                              onSort(columnIndex, ascending, () {
                                insurances.sort((a, b) =>
                                    a.renewalDays.compareTo(b.renewalDays));
                              });
                            },
                          ),
                          DataColumn(
                            label: Text("Status"),
                            onSort: (columnIndex, ascending) {
                              onSort(columnIndex, ascending, () {
                                insurances.sort(
                                    (a, b) => a.status == InsuranceStatus.active
                                        ? 0
                                        : a.status == InsuranceStatus.expired
                                            ? 1
                                            : 2);
                              });
                            },
                          ),
                        ],
                        rows: insurances
                            .map((insurance) => DataRow(
                                    onSelectChanged: (isTapped) {
                                      if (isTapped != null && isTapped) {
                                        navigateToInsuranceDetailScreen(
                                            insurance);
                                      }
                                    },
                                    cells: [
                                      DataCell(
                                        Text(insurance.member?.state?.name ??
                                            ""),
                                      ),
                                      DataCell(
                                        Text(
                                            insurance.member?.programme?.name ??
                                                ""),
                                      ),
                                      DataCell(
                                        Text(insurance.member?.region?.name ??
                                            ""),
                                      ),
                                      DataCell(
                                        Text(insurance.member?.location?.name ??
                                            ""),
                                      ),
                                      DataCell(
                                        Text(insurance.cluster?.name ?? ""),
                                      ),
                                      DataCell(
                                        Text(insurance.group?.name ?? ""),
                                      ),
                                      DataCell(
                                        Text(insurance.member?.name ?? ""),
                                      ),
                                      DataCell(
                                        Text(insurance.livestock?.name ?? ""),
                                      ),
                                      DataCell(
                                        Text(insurance.renewalDays >= 0
                                            ? insurance.renewalDays.toString()
                                            : "-"),
                                      ),
                                      DataCell(
                                        Text(insurance.status.name),
                                      ),
                                    ]))
                            .toList()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPressed() {}
}
