// ✅ الصح - استخدم DialogHelper في كل الـ views
// lib/core/utils/dialog_helper.dart
import 'package:flutter/material.dart';

class DialogHelper {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
