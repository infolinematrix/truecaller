import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

Database? store;
Admin? admin;

/// flutter pub run build_runner build

class Database {
  /// The Store of this app.
  late final Store objStore;

  Database._create(this.objStore) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create() async {
    final docsDir = await _localPath;

    final objStore = await openStore(
      directory: p.join(docsDir, "data-findo.mdb"),
      maxReaders: 1,
      maxDBSizeInKB: 1024 * 1024,
    );

    //--Delete Database with all object
    // store.close();

    return Database._create(objStore);
  }
}

Future<String> readcontent() async {
  try {
    final file = await _localFile;
    // Read the file
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    // If there is an error reading, return a default String
    return 'Error';
  }
}

Future<File> writeContent() async {
  final file = await _localFile;
  // Write the file
  return file.writeAsString('Hello Folks');
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/readme.txt');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
