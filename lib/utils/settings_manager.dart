import 'package:flutter/material.dart';

import '../ui/settings_dialog.dart';

abstract class SettingsManager {
  static void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SettingsDialog();
      },
    );
  }
}
