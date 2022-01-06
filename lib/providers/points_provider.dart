import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/utils/consts.dart';

import '../models/cube_model.dart';

class PointsProvider extends ChangeNotifier {
  final List<CubeModel> _list = [CubeModel.point(0, 0)];

  void setDefaults() {
    clear();

    for (var i = 0; i < 2; i++) addRandom();
  }

  List<CubeModel> get list => _list;

  void _add(CubeModel cubeModel) {
    _list.add(cubeModel);
  }

  void addRandom() {
    final random = Random.secure();

    var ranX = random.nextInt(boardSizeX), ranY = random.nextInt(boardSizeY);

    if (_list.any((element) => element.x == ranX && element.y == ranY)) {
      // keep recursing until we find a valid position
      addRandom();
    } else {
      final model = CubeModel.point(ranX, ranY);

      _add(model);
    }
  }

  void removeAt(int x, int y) {
    final idx = _list.indexWhere((cube) => cube.x == x && cube.y == y);

    remove(idx);
  }

  void remove(int idx) {
    if (idx >= 0 && idx < _list.length) _list.removeAt(idx);
  }

  bool matches(CubeModel cubeModel) {
    final idx = _list.indexWhere((c) => c == cubeModel);

    final match = idx != -1;

    if (match) {
      remove(idx);
      addRandom();
      notifyListeners();
    }

    return match;
  }

  void clear() {
    _list.clear();
  }
}
