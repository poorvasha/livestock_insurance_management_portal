import 'package:excel/excel.dart';
import '../models/data/insurance_model.dart';

class ExcelExporter {
  static exportInsurances(List<Insurance> insurances) {
    try {
      var excel = Excel.createExcel();
      Sheet sheet = excel[excel.getDefaultSheet()!];

      sheet = _addInsuranceHeader(sheet);
      for (int row = 0; row < insurances.length; row++) {
        sheet = _addInsuranceData(sheet, insurances[row], row + 1);
      }

      excel.save(fileName: "insurance.xlsx");
    } catch (e) {
      print(e);
    }
  }

  static _addInsuranceHeader(Sheet sheet) {
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "Insurance Id";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "Member";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "State";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "Programme";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        "Region";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        "Location";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        "Cluster";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
        "LiveStock";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
        "Renewal Days";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
        "Status";
    return sheet;
  }

  static _addInsuranceData(Sheet sheet, Insurance insurance, int row) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
        .value = insurance.sId ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
        .value = insurance.member?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
        .value = insurance.member?.state?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
        .value = insurance.member?.programme?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
        .value = insurance.member?.region?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
        .value = insurance.member?.location?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
        .value = insurance.cluster?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
        .value = insurance.livestock?.name ?? "";
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
        .value = insurance.renewalDays;
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
        .value = insurance.status.name;
    return sheet;
  }
}
