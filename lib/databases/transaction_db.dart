import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/transactions.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertData(Transactions statement) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense');

    var keyID = store.add(db, {
      "title": statement.title,
      "authors": statement.authors,
      "genres": statement.genres,
      "status": statement.status,
      "synopsis": statement.synopsis,
      "imageUrl": statement.imageUrl,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  deleteData(int? index) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense');

    await store.delete(db,
        finder: Finder(filter: Filter.equals(Field.key, index)));
  }

  //ใหม่ => เก่า, มาก => น้อย false
  //เก่า => ใหม่, น้อย => มาก true
  Future<List<Transactions>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactions = [];
    for (var record in snapshot) {
      transactions.add(
        Transactions(
          keyID: record.key,
          title: record['title'].toString(),
          authors: record['authors'].toString(),
          genres: record['genres'].toString(),
          status: record['status'].toString(),
          synopsis: record['synopsis'].toString(),
          imageUrl: record['imageUrl'].toString(),
          date: DateTime.parse(record['date'].toString()),
        ),
      );
    }
    return transactions;
  }
}
