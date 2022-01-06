import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/game_state.dart';
import '../utils/consts.dart';
import '../ui/cube.dart';
import '../providers/snake_provider.dart';
import '../enums/direction_enum.dart';

class CubeModel {
  int x, y;

  Color color;

  CubeModel(
    this.x,
    this.y,
    this.color,
  );

  CubeModel._()
      : this.x = 0,
        this.y = 0,
        this.color = Colors.white;

  CubeModel.snake(this.x, this.y) : color = snakeCubeColor;

  CubeModel.bgCube(this.x, this.y) : color = bgCubeColor;

  CubeModel.from(CubeModel other)
      : x = other.x,
        y = other.y,
        color = other.color;

  Cube cube() => Cube(this);

  CubeModel copyWith({
    int? x,
    int? y,
    Color? color,
  }) {
    return CubeModel(
      x ?? this.x,
      y ?? this.y,
      color ?? this.color,
    );
  }

  void copyFrom(CubeModel other) {
    x = other.x;
    y = other.y;
    color = other.color;
  }

  bool get _isOutOfBoundsX => x.isNegative || x >= boardSizeX;
  bool get _isOutOfBoundsY => y.isNegative || y >= boardSizeY;

  bool get isOutOfBounds => _isOutOfBoundsX || _isOutOfBoundsY;

  static CubeModel afterMove(
    CubeModel model,
    Direction direction,
  ) {
    switch (direction) {
      case Direction.right:
        model.x++;
        break;
      case Direction.down:
        model.y--;
        break;
      case Direction.left:
        model.x--;
        break;
      case Direction.up:
        model.y++;
        break;
    }

    return model;
  }

  void move() {
    final prov = Provider.of<SnakeProvider>(GameState.context(), listen: false);

    final model = afterMove(this, prov.nextDirection);

    this.copyFrom(model);
  }
}
