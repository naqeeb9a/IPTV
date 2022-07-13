import 'package:bwciptv/data.dart';
import 'package:flutter/foundation.dart';

class ChannelProvider extends ChangeNotifier {
  String link = categories[0]["link"];

  updateChannel(String value) {
    link = value;
    notifyListeners();
  }
}
