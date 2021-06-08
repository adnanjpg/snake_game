import 'package:flutter/material.dart';

import 'consts.dart';
import 'cube_model.dart';
import 'direction_enum.dart';

class SnakeProvider extends ChangeNotifier {
  static Direction direction = Direction.right;
  List<CubeModel> _cubes = [];
  List<CubeModel> get cubes {
    if (_cubes.length == 0) generateNew();
    return _cubes;
  }

  void generateNew() {
    for (var i = 0; i < 3; i++) {
      _cubes.add(
        CubeModel(i + 3, 5, snakeCubeColor),
      );
    }
  }

  void add(CubeModel value) {
    _cubes.add(value);
    notifyListeners();
  }

  void forward() {
    if (_cubes.length == 0) generateNew();
    for (var i = 0; i < _cubes.length - 1; i++) {
      _cubes[i].copyFrom(_cubes[i + 1]);
    }
    _cubes[_cubes.length - 1].move();
    notifyListeners();
  }
}
