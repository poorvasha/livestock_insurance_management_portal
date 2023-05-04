import 'package:flutter/material.dart';

import '../utils/Helpers.dart';
import '../widgets/HeaderWidget.dart';

class MasterDataEntryScreen extends StatelessWidget {
  const MasterDataEntryScreen({super.key});

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
                        child: ElevatedButton(
                            onPressed: onPressed, child: const Text("State")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed,
                            child: const Text("Programme")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed, child: const Text("Region")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed,
                            child: const Text("Location")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed, child: const Text("Cluster")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed, child: const Text("Group")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed, child: const Text("Member")),
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: onPressed,
                            child: const Text("LiveStock")),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.amber,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {}
}
