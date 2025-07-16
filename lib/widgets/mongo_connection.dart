import 'package:mongo_dart/mongo_dart.dart';

// Future<void> connectToMongoDB() async {
//     const connectionString = 'mongodb+srv://ayseabbas7557:<MQHJmdN9raCbrRIT>@cluster0.pujgzka.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
//     final db = await Db.create(connectionString);
//     await db.open();
//     print("Connected to MongoDB");
//     await db.close();
// }
Future<void> connectToMongoDB() async {
  const connectionString =
      'mongodb+srv://ayseabbas7557:MQHJmdN9raCbrRIT@cluster0.pujgzka.mongodb.net/ScamWiseDB?retryWrites=true&w=majority&appName=Cluster0';

  try {
    final db = await Db.create(connectionString);
    await db.open();
    print("✅ Connected to MongoDB Atlas");
    await db.close();
  } catch (e) {
    print("❌ Connection failed: $e");
  }
}
