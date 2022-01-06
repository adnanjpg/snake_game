import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points_provider.dart';
import '../utils/consts.dart';

class PointsBody extends StatelessWidget {
  const PointsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PointsProvider>(
      builder: (context, value, child) {
        return Stack(
          children: value.list.map(
            (model) {
              return Positioned(
                left: model.x * cubeSize,
                top: model.y * cubeSize,
                child: model.point(),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
