import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/main.dart';

import 'snake_provider.dart';

class GameState {
  static bool paused = true;
  static void restart() {
    SnakeProvider w = Provider.of<SnakeProvider>(
      navKey.currentContext!,
      listen: false,
    );
    w.generateNew();
  }
}
