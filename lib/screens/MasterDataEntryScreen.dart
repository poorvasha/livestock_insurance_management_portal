import 'package:flutter/material.dart';
import 'package:lsi_management_portal/configs/Resources.dart';

import '../utils/Helpers.dart';
import '../widgets/EntityEntry/DataEntryItem.dart';
import '../widgets/HeaderWidget.dart';

class MasterDataEntryScreen extends StatefulWidget {
  const MasterDataEntryScreen({super.key});

  @override
  State<MasterDataEntryScreen> createState() => _MasterDataEntryScreenState();
}

class _MasterDataEntryScreenState extends State<MasterDataEntryScreen> {
  String selectedEntity = "state";

  void onPressed(String entity) {
    setState(() {
      selectedEntity = entity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(
            screenType: ScreenType.masterDataEntryScreen,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "state"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("state"),
                            child: Text(
                              "State",
                              style: TextStyle(
                                  color: selectedEntity == "state"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "programme"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("programme"),
                            child: Text(
                              "Programme",
                              style: TextStyle(
                                  color: selectedEntity == "programme"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "region"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("region"),
                            child: Text(
                              "Region",
                              style: TextStyle(
                                  color: selectedEntity == "region"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "location"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("location"),
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  color: selectedEntity == "location"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "cluster"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("cluster"),
                            child: Text(
                              "Cluster",
                              style: TextStyle(
                                  color: selectedEntity == "cluster"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "group"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("group"),
                            child: Text(
                              "Group",
                              style: TextStyle(
                                  color: selectedEntity == "group"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "member"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("member"),
                            child: Text(
                              "Member",
                              style: TextStyle(
                                  color: selectedEntity == "member"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  selectedEntity == "livestock"
                                      ? Resources.primaryColor
                                      : Resources.white),
                            ),
                            onPressed: () => onPressed("livestock"),
                            child: Text(
                              "LiveStock",
                              style: TextStyle(
                                  color: selectedEntity == "livestock"
                                      ? Resources.white
                                      : Resources.primaryColor),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child: DataEntryItem(entity: selectedEntity))
              ],
            ),
          )
        ],
      ),
    );
  }
}
