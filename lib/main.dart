import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => SnakeProvider()),
        ChangeNotifierProvider(create: (context) => PointsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GameState.navKey,
        home: const GameBoard(),
      ),
    );
  }
}
