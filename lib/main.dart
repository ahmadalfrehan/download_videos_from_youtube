import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:difference/Cubit/Cubit.dart';
import 'package:difference/Cubit/States.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:workmanager/workmanager.dart';

import 'FirstAndSecond/GetSharedData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    FlutterYoutubeDownloader.downloadVideo(
        'https://youtu.be/rMz9bgAIBwg', 'A.', 18);

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DownCubit(),
      child: BlocConsumer<DownCubit, DownState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                DownCubit.get(context)
                    .titles[DownCubit.get(context).currentIndex]
                    .toString(),
              ),
            ),
            body: DownCubit.get(context)
                .screens[DownCubit.get(context).currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              items: const [
                Icon(Icons.download),
                Icon(Icons.ondemand_video_outlined),
                Icon(Icons.ondemand_video),
              ],
              backgroundColor: Colors.red,
              index: DownCubit.get(context).currentIndex,
              onTap: (index) {
                DownCubit.get(context).ChangeBottomNavigation(index);
              },
            ),
          );
        },
      ),
    );
  }
}
