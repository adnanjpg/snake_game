import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/utils/consts.dart';

import '../models/cube_model.dart';

class PointsProvider extends ChangeNotifier {
  final List<CubeModel> _list = [CubeModel.point(0, 0)];

  void setDefaults() {
    clear();
    addRandom();
    addRandom();
  }

  List<CubeModel> get list => _list;

  void _add(CubeModel cubeModel) {
    _list.add(cubeModel);
  }

  void addRandom() {
    final random = Random.secure();

    final ranX = random.nextInt(boardSizeX), ranY = random.nextInt(boardSizeY);

    final model = CubeModel.point(ranX, ranY);

    _add(model);
  }

  void remove(CubeModel cubeModel) {
    _list.remove(cubeModel);
    notifyListeners();
  }

  void clear() {
    _list.clear();
  }
}
