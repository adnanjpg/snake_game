import 'package:flutter/material.dart';

import '../cube_model.dart';
import '../consts.dart';

class Cube extends StatelessWidget {
  final CubeModel model;

  /// for the head of the snake
  final Color? color;
  const Cube(this.model, {this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
        ),
        color: color ?? model.color,
      ),
    );
  }
}
