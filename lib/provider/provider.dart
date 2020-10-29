import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiSettings with ChangeNotifier {
  double _fontSize = 22.0;
  double get fontSize => _fontSize;

  void setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  bool _boldFont = false;
  bool get boldFont => _boldFont;
  void setBoldfont(bool boldFont) {
    _boldFont = boldFont;
    notifyListeners();
  }

  Color _color = Colors.green;
  Color get color => _color;
  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  double _width = 100.0;
  double get width => _width;
  void setWidth(double width) {
    _width = width;
    notifyListeners();
  }

  TextStyle get textStyle {
    return TextStyle(
      fontSize: _fontSize,
      fontWeight: boldFont ? FontWeight.bold : FontWeight.normal,
    );
  }

  double _boxRadius = 5;
  double get boxRadius => _boxRadius;
  void setBoxRadius(double radius) {
    _boxRadius = radius;
    notifyListeners();
  }
}
