import 'package:flutter/material.dart';

import '../utils/consts.dart';

class BoardDimensionsModel {
  final int x, y;

  const BoardDimensionsModel(this.x, this.y);

  factory BoardDimensionsModel.fromConstraints(BoxConstraints constraints) {
    final height = constraints.heightConstraints().maxHeight;
    final width = constraints.widthConstraints().maxWidth;

    const _outSize = cubeSize + borderWidth * 2;

    return BoardDimensionsModel(width ~/ _outSize, height ~/ _outSize);
  }
}
