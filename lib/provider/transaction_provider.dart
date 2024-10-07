import 'package:account/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  //ดึงข้อมูลมาแสดงผลในตอนแรก
  void initData() async {
    var db = TransactionDB(dbName: 'transactions.db');
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: 'transactions.db');
    //บันทึกข้อมูล
    await db.insertData(statement);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void deleteTransaction(int? index) async {
    var db = TransactionDB(dbName: 'transactions.db');
    //ลบข้อมูล
    await db.deleteData(index);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }
}
