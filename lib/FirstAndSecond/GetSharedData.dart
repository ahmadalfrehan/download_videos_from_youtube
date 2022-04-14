import 'package:flutter/services.dart';

class Dataclass {
  static String Channelname = "youTubeDownloader";

  Future<String> ShareData() async {
    final data = await MethodChannel(Channelname).invokeMethod(
      'getData',
    );
    return data;
  }
}
