import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'points_provider.dart';

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
      const _outSize = cubeSize + borderWidth * 2;
      boardSizeX = width ~/ _outSize;
      boardSizeY = height ~/ _outSize;
    }

    _cubes = [];
    nextDirection = initDirection;
  }

  void setDirection(Direction direction) {
    final dif = direction.index - nextDirection.index;

    final ab = dif.abs();

    if (ab == 1 || ab == 3) nextDirection = direction;
  }

  Direction nextDirection = initDirection;

  List<CubeModel> _cubes = [];
  List<CubeModel> get cubes {
    if (_cubes.isEmpty) {
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

  bool isPowerOf2(int e) {
    return (e & (e - 1)) == 0;
  }

  int _increaseCount = 0;

  void addToTail() {
    // we dont wanna increase the trail in each step,
    // so we increase it each power of 2, which is a steady increase
    // and gets harder as the game progresses
    if (isPowerOf2(_increaseCount++)) {
      _cubes.insert(0, prevFirst);
      speed += 2;
    }
  }

  static CubeModel prevFirst = CubeModel(0, 0, Colors.red);

  void forward() {
    if (_cubes.isEmpty) {
      generateNew();
    }

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
    }

    notifyListeners();
  }
}
