// import 'package:mongo_dart/mongo_dart.dart';

// class MongoDbReport {
//   static const String _uri =
//       'mongodb+srv://ayseabbas7557:MQHJmdN9raCbrRIT@cluster0.pujgzka.mongodb.net/ScamWiseDB?retryWrites=true&w=majority&appName=Cluster0';
//   static const String collectionName = "ReportData";

//   static Future<void> insertReport(Map<String, dynamic> reportData) async {
//     final db = await Db.create(_uri);
//     await db.open();
//     final collection = db.collection(collectionName);
//     await collection.insertOne(reportData);
//     await db.close();
//   }
// }
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbReport {
  static const String _uri =
      'mongodb+srv://ayseabbas7557:MQHJmdN9raCbrRIT@cluster0.pujgzka.mongodb.net/ScamWiseDB?retryWrites=true&w=majority&appName=Cluster0';
  static const String collectionName = "ReportData";

  static Future<void> insertReport(Map<String, dynamic> reportData) async {
    final db = await Db.create(_uri);
    await db.open();

    final collection = db.collection(collectionName);

    final documentToInsert = {
      "_id": ObjectId(), // ✅ Prevents ObjectId casting error
      ...reportData,
    };

    print("Attempting to insert: $documentToInsert");

    try {
      final result = await collection.insertOne(documentToInsert);
      if (result.isSuccess) {
        print("✅ Insert successful");
      } else {
        print("❌ Insert failed: ${result.errmsg}");
      }
    } catch (e, st) {
      print("🔥 Error inserting: $e");
      print("🔍 StackTrace: $st");
      rethrow;
    }

    await db.close();
  }
}
