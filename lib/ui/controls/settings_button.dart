import 'package:flutter/material.dart';

import '../../utils/settings_manager.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      icon: Icon(
        Icons.settings,
      ),
      onPressed: SettingsManager.showSettingsDialog,
    );
  }
}
