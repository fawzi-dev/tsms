import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/app/app.dart';
import 'package:tsms/firebase_options.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';
import 'package:tsms/manager/get-version/get_version_bloc.dart';
import 'package:tsms/manager/messages-bloc/message_bloc.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ),
        BlocProvider(
          create: (context) => MessageBloc(),
        ),
        BlocProvider(
          create: (context) => GetVersionBloc(),
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
