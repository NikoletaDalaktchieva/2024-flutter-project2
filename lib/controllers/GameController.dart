import 'package:hive_flutter/adapters.dart';

class GameController {
  var storage = Hive.box("storage");

  getLevelProgress(level) {
    List<String> levels =
        List<String>.from(storage.get(level, defaultValue: []));
    return levels;
  }

  saveLevel(level, cards) {
    storage.put(level, cards);
  }

  removeLevelData(level) {
    storage.delete(level);
  }
}
