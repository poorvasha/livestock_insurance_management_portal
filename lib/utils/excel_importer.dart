import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:lsi_management_portal/models/data/filtered_insurance_model.dart';
import 'package:lsi_management_portal/services/insurance_service.dart';

import '../models/data/insurance_model.dart';

class ExcelImporter {
  List<Insurance> rawInsurances = [];
  static BuildContext? context;

  static Future<bool> importInsurance(BuildContext buildContext) async {
    context = buildContext;
    print(DateTime.now().toString());
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    /// file might be picked

    if (pickedFile != null) {
      List<FilteredInsurance> insurances = [];
      Uint8List? bytes = pickedFile.files.single.bytes;
      Excel excel = Excel.decodeBytes(bytes!);
      print(excel.tables);
      //print( excel.tables[0]);

      try {
        for (var sheet in excel.tables.keys) {
          if (excel.tables.isEmpty) {
            return false;
          }

          print(sheet);
          //sheet Name
          // print(excel.tables[sheet]!.maxCols);
          // print(excel.tables[sheet]!.maxRows);
          for (var row in excel.tables[sheet]!.rows) {
            if (row[0]!.value != excel.tables[sheet]!.rows.first[0]!.value) {
              FilteredInsurance insurance = FilteredInsurance();
              print(row[5]!.value);
              insurance.cluster = row[0]!.value!.toString();
              insurance.group = row[1]!.value.toString();
              insurance.member = row[2]!.value.toString();
              insurance.livestock = row[3]!.value.toString();
              insurance.variety = row[4]!.value.toString();
              insurance.cost = int.parse(row[5]!.value.toString());
              insurance.premiumAmount = int.parse(row[6]!.value.toString());
              insurance.sumAssured = int.parse(row[7]!.value.toString());
              insurance.tagNumber = int.parse(row[8]!.value.toString());
              insurance.enrolledDate = row[9]!.value.toString();
              insurance.coveringPeriod = int.parse(row[10]!.value.toString());
              insurance.imageBack = "no image";
              insurance.imageFront = "no image";
              insurance.imageLeft = "no image";
              insurance.imageRight = "no image";
              for (Data? value in row) {
                if (value != null) {
                  print(value!.value);
                }
              }
              insurances.add(insurance);
              print('$row');
            }
          }
          break;
        }
      } on Exception catch (e) {
        showDialog(
            context: context!,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Unexpected Data"),
                  content: Text("Kindly insert valid excel sheet"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Okay"))
                  ],
                ));
        return false;
      }
      print(insurances);

      await InsuranceService.createInsurance(insurances);
      return true;
    }
    else{
      return false;
    }
  }
}
