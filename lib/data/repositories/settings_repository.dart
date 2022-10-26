import 'package:objectbox/objectbox.dart';
import 'package:truecaller/data/models/settings_model.dart';
import 'package:truecaller/data/source/objectstore.dart';

class SettingsRepository {
  final settingBox = store!.objStore.box<SettingsModel>();

  getAll() async {
    QueryBuilder<SettingsModel> builder = settingBox.query();

    Query<SettingsModel> query = builder.build();
    List<SettingsModel> data = query.find().toList();

    query.close();
    return data;
  }
}
