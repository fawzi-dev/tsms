import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:tsms/app/app.dart';
import 'package:tsms/models/country_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Device Size
    Size deviceSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(deviceSize.width, deviceSize.height),
      child: MaterialApp(
        title: 'SMS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Base(),
      ),
    );
  }
}
