import 'package:difference/Cubit/Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import '../Cubit/States.dart';

class DownloadScreen extends StatelessWidget {
  var urlController = TextEditingController();
  var farKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DownCubit(),
      child: BlocConsumer<DownCubit, DownState>(
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
                              onLongPress: () {
                                String hh = DownCubit.get(context).ifenvski();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(hh),
                                  ),
                                );
                              },
                              onPressed: () {
                                if (farKey.currentState!.validate()) {
                                  print(urlController.text);
                                  String hh = DownCubit.get(context).ifenvski();
                                  Workmanager().registerOneOffTask(
                                      hh, 'Ahmad Al_Frehan');
                                  Workmanager()
                                      .executeTask((taskName, inputData) {
                                    DownCubit.get(context).downloadVideo(
                                        urlController.text.toString());
                                    return Future.value(true);
                                  });
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
                              onLongPress: () {
                                String l = DownCubit.get(context)
                                    .generateRandomString(16);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l),
                                  ),
                                );
                              },
                              onPressed: () {
                                if (farKey.currentState!.validate()) {
                                  DownCubit.get(context)
                                      .launchURL(urlController.text.toString());
                                }
                                //urlController = TextEditingController();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
