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
    return ScreenUtilInit(
      designSize: Size(context.size?.width ?? 360, context.size?.height ?? 853),
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
