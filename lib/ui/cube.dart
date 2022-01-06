import 'package:flutter/material.dart';

import '../models/cube_model.dart';
import '../utils/consts.dart';

class Cube extends StatelessWidget {
  final CubeModel model;

  /// empty cube, snake body, snake head
  final Color? color;
  const Cube(this.model, {this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cubeSize,
      height: cubeSize,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
        ),
        color: color ?? model.color,
      ),
    );
  }
}
