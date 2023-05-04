import 'package:flutter/material.dart';
import 'package:lsi_management_portal/configs/Resources.dart';
import 'package:lsi_management_portal/utils/Helpers.dart';

import '../widgets/HeaderWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchOptions = [
    "All",
    "State",
    "Programme",
    "Region",
    "location",
    "Tag No",
    "Renewal Days"
  ];
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
              height: 60,
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
                    child: const Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Choose options to start searching ',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: searchOptions.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          boxShadow: Resources.customShadow,
                          borderRadius: BorderRadius.circular(10),
                          color: Resources.primaryColor),
                      height: 60,
                      width: 140,
                      child: Center(
                          child: Text(
                        searchOptions[index],
                        style: const TextStyle(
                            color: Resources.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Resources.white),
                child: DataTable(
                    dividerThickness: 4,
                    headingTextStyle: const TextStyle(
                        color: Resources.white, letterSpacing: 1, fontSize: 16),
                    dataRowColor: MaterialStateProperty.resolveWith(
                        (states) => Resources.primaryColor.withOpacity(0.1)),
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Resources.primaryColor),
                    columnSpacing: 60,
                    columns: const [
                      DataColumn(
                          label: Text(
                        "State",
                        textAlign: TextAlign.center,
                      )),
                      DataColumn(label: Text("Programme")),
                      DataColumn(label: Text("Region")),
                      DataColumn(label: Text("Location")),
                      DataColumn(label: Text("Cluster")),
                      DataColumn(label: Text("Group")),
                      DataColumn(label: Text("Member")),
                      DataColumn(label: Text("LiveStock")),
                      DataColumn(label: Text("Variety"))
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                        DataCell(
                          Text("jkchdjcddvvdfdcdcdcsd"),
                        ),
                      ])
                    ]),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Resources.primaryColor)),
                    onPressed: onPressed,
                    child: const Text("Previous")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Resources.primaryColor)),
                    onPressed: onPressed,
                    child: const Text("Next"))
              ],
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {}
}
