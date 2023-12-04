import 'dart:math';

import 'package:flutter/material.dart';

final TextEditingController inputController = TextEditingController();

class interCode extends ChangeNotifier {
  final String whereIs = inputController.text;

  notifyListeners();
}