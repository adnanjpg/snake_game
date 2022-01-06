import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/points_provider.dart';

import 'providers/snake_provider.dart';
import 'ui/game_board.dart';
import 'utils/game_state.dart';

void main() {
  runApp(SnakeGame());
}

class SnakeGame extends StatelessWidget {
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
        home: GameBoard(),
      ),
    );
  }
}
