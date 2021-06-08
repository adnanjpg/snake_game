import 'package:flutter/material.dart';

import 'cube_model.dart';
import 'direction_enum.dart';

class SnakeProvider extends ChangeNotifier {
  static Direction direction = Direction.right;
  List<CubeModel> _cubes = [];
  List<CubeModel> get cubes {
    if (_cubes.length == 0) generateNew();
    return _cubes;
  }

  bool get eatingItsTail {
    return _cubes.any(
        (element) => element.y == _cubes.last.y || element.x == _cubes.last.x);
  }

  bool get gameOver => eatingItsTail || _cubes.last.isOutOfBounds;

  bool gonFallOffEdge(Direction dir) {
    CubeModel mod = CubeModel.afterMove(CubeModel.from(_cubes.last), dir);
    return mod.isOutOfBounds;
  }

  void generateNew() {
    for (var i = 0; i < 6; i++) {
      _cubes.add(
        CubeModel.snake(i + 3, 5),
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
    _cubes.last.move();

    notifyListeners();
  }
}
