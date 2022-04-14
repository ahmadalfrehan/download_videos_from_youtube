import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Cubit/Cubit.dart';
import '../Cubit/States.dart';

class Third extends StatelessWidget {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  WebViewController? controller2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DownCubit()..initialDownPlatform(),
      child: Builder(
        builder: (context) {
          DownCubit.get(context).initialDownPlatform();
          DownCubit.get(context).checkDownLoadButton(controller2);
          return BlocConsumer<DownCubit, DownState>(
            listener: (context, state) {},
            builder: (context, state) {
              DownCubit.get(context).checkDownLoadButton(controller2);
              return WillPopScope(
                onWillPop: () async {
                  if (await controller2!.canGoBack()) {
                    controller2?.goBack();
                  }
                  return false;
                },
                child: Scaffold(
                  body: WebView(
                    initialUrl: DownCubit.get(context).url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller2 = webViewController;
                      controller.complete(webViewController);
                    },
                    gestureNavigationEnabled: true,
                    allowsInlineMediaPlayback: true,
                  ),
                  floatingActionButton:
                      DownCubit.get(context).showDownloadButton
                          ? FloatingActionButton(
                              onPressed: () async {
                                print(await controller2!.currentUrl());
                                print(await controller2!.getTitle());
                                DownCubit.get(context).downloadVideoDirectly(
                                  await controller2!.currentUrl() as String,
                                  await controller2!.getTitle() as String,
                                );
                              },
                              child: Icon(Icons.download),
                            )
                          : Container(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
