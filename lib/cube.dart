import 'package:flutter/material.dart';

import 'cube_model.dart';
import 'consts.dart';

class Cube extends StatelessWidget {
  final CubeModel model;
  const Cube(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
        ),
        color: model.color,
      ),
    );
  }
}
