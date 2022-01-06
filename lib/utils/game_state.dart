import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points_provider.dart';
import '../providers/snake_provider.dart';

class GameState {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  static bool paused = true;

  static BuildContext context() {
    final context = GameState.navKey.currentContext;

    if (context == null) {
      throw Exception('An error oSccured, please restart the game');
    }

    return context;
  }

  static void restart() {
    SnakeProvider w = Provider.of<SnakeProvider>(
      context(),
      listen: false,
    );

    w.generateNew();
  }

  static void setDefaults() {
    final snakeProv = Provider.of<SnakeProvider>(context(), listen: false);
    snakeProv.setDefaults();

    final pointProv = Provider.of<PointsProvider>(context(), listen: false);
    pointProv.setDefaults();
  }
}
