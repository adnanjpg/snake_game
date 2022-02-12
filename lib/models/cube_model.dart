import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/direction_enum.dart';
import '../providers/snake_provider.dart';
import '../ui/space_unit.dart';
import '../utils/consts.dart';
import '../utils/game_state.dart';

class CubeModel {
  int x, y;

  Color color;

  CubeModel(
    this.x,
    this.y,
    this.color,
  );

  CubeModel.snake(this.x, this.y) : color = snakeCubeColor;

  CubeModel.bgCube(this.x, this.y) : color = bgCubeColor;

  CubeModel.point(this.x, this.y) : color = pointColor;

  CubeModel.from(CubeModel other)
      : x = other.x,
        y = other.y,
        color = other.color;

  Widget cube() => Cube(this);

  Widget point() => ScorePoint(this);

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
        model.y++;
        break;
      case Direction.left:
        model.x--;
        break;
      case Direction.up:
        model.y--;
        break;
    }

    return model;
  }

  void move() {
    final prov = Provider.of<SnakeProvider>(GameState.context(), listen: false);

    final model = afterMove(this, prov.nextDirection);

    copyFrom(model);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CubeModel &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
