import 'package:flutter/material.dart';

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

  Cube cube() => Cube(this);

  void copyFrom(CubeModel other) {
    x = other.x;
    y = other.y;
  }

  void move() {
    switch (SnakeProvider.direction) {
      case Direction.right:
        this.x++;
        break;
      case Direction.down:
        this.y--;
        break;
      case Direction.left:
        this.x--;
        break;
      case Direction.up:
        this.y++;
        break;
    }
  }
}
