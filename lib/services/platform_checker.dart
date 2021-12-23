
import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformCheck{
  static bool isAndroid() => Platform.isAndroid;
  static bool isInReleaseMode() => kReleaseMode;
}