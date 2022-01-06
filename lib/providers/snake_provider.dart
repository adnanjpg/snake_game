import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/providers/points_provider.dart';

import '../utils/game_state.dart';
import '../utils/consts.dart';
import '../models/cube_model.dart';
import '../enums/direction_enum.dart';

class SnakeProvider extends ChangeNotifier {
  setDefaults() {
    {
      final querySize = MediaQuery.of(GameState.context()).size;
      final height = querySize.height;
      final width = querySize.width;
      final _outSize = cubeSize + borderWidth * 2;
      boardSizeX = width ~/ _outSize;
      boardSizeY = height ~/ _outSize;
    }

    _cubes = [];
    nextDirection = initDirection;
  }

  void setDirection(Direction direction) => nextDirection = direction;

  Direction nextDirection = initDirection;

  List<CubeModel> _cubes = [];
  List<CubeModel> get cubes {
    if (_cubes.length == 0) {
      generateNew();
    }

    return _cubes;
  }

  bool get eatingItsTail {
    for (var i = 0; i < _cubes.length - 1; i++) {
      if (_cubes[i] == _cubes.last) {
        return true;
      }
    }

    return false;
  }

  bool get gameOver => eatingItsTail || _cubes.last.isOutOfBounds;

  bool gonFallOffEdge(Direction dir) {
    CubeModel mod = CubeModel.afterMove(CubeModel.from(_cubes.last), dir);
    return mod.isOutOfBounds;
  }

  void generateNew() {
    GameState.paused = true;
    GameState.setDefaults();
    for (var i = 0; i < initSnakeLen; i++) {
      _cubes.add(
        CubeModel.snake(i + 3, 5),
      );
    }
    GameState.paused = false;
  }

  void addToTail() {
    _cubes.insert(0, prevFirst);
  }

  static CubeModel prevFirst = CubeModel(0, 0, Colors.red);

  void forward() {
    if (_cubes.length == 0) generateNew();

    // saving the previous position of the first cube (aka the tail),
    // so we can add it to the tail later.
    prevFirst = CubeModel.from(_cubes.first);

    for (var i = 0; i < _cubes.length - 1; i++) {
      _cubes[i].copyFrom(_cubes[i + 1]);
    }
    final last = _cubes.last;
    last.move();

    final points =
        Provider.of<PointsProvider>(GameState.context(), listen: false);

    final matches = points.matches(last);
    if (matches) {
      addToTail();
      print('ateee');
    }

    notifyListeners();
  }
}
