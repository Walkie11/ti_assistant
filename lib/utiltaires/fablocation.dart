
import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final double screenWidth = scaffoldGeometry.scaffoldSize.width;
    final double screenHeight = scaffoldGeometry.scaffoldSize.height;

    // Centré horizontalement
    final double dx = (screenWidth - fabWidth) / 2;

    // Descendu plus bas
    final double dy = screenHeight - fabHeight -10;
    // ↓ diminue le 10 pour descendre encore plus

    return Offset(dx, dy);
  }
}
