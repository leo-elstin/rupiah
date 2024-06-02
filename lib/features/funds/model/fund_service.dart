import 'package:expense_kit/credentials.dart';
import 'package:gsheets/gsheets.dart';

class MutualFundService {
  Future<List<Map<String, String>>?> getFunds() async {
    final sheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await sheets.spreadsheet(sheetId);
    // get worksheet by its title
    final sheet = ss.worksheetByTitle('Mutual Fund');
    var items = await sheet?.values.map.allRows(fromRow: 2, fromColumn: 2);

    return items;
  }

  Future<List<Map<String, String>>?> getStocks() async {
    final sheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await sheets.spreadsheet(sheetId);
    // get worksheet by its title
    final sheet = ss.worksheetByTitle('Stocks');
    var items = await sheet?.values.map.allRows(fromRow: 2);

    return items;
  }
}
