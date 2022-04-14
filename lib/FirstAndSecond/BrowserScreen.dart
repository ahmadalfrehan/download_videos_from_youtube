import 'package:difference/Cubit/Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/States.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          DownCubit()..launchURL(DownCubit.get(context).url),
      child: BlocConsumer<DownCubit, DownState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Container(),
          );
        },
      ),
    );
  }
}
