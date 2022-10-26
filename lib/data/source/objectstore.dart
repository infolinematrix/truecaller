import 'package:objectbox/objectbox.dart';
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
    final docsDir = await getApplicationDocumentsDirectory();

    final objStore = await openStore(
      directory: p.join(docsDir.path, "data-findo.mdb"),
      maxReaders: 1,
      maxDBSizeInKB: 1024 * 1024,
    );

    //--Delete Database with all object
    // store.close();

    return Database._create(objStore);
  }
}
