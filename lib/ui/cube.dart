import 'package:flutter/material.dart';

import '../models/cube_model.dart';
import '../utils/consts.dart';

class Cube extends StatelessWidget {
  final CubeModel model;

  const Cube(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cubeSize,
      height: cubeSize,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
        ),
        color: model.color,
      ),
    );
  }
}
