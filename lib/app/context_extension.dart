import 'package:flutter/material.dart';

extension AppContext<T> on BuildContext {
  // Media Query extension
  Size? get deviceSize => MediaQuery.of(this).size ?? const Size(360, 1920);
}
