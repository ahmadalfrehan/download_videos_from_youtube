import 'dart:io';
import 'dart:math';
import 'package:difference/Cubit/States.dart';
import 'package:difference/FirstAndSecond/BrowserScreen.dart';
import 'package:difference/FirstAndSecond/DownloadScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../FirstAndSecond/GetSharedData.dart';
import '../FirstAndSecond/Third.dart';

class DownCubit extends Cubit<DownState> {
  DownCubit() : super(initialState());

  static DownCubit get(context) => BlocProvider.of(context);

  List<String> titles = [
    'download',
    'YouTubeDownloader',
    'youtube',
  ];
  List screens = [
    DownloadScreen(),
    Third(),
    const BrowserScreen(),
  ];

  int currentIndex = 0;

  void ChangeBottomNavigation(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  GetLinkByShare() {
    String x ='';
    Dataclass().ShareData().then(
      (value) {
        x = value;
        print(x);
      },
    );
    return x;
  }

  Future<void> downloadVideo(String s) async {
    emit(SucessDownState());
    String r = generateRandomString(26);
    print(r);
    final result = await FlutterYoutubeDownloader.downloadVideo(s, "$r.", 18);
    print(result);
  }

  Future<void> downloadVideoDirectly(String iUrl, String title) async {
    emit(SucessDownState());
    final result =
        await FlutterYoutubeDownloader.downloadVideo(iUrl, "$title.", 18);
    print(result);
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  String url = 'https://www.youtube.com';

  void launchURL(String url) async {
    emit(SucessLaunchState());
    if (!await launch(
      url,
    )) throw 'Could not launch $url';
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
  }

  initialDownPlatform() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  bool showDownloadButton = true;

  void checkDownLoadButton(var x) async {
    emit(SuccessChangeState());
    //print(await x?.currentUrl());
    if (await x?.currentUrl() == 'https://m.youtube.com/') {
      showDownloadButton = false;
    } else {
      showDownloadButton = true;
    }
  }
}
