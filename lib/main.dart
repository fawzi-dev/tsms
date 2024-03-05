import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:tsms/app/app.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';
import 'package:tsms/presentation/select-country/view_model/country_model.dart';
import 'package:html/dom.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryManagerBloc(),
        ),
        BlocProvider(
          create: (context) => CountryPhoneNumberListBlocManagerBloc(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(deviceSize.width, deviceSize.height),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SMS',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          home: const Base(),
        ),
      ),
    );
  }
}
