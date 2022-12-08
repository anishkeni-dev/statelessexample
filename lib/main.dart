import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hompage.dart';
import 'model/datamodel.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider<UserModel>(create: (_) => UserModel(name: ''))],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

