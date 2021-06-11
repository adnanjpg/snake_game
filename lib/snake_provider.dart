import 'package:flutter/material.dart';

import 'game_state.dart';
import 'consts.dart';
import 'cube_model.dart';
import 'direction_enum.dart';

class SnakeProvider extends ChangeNotifier {
  setDefaults() {
    _cubes = [];
    _direction = Direction.right;
    _nextDirections = [];
  }

  void addDirection(Direction d) {
    if (_nextDirections.length == 0 // if hasn't
        // had any instructions yet, or finished
        // all previoues instructions
        ||
        _nextDirections.last != d) {
      _nextDirections.add(d);
    }
  }

  List<Direction> _nextDirections = [];
  Direction get nextDirection {
    if (_nextDirections.length > 0) {
      _direction = _nextDirections[0];
      _nextDirections.removeAt(0);
    }
    return _direction;
  }

  late Direction _direction;
  List<CubeModel> _cubes = [];
  List<CubeModel> get cubes {
    if (_cubes.length == 0) generateNew();

    return _cubes;
  }

  bool get eatingItsTail {
    bool eat = false;
    for (var i = 0; i < _cubes.length - 1; i++) {
      eat = _cubes[i].y == _cubes.last.y && _cubes[i].x == _cubes.last.x;
      if (eat) break;
    }
    return eat;
  }

  bool get gameOver => eatingItsTail || _cubes.last.isOutOfBounds;

  bool gonFallOffEdge(Direction dir) {
    CubeModel mod = CubeModel.afterMove(CubeModel.from(_cubes.last), dir);
    return mod.isOutOfBounds;
  }

  void generateNew() {
    GameState.paused = true;
    setDefaults();
    for (var i = 0; i < initSnakeSize; i++) {
      _cubes.add(
        CubeModel.snake(i + 3, 5),
      );
    }
    GameState.paused = false;
    // this method will run during build,
    // and it will throw an error,
    // so we safely await for the build
    // to finish.
    Future.microtask(() {
      notifyListeners();
    });
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
