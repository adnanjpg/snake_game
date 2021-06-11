import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'snake_provider.dart';

class GameState {
  static GlobalKey<NavigatorState> navKey = GlobalKey();
  static bool paused = true;
  static void restart() {
    SnakeProvider w = Provider.of<SnakeProvider>(
      navKey.currentContext!,
      listen: false,
    );
    w.generateNew();
  }
}
