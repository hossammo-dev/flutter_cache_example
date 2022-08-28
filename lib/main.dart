import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_screen.dart';
import 'models/comment_model.dart';
import 'remote_data_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
