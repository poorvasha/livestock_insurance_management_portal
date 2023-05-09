import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lsi_management_portal/models/data/livestock_model.dart';

import '../../configs/Resources.dart';
import '../../models/InputFieldModel.dart';
import '../../services/app_helper.dart';
import '../../services/master_data_service.dart';
import '../../utils/dialog_helper.dart';
import '../TextFieldWidget.dart';

class LivestockEntryItem extends StatefulWidget {
  const LivestockEntryItem({super.key});

  @override
  State<LivestockEntryItem> createState() => _LivestockEntryItemState();
}

class _LivestockEntryItemState extends State<LivestockEntryItem> {
  late InputFieldData livestockNameInput;
  late InputFieldData livestockCodeInput;

  List<Livestock> livestocks = [];
  Livestock? selectedLivestock;

  @override
  void initState() {
    livestockNameInput = InputFieldData(
        labelName: "Livestock Name",
        errMessage: "Please enter a Livestock name",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    livestockCodeInput = InputFieldData(
        labelName: "Livestock Code",
        errMessage: "Please enter a Livestock code",
        myController: TextEditingController(),
        keyboardType: TextInputType.none,
        textInputType: FilteringTextInputFormatter.singleLineFormatter,
        onTextChange: () {});
    super.initState();
    getDependentData();
  }

  resetInputs() {
    livestockNameInput.myController.text = "";
    livestockCodeInput.myController.text = "";
    setState(() {
      selectedLivestock = null;
    });
  }

  getDependentData() async {
    try {
      List<Livestock> livestockResponse =
          await MasterDataService.getLivestocks();
      setState(() {
        livestocks = livestockResponse;
      });
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong", context);
    }
  }

  createLivestock() async {
    if (livestockNameInput.myController.text.isEmpty ||
        livestockCodeInput.myController.text.isEmpty) {
      return AppHelper.showSnackbar(
          "State and code should not be empty", context);
    }

    try {
      if (selectedLivestock != null) {
        await MasterDataService.editLivestock(
            livestockNameInput.myController.text,
            livestockCodeInput.myController.text,
            selectedLivestock!.sId!);
        resetInputs();
        getDependentData();
        return;
      }

      await MasterDataService.createLivestock(
          livestockNameInput.myController.text,
          livestockCodeInput.myController.text);
      resetInputs();
      getDependentData();
      AppHelper.showSnackbar("Livestock created successfully", context);
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong!", context);
    }
  }

  onItemEdit(Livestock item) {
    livestockNameInput.myController.text = item.name!;
    livestockCodeInput.myController.text = item.code!;
    setState(() {
      selectedLivestock = item;
    });
  }

  onDeleteSuccess(Livestock item) async {
    try {
      await MasterDataService.deleteLivestock(item.sId!);
    } catch (e) {
      AppHelper.showSnackbar("Something went wrong!", context);
    }
    resetInputs();
    getDependentData();
  }

  onItemDelete(Livestock item) {
    DialogHelper().showDeleteConfirmation(context, () {
      onDeleteSuccess(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                  width: 400,
                  child: TextFieldWidget(inputData: livestockNameInput)),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: 400,
                  child: TextFieldWidget(inputData: livestockCodeInput)),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: createLivestock,
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
                rows: livestocks
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
    );
  }
}
