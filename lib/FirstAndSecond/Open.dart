import 'package:difference/Cubit/Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/States.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Open extends StatelessWidget {
  final String urL;

  Open({Key? key, required this.urL}) : super(key: key);

  WebViewController? controller2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DownCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DownCubit, DownState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: WebView(
                  initialUrl: urL,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller2 = webViewController;
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    print(await controller2!.currentUrl());
                    print(await controller2!.getTitle());
                    DownCubit.get(context).downloadVideoDirectly(
                      await controller2!.currentUrl() as String,
                      await controller2!.getTitle() as String,
                    );
                  },
                  child: Icon(Icons.download),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
