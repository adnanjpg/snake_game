import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/board_size_provider.dart';
import 'providers/points_provider.dart';
import 'providers/snake_provider.dart';
import 'ui/game_board.dart';
import 'utils/game_state.dart';

void main() {
  runApp(const SnakeGame());
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: BoardDimensionsProvider.new),
        ChangeNotifierProxyProvider<BoardDimensionsProvider, SnakeProvider>(
          create: (context) => SnakeProvider(
            context: context,
            dimension:
                Provider.of<BoardDimensionsProvider>(context, listen: false)
                    .size,
          ),
          update:
              (BuildContext context, dimensionProv, SnakeProvider? previous) {
            final dimension = dimensionProv.size;

            if (previous == null) {
              return SnakeProvider(
                context: context,
                dimension: dimension,
              );
            }

            previous.setDimension(dimension);

            return previous;
          },
        ),
        ChangeNotifierProxyProvider<BoardDimensionsProvider, PointsProvider>(
          create: (context) => PointsProvider(
            context: context,
            dimension:
                Provider.of<BoardDimensionsProvider>(context, listen: false)
                    .size,
          ),
          update:
              (BuildContext context, dimensionProv, PointsProvider? previous) {
            final dimension = dimensionProv.size;

            if (previous == null) {
              return PointsProvider(
                context: context,
                dimension: dimension,
              );
            }

            previous.setDimension(dimension);

            return previous;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GameState.navKey,
        home: const GameBoard(),
      ),
    );
  }
}
