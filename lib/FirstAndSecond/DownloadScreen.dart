import 'package:difference/Cubit/Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import '../Cubit/States.dart';
import 'GetSharedData.dart';
import 'Open.dart';

class DownloadScreen extends StatelessWidget {

  var urlController = TextEditingController();

  var farKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DownCubit()..GetLinkByShare(),
      child: Builder(
        builder: (context) {
          Dataclass().ShareData().then(
            (value) {
              print('the value is ' + value);
            },
          );
            urlController.text = DownCubit.get(context).GetLinkByShare();
          return BlocConsumer<DownCubit, DownState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: Container(
                  child: Form(
                    key: farKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.link),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'url',
                              hintText: 'paste url here',
                            ),
                            controller: urlController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'the url must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('download ?'),
                                  onPressed: () {
                                    print(urlController.text);
                                    if (farKey.currentState!.validate()) {
                                      DownCubit.get(context).downloadVideo(
                                          urlController.text.toString());
                                    }
                                    urlController = TextEditingController();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('open link ?'),
                                  onPressed: () {
                                    if (farKey.currentState!.validate()) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Open(
                                            urL: urlController.text,
                                          ),
                                        ),
                                      );
                                    }
                                    //urlController = TextEditingController();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('open link in youtube ?'),
                                  onPressed: () {
                                    if (farKey.currentState!.validate()) {
                                      DownCubit.get(context).launchURL(
                                          urlController.text.toString());
                                    }
                                    //urlController = TextEditingController();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
