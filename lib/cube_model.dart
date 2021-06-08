import 'package:flutter/material.dart';

import 'consts.dart';
import 'cube.dart';
import 'snake_provider.dart';
import 'direction_enum.dart';

class CubeModel {
  int x, y;
  Color color;
  CubeModel(
    this.x,
    this.y,
    this.color,
  );
  factory CubeModel.snake(int x, int y) {
    return CubeModel(x, y, snakeCubeColor);
  }
  factory CubeModel.bgCube(int x, int y) {
    return CubeModel(x, y, bgCubeColor);
  }

  static CubeModel from(CubeModel model) {
    return CubeModel(0, 0, Colors.amber)..copyFrom(model);
  }

  bool get isOutOfBounds =>
      x.isNegative || y.isNegative || x >= boardSizeX || y >= boardSizeY;

  Cube cube() => Cube(this);

  void copyFrom(CubeModel other) {
    x = other.x;
    y = other.y;
    color = other.color;
  }

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
    CubeModel mod = afterMove(this, SnakeProvider.direction);
    this.copyFrom(mod);
  }
}
