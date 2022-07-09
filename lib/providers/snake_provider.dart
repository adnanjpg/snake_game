import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/board_dimensions_model.dart';

import '../enums/direction_enum.dart';
import '../models/cube_model.dart';
import '../utils/consts.dart';
import '../utils/game_state.dart';
import 'points_provider.dart';

class SnakeProvider extends ChangeNotifier {
  final BuildContext context;
  BoardDimensionsModel dimension;

  SnakeProvider({
    required this.context,
    required this.dimension,
  });

  void setDimension(BoardDimensionsModel dimension) {
    this.dimension = dimension;
  }

  void setDefaults() {
    _cubes = [];
    _increaseCount = 0;
    speed = initSpeed;
    nextDirection = initDirection;
  }

  void setDirection(Direction direction) {
    final dif = direction.index - nextDirection.index;

    final ab = dif.abs();

    if (ab == 1 || ab == 3) nextDirection = direction;
  }

  void setDirectionByEvent(RawKeyEvent event) {
    // this method gets called on key up and down,
    // but we only want to work it on key down.
    // https://stackoverflow.com/a/50986257/12555423
    if (event.runtimeType != RawKeyDownEvent) return;

    final map = {
      // i have no idea why, but `arrowUp` and `arrowDown`
      // each represent its exact reverse
      [LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.keyS]: Direction.down,
      [LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.keyW]: Direction.up,
      [LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.keyD]: Direction.right,
      [LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.keyA]: Direction.left,
    };

    for (var item in map.entries) {
      for (var key in item.key) {
        if (!event.isKeyPressed(key)) continue;

        setDirection(item.value);
        return;
      }
    }
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

  bool get gameOver => eatingItsTail || _cubes.last.isOutOfBounds(dimension);

  // bool gonFallOffEdge(Direction dir) {
  //   CubeModel mod = CubeModel.afterMove(CubeModel.from(_cubes.last), dir);
  //   return mod.isOutOfBounds;
  // }

  void generateNew() {
    GameState.paused = true;
    GameState.setDefaults();
    for (var i = 0; i < initSnakeLen; i++) {
      _cubes.add(
        CubeModel.snake(i + snakeInitX, snakeInitY),
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
      speed += speedIncrease;
    }
  }

  static CubeModel prevFirst = CubeModel(0, 0, Colors.red);

  void forward() {
    // saving the previous position of the first cube (aka the tail),
    // so we can add it to the tail later.
    prevFirst = CubeModel.from(cubes.first);

    for (var i = 0; i < cubes.length - 1; i++) {
      cubes[i].copyFrom(cubes[i + 1]);
    }
    final last = cubes.last;
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
